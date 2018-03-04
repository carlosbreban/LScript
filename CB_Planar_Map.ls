main
{
selmode(USER);
selpolygon(CLEAR);
newvmap = createVmap();
mapPlanar("ZPOS");
//mapPlanar("ZNEG");
//mapPlanar("XPOS");
//mapPlanar("XNEG");
//mapPlanar("YPOS");
//mapPlanar("YNEG");
//mapChk();

}//end function def

//########################################################
//FUNCTION to find vmap points belong to
//########################################################
vmapChk
{
myVmap = VMap(VMTEXTURE);
editbegin();
if(myVmap.isMapped(points[1]))
	{
	//info("vmap first");
	return myVmap;
	}//end first vmap mapped condition
else
	{
	for(i = 1; i < myVmap.count(); i++)
		{
		nextVmap = myVmap.next();
		if(nextVmap.isMapped(points[1]))
			{
			//info("vmap second");
			myVmap = nextVmap;
			return myVmap;
			}//end mapped points condition
		else myVmap = nil;	
		}//end vmap loop	
	}//end not first vmap
editend();	
//return myVmap;
}//end function def


//########################################################
//FUNCTION for creating vmap
//########################################################
createVmap
{
editbegin();
myMap = VMap(VMTEXTURE, "slot_uv", 2);
pntCnt = pointcount();
for(i = 1; i <= pntCnt; i++){
myMap.setValue(points[i], 0);
}
//info(myMap.isMapped(points[1]));
editend();	
selectvmap(VMTEXTURE,myMap.name);

return myMap;
}//end function def


//########################################################
//FUNCTION for planar mapping
//Argument is string key
//########################################################
mapPlanar : axis
{

//check which map points are mapped to
activeVmap = vmapChk();

//info(activeVmap.name);
//start edit poly
editbegin();

//get vectors for bounding box and point count
bbox = boundingbox();
pntCnt = pointcount();
//info(bbox);
//if vmap found
if(activeVmap)
	{
	
	//info("vmap found");
	bbx = bbox[2].x - bbox[1].x;
	bby = bbox[2].y - bbox[1].y;
	bbz = bbox[2].z - bbox[1].z;
	
	
//Z Positive
	if(axis == "ZPOS")
		{
		//info(activeVmap.isMapped(points[1]));
		//info("z projection");
		for(i = 1; i <= pntCnt; i++){
			if(activeVmap.isMapped(points[i])){
				//info("points mapped");
				if(bbx == 0) values[2] = 0;
				else values[1] = (points[i].x - bbox[1].x)/(bbox[2].x - bbox[1].x);
				
				if(bby == 0) values[2] = 0;
				else values[2] = (points[i].y - bbox[1].y)/(bbox[2].y - bbox[1].y);
				
				activeVmap.setValue(points[i],values);		
				}//end uv channel check
			else info("not mapped");	
			}//end points loop		
		}//end z positive condition	
		
//Z Negative	
	if(axis == "ZNEG")
		{
		for(i = 1; i <= pntCnt; i++){
			if(activeVmap.isMapped(points[i])){
				if(bbx == 0) values[2] = 0;
				else values[1] = 0 - (points[i].x - bbox[1].x)/(bbox[2].x - bbox[1].x) + 1;
				
				if(bby == 0) values[2] = 0;
				else values[2] = (points[i].y - bbox[1].y)/(bbox[2].y - bbox[1].y);
				
				activeVmap.setValue(points[i],values);
				}//end uv channel check
			}//end points loop
		}//end z negative condition		
		
//X Positive
	if(axis == "XPOS")
		{
		for(i = 1; i <= pntCnt; i++){
			if(activeVmap.isMapped(points[i])){
				if(bbz == 0) values[2] = 0;
				else values[1] = (points[i].z - bbox[1].z)/(bbox[2].z - bbox[1].z);
				
				if(bby == 0) values[2] = 0;
				else values[2] = (points[i].y - bbox[1].y)/(bbox[2].y - bbox[1].y);
				
				activeVmap.setValue(points[i],values);
				}//end uv channel check
			}//end points loop
		}//end x positive condition	

//X Negative
	if(axis == "XNEG")
		{
		for(i = 1; i <= pntCnt; i++){
			if(activeVmap.isMapped(points[i])){
				if(bbz == 0) values[2] = 0;
				else values[1] = 0 - (points[i].z - bbox[1].z)/(bbox[2].z - bbox[1].z) + 1;
				
				if(bby == 0) values[2] = 0;
				else values[2] = (points[i].y - bbox[1].y)/(bbox[2].y - bbox[1].y);
				
				activeVmap.setValue(points[i],values);
				}//end uv channel check
			}//end points loop
		}//end x negative condition	
		
//Y Positive
	if(axis == "YPOS")
		{
		for(i = 1; i <= pntCnt; i++){
			if(activeVmap.isMapped(points[i])){
				if(bbx == 0) values[1] = 0;
				else values[1] = (points[i].x - bbox[1].x)/(bbox[2].x - bbox[1].x);
				
				if(bbz == 0) values[2] = 0;
				else values[2] = (points[i].z - bbox[1].z)/(bbox[2].z - bbox[1].z);
				
				activeVmap.setValue(points[i],values);
				}//end uv channel check
			}//end points loop
		}//end y positive condition		
		
//Y Negative
	if(axis == "YNEG")
		{
		for(i = 1; i <= pntCnt; i++){
			if(activeVmap.isMapped(points[i])){			
				if(bbx == 0) values[1] = 0;
				else values[1] = 0 - (points[i].x - bbox[1].x)/(bbx) + 1;

				if(bbz == 0) values[2] = 0;
				else values[2] = (points[i].z - bbox[1].z)/(bbz);
					
				activeVmap.setValue(points[i],values);
				}//end uv channel check
			}//end points loop
		}//end y negative condition		
	}//end vmap condition	
else info("no vmap");
editend();	
}//end function def