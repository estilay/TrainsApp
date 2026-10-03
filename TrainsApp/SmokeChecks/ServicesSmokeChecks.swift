import Foundation
import OpenAPIURLSession

// MARK: - Nearest Stations
func smokeCheckNearestStations() async {
    do {
        let service = NearestStationsService(
            client: try SmokeCheckConfig.makeClient(),
            apikey: SmokeCheckConfig.apikey
        )
        let result = try await service.getNearestStations(
            lat: 55.7558, lng: 37.6173, distance: 5
        )
        dump(result, name: "NearestStations")
    } catch {
        print("[NearestStations]: \(error)")
    }
}

// MARK: - Copyright
func smokeCheckCopyright() async {
    do {
        let service = CopyrightService(
            client: try SmokeCheckConfig.makeClient(),
            apikey: SmokeCheckConfig.apikey
        )
        let result = try await service.getCopyright()
        dump(result, name: "Copyright")
    } catch {
        print("[Copyright]: \(error)")
    }
}

// MARK: - Search
func smokeCheckSearch() async {
    do {
        let service = SearchService(
            client: try SmokeCheckConfig.makeClient(),
            apikey: SmokeCheckConfig.apikey
        )
        let result = try await service.getScheduleBetweenStations(
            from: "c213", to: "c2",
            date: nil, transportTypes: nil, limit: 5, offset: nil
        )
        dump(result, name: "Search")
    } catch {
        print("[Search]: \(error)")
    }
}

// MARK: - Station Schedule
func smokeCheckStationSchedule() async {
    do {
        let service = StationScheduleService(
            client: try SmokeCheckConfig.makeClient(),
            apikey: SmokeCheckConfig.apikey
        )
        let result = try await service.getStationSchedule(
            station: "s9600213",
            date: nil, transportTypes: nil, event: nil, direction: nil, system: nil
        )
        dump(result, name: "StationSchedule")
    } catch {
        print("[StationSchedule]: \(error)")
    }
}

// MARK: - Route Stations
func smokeCheckRouteStations() async {
    do {
        let client = try SmokeCheckConfig.makeClient()

        let searchService = SearchService(client: client, apikey: SmokeCheckConfig.apikey)
        let search = try await searchService.getScheduleBetweenStations(
            from: "c213", to: "c2", limit: 1, offset: nil
        )

        guard let uid = search.segments?.first?.thread?.uid else {
            print("[RouteStations]: failed to obtain uid from Search")
            return
        }

        let service = RouteStationsService(client: client, apikey: SmokeCheckConfig.apikey)
        let result = try await service.getRouteStations(
            uid: uid, from: nil, to: nil, date: nil, showSystems: nil
        )
        dump(result, name: "RouteStations")
    } catch {
        print("[RouteStations]: \(error)")
    }
}

// MARK: - Nearest City
func smokeCheckNearestCity() async {
    do {
        let service = NearestCityService(
            client: try SmokeCheckConfig.makeClient(),
            apikey: SmokeCheckConfig.apikey
        )
        let result = try await service.getNearestCity(
            lat: 55.7558, lng: 37.6173, distance: nil
        )
        dump(result, name: "NearestCity")
    } catch {
        print("[NearestCity]: \(error)")
    }
}

// MARK: - Carrier Info
func smokeCheckCarrierInfo() async {
    do {
        let service = CarrierInfoService(
            client: try SmokeCheckConfig.makeClient(),
            apikey: SmokeCheckConfig.apikey
        )
        let result = try await service.getCarrierInfo(
            code: "SU", system: "iata"
        )
        dump(result, name: "CarrierInfo")
    } catch {
        print("[CarrierInfo]: \(error)")
    }
}

// MARK: - All Stations
func smokeCheckAllStations() async {
    do {
        let service = AllStationsService(
            client: try SmokeCheckConfig.makeClient(),
            apikey: SmokeCheckConfig.apikey
        )
        let result = try await service.getAllStations()
        for country in (result.countries ?? []).prefix(3) {
            print("— \(country.title ?? "—"): \(country.regions?.count ?? 0) regions")
        }
    } catch {
        print("[AllStations]: \(error)")
    }
}

// MARK: - Run all
func smokeCheckAll() async {
    print("Starting smoke Checks...")
    await smokeCheckNearestStations()
    await smokeCheckCopyright()
    await smokeCheckSearch()
    await smokeCheckStationSchedule()
    await smokeCheckRouteStations()
    await smokeCheckNearestCity()
    await smokeCheckCarrierInfo()
    await smokeCheckAllStations()
    print("Done.")
}
