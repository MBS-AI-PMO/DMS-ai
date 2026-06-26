import {
  AfterViewInit,
  Component,
  ElementRef,
  HostListener,
  Input,
  OnChanges,
  OnInit,
  SimpleChanges,
  ViewChild,
} from '@angular/core';
import { DocumentByCategory } from '@core/domain-classes/document-by-category';
import { LegendPosition } from '@swimlane/ngx-charts';
import { DASHBOARD_COLOR_SCHEME } from '../dashboard-theme';
import { DashboradService } from '../dashboard.service';

type ChartType = 'pie' | 'bar';

@Component({
  selector: 'app-document-by-category-chart',
  templateUrl: './document-by-category-chart.component.html',
  styleUrls: ['./document-by-category-chart.component.scss'],
})
export class DocumentByCategoryChartComponent
  implements OnInit, OnChanges, AfterViewInit
{
  @ViewChild('chartContainer') chartContainer?: ElementRef<HTMLElement>;
  @Input() chartData: DocumentByCategory[] | null = null;
  @Input() loading = false;

  single: { name: string; value: number }[] = [];
  view: [number, number] = [700, 360];
  chartType: ChartType = 'pie';
  legendPosition = LegendPosition.Below;
  colorScheme = DASHBOARD_COLOR_SCHEME;
  totalDocuments = 0;

  constructor(private dashboardService: DashboradService) {}

  ngOnInit(): void {
    if (!this.chartData) {
      this.fetchChartData();
    }
  }

  ngOnChanges(changes: SimpleChanges): void {
    if (changes['chartData'] && this.chartData) {
      this.applyChartData(this.chartData);
    }
  }

  ngAfterViewInit(): void {
    setTimeout(() => this.updateChartView());
  }

  @HostListener('window:resize')
  onResize(): void {
    this.updateChartView();
  }

  setChartType(type: ChartType): void {
    this.chartType = type;
    setTimeout(() => this.updateChartView());
  }

  private fetchChartData(): void {
    this.loading = true;
    this.dashboardService.getDocumentByCategory().subscribe({
      next: (data) => {
        this.applyChartData(data ?? []);
        this.loading = false;
      },
      error: () => {
        this.single = [];
        this.loading = false;
      },
    });
  }

  private applyChartData(data: DocumentByCategory[]): void {
    this.single = data.map((item) => ({
      name: item.categoryName,
      value: item.documentCount ?? 0,
    }));
    this.totalDocuments = this.single.reduce((sum, item) => sum + item.value, 0);
  }

  private updateChartView(): void {
    if (!this.chartContainer?.nativeElement) {
      return;
    }

    const width = this.chartContainer.nativeElement.clientWidth;
    const chartWidth = Math.max(width - 24, 280);
    const chartHeight = this.chartType === 'bar' ? 380 : 360;
    this.view = [chartWidth, chartHeight];
  }
}
