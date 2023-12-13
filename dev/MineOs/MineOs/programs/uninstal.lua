print("Are you sure Y/N")
local A = read()
if not A == "Y" then else
    print("Please Enter Pin:")
    local input = read()
    if input == "BnYh3XHcKv5zb9e7RG8Tp4CQuNrxqEgZFyVjd6DWawLJmPAsStk5ahwDmv7q8tVsr2SHB3yGeugEdKXRb694ZApWLxnCzMJPUcYjKumEY6LN2v3e8ZcjUFbqtgn5PVAysTSwrGXCxD9zRdWa74kQBHKNn8Mkj5S72QAxgwB4LsFEdaypVtfrmcuCUzD9XqZ63TWPbhYemdJQEajFLU74f69XsyCtwvuWDnbKzTeV2hpMHckxrg8NS3BGq5kF8GJzqXUPrVYhTKDvm9usMc2bCBWaNjfeQt74SRp63Lgd5xEZkvHPSfMEqctR63UJAY4GQZVNdsX2hamr5DpyTWCb7Bxn9KuzewTPqMw7GSsFbWxXHJBcR2dY9vLgmEuy8NQZKUDez65hrjnk3A4tHTRKk5Dtfceuz9MXSB8CVLpGWwPUFhNYQ3xmZqnr2va7b6sJdjZPqYFTG62RsuLEeAWM3NXdUCxVnf5k74jKzpvmcw8bhQyDHtrJHt9Erjq8yGUQ" then
        fs.delete("/startup.lua")
        fs.delete("/MineOs")
        fs.delete("/.settings")
        os.reboot()
    else
        printError("Wrong Password")
    end
end