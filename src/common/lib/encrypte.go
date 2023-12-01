package lib

import (
	"crypto/sha256"
	"encoding/base64"
	"encoding/hex"
	"fmt"

	"golang.org/x/crypto/bcrypt"
)

func HashPassword(password string) (string, error) {
	// bytes, err := bcrypt.GenerateFromPassword([]byte(password), 14)
	bytes, err := bcrypt.GenerateFromPassword([]byte(password), bcrypt.DefaultCost)
	return string(bytes), err
}

func CheckPasswordHash(password, hash string) bool {
	err := bcrypt.CompareHashAndPassword([]byte(hash), []byte(password))
	return err == nil
}

func Base64Encoding(data string) string {
	str := data
	encodedStr := base64.StdEncoding.EncodeToString([]byte(str))
	fmt.Println("Encoded:", encodedStr)

	return encodedStr
}

func Base64Decoding(data string) string {
	str := data
	decodedStr, err := base64.StdEncoding.DecodeString(str)
	if err != nil {
		panic("malformed input")
	}
	fmt.Println("Decoded:", string(decodedStr))

	return string(decodedStr)
}

func NewSHA256(data string) string {
	h := sha256.New()
	h.Write([]byte(data))
	sha := hex.EncodeToString(h.Sum(nil))
	return sha
}
