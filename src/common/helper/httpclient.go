package helper

import (
	"bytes"
	"crypto/tls"
	"encoding/json"
	"mime/multipart"
	"net/http"
	"time"

	"testapps/src/common/lib"
)

type HelperHttpClient struct{}

func (self HelperHttpClient) HttpClientJson(method string, url string, reqbody any, header []lib.DtosHeader) (lib.HttpClientStructResponse, error) {
	postBody, err := json.Marshal(reqbody)
	if err != nil {
		return lib.HttpClientStructResponse{}, err
	}

	bodyrequest := bytes.NewReader(postBody)

	tr := &http.Transport{
		MaxIdleConns:       10,
		IdleConnTimeout:    10 * time.Second,
		DisableCompression: true,
		TLSClientConfig:    &tls.Config{InsecureSkipVerify: true},
	}
	c := http.Client{Transport: tr}
	req, err := http.NewRequest(method, url, bodyrequest)
	if err != nil {
		return lib.HttpClientStructResponse{}, err
	}
	//---- header create
	for _, v := range header {
		req.Header.Add(v.Key, v.Value)
	}

	resp, err := c.Do(req)
	if err != nil {
		return lib.HttpClientStructResponse{}, err
	}

	defer resp.Body.Close()

	var resutl lib.Mapany

	json.NewDecoder(resp.Body).Decode(&resutl)

	return lib.HttpClientStructResponse{
		Code: resp.StatusCode,
		Body: resutl,
	}, nil

}

func (self HelperHttpClient) HttpClientFormMultypart(method string, url string, reqbody []lib.DtosBody, header []lib.DtosBody, response any) error {
	// client := &http.Client{}
	payload := &bytes.Buffer{}
	writer := multipart.NewWriter(payload)

	if len(reqbody) > 0 {
		for _, v := range reqbody {
			_ = writer.WriteField(v.Key, v.Value)
		}
	}

	return nil
}
