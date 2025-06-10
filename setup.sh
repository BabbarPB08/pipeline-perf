# Step 1: Apply namespace
oc apply -k cpu-perf-tester/ns/.

# Step 2: Wait for namespace to become Active
while [[ $(oc get ns pipeline-pref -o jsonpath='{.status.phase}') != "Active" ]]; do
  echo "Waiting for kafka namespace to be Active..."
  sleep 2
done

# Step 3: Apply rest of the resources
oc apply -k cpu-perf-tester/resources/.
