library_name = "libentry.A.dylib"
entry_c = normpath(@__DIR__, "entry.c")
const libentry = normpath(@__DIR__, library_name)
if !isfile(libentry)
    run(`clang -dynamiclib -std=c99 $entry_c -o $libentry`)
end

struct GeoCoord
    lat::Cdouble
    lon::Cdouble
end

struct Geofence
    numVerts::Cint
    verts::Ptr{GeoCoord}
end

struct GeoPolygon
    geofence::Geofence
    numHoles::Cint
    holes::Ptr{Geofence}
end

verts = [GeoCoord(0.01, 0.01),
         GeoCoord(0.01, -0.01),
         GeoCoord(-0.01, -0.01),
         GeoCoord(-0.01, 0.01)]
fence = Geofence(4, pointer(verts))
ccall((:entry, libentry), Int32, (Ptr{Geofence},), Ref(fence))
println()

polygon = GeoPolygon(fence, 0, C_NULL)
ccall((:entry_polygon, libentry), Int32, (Ptr{GeoPolygon},), Ref(polygon))
