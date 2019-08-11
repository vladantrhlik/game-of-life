String type,needToLyf,needToGetLyf;

//===VARIABLES==================
int w = 50;  //width of the grid
int h = 50;  //height of the grid
//=============================

int[][] pole = new int[w][h];
int[][] nb = new int[w][h];
boolean[][] checked = new boolean[w][h];
boolean text;
int tileSize,fps;

int poleW, poleH;


void setup(){
    
  size(1000,1000);
  
  //====VARIABLES========
  type = "23/3"; //numbers of neighbours to stay alive / numbers of neighbours to "rise from the dead" lol
  tileSize = 20;
  text = true;
  fps = 5;
  //=====================
  
  
  needToLyf = "";
  needToGetLyf = "";
  frameRate(fps);
  
  boolean lomitko = false;
  for(int i = 0;i<type.length();i++){
    if(type.charAt(i) == '/'){
      lomitko = true;  
      i++;
    }
    if(!lomitko){
      needToLyf += type.charAt(i);   
    }else{
      needToGetLyf += type.charAt(i); 
    }
  }
  
  poleW = w;
  poleH = h;
  
  for(int x = 0;x<poleW;x++){
    for(int y = 0;y<poleH;y++){
        pole[x][y] = round(random(1));
        //print(pole[x][y]);
        nb[x][y] = 0;
        checked[x][y] = false;
    }  
  }
  
  //count_neighbours();

}

void draw(){
  background(#272727);
  
  count_neighbours();
  getshitdoneuwu();
  
  draw_cells();
  if(text){
    draw_neighbours();  
  }
}

void getshitdoneuwu(){
    for(int x = 0;x<poleW;x++){
      for(int y = 0;y<poleH;y++){
        boolean isAlive = boolean(pole[x][y]);
        
        
        for(int i = 0;i<needToLyf.length();i++){
          char number = (needToLyf.charAt(i));
          
          if(isAlive && nb[x][y] == number - '0'){
            checked[x][y] = true;  
          }
        }
        for(int i = 0;i<needToGetLyf.length();i++){
          char number = char(needToGetLyf.charAt(i));
          if(!isAlive && nb[x][y] == number  - '0'){
            pole[x][y] = 1;
            checked[x][y] = true;
          }
        }
        
      }
    }
    
    for(int x = 0;x<poleW;x++){
      for(int y = 0;y<poleH;y++){
        if(checked[x][y] == false){
          pole[x][y] = 0;  
        }
      }
    }
}

void count_neighbours(){
  
  for(int x = 0;x<poleW;x++){
    for(int y = 0;y<poleH;y++){
      nb[x][y] = 0;
      checked[x][y] = false;
        if(x > 0 && x < poleW-1 && y > 0 && y < poleH-1){
            int pos[][] = {{-1,-1},{0,-1},{1,-1},{-1,0},{1,0},{-1,1},{0,1},{1,1}};
            for(int i = 0;i<pos.length;i++){
              if(pole[x+pos[i][0]][y+pos[i][1]] == 1){
                nb[x][y]++;
              }
            }   
        }else if(x == 0 && y > 0 && y < poleH-1){  //left column
            int pos[][] = {{0,-1},{1,0},{0,1},{1,1},{1,-1}};
            for(int i = 0;i<pos.length;i++){
              if(pole[x+pos[i][0]][y+pos[i][1]] == 1){
                nb[x][y]++;
              }
            }   
        }else if(x == poleW-1 && y > 0 && y < poleH-1){  //right column
            int pos[][] = {{0,-1},{-1,0},{0,1},{-1,-1},{-1,1}};
            for(int i = 0;i<pos.length;i++){
              if(pole[x+pos[i][0]][y+pos[i][1]] == 1){
                nb[x][y]++;
              }
            }   
        }else if(y == 0 && x > 0 && x < poleW-1){  //top row
            int pos[][] = {{-1,0},{1,0},{0,1},{-1,1},{1,1}};
            for(int i = 0;i<pos.length;i++){
              if(pole[x+pos[i][0]][y+pos[i][1]] == 1){
                nb[x][y]++;
              }
            }   
        }else if(y == poleH-1 && x > 0 && x < poleW-1){  //bottom row
            int pos[][] = {{-1,0},{1,0},{0,-1},{-1,-1},{1,-1}};
            for(int i = 0;i<pos.length;i++){
              if(pole[x+pos[i][0]][y+pos[i][1]] == 1){
                nb[x][y]++;
              }
            }   
        }else if(x == 0 && y == 0){  //top left
            int pos[][] = {{1,0},{1,1},{0,1}};
            for(int i = 0;i<pos.length;i++){
              if(pole[x+pos[i][0]][y+pos[i][1]] == 1){
                nb[x][y]++;
              }
            }   
        }else if(x == poleW-1 && y == 0){  //top right
            int pos[][] = {{-1,0},{-1,1},{0,1}};
            for(int i = 0;i<pos.length;i++){
              if(pole[x+pos[i][0]][y+pos[i][1]] == 1){
                nb[x][y]++;
              }
            }   
        }else if(x == 0 && y == poleH-1){  //bottom left
            int pos[][] = {{0,-1},{1,-1},{1,0}};
            for(int i = 0;i<pos.length;i++){
              if(pole[x+pos[i][0]][y+pos[i][1]] == 1){
                nb[x][y]++;
              }
            }   
        }else if(x == poleW-1 && y == poleH-1){  //bottom right
            int pos[][] = {{-1,-1},{-1,0},{0,-1}};
            for(int i = 0;i<pos.length;i++){
              if(pole[x+pos[i][0]][y+pos[i][1]] == 1){
                nb[x][y]++;
              }
            }   
        }
        
        
        
    }  
  }
  
}


void draw_neighbours(){
    for(int x = 0;x<poleW;x++){
      for(int y = 0;y<poleH;y++){
        textAlign(CENTER,CENTER);
        if(pole[x][y] == 1){
          fill(#272727);  
        }else{
           fill(255); 
        }
        text(nb[x][y],x*tileSize+tileSize/2,y*tileSize+tileSize/2);
      }
    }
}

void draw_cells(){
  noStroke();
  for(int x = 0;x<poleW;x++){
    for(int y = 0;y<poleH;y++){
        if(pole[x][y] == 1){
          fill(255);    
        }else{
          noFill();  
        }
        rect(x*tileSize,y*tileSize,tileSize,tileSize);
        
        if(checked[x][y] == true){
          //fill(255,0,0);
          //rect(x*tileSize,y*tileSize,tileSize,tileSize);
        }
        
        
    }  
  }  
}
