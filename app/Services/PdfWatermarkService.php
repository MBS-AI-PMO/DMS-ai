<?php

namespace App\Services;

use setasign\Fpdi\Fpdi;

class PdfWatermarkService
{
    public function addWatermark(string $inputFilePath, string $outputFilePath, string $watermarkText)
    {
        if (!file_exists($inputFilePath)) {
            throw new \Exception("Input PDF not found: $inputFilePath");
        }

        $pdf = new WatermarkFpdiNew();

        $pageCount = $pdf->setSourceFile($inputFilePath);

        // Create transparent PNG watermark dynamically
        $watermarkImage = $this->createTransparentWatermarkImage($watermarkText);

        // Get the PNG dimensions
        list($imgWidth, $imgHeight) = getimagesize($watermarkImage);

        for ($pageNo = 1; $pageNo <= $pageCount; $pageNo++) {

            $templateId = $pdf->importPage($pageNo);
            $size = $pdf->getTemplateSize($templateId);

            $pdf->AddPage($size['orientation'], [$size['width'], $size['height']]);
            $pdf->useTemplate($templateId);

            // Scale image to fit 70% of page width
            $maxWidth = $size['width'] * 0.7;
            $scale = $maxWidth / $imgWidth;

            $finalWidth  = $size['width'] * 1.2;        // 120% of page width (big)
            $finalHeight = ($imgHeight / $imgWidth) * $finalWidth;    // keep aspect ratio

            // Center position
            $centerX = ($size['width']  - $finalWidth)  / 2;
            $centerY = ($size['height'] - $finalHeight) / 2;

            // Rotate watermark (45° diagonal)
            $pdf->Rotate(45, $size['width'] / 2, $size['height'] / 2);

            // Insert Transparent Watermark PNG
            $pdf->Image($watermarkImage, $centerX, $centerY, $finalWidth, $finalHeight, 'PNG');

            // Reset rotation
            $pdf->Rotate(0);
        }

        $result = $pdf->Output($outputFilePath, 'F');

        // Clean up temporary watermark image
        if (file_exists($watermarkImage)) {
            unlink($watermarkImage);
        }

        return $result;
    }



    /**
     * Create a semi-transparent PNG watermark using GD (True Transparency)
     */
    private function createTransparentWatermarkImage(string $text): string
    {
        // Measure rough text length (each char ≈ 22px at 140 font size)
        $estimatedWidth = strlen($text) * 22;

        // Minimum width 2000px
        $width = max(2000, $estimatedWidth);
        $height = 450;  // Taller for long text

        // Create transparent PNG
        $img = imagecreatetruecolor($width, $height);
        imagesavealpha($img, true);

        $transparent = imagecolorallocatealpha($img, 0, 0, 0, 127);
        imagefill($img, 0, 0, $transparent);

        // Use TTF font
        $font = public_path("fonts/arial.ttf");
        if (!file_exists($font)) {
            throw new \Exception("Font not found: $font");
        }

        // Larger font size  
        $fontSize = 100;

        // Calculate text bounding box
        $bbox = imagettfbbox($fontSize, 0, $font, $text);
        $textWidth  = $bbox[2] - $bbox[0];
        $textHeight = $bbox[1] - $bbox[7];

        // Center text
        $x = ($width  - $textWidth)  / 2;
        $y = ($height + $textHeight) / 2;

        // Semi-transparent dark gray text
        $textColor = imagecolorallocatealpha($img, 120, 120, 120, 85);

        // Draw text
        imagettftext($img, $fontSize, 0, $x, $y, $textColor, $font, $text);

        // Save temp PNG
        $tmpFile = tempnam(sys_get_temp_dir(), 'wm_') . ".png";
        imagepng($img, $tmpFile);
        imagedestroy($img);

        return $tmpFile;
    }
}


trait PdfRotateTrait
{
    protected $angle = 0;

    public function Rotate($angle, $x = null, $y = null)
    {
        if ($this->angle !== 0) {
            $this->_out('Q');
        }

        $this->angle = $angle;

        if ($angle !== 0) {
            if ($x === null) $x = $this->x;
            if ($y === null) $y = $this->y;

            $angleRad = $angle * M_PI / 180;
            $c = cos($angleRad);
            $s = sin($angleRad);

            $cx = $x * $this->k;
            $cy = ($this->h - $y) * $this->k;

            $this->_out(sprintf(
                'q %.3F %.3F %.3F %.3F %.3F %.3F cm 1 0 0 1 %.3F %.3F cm',
                $c,
                $s,
                -$s,
                $c,
                $cx,
                $cy,
                -$cx,
                -$cy
            ));
        }
    }

    function _endpage()
    {
        if ($this->angle !== 0) {
            $this->angle = 0;
            $this->_out('Q');
        }

        parent::_endpage();
    }
}

class WatermarkFpdiNew extends Fpdi
{
    use PdfRotateTrait;
}
