// LIGHTWAVE: Planar Map UVs
// By Carlos Breban
// Usage: 
// 	1. Select layer
//	2. Run script
// 	NOTE: script has different modes for changing the direction of the planar map. Can be split into multiple scripts.
main
	{
	selmode(USER);
	selpolygon(CLEAR);
	uvMapName = "uv_0";
	newvmap = CreateVmap(uvMapName);
	MapPlanar("ZPOS", uvMapName);
	//MapPlanar("ZNEG", uvMapName);
	//MapPlanar("XPOS", uvMapName);
	//MapPlanar("XNEG", uvMapName);
	//MapPlanar("YPOS", uvMapName);
	//MapPlanar("YNEG", uvMapName);

	}//end function def


CreateVmap : incMapName
	{
	editbegin();
	myMap = VMap(VMTEXTURE, incMapName, 2);
	pntCnt = pointcount();
	for(i = 1; i <= pntCnt; i++){
		myMap.setValue(points[i], 0);
	}
	editend();	
	selectvmap(VMTEXTURE,myMap.name);

	return myMap;
	}


MapPlanar : incAxis, incMapName
	{
	vmap = VMap(VMTEXTURE);
	editbegin();

	//get vectors for bounding box and point count
	bbox = boundingbox();
	pntCnt = pointcount();

	for(i = 0; i < vmap.count(); i++)
		{
		activeVmap = vmap.next();
		if(activeVmap.name == incMapName){
			bbx = bbox[2].x - bbox[1].x;
			bby = bbox[2].y - bbox[1].y;
			bbz = bbox[2].z - bbox[1].z;
					
			//Z Positive
			if(incAxis == "ZPOS"){
				for(i = 1; i <= pntCnt; i++){
					if(activeVmap.isMapped(points[i])){
						if(bbx == 0) values[2] = 0;
						else values[1] = (points[i].x - bbox[1].x)/(bbox[2].x - bbox[1].x);
						
						if(bby == 0) values[2] = 0;
						else values[2] = (points[i].y - bbox[1].y)/(bbox[2].y - bbox[1].y);
						
						activeVmap.setValue(points[i],values);		
						}
					else info("not mapped");	
					}	
				}
				
			//Z Negative	
			if(incAxis == "ZNEG"){
				for(i = 1; i <= pntCnt; i++){
					if(activeVmap.isMapped(points[i])){
						if(bbx == 0) values[2] = 0;
						else values[1] = 0 - (points[i].x - bbox[1].x)/(bbox[2].x - bbox[1].x) + 1;
						
						if(bby == 0) values[2] = 0;
						else values[2] = (points[i].y - bbox[1].y)/(bbox[2].y - bbox[1].y);
						
						activeVmap.setValue(points[i],values);
						}
					}
				}		
				
			//X Positive
			if(incAxis == "XPOS"){
				for(i = 1; i <= pntCnt; i++){
					if(activeVmap.isMapped(points[i])){
						if(bbz == 0) values[2] = 0;
						else values[1] = (points[i].z - bbox[1].z)/(bbox[2].z - bbox[1].z);
						
						if(bby == 0) values[2] = 0;
						else values[2] = (points[i].y - bbox[1].y)/(bbox[2].y - bbox[1].y);
						
						activeVmap.setValue(points[i],values);
						}
					}
				}

			//X Negative
			if(incAxis == "XNEG"){
				for(i = 1; i <= pntCnt; i++){
					if(activeVmap.isMapped(points[i])){
						if(bbz == 0) values[2] = 0;
						else values[1] = 0 - (points[i].z - bbox[1].z)/(bbox[2].z - bbox[1].z) + 1;
						
						if(bby == 0) values[2] = 0;
						else values[2] = (points[i].y - bbox[1].y)/(bbox[2].y - bbox[1].y);
						
						activeVmap.setValue(points[i],values);
						}
					}
				}	
				
			//Y Positive
			if(incAxis == "YPOS"){
				for(i = 1; i <= pntCnt; i++){
					if(activeVmap.isMapped(points[i])){
						if(bbx == 0) values[1] = 0;
						else values[1] = (points[i].x - bbox[1].x)/(bbox[2].x - bbox[1].x);
						
						if(bbz == 0) values[2] = 0;
						else values[2] = (points[i].z - bbox[1].z)/(bbox[2].z - bbox[1].z);
						
						activeVmap.setValue(points[i],values);
						}
					}
				}	
				
			//Y Negative
			if(incAxis == "YNEG"){
				for(i = 1; i <= pntCnt; i++){
					if(activeVmap.isMapped(points[i])){			
						if(bbx == 0) values[1] = 0;
						else values[1] = 0 - (points[i].x - bbox[1].x)/(bbx) + 1;

						if(bbz == 0) values[2] = 0;
						else values[2] = (points[i].z - bbox[1].z)/(bbz);
							
						activeVmap.setValue(points[i],values);
						}
					}
				}	
			}	
	}
	editend();	
}