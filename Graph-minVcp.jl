#-------------- Gerekli yardımcı paketler ---------------
#-------------- Compose hatası alırsanız JuliaPro\pkgs-0.6.0.1\lib\v0.6\Compose.jl dosyasın silip junoyu yenden başlatın  ---------------
Pkg.add("LightGraphs")
Pkg.add("GraphPlot")
Pkg.add("Cairo")
Pkg.add("Fontconfig")
#Pkg.update()
using Compose
using Gadfly
using LightGraphs
using GraphPlot

#---------- Üçgen graph oluşturur --- Kenar ağırlıkları yok ------------------
G0 = Graph(3) #Graph taki kenar sayısı yani 3 kenarlı
add_edge!(G0, 1, 2) #1 den 2 düğüme
add_edge!(G0, 1, 3) #1 den 3 düğüme
add_edge!(G0, 2, 3)  #2 den 3 düğüme
#---------- Kenar Eklemek isterseniz opsiyonel ------------------
# add_edge!(G₁, 1, 2)
# add_edge!(G₁, 1, 3)
# add_edge!(G₁, 2, 4)
# add_edge!(G₁, 3, 4)
# add_edge!(G₁, 3, 5)
# add_edge!(G₁, 4, 5)
# add_vertex!(G₁)
# add_edge!(G₁, 2, 4)
draw(PNG("ücgen-graph.png", 16cm, 16cm),gplot(G0, nodelabel=1:nv(G0)))#kenar ağırlıkları vermek için ", edgelabel=1:ne(G₁)" ekleyin

#---------- Ev tipi graph oluşturur --- Kenar ağırlıkları ile beraber ------------------
G1 = smallgraph("house")
nvertices = nv(G1) # Düğüm sayısı
nedges = ne(G1)    # Kenar sayısı
draw(PNG("house-graph.png", 16cm, 16cm),gplot(G1, nodelabel=1:nvertices, edgelabel=1:nedges)) #Png dosyası oluşturmakta açıp graphı inceleyebilirsiniz

#---------- Örnek Graphı oluşturur --- Kenar ağırlıkları yok ------------------
G2 = Graph(6) #Graph taki kenar sayısı yani 3 kenarlı
add_edge!(G2, 1, 2) #1 den 2 düğüme
add_edge!(G2, 2, 3) #1 den 3 düğüme
add_edge!(G2, 2, 4)  #2 den 3 düğüme
add_edge!(G2, 3, 5)  #2 den 3 düğüme
add_edge!(G2, 4, 5)  #2 den 3 düğüme
add_edge!(G2, 4, 6)  #2 den 3 düğüme
draw(PNG("örnek-graph.png", 16cm, 16cm),gplot(G2, nodelabel=1:nv(G2)))#kenar ağırlıkları vermek için ", edgelabel=1:ne(G₁)" ekleyin

println("Graph resimleri dosyanın çalıştırıldığı konumdan incelenebilir.")
#Vertexlerin Ekrana yazdırılması
function Dugumler(graph)
  println("Graphtaki Düğümler")
  for v in vertices(graph)
      println("vertex $v")
  end
end

#Graphtaki Kenarlar
function DugumKenar(graph)
  println("Düğümler ve kenarları")
  for e in edges(graph)
      u, v = src(e), dst(e)
      println("edge $u - $v")
  end
end
#Yakınlık Matrisi
function YakinlikMatrisi(graph)
  println("\nGraph matrisi kenarları \n",maximal_cliques(graph)) #Graphs.jl metodu
  println("\n")
  println("Yakınlık matrisi")
  println(adjacency_matrix(graph))
end

minVcp=0
kenarSayisi=0;
function minVCP(graph)
  global minVcp
  global kenarSayisi
  for e in edges(graph)
      u, v = src(e), dst(e)
      a=src(e) #düğüm
      b=dst(e) #hedef düğüm
      # println("a sayisi: ",a)
      # println("b sayisi: ",b)
      if b==a+2
        minVcp=minVcp+1
      end
      if isodd(kenarSayisi)
        minVcp=convert(Int32,round((kenarSayisi+1)/2))
      end
      kenarSayisi=kenarSayisi+1
  end
  return minVcp
end
Dugumler(G2)
println("\n")
DugumKenar(G2)
YakinlikMatrisi(G2) #Graph ın matris halive yakınlık matrisi

#G1 ve G2 graphlar denenebilir kaydedilen graph resimler üzerinden de kontrol ediniz
#(G1)house graph ve (G2)örnek graph hesaplandığında ikisininde minVCP =3 çıkmakta
println("\n","Minimum vcp: ",minVCP(G2))
