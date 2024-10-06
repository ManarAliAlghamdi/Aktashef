import Foundation

func loadCountries() -> [Countries] {
  
    
    let fileManager = FileManager.default
    

  
    if let url = getDocumentsDirectory()?.appendingPathComponent("countries.json"),
       fileManager.fileExists(atPath: url.path) {
        
        do {
            let data = try Data(contentsOf: url)
            
            let decoder = JSONDecoder()
            
            let jsonData = try decoder.decode([Countries].self, from: data)

            
            return jsonData

        } catch {
            print("Error loading JSON data from Documents Directory: \(error)")
            
            
        }
    }

    if let bundleUrl = Bundle.main.url(forResource: "countries", withExtension: "json") {
        
        do {
            let data = try Data(contentsOf: bundleUrl)
            
            let decoder = JSONDecoder()
            
            let jsonData = try decoder.decode([Countries].self, from: data)
           
            if let url = getDocumentsDirectory()?.appendingPathComponent("countries.json") {
                try data.write(to: url)
                
            }
            
            return jsonData
        } catch {
            print("Error loading JSON data from Bundle: \(error)")
            
        }
    }

    return []
   
}


func saveCountriesToJSON(countries: [Countries]) {
    let encoder = JSONEncoder()
    encoder.outputFormatting = .prettyPrinted

    do {
        let data = try encoder.encode(countries)
        if let url = getDocumentsDirectory()?.appendingPathComponent("countries.json") {
            try data.write(to: url)
            print("Successfully saved countries to JSON file.")
        }
    } catch {
        print("Failed to save countries to JSON: \(error)")
    }
}

// Helper function to get the Documents Directory
func getDocumentsDirectory() -> URL? {
    let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
    return paths.first
}
