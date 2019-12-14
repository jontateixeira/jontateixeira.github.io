<!--
.. title: Gmsh: exporting old msh format
.. slug: gmsh-exporting-old-msh-format
.. date: 2019-12-14 10:52:15 UTC-03:00
.. tags: gmsh, mesh, pre-process, msh format
.. category: pre-process
.. link: 
.. description: old msh format
.. type: text
-->


This post is mainly aimed at my colleagues (and students) in the [LMCG research group](http://www.lmcg.ufpe.br/) at [LITPEG](https://www.ufpe.br/litpeg). After many people going to me, asking about a bug of [p3matpac preprocessor](https://bitbucket.org/lmcg_research_group/p3matpac/src/master/), I decide to write it. 

After the [Gmsh](http://gmsh.info/) 4.0.0 release, Christophe Geuzaine and Jean-François Remacle set the new msh version (msh4) as default msh format (*I guess... *). After that, new students and colleagues have faced with a following error:

```matlab
>>> g = gridprocessing.load_gmsh('mesh_test.msh')
Unknown mesh format: 4.1 0 8
```

There are 3 ways to fix this: GUI, CLI, and script [^1].

[^1]: Some steps ilustrated here can also be found on [Gmsh: MSH file format](http://onelab.info/pipermail/gmsh/2018/012422.html)


### GUI mode

You need to have the following steps:

**1)** Press `Ctrl+E` shortcut to open the export window:

<img src="/files/gmsh-exporting-old-msh-format/export_window.png" width=500>

**2)** Select the `Version 2 ASCII` and OK.

<img src="/files/gmsh-exporting-old-msh-format/format_type_window.png" width=500>

Done!!


### CLI mode

Using the command line interface all you need is run this:

```bash
gmsh mesh_test.geo -2 -format msh2
```

### Script 

Just put this `Mesh.MshFileVersion = 2.2;` into `*.geo` script  file.

### Other way

Using this mode, gmsh will **always** save in msh format 2.2. All you need is add this lines:

``` bash
Mesh.Format = 1; // msh output format
Mesh.MshFileVersion = 2.2; // Version of the MSH file format to use
```

Into `.gmshrc` file, by this command:

``` bash
echo "Mesh.Format = 1; // msh output format
Mesh.MshFileVersion = 2.2; // Version of the MSH file format to use" >> ~/.gmshrc
```



