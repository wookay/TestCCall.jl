#include <stdio.h>

typedef struct {
    double lat;
    double lon;
} GeoCoord;

typedef struct {
    int numVerts;
    GeoCoord *verts;
} Geofence;

typedef struct {
    Geofence geofence;
    int numHoles;
    Geofence *holes;
} GeoPolygon;

int entry(Geofence* fence) {
    for (int idx =0; idx < fence->numVerts; idx++) {
      GeoCoord vert = fence->verts[idx];
      printf("vert %d %f %f\n", idx+1, vert.lat, vert.lon);
    }
    fflush(stdout);
    return 1;
}

int entry_polygon(GeoPolygon* polygon) {
    Geofence* fence = &(polygon->geofence);
    return entry(fence);
}
