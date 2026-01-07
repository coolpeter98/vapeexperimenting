--[[

this is EXTREMELY SKIDDED... /srs

]]

local run = function(func) func() end
local cloneref = cloneref or function(obj) return obj end

local playersService = cloneref(game:GetService('Players'))
local inputService = cloneref(game:GetService('UserInputService'))
local replicatedStorage = cloneref(game:GetService('ReplicatedStorage'))
local runService = cloneref(game:GetService('RunService'))

local gameCamera = workspace.CurrentCamera
local lplr = playersService.LocalPlayer
local vape = shared.vape
local entitylib = vape.Libraries.entity
local targetinfo = vape.Libraries.targetinfo

local lMouse = cloneref(lplr:GetMouse())

run(function()
local Killaura
local Targets
local CPS
local SwingRange
local AttackRange
local AngleSlider
local Max
local Mouse
local Swing
local BoxSwingColor
local BoxAttackColor
local ParticleTexture
local ParticleColor1
local ParticleColor2
local ParticleSize
local LegitAura
local Particles, Boxes, AttackDelay, SwingDelay, ClickDelay = {}, {}, tick(), tick(), tick()

local function getAttackData()
if Mouse.Enabled then
	if not inputService:IsMouseButtonPressed(0) then return false end
		end
		if LegitAura.Enabled then
			if ClickDelay < tick() then return false end
				end

				local tool = lplr.Character and lplr.Character:FindFirstChildWhichIsA('Tool', true)
				return tool and tool:HasTag('Sword') and tool or false
				end

				Killaura = vape.Categories.Blatant:CreateModule({
					Name = 'Killaura',
					Function = function(callback)
					if callback then
						if LegitAura.Enabled then
							Killaura:Clean(inputService.InputBegan:Connect(function(input)
							if input.UserInputType == Enum.UserInputType.MouseButton1 then
								ClickDelay = tick() + 0.1
								end
								end))
							end

							repeat
							local tool = getAttackData()
							local attacked = {}

							if tool then
								local plrs = entitylib.AllPosition({
									Range = SwingRange.Value,
									Wallcheck = Targets.Walls.Enabled or nil,
									Part = 'RootPart',
									Players = Targets.Players.Enabled,
									NPCs = Targets.NPCs.Enabled,
									Limit = Max.Value
								})

								if #plrs > 0 then
									local selfpos = entitylib.character.RootPart.Position
									local localfacing = entitylib.character.RootPart.CFrame.LookVector * Vector3.new(1, 0, 1)

									for _, v in plrs do
										local delta = (v.RootPart.Position - selfpos)
										local angle = math.acos(localfacing:Dot((delta * Vector3.new(1, 0, 1)).Unit))
										if angle > math.rad(AngleSlider.Value / 2) then continue end

											table.insert(attacked, {
												Entity = v,
												Check = delta.Magnitude > AttackRange.Value and BoxSwingColor or BoxAttackColor
											})
											targetinfo.Targets[v] = tick() + 1

				if not Swing.Enabled and SwingDelay < tick() then
					SwingDelay = tick() + 0.25
					local anim = entitylib.character.Humanoid.Animator:LoadAnimation(tool.Animations.Swing)
					anim:Play()

					if vape.ThreadFix then setthreadidentity(2) end
						pcall(function() bd.ViewmodelController:PlayAnimation(tool.Name) end)
						if vape.ThreadFix then setthreadidentity(8) end
							end

							if delta.Magnitude > AttackRange.Value then continue end

								if AttackDelay < tick() then
									AttackDelay = tick() + (1 / CPS.GetRandomValue())

									pcall(function()
									replicatedStorage:WaitForChild("Network"):WaitForChild("RequestSwordHit")
									:FireServer(v.Character)
									end)
									end
									end
									end
									end

									for i, box in Boxes do
										box.Adornee = attacked[i] and attacked[i].Entity.RootPart or nil
										if box.Adornee then
											box.Color3 = Color3.fromHSV(attacked[i].Check.Hue, attacked[i].Check.Sat, attacked[i].Check.Value)
											box.Transparency = 1 - attacked[i].Check.Opacity
											end
											end

											for i, part in Particles do
												if attacked[i] then
													part.Position = attacked[i].Entity.RootPart.Position
													part.Parent = gameCamera
													else
														part.Position = Vector3.new(9e9, 9e9, 9e9)
														part.Parent = nil
														end
														end

														task.wait()
														until not Killaura.Enabled
														else
															for _, box in Boxes do box.Adornee = nil end
																for _, part in Particles do part.Parent = nil end
																	end
																	end,
																	Tooltip = 'Attack players around you\nwithout aiming at them.'
				})

				Targets = Killaura:CreateTargets({Players = true})
				CPS = Killaura:CreateTwoSlider({
					Name = 'Attacks per Second',
					Min = 1,
					Max = 20,
					DefaultMin = 12,
					DefaultMax = 12
				})
				SwingRange = Killaura:CreateSlider({
					Name = 'Swing range',
					Min = 1,
					Max = 16,
					Default = 16,
					Suffix = function(val) return val == 1 and 'stud' or 'studs' end
				})
				AttackRange = Killaura:CreateSlider({
					Name = 'Attack range',
					Min = 1,
					Max = 16,
					Default = 16,
					Suffix = function(val) return val == 1 and 'stud' or 'studs' end
				})
				AngleSlider = Killaura:CreateSlider({
					Name = 'Max angle',
					Min = 1,
					Max = 360,
					Default = 360
				})
				Max = Killaura:CreateSlider({
					Name = 'Max targets',
					Min = 1,
					Max = 10,
					Default = 10
				})
				Mouse = Killaura:CreateToggle({Name = 'Require mouse down'})
				Swing = Killaura:CreateToggle({Name = 'No Swing'})

				Killaura:CreateToggle({
					Name = 'Show target',
					Function = function(callback)
					BoxSwingColor.Object.Visible = callback
					BoxAttackColor.Object.Visible = callback
					if callback then
						for i = 1, 10 do
							local box = Instance.new('BoxHandleAdornment')
							box.Adornee = nil
							box.AlwaysOnTop = true
							box.Size = Vector3.new(3, 5, 3)
							box.CFrame = CFrame.new(0, -0.5, 0)
							box.ZIndex = 0
							box.Parent = vape.gui
							Boxes[i] = box
							end
							else
								for _, box in Boxes do box:Destroy() end
									table.clear(Boxes)
									end
									end
				})
				BoxSwingColor = Killaura:CreateColorSlider({Name = 'Target Color', Darker = true, DefaultHue = 0.6, DefaultOpacity = 0.5, Visible = false})
				BoxAttackColor = Killaura:CreateColorSlider({Name = 'Attack Color', Darker = true, DefaultOpacity = 0.5, Visible = false})

				Killaura:CreateToggle({
					Name = 'Target particles',
					Function = function(callback)
					ParticleTexture.Object.Visible = callback
					ParticleColor1.Object.Visible = callback
					ParticleColor2.Object.Visible = callback
					ParticleSize.Object.Visible = callback
					if callback then
						for i = 1, 10 do
							local part = Instance.new('Part')
							part.Size = Vector3.new(2, 4, 2)
							part.Anchored = true
							part.CanCollide = false
							part.Transparency = 1
							part.CanQuery = false
							part.Parent = nil

							local emitter = Instance.new('ParticleEmitter', part)
							emitter.Brightness = 1.5
							emitter.Size = NumberSequence.new(ParticleSize.Value)
							emitter.Shape = Enum.ParticleEmitterShape.Sphere
							emitter.Texture = ParticleTexture.Value
							emitter.Transparency = NumberSequence.new(0)
							emitter.Lifetime = NumberRange.new(0.4)
							emitter.Speed = NumberRange.new(16)
							emitter.Rate = 128
							emitter.Drag = 16
							emitter.ShapePartial = 1
							emitter.Color = ColorSequence.new({
								ColorSequenceKeypoint.new(0, Color3.fromHSV(ParticleColor1.Hue, ParticleColor1.Sat, ParticleColor1.Value)),
															  ColorSequenceKeypoint.new(1, Color3.fromHSV(ParticleColor2.Hue, ParticleColor2.Sat, ParticleColor2.Value))
							})

							Particles[i] = part
							end
							else
								for _, part in Particles do part:Destroy() end
									table.clear(Particles)
									end
									end
				})
				ParticleTexture = Killaura:CreateTextBox({Name = 'Texture', Default = 'rbxassetid://14736249347', Darker = true, Visible = false,
					Function = function()
					for _, part in Particles do part.ParticleEmitter.Texture = ParticleTexture.Value end
						end
				})
				ParticleColor1 = Killaura:CreateColorSlider({Name = 'Color Begin', Darker = true, Visible = false,
					Function = function(h,s,v)
					for _, part in Particles do
						part.ParticleEmitter.Color = ColorSequence.new({
							ColorSequenceKeypoint.new(0, Color3.fromHSV(h,s,v)),
																	   ColorSequenceKeypoint.new(1, Color3.fromHSV(ParticleColor2.Hue, ParticleColor2.Sat, ParticleColor2.Value))
						})
						end
						end
				})
				ParticleColor2 = Killaura:CreateColorSlider({Name = 'Color End', Darker = true, Visible = false,
					Function = function(h,s,v)
					for _, part in Particles do
						part.ParticleEmitter.Color = ColorSequence.new({
							ColorSequenceKeypoint.new(0, Color3.fromHSV(ParticleColor1.Hue, ParticleColor1.Sat, ParticleColor1.Value)),
																	   ColorSequenceKeypoint.new(1, Color3.fromHSV(h,s,v))
						})
						end
						end
				})
				ParticleSize = Killaura:CreateSlider({Name = 'Size', Min = 0, Max = 1, Default = 0.14, Decimal = 100, Darker = true, Visible = false,
					Function = function(val)
					for _, part in Particles do part.ParticleEmitter.Size = NumberSequence.new(val) end
						end
				})

				LegitAura = Killaura:CreateToggle({
					Name = 'Swing only',
					Tooltip = 'Only attacks while swinging manually',
					Function = function()
					if Killaura.Enabled then
						Killaura:Toggle()
						task.wait()
						Killaura:Toggle()
						end
						end
				})
				end)

