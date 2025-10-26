function tempy
    # Create timestamp
    set timestamp (date +%Y%m%d-%H%M%S)

    # Create temp directory
    set tmpdir "/tmp/tempy/tempy-$timestamp"
    mkdir -p $tmpdir

    # Initialize jj with git colocated repo
    jj git init --colocate $tmpdir

    # Print path
    echo $tmpdir

    # Change to the directory
    cd $tmpdir
end
