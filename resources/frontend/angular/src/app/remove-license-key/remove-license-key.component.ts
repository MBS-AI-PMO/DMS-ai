import { CommonModule } from '@angular/common';
import { Component, inject, OnInit } from '@angular/core';
import { ReactiveFormsModule } from '@angular/forms';
import { LicenseValidatorService } from '@mlglobtech/license-validator-docphp';

@Component({
  selector: 'app-remove-license-key',
  standalone: true,
  imports: [
    CommonModule,
    ReactiveFormsModule
  ],
  templateUrl: './remove-license-key.component.html',
  styleUrl: './remove-license-key.component.scss'
})
export class RemoveLicenseKeyComponent implements OnInit {
  licenseValidatorService = inject(LicenseValidatorService);

  ngOnInit(): void {
  }

  onDeactiveLicense(): void {
    this.licenseValidatorService.onDeactiveLicense('');
  }
}
