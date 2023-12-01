package dtos

type DtosPanelLogin struct {
	NamaUser  string `json:"namauser,omitempty" validate:"required"`
	Username  string `json:"username,omitempty" validate:"required"`
	Tipe      string `json:"tipe,omitempty" validate:"required"`
	Passwords string `json:"passwords,omitempty" validate:"required"`
}

type DtosDataKaryawan struct {
	IdGEPD   string `json:"m_mst_gepd,omitempty" validate:"required"`
	NamaGEPD string `json:"NamaGEPD,omitempty" validate:"required"`
	IdEPD    string `json:"m_mst_epd,omitempty" validate:"required"`
	NamaEPD  string `json:"NamaEPD,omitempty" validate:"required"`
	BranchId string `json:"m_branch_id,omitempty" validate:"required"`
	Name     string `json:"m_name,omitempty" validate:"required"`
}
