platform.apilevel = '2.0'     
function on.paint(gc)
    gc:setFont("sansserif", "r", 6)
    local h = platform.window:height()
    local w = platform.window:width()
    
    --CHECK INPUT VARIABLES
    if(var.recall("xend")<=var.recall("xstart")) then
         gc:drawString("ERROR: xend has to be larger than xstart", 10, 20)
         return
    end
    
    if(var.recall("yend")<var.recall("ystart")) then
         gc:drawString("ERROR: ystart has to be smaller than yend", 10, 30)
         return
    end
    
    
    if(not(var.recall("xstart")>0)) then
         gc:drawString("ERROR: xstart has to be positive (greater than 0)", 10, 40)
         return
    end
    
    --VERTICAL LINES PROCESSING--------------------------
    local offsetleft = 25
    local offsetbottom = 15
    local zerooffset = 0
   
    local nodes = math.eval("ceiling(approx(log(xend,10)-log(xstart,10)))")
    for i = 0, nodes, 1 do
        gc:setPen("thin", "dashed")
        gc:drawLine(((w-offsetleft)/nodes)*i+offsetleft, 0, ((w-offsetleft)/nodes)*i+offsetleft, h-offsetbottom)
        gc:drawString(math.eval("approx(xstart*10^("..i.."))"), ((w-offsetleft)/nodes)*i+offsetleft-5, h-2, "bottom")
        for j = 1, 9, 1 do
            gc:setPen("thin", "dotted")
            gc:drawLine((((w-offsetleft)/nodes)*i+offsetleft)+math.eval("approx(log("..j..",10))")*((w-offsetleft)/nodes), 0, (((w-offsetleft)/nodes)*i+offsetleft)+math.eval("approx(log("..j..",10))")*((w-offsetleft)/nodes), h-offsetbottom)
        end
    end
    
    --HORIZONTAL GAIN LINES PROCESSING---------------------
    var.store("ystart", math.eval("floor(ystart/10)*10")) -- round to 10
    var.store("yend", math.eval("ceiling(yend/10)*10"))   -- round to 10
    local nodes2 = math.eval("ceiling(approx((yend-ystart)/10))")
 
    for i = 0, nodes2, 1 do --draw horizintal lines
       gc:drawLine(offsetleft, ((h-offsetbottom)/nodes2)*i, w, ((h-offsetbottom)/nodes2)*i) 
       gc:drawString((var.recall("yend")-10*i).."dB", 0, ((h-offsetbottom)/nodes2)*i+5)
       if((var.recall("yend")-10*i)==0) then --find zero line
           zerooffset = ((h-offsetbottom)/nodes2)*i
       end
    end
    
    if(var.recall("ystart")>0)then--Fixes bug, if zeroline is below window wiew
        zerooffset = ((h-offsetbottom)+(h-offsetbottom)/nodes2)*var.recall("ystart")/10
    end
    
    if(var.recall("yend")<0 )then--fixes bug, if zeroline is above window view
        zerooffset = ((h-offsetbottom)/nodes2)*var.recall("yend")/10
    end
   
    
    --PLOT GAIN--------------------------------------------
    local plotstart = math.eval("approx(log(xstart,10))")
    local plotend = math.eval("approx(log(xend,10))")
    local step = var.recall("step")
    local stepquant = math.ceil((plotend-plotstart)/step)
    local pixelperstep = (w-offsetleft)/stepquant
    
    gc:setPen("thin", "smooth")
    local linepoints = {}
    for i=0, stepquant, 1 do
       local value = math.eval("20*log(abs(h(10^("..plotstart+step*i.."))),10)")
       linepoints[2*i+1] = (pixelperstep*i)+offsetleft;
       linepoints[2*i+2] = zerooffset-((h-offsetbottom)/(nodes2*10))*value;
    end
    gc:drawPolyLine(linepoints)
end

--------------------------------------------------------------------------------------------------------
function on.activate()
    platform.window:invalidate()
end

---------------------------------------------------------------------------------------------------------

function on.arrowUp()
   var.store("yend", var.recall("yend")+10)
   var.store("ystart", var.recall("ystart")+10)
   platform.window:invalidate()
end

function on.arrowDown()
   var.store("yend", var.recall("yend")-10)
   var.store("ystart", var.recall("ystart")-10)
   platform.window:invalidate()
end

function on.arrowLeft()
   var.store("xstart", var.recall("xstart")/10)
   var.store("xend", var.recall("xend")/10)
   platform.window:invalidate()
end

function on.arrowRight()
   var.store("xstart", var.recall("xstart")*10)
   var.store("xend", var.recall("xend")*10)
   platform.window:invalidate()
end


function on.charIn(ch)
    if(ch == "*") then
       var.store("xend", var.recall("xend")/10)
       platform.window:invalidate()
    end
    
    if(ch == "/") then
       var.store("xend", var.recall("xend")*10)
       platform.window:invalidate()
    end
    
    if(ch == "+") then
       var.store("yend", var.recall("yend")-10)
       platform.window:invalidate()
    end
    
    if(ch == "-") then
       var.store("yend", var.recall("yend")+10)
       platform.window:invalidate()
    end
end 