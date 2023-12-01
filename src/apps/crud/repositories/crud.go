package repositories

import (
	"errors"

	"net/http"
	"testapps/src/common/entity"

	"testapps/src/config"

	"gorm.io/gorm"
)

type RepositoriesCrud struct{}

func (self RepositoriesCrud) CreateAja(save entity.Dataperusahaan) (int, entity.Dataperusahaan, string, error) {
	var dbexec entity.Dataperusahaan
	db_conn := config.DBClientMysql.
		Unscoped().
		Table("dataperusahaan").
		Create(&save)
	err := db_conn.Error

	if err != nil {
		return http.StatusNotFound, entity.Dataperusahaan{}, "Gagal Simpan Data", err
	}

	return http.StatusOK, dbexec, "Success", nil

}
func (self RepositoriesCrud) Delete(fild string, find any) (int, entity.Dataperusahaan, string, error) {

	var dbexec entity.Dataperusahaan
	db_conn := config.DBClientMysql.
		Unscoped().
		Where(fild, find).
		Table("dataperusahaan").
		Delete(&dbexec)
	err := db_conn.Error

	if err != nil {
		return http.StatusInternalServerError, entity.Dataperusahaan{}, "Error, Internal Server", err
	}

	return http.StatusOK, dbexec, "Success", nil
}
func (self RepositoriesCrud) FindOne(fild string, find any) (int, entity.Dataperusahaan, string, error) {

	var dbexec entity.Dataperusahaan
	db_conn := config.DBClientMysql.
		Unscoped().
		Where(fild, find).
		Table("dataperusahaan").
		Find(&dbexec)
	err := db_conn.Error

	if dbexec.MName == "" {
		return http.StatusNotFound, entity.Dataperusahaan{}, "Data Tidak Ditemukan", gorm.ErrRecordNotFound
	} else if err != nil {
		return http.StatusInternalServerError, entity.Dataperusahaan{}, "Error, Internal Server", err
	}

	return http.StatusOK, dbexec, "Success", nil
}

func (self RepositoriesCrud) LoginRep(find string, field any) (int, entity.Datalogin, string, error) {
	// datawhere := fmt.Sprintf(`username = %f AND passwords = %f`)
	var dbexec entity.Datalogin
	db_conn := config.DBClientMysql.
		Unscoped().
		Table("datalogin").
		Where(find, field).
		Find(&dbexec)
	err := db_conn.Error

	if err != nil {
		return http.StatusInternalServerError, entity.Datalogin{}, "Error, Internal Server", err
	}

	return http.StatusOK, dbexec, "Success", nil
}

func (self RepositoriesCrud) UpdateAllData(find entity.Dataperusahaan, save entity.Dataperusahaan) (int, entity.Dataperusahaan, string, error) {
	var dbexec entity.Dataperusahaan
	db_conn := config.DBClientMysql.
		Unscoped().
		Where(find).
		Assign(save).
		Table("dataperusahaan").
		FirstOrCreate(&dbexec)
	err := db_conn.Error

	if errors.Is(err, gorm.ErrRecordNotFound) {
		return http.StatusNotFound, entity.Dataperusahaan{}, "Data Tidak Ditemukan", err
	} else if err != nil {
		return http.StatusNotFound, entity.Dataperusahaan{}, "Server Internal Error", err
	}

	return http.StatusOK, dbexec, "Success", nil
}

func (self RepositoriesCrud) GetAllData() (int, []entity.Dataperusahaan, string, error) {
	var dbexec []entity.Dataperusahaan

	db_conn := config.DBClientMysql.
		Order("NamaGEPD asc").
		Table("dataperusahaan").
		Find(&dbexec)
	err := db_conn.Error

	if errors.Is(err, gorm.ErrRecordNotFound) {
		return http.StatusNotFound, []entity.Dataperusahaan{}, "Data Tidak Ditemukan", err
	} else if err != nil {
		return http.StatusNotFound, []entity.Dataperusahaan{}, "Server Internal Error", err
	}

	return http.StatusOK, dbexec, "Success", nil
}
