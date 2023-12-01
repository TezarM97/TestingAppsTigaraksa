package entity

type Dataperusahaan struct { //Tabel Name
	// gorm.Model

	MMstGepd  string `json:"m_mst_gepd,omitempty" validate:"required" `
	NamaGEPD  string `json:"NamaGEPD,omitempty" gorm:"column:NamaGEPD" validate:"required"`
	MMstEpd   string `json:"m_mst_epd,omitempty" validate:"required"`
	NamaEPD   string `json:"NamaEPD,omitempty"  gorm:"column:NamaEPD" validate:"required"`
	MBranchId string `json:"m_branch_id,omitempty" validate:"required"`
	MName     string `json:"m_name,omitempty" validate:"required" `

	// gorm.Model // ini created_at ama updated at
	// DeletedAt gorm.DeletedAt // ini ed_at
}
