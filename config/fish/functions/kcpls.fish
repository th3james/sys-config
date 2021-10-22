function kcpls -d 'kubectl search pods' -a namespace pod_name
  kubectl get pods --namespace=$namespace -o wide | grep "$pod_name" | awk '{ print $1 }' 
end
