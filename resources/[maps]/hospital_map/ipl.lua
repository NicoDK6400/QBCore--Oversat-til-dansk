
Citizen.CreateThread(function()
  RequestIpl("rc12b_default")
  RemoveIpl("rc12b_default")
  RequestIpl("rc12b_destroyed")
  RemoveIpl("rc12b_destroyed")
  RequestIpl("rc12b_hospitalinterior")
end)
