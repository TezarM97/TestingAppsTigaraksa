package lib

import (
	"github.com/golang-jwt/jwt"
)

type JwtEntity struct {
	Id       uint   `json:"id"`
	Fullname string `json:"fullname"`
	Email    string `json:"email"`
	Gender   string `json:"gender"`
	// Password    string             `json:"password"`
	Phone      string     `json:"phone"`
	Active     int32      `json:"active"`
	IsRevoked  int32      `json:"is_revoked"`
	MediaId    string     `json:"media_id"`
	IdGroups   int64      `json:"id_groups"`
	UserGroups UserGroups `json:"user_groups"`
	jwt.StandardClaims
}

type JwtEntityResponse struct {
	Id       uint   `json:"id,omitempty"`
	Fullname string `json:"fullname,omitempty"`
	Email    string `json:"email,omitempty"`
	Gender   string `json:"gender,omitempty"`
	// Password    string             `json:"password"`
	Phone      string     `json:"phone,omitempty"`
	Active     int32      `json:"active,omitempty"`
	IsRevoked  int32      `json:"is_revoked,omitempty"`
	MediaId    string     `json:"media_id,omitempty"`
	IdGroups   int64      `json:"id_groups,omitempty"`
	UserGroups UserGroups `json:"user_groups,omitempty"`
	Token      string     `json:"token,omitempty"`
}

type UserGroups struct {
	Id   uint   `json:"id,omitempty"`
	Name string `json:"name,omitempty"`
}
