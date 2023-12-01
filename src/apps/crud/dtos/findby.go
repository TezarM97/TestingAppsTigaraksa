package dtos

type DtosFindByName struct {
	Name string `json:"m_name,omitempty" validate:"required"`
}

type DtosLogin struct {
	Username  string `json:"username,omitempty" gorm:"column:username" validate:"required"`
	Namauser  string `json:"namauser,omitempty" gorm:"column:namauser" `
	Passwords string `json:"passwords,omitempty"`
	Tipe      string `json:"tipe,omitempty"`
}
