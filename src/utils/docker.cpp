#include "utils/docker.h"

#include "utils/fs.h"

namespace faas {
namespace docker_utils {

namespace {
std::string cgroupfs_root = "/sys/fs/cgroup";
}

void SetCgroupFsRoot(std::string_view path) {
    cgroupfs_root = std::string(path);
}

const std::string kInvalidContainerId(kContainerIdLength, '0');

std::string GetSelfContainerId() {
    std::string contents;
    if (!fs_utils::ReadContents("/proc/self/cgroup", &contents)) {
        LOG(ERROR) << "Failed to read /proc/self/cgroup";
        return kInvalidContainerId;
    }
    size_t pos = contents.find("/docker/");
    if (pos == std::string::npos
          || pos + strlen("/docker/") + kContainerIdLength >= contents.length()) {
        LOG(ERROR) << "Cannot find docker's cgroup in /proc/self/cgroup";
        return kInvalidContainerId;
    }
    return contents.substr(pos + strlen("/docker/"), kContainerIdLength);
}

}  // namespace docker_utils
}  // namespace faas
