function fish_prompt --description 'Write out the prompt'
    echo -n (set_color $fish_color_cwd)(prompt_pwd)
    echo -n (set_color normal)(fish_vcs_prompt)
    echo -n (set_color normal) '> '
end
