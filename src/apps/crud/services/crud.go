package services // services adalah nama folder
import (
	"fmt"
	"net/http"
	"testapps/src/apps/crud/dtos"
	"testapps/src/apps/crud/repositories"
	"testapps/src/common/entity"
)

type ServicesCrud struct{}

func (self ServicesCrud) Update(find entity.Dataperusahaan, req entity.Dataperusahaan) (int, entity.Dataperusahaan, string, error) {
	code, data, message, errorresp := repositories.RepositoriesCrud{}.UpdateAllData(
		entity.Dataperusahaan{MMstGepd: find.MMstGepd, NamaGEPD: find.NamaGEPD, MMstEpd: find.MMstEpd, NamaEPD: find.NamaEPD, MBranchId: find.MBranchId, MName: find.MName},
		entity.Dataperusahaan{MMstGepd: req.MMstGepd, NamaGEPD: req.NamaGEPD, MMstEpd: req.MMstEpd, NamaEPD: req.NamaEPD, MBranchId: req.MBranchId, MName: req.MName})
	if errorresp != nil {
		return code, data, message, errorresp
	}

	return http.StatusOK, data, "success", nil
}

func (self ServicesCrud) Index() (int, []entity.Dataperusahaan, string, error) {

	code, data, message, errorresp := repositories.RepositoriesCrud{}.GetAllData()
	if errorresp != nil {
		return code, []entity.Dataperusahaan{}, message, errorresp
	}

	return http.StatusOK, data, "success", nil
}

func (self ServicesCrud) Delete(req dtos.DtosFindByName) (int, entity.Dataperusahaan, string, error) {
	codedetail, data, messagedetail, errorrespdetail := repositories.RepositoriesCrud{}.Delete("m_name", req.Name)

	if errorrespdetail != nil {
		return codedetail, data, messagedetail, errorrespdetail
	}

	return http.StatusOK, data, "success", nil
}

func (self ServicesCrud) GetDataByName(req dtos.DtosFindByName) (int, entity.Dataperusahaan, string, error) {

	code, data, message, errorresp := repositories.RepositoriesCrud{}.FindOne("m_name", req.Name)
	if errorresp != nil {
		return code, data, message, errorresp
	}

	return http.StatusOK, data, "success", nil
}

func (self ServicesCrud) Logins(req dtos.DtosLogin) (int, entity.Datalogin, string, error) {

	code, data, message, errorresp := repositories.RepositoriesCrud{}.LoginRep("username", req.Username)
	if errorresp != nil {
		return code, data, message, errorresp
	}

	return http.StatusOK, data, "success", nil
}

func (self ServicesCrud) GetDataById(id string) (int, entity.Dataperusahaan, string, error) {

	code, data, message, errorresp := repositories.RepositoriesCrud{}.FindOne("m_mst_gepd", id)
	if errorresp != nil {
		return code, data, message, errorresp
	}

	return http.StatusOK, data, "success", nil
}

func (self ServicesCrud) Store(req entity.Dataperusahaan) (int, entity.Dataperusahaan, string, error) {

	fmt.Println("datanya : ", req)
	code, data, message, errorresp := repositories.RepositoriesCrud{}.CreateAja(entity.Dataperusahaan{
		MMstGepd:  req.MMstGepd,
		NamaGEPD:  req.NamaGEPD,
		MMstEpd:   req.MMstEpd,
		NamaEPD:   req.NamaEPD,
		MBranchId: req.MBranchId,
		MName:     req.MName})

	if errorresp != nil {
		return code, data, message, errorresp
	}
	return http.StatusOK, data, "success", nil
}
