This page contains information on the cluster storage backend and how to best use it. There is an FAQ at the bottom of this page for additional information.

To see your current usage across any of the storage entities, refer to the [`dsiquota` tool]({% link _tools/dsiquota.md %}).

# Backend description

The current cluster backend can be thought of as 3 distinct entities: Home, Project, and Scratch folders.

The current file system uses NFS/ZFS which has some blocking elements that affect sharing performance. Files that are frequently accessed by multiple users will experience lower read performance.


## Home folders:
  - Limited to 50GB
  - Mirrored across all of the login nodes
  - Can be found at `/home/[cnet-id]`
  
## Project folders:
  - Project folders can be found in either `/net/projects/[project-name]` or `/net/projects2/[project-name]`
  - These are (generally) shared around a specific project or dataset that will be used repeatedly by multiple users with a specific focus area
  - This data is backed up with the expectation that it is recoverable in case of system failure
  - Project folders are created by DSI Techstaff
  - When requesting a project folder, please include who the project lead is as well as the amount of space required
  - These are designed for longer-term (but not permanent) storage

## Scratch folders:
  - Scratch folders can be found in either `/net/scratch` or `/net/scratch2`
  - This is _ephemeral_ storage, meaning that the space should be used for temporary storage while working on projects
  - Any file that has not been used in more than 60 days will be automatically deleted
  - Scratch is not designed for recovery. If there is a system failure, data on scratch is not designed to be restored
  - Users are allotted 50GB of scratch space. They can request more by emailing DSI Techstaff

# Best Practices

When designing the flow of your data processing, keep in mind the following principles:

1. The cluster's general storage (Home, Projects, and Scratch) is designed to facilitate active research, it is _not_ for long-term storage of data. It is also not designed for _public_ sharing of data. If you are not actively doing research or planning to do active research, then the data should be removed to make way for active research.
2. Scratch is ephemeral and is great for data like checkpoints and intermediate processing. Unique and important datasets should not be stored on scratch.
3. Project locations are designed for specific projects and research agendas. This is where code and raw datasets should be kept. Final results can be stored here as well.
4. Once a project is complete, have a plan for moving your code and data off the cluster to another storage site.

While every project is different, the following diagram describes the rough outline of the use of cluster storage:

<div class="mermaid">
graph TB
    subgraph row1[" "]
        direction LR
        init["<b>1. Project Initialization</b><br>• Store raw data in project folder<br>• Keep code in project folder"]
        exp["<b>2. Experimentation</b><br>• Keep code in projects folder<br>• Store intermediate results and active<br>  experiments in scratch space"]
    end
    
    subgraph row2[" "]
        direction LR
        synth["<b>3. Synthesis/Conclusion</b><br>• Keep all code in projects folder<br>• Remove intermediate results from scratch<br>• Save final results to projects folder"]
        final["<b>4. Project Finalization</b><br>• Remove all code and data<br>  from the cluster"]
    end
    
    init --> exp
    exp --> synth
    synth --> final
    
    style init fill:#f5f5f5,stroke:#333,stroke-width:2px,rx:10,ry:10,color:#333
    style exp fill:#f5f5f5,stroke:#333,stroke-width:2px,rx:10,ry:10,color:#333
    style synth fill:#f5f5f5,stroke:#333,stroke-width:2px,rx:10,ry:10,color:#333
    style final fill:#f5f5f5,stroke:#333,stroke-width:2px,rx:10,ry:10,color:#333
    style row1 fill:none,stroke:none
    style row2 fill:none,stroke:none
</div>

# FAQ

### Can DSI Techstaff put together a shared data resource, such as joint hosting of a number of LLMs? 

<div class="faq-answer">
Unfortunately this is out of bounds for DSI Techstaff for a number of reasons:
<ul>
<li>Maintaining and managing such a storage space takes time. Deciding which assets are included, not included and handling ongoing changes to such a dataset is not straightforward.</li>
<li>The purpose of the cluster is for data in use in active research, it is not for long term storage. Unless someone is actively working in a specific research area (which DSI Techstaff is not) designating what data can be deleted and what data should be kept is impossible. The cluster does not have infinite storage and we want to avoid situations where data grows without control and pruning.</li>
<li>If there are multiple teams working on a common dataset then there is nothing stopping them from identifying a maintainer who is willing to <strong>both</strong> prune unused data as well as keep the current data aligned with active research and then creating a project folder to put them in and updating the permissions appropriately.</li>
<li>Finally, the current storage infrastructure (this is on the roadmap to change) uses NFS/ZFS which has some properties that limit the effectiveness of shared files. Specifically, multiple users reading the same file at the same time can cause slow down.</li>
</ul>
</div>

