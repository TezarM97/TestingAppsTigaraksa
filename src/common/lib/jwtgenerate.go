package lib

import (
	"errors"
	"fmt"
	"strings"

	"github.com/gin-gonic/gin"
	"github.com/golang-jwt/jwt"
	"github.com/spf13/viper"
)

var jwtKey = []byte(viper.GetString("common.jwt_key"))

//--------------------------------------------------------

func JwtEncode(jwtentity JwtEntity) (string, int64, error) {
	expiresAt := AddHours(viper.GetInt("common.jwt_hour")).Unix()
	claims := JwtEntity{
		Id:         jwtentity.Id,
		Fullname:   jwtentity.Fullname,
		Email:      jwtentity.Email,
		Gender:     jwtentity.Gender,
		Phone:      jwtentity.Phone,
		Active:     jwtentity.Active,
		IsRevoked:  jwtentity.IsRevoked,
		MediaId:    jwtentity.MediaId,
		IdGroups:   jwtentity.IdGroups,
		UserGroups: jwtentity.UserGroups,
		StandardClaims: jwt.StandardClaims{
			// In JWT, the expiry time is expressed as unix milliseconds
			ExpiresAt: expiresAt,
		},
	}

	token := jwt.NewWithClaims(jwt.SigningMethodHS512, claims)
	tokenString, err := token.SignedString(jwtKey)
	if err != nil {
		return "", 0, err
	}
	return tokenString, expiresAt, nil
}

func GetToken(c *gin.Context) (string, bool) {
	authValue := c.GetHeader("Authorization")
	arr := strings.Split(authValue, " ")
	if len(arr) != 2 {
		return "", false
	}
	authType := strings.Trim(arr[0], "\n\r\t")
	if strings.ToLower(authType) != strings.ToLower("Bearer") {
		return "", false
	}
	return strings.Trim(arr[1], "\n\t\r"), true
}

func ValidateToken(tokenString string) (JwtEntity, error) {
	var claims JwtEntity
	token, err := jwt.ParseWithClaims(tokenString, &claims, func(token *jwt.Token) (interface{}, error) {
		if _, ok := token.Method.(*jwt.SigningMethodHMAC); !ok {
			return nil, fmt.Errorf("unexpected signing method: %v", token.Header["alg"])
		}
		return jwtKey, nil
	})
	if err != nil {
		return JwtEntity{}, err
	}
	if !token.Valid {
		return JwtEntity{}, errors.New("invalid token")
	}

	return claims, nil
}
