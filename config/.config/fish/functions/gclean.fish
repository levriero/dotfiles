# Delete all local branches except `master` and `staging`
function gclean
  git for-each-ref --format '%(refname:short)' refs/heads | grep -v 'master\|staging' | xargs git branch -D
end
