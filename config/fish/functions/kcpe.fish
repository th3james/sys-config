function kcpe -d 'kubectl exec on pod' -a pod_name 
  kubectl exec -it (kcpls $pod_name) -- $argv[2..]
end
