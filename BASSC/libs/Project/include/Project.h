#include <filesystem>
#include "BCache/BCache"
#include <string>

class Project{
public:
    Project(std::filesystem::path projkDir, std::filesystem::path wavdir);

private:


    std::filesystem::path _project_data_dir;

    std::filesystem::path _wav_data_dir;

    std::string _birdName;

    std::string _projectName;

    BCache _cache;
};
