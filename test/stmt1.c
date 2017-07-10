for(i=0; i < 100; i++) {
    if(i * i > 100) break;
    else {
        if(vis[i] == 0) {
            for(j = 2; j * i < 100; j++) 
                vis[i*j] = 1;
        }
    }
}