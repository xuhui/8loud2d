-- 宽度
local MAX_X = 24     -- Game width
-- 高度
local MAX_Y = 5     -- Game height
-- 小人原始的X坐标，最左边为1，最右边为24
local ORIGINAL_X = 6
-- 小人原始的Y左边，最上一行为1，最下一行为5
local ORIGINAL_Y = 4
-- 难度系数，1到23。越大越容易，地面越少洞
local DIFFICULTY = 15
-- 最大的洞可以多大
local MAX_HOLESIZE = 10
-- 声明一个局部变量G（名字随意，这个变量组成游戏对象的主体，需要有约定的方法/函数）
local G = {}

G.grid = {}

-- 主程序将循环调用本方法
-- dt: 距离上次调用的时间长度
-- key: 按键（），若X1000平台则为声音大小的值（1-0）
function G.run(dt, key)

  local groundLine = #G.grid                          -- 最下面一行，地面
  hasGround = G.grid[groundLine][G.jumper.x] ~= 0     -- 小人当前位置下面有没有地面

  -- 移植时修改，目的时根据key值赋予小人往上跳的能量
  if key and key >= '1' and key <= '9' and hasGround and G.jumper.y == groundLine - 1 then
    G.jumper.e = key - '0'
  end

  -- 如果没有往上的力量了，有地方站着，那么画面不动
  if G.jumper.e == 0 and G.jumper.y == groundLine - 1 and hasGround then
    return 
  end

  -- 处理背景。往前走（背景往左边移动）
  table.remove(G.grid[groundLine], 1)
  if G.hole > 0 then                                                -- 正在挖洞吗？
    table.insert(G.grid[groundLine], #G.grid[groundLine] + 1, 0)    -- 是的挖洞，用0表示，插入0
    G.hole = G.hole - 1                                             -- 当前的挖洞减一
  else
    table.insert(G.grid[groundLine], #G.grid[groundLine] + 1, 1)    -- 不用挖洞，地面用1表示，插入1
    -- 原来的洞已经挖好了，那么要挖新的洞吗？通过整个地面的完整度来决策
    -- 开始计算有多少连续的地面
    local groundGompleteness = 0
    for x=MAX_X,1,-1 do
      if G.grid[groundLine][x] == 0 then
        break
      end
      groundGompleteness = groundGompleteness + G.grid[groundLine][x];
    end
    -- 如果前边是连续的地面，那么放一个洞吧
    if groundGompleteness > DIFFICULTY then
      G.hole = math.random(1, MAX_HOLESIZE)                         -- 洞的大小
      score = score + G.hole                                        -- 累计得分
    end
  end

  -- 处理小人
  if G.jumper.e > 0 then                                            -- 还有能量往上吗？
    G.jumper.e = G.jumper.e - 1                                     -- 有的，减能量值
    if G.jumper.y > 1 then                                          -- 到顶了吗？（确保始终在画面显示）
      G.jumper.y = G.jumper.y - 1                                   -- 没到顶，往上一格
    end
  else
    -- 没有能量了
    G.jumper.y = G.jumper.y + 1                                     -- 继续往下掉一格
    if G.jumper.y > groundLine then                                 -- 已经掉到洞里面，看不见了吗
      runStatus = 'lost'                                            -- 结束咯
    end
  end
end

-- 画图前调用，吧小人和背景加在一起，生产一个表并返回
function G.render()
  local gr = {}
  for y = 1, MAX_Y do
    gr[y] = {}
    for x=1, MAX_X do
      if x == G.jumper.x and y == G.jumper.y then
        gr[y][x] = 1
      else
        gr[y][x] = G.grid[y][x]
      end
    end
  end
  return gr
end

-- 新开始或者重新开始时初始化一遍
function G.init()
  G.jumper = {x = ORIGINAL_X, y = ORIGINAL_Y, e = 0}    -- 原始坐标，能量
  G.hole = 0
  for y = 1, MAX_Y do
    G.grid[y] = {}
    for x = 1, MAX_X do
      G.grid[y][x] = y == MAX_Y and 1 or 0              -- 如果是最下面的一行的话填1，否则填0
    end
  end
  score = 0
end

-- 返回上述定义的游戏对象，供X1000或者LOVE2D或者TERMINAL使用，X1000的接口还没做。TERMINAL的版本是最初的原型，不打算改回去了
return G
