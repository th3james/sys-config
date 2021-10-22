function kcpe -d 'kubectl exec on pod' -a namespace pod_name 
  kubectl exec --namespace=$namespace -it (kcpls $namespace $pod_name) -- $argv[3..]
end
