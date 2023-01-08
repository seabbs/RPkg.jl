
# ======================== Utilities for adding packages ==========================
function add(pkgname)
    if ispath("renv.lock")
        path = pwd()
        R"""
        renv::install($pkgname, project = $path, repos=r);
        renv::record($pkgname, project=$path);
        """
        println("R package '$pkgname' added")
    else
        R"""
        install.packages($pkgname);
        """
    end
end

function add(pkgs...)
    for pkg in pkgs
        add(pkg)
    end
end

function add(pkg, remote::Symbol)
    if remote == :github
        R"""
        devtools::install_github($pkg)
        """
    elseif remote == :bioc
        R"""
        BiocManager::install($pkg)
        """
    else
        @error "Invalid host keyword"
    end
end
# ======================== Utilities for removing packages ============================
function rm(pkgname)
    R"""
    renv::remove($pkgname);
    """
    println("R package '$pkgname' deleted")
end

function rm(pkgs...)
    for pkg in pkgs
        rm(pkg)
    end
end
# ======================== Activate Prjct Env ============================
function activate() 
    R"""
    renv::activate()
    """
end
# ======================== Instantiate ============================
function instantiate(;path=pwd())
    if ispath("renv.lock")
        println("R Project Environment is already activated!")
    else
        R"""
        renv::init(project = $path)
        """
        println("Restaring R Now...")
        return  
    end
end


function status()
    path = pwd()
    R"""
    renv::dependencies()
    """
end

function update()
    R"""
    renv::update()
    """
end

function update(pkgname)
    R"""
    renv::update($pkgname)
    """
end

function update(pkgs...)
    for pkg in pkgs
        update(pkg)
    end
end

function build()
    R"""
    renv::rebuild()
    """
end 

function build(pkgname)
    R"""
    renv::rebuild($pkgname)
    """
end 

function build(pkgs...)
    for pkg in pkgs
        build(pkg)
    end
end

function resolve()
    R"""
    renv::repair()
    """
end