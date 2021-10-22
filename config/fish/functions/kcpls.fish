function kcpls -d 'kubectl search pods' -a pod_name
  kubectl get pods -o wide | grep "$pod_name" | awk '{ print $1 }' 
end