run(function()
local Scaffold
local Expand
local Tower
local Downwards
local Diagonal
local LimitItem
local adjacent, lastpos = {}, Vector3.zero

for x = -3, 3, 3 do
	for y = -3, 3, 3 do
		for z = -3, 3, 3 do
			local vec = Vector3.new(x, y, z)
			if vec.Y ~= 0 and (vec.X ~= 0 or vec.Z ~= 0) then
				continue
				end

				if vec ~= Vector3.zero then
					table.insert(adjacent, vec)
					end
					end
					end
					end

					local function getBlocksInPoints(s, e)
					local list = {}
					for x = s.X, e.X, 3 do
						for y = s.Y, e.Y, 3 do
							for z = s.Z, e.Z, 3 do
								local vec = Vector3.new(x, y, z)
								if workspace:FindFirstChild("Map") and workspace.Map:FindFirstChild(tostring(vec)) then
									table.insert(list, vec)
									end
									end
									end
									end
									return list
									end

									local function roundPos(vec)
									return Vector3.new(math.round(vec.X / 3) * 3, math.round(vec.Y / 3) * 3, math.round(vec.Z / 3) * 3)
									end

									local function nearCorner(poscheck, pos)
									local startpos = poscheck - Vector3.new(3, 3, 3)
									local endpos = poscheck + Vector3.new(3, 3, 3)
									local check = poscheck + (pos - poscheck).Unit * 100
									if math.abs(check.Y - startpos.Y) > 3 then
										return Vector3.new(poscheck.X, math.clamp(check.Y, startpos.Y, endpos.Y), poscheck.Z)
										end
										return Vector3.new(math.clamp(check.X, startpos.X, endpos.X), math.clamp(check.Y, startpos.Y, endpos.Y), math.clamp(check.Z, startpos.Z, endpos.Z))
										end

										local function blockProximity(pos)
										local mag, returned = 60
										local tab = getBlocksInPoints(pos - Vector3.new(21, 21, 21), pos + Vector3.new(21, 21, 21))
										for _, v in tab do
											local blockpos = nearCorner(v, pos)
											local newmag = (pos - blockpos).Magnitude
											if newmag < mag then
												mag, returned = newmag, blockpos
												end
												end
												table.clear(tab)
												return returned
												end

												local function checkAdjacent(pos)
												for _, v in adjacent do
													if workspace:FindFirstChild("Map") and workspace.Map:FindFirstChild(tostring(pos + v)) then return true end
														end
														return false
														end

														local function getBlock()
														local tool = lplr.Character and lplr.Character:FindFirstChildWhichIsA('Tool', true)
														if tool and tool:HasTag('Blocks') then
															local btype = tool.Name == 'Blocks' and 'Clay' or tool.Name:sub(1, -6)
															return btype, btype == 'Clay' and 'Blocks' or ("%sBlock"):format(btype)
															end

															if LimitItem.Enabled then return end
																for _, tool in lplr.Backpack:GetChildren() do
																	if tool:IsA('Tool') and tool:HasTag('Blocks') then
																		local btype = tool.Name == 'Blocks' and 'Clay' or tool.Name:sub(1, -6)
																		return btype, btype == 'Clay' and 'Blocks' or ("%sBlock"):format(btype)
																		end
																		end
																		end

																		Scaffold = vape.Categories.Utility:CreateModule({
																			Name = 'Scaffold',
																			Function = function(callback)
																			if callback then
																				repeat
																				if entitylib.isAlive then
																					local btype, bname = getBlock()

																					if btype then
																						local root = entitylib.character.RootPart
																						if Tower.Enabled and inputService:IsKeyDown(Enum.KeyCode.Space) and (not inputService:GetFocusedTextBox()) then
																							root.Velocity = Vector3.new(root.Velocity.X, 38, root.Velocity.Z)
																							end

																							for i = Expand.Value, 1, -1 do
																								local currentpos = roundPos(root.Position - Vector3.new(0, entitylib.character.HipHeight + (Downwards.Enabled and inputService:IsKeyDown(Enum.KeyCode.LeftShift) and 4.5 or 1.5), 0) + entitylib.character.Humanoid.MoveDirection * (i * 3))
																								if Diagonal.Enabled then
																									if math.abs(math.round(math.deg(math.atan2(-entitylib.character.Humanoid.MoveDirection.X, -entitylib.character.Humanoid.MoveDirection.Z)) / 45) * 45) % 90 == 45 then
																										local dt = (lastpos - currentpos)
																										if ((dt.X == 0 and dt.Z ~= 0) or (dt.X ~= 0 and dt.Z == 0)) and ((lastpos - root.Position) * Vector3.new(1, 0, 1)).Magnitude < 2.5 then
																											currentpos = lastpos
																											end
																											end
																											end

																											local block = workspace:FindFirstChild("Map") and workspace.Map:FindFirstChild(tostring(currentpos))
																											if not block then
																												local blockpos = checkAdjacent(currentpos) and currentpos or blockProximity(currentpos)
																												if blockpos then
																													local args = {
																														blockpos
																													}
																													replicatedStorage:WaitForChild("Network"):WaitForChild("Request_PlaceBlock"):FireServer(unpack(args))
																													end
																													end
																													lastpos = currentpos
																													end
																													end
																													end
																													task.wait(0.03)
																													until not Scaffold.Enabled
																													end
																													end,
																													Tooltip = 'Helps you make bridges/scaffold walk.'
																		})
																		Expand = Scaffold:CreateSlider({
																			Name = 'Expand',
																			Min = 1,
																			Max = 6
																		})
																		Tower = Scaffold:CreateToggle({
																			Name = 'Tower',
																			Default = true
																		})
																		Downwards = Scaffold:CreateToggle({
																			Name = 'Downwards',
																			Default = true
																		})
																		Diagonal = Scaffold:CreateToggle({
																			Name = 'Diagonal',
																			Default = true
																		})
																		LimitItem = Scaffold:CreateToggle({Name = 'Limit to items'})
																		end)

