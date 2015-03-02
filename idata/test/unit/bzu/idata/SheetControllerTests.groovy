package bzu.idata



import org.junit.*
import grails.test.mixin.*

@TestFor(SheetController)
@Mock(Sheet)
class SheetControllerTests {

    def populateValidParams(params) {
        assert params != null
        // TODO: Populate valid properties like...
        //params["name"] = 'someValidName'
    }

    void testIndex() {
        controller.index()
        assert "/sheet/list" == response.redirectedUrl
    }

    void testList() {

        def model = controller.list()

        assert model.sheetInstanceList.size() == 0
        assert model.sheetInstanceTotal == 0
    }

    void testCreate() {
        def model = controller.create()

        assert model.sheetInstance != null
    }

    void testSave() {
        controller.save()

        assert model.sheetInstance != null
        assert view == '/sheet/create'

        response.reset()

        populateValidParams(params)
        controller.save()

        assert response.redirectedUrl == '/sheet/show/1'
        assert controller.flash.message != null
        assert Sheet.count() == 1
    }

    void testShow() {
        controller.show()

        assert flash.message != null
        assert response.redirectedUrl == '/sheet/list'

        populateValidParams(params)
        def sheet = new Sheet(params)

        assert sheet.save() != null

        params.id = sheet.id

        def model = controller.show()

        assert model.sheetInstance == sheet
    }

    void testEdit() {
        controller.edit()

        assert flash.message != null
        assert response.redirectedUrl == '/sheet/list'

        populateValidParams(params)
        def sheet = new Sheet(params)

        assert sheet.save() != null

        params.id = sheet.id

        def model = controller.edit()

        assert model.sheetInstance == sheet
    }

    void testUpdate() {
        controller.update()

        assert flash.message != null
        assert response.redirectedUrl == '/sheet/list'

        response.reset()

        populateValidParams(params)
        def sheet = new Sheet(params)

        assert sheet.save() != null

        // test invalid parameters in update
        params.id = sheet.id
        //TODO: add invalid values to params object

        controller.update()

        assert view == "/sheet/edit"
        assert model.sheetInstance != null

        sheet.clearErrors()

        populateValidParams(params)
        controller.update()

        assert response.redirectedUrl == "/sheet/show/$sheet.id"
        assert flash.message != null

        //test outdated version number
        response.reset()
        sheet.clearErrors()

        populateValidParams(params)
        params.id = sheet.id
        params.version = -1
        controller.update()

        assert view == "/sheet/edit"
        assert model.sheetInstance != null
        assert model.sheetInstance.errors.getFieldError('version')
        assert flash.message != null
    }

    void testDelete() {
        controller.delete()
        assert flash.message != null
        assert response.redirectedUrl == '/sheet/list'

        response.reset()

        populateValidParams(params)
        def sheet = new Sheet(params)

        assert sheet.save() != null
        assert Sheet.count() == 1

        params.id = sheet.id

        controller.delete()

        assert Sheet.count() == 0
        assert Sheet.get(sheet.id) == null
        assert response.redirectedUrl == '/sheet/list'
    }
}
