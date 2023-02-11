function 'mgit' -d 'Check status for all ~/git/*/* repositories.'
    for repo in ~/git/*/*
        pushd $repo
        printf '%-48s:%s\n' $repo (fish_git_prompt)
        popd
    end
end
