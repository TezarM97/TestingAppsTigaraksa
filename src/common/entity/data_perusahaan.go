package entity

type Dataperusahaans struct {
	MMstGepd  string `json:"m_mst_gepd,omitempty" `
	NamaGEPD  string `json:"NamaGEPD,omitempty"  `
	MMstEpd   string `json:"m_mst_epd,omitempty"`
	NamaEPD   string `json:"NamaEPD,omitempty" `
	MBranchId string `json:"m_branch_id,omitempty"  `
	MName     string `json:"m_name,omitempty" `
}

type Datalogin struct {
	NamaUser  string `json:"namauser,omitempty" gorm:"column:namauser" `
	UserName  string `json:"username,omitempty" gorm:"column:username" `
	Passwords string `json:"passwords,omitempty"`
	Tipe      string `json:"tipe,omitempty"`
}