run(function()
local Nuker
local Radius
local Speed

local function getBlocksInPoints(s, e)
local list = {}
for x = s.X, e.X, 3 do
	for y = s.Y, e.Y, 3 do
		for z = s.Z, e.Z, 3 do
			local vec = Vector3.new(x, y, z)
			if workspace:FindFirstChild("Map") and workspace.Map:FindFirstChild(tostring(vec)) then
				list[vec] = workspace.Map:FindFirstChild(tostring(vec))
				end
				end
				end
				end
				return list
				end

				Nuker = vape.Categories.Blatant:CreateModule({
					Name = 'Nuker',
					Function = function(callback)
					if callback then
						local lastBreakTime = tick()
						repeat
						if entitylib.isAlive then
							local pos = entitylib.character.RootPart.Position
							local rvec = Vector3.new(Radius.Value, Radius.Value, Radius.Value) * 3

							for blockpos, block in getBlocksInPoints(pos - rvec, pos + rvec) do
								if block and tick() - lastBreakTime >= (1 / Speed.Value) then
									local args = { blockpos }
									replicatedStorage:WaitForChild("Network"):WaitForChild("Request_BreakBlock"):FireServer(unpack(args))
									lastBreakTime = tick()
									break
									end
									end
									end
									task.wait()
									until not Nuker.Enabled
									end
									end,
									Tooltip = 'Breaks nearby blocks'
				})
				Radius = Nuker:CreateSlider({
					Name = 'Radius',
					Min = 1,
					Max = 10,
					Default = 5,
					Suffix = 'studs'
				})
				Speed = Nuker:CreateSlider({
					Name = 'Speed',
					Min = 1,
					Max = 20,
					Default = 10,
					Suffix = 'bps'
				})
				end)

run(function()
local Godmode
local Delay

Godmode = vape.Categories.Blatant:CreateModule({
	Name = 'Godmode',
	Function = function(callback)
	if callback then
		repeat
		local args = { "Golden_Apple" }
		replicatedStorage:WaitForChild("Network"):WaitForChild("Request_ConsumableUse"):FireServer(unpack(args))
		task.wait(Delay.Value)
		until not Godmode.Enabled
		end
		end,
		Tooltip = 'Spams golden apple use for godmode'
})
Delay = Godmode:CreateSlider({
	Name = 'Delay',
	Min = 0,
	Max = 1,
	Default = 0.1,
	Decimal = 100,
	Suffix = 's'
})
end)
