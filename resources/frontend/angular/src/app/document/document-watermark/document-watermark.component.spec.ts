import { ComponentFixture, TestBed } from '@angular/core/testing';

import { DocumentWatermarkComponent } from './document-watermark.component';

describe('DocumentWatermarkComponent', () => {
  let component: DocumentWatermarkComponent;
  let fixture: ComponentFixture<DocumentWatermarkComponent>;

  beforeEach(async () => {
    await TestBed.configureTestingModule({
      imports: [DocumentWatermarkComponent]
    })
    .compileComponents();

    fixture = TestBed.createComponent(DocumentWatermarkComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
