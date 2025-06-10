# Pipeline CPU Performance Benchmark

This repository contains OpenShift/Kubernetes resources to run a CPU performance benchmark using a Tekton pipeline. The benchmark measures matrix multiplication performance and reports metrics like execution time and operations per second.

## 📋 Prerequisites

- OpenShift 4.x+ or Kubernetes 1.24+ cluster
- Tekton Pipelines v0.40.0+ installed
- `oc` or `kubectl` CLI configured
- Cluster admin privileges (for namespace creation)
- 2 vCPUs and 4GB RAM available for benchmark tasks

## 🚀 Quick Start

```bash
git clone https://github.com/BabbarPB08/pipeline-pref.git
cd pipeline-pref
oc apply -k cpu-perf-tester/ns/.
oc apply -k cpu-perf-tester/resources/.
```

## 🔍 Monitoring Results

1. Access the OpenShift Console
2. Navigate to: **Pipelines** → **PipelineRuns**
3. Select the latest run
4. View logs under the `run-benchmark` task

## 📊 Expected Output

```plaintext
[2025-06-10 20:08:04] === Benchmark Script Start ===
[2025-06-10 20:08:04] Benchmark Result:
+------------------+----------------------+
| Matrix Size      | 1000 x 1000          |
+------------------+----------------------+
| Time Taken (sec) | 0.02                 |
+------------------+----------------------+
| Speed            | 46662.48 MegaOps/sec |
+------------------+----------------------+
System C-State Info: 9
```

## 🔄 Workflow Diagram

```mermaid
sequenceDiagram
    participant User
    participant OpenShift
    participant Tekton
    participant BenchmarkPod
    
    User->>OpenShift: Apply Kubernetes Manifests
    OpenShift->>Tekton: Create PipelineRun
    Tekton->>BenchmarkPod: Create Pod with 2 containers
    BenchmarkPod->>BenchmarkPod: copy-script (init)
    BenchmarkPod->>BenchmarkPod: run-benchmark (main)
    BenchmarkPod-->>Tekton: Stream Logs
    Tekton-->>OpenShift: Update Status
    OpenShift-->>User: Display Results in Console
```

## 🧩 Benchmark Details

### Test Methodology
- Uses Python NumPy for matrix operations
- 1000×1000 floating-point matrices
- Measures:
  - Pure computation time (excluding I/O)
  - Floating-point operations per second
  - System power state (C-State)

### Performance Metrics
| Metric               | Description                          |
|----------------------|--------------------------------------|
| Matrix Size          | Dimension of test matrices           |
| Time Taken           | Wall-clock execution time (seconds)  |
| MegaOps/sec          | Millions of operations per second    |
| C-State              | CPU power saving state (0-9)         |

## 📂 Repository Structure

```
cpu-perf-tester/
├── ns/
│   ├── kustomization.yaml
│   └── namespace.yaml
└── resources/
    ├── pipeline.yaml
    ├── task-copy-script.yaml
    ├── task-run-benchmark.yaml
    └── kustomization.yaml
```

## 📜 License

Apache License 2.0

```text
Copyright 2024 Your Name

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

   http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.
```

## 🤝 Contributing

1. Fork the repository
2. Create a feature branch (`git checkout -b feature/improvement`)
3. Commit changes (`git commit -am 'Add new feature'`)
4. Push to branch (`git push origin feature/improvement`)
5. Open a Pull Request

```
