---
title: "Account Creation & Permissions"
layout: single
nav_order: 2
category: quickstart
classes: wide
---

{% include masthead.html %}

<div class="content-wrapper">
    {% include sidebar.html %}
    <article class="main-content">
        <section id="requesting-access">
            <h2>Step 1: Requirements for accessing the cluster </h2>
            <p> Users of the DSI have to meet one of the following criteria:</p>
            <ol>
                <li>Have a DSI-related grant.</li>
                <li>Be in the DSI or a DSI affiliated faculty (with some exceptions).</li>
                <li>Be a student with written approval by a DSI faculty mentor.</li>
            </ol>
            <p>If you are looking for compute resources and are more generally affiliated with the University we recommend contacting <a href = "https://rcc.uchicago.edu/">RCC</a>.</p>

            <h2>Step 2: Requesting Access</h2>
            <p>To gain access to the UChicago DSI cluster, you must first submit an access request. Please follow these steps:</p>
            <ol>
                <li>Go to the <a href="https://example.com/access-request-form">Cluster Access Request Form</a>.</li>
                <li>Fill out all required fields, including your University of Chicago email address, CNetID, and the research group you'll be working with.</li>
                <li>In the "Reason for Access" section, provide a brief description of your research project and the resources you'll need.</li>
                <li>Submit the form. You will receive an email confirmation once your request is processed.</li>
            </ol>

            <div class="callout callout-info">
                <p><strong>Note:</strong> Access requests are typically reviewed within 2-3 business days. Please plan accordingly and submit your request well in advance of when you need to start using the cluster.</p>
            </div>
        </section>

        <section id="setting-up-profile">
            <h2>Step 3: Setting Up Your Profile</h2>
            <p>Once your access request is approved, you'll receive an email with instructions on how to set up your cluster profile. This involves configuring your SSH keys and setting a password:</p>

            <h3>Generating SSH Keys</h3>
            <p>We require SSH key-based authentication for secure access to the cluster. Here’s how to generate an SSH key pair:</p>
            <div class="language-bash highlighter-rouge">
                <div class="highlight">
                    <pre class="highlight"><code>ssh-keygen -t rsa -b 4096 -C "your_cnetid@uchicago.edu"</code></pre>
                </div>
            </div>
            <p>Follow the prompts to save your key pair. The default location is usually <code>~/.ssh/id_rsa</code> (private key) and <code>~/.ssh/id_rsa.pub</code> (public key).</p>

            <div class="callout callout-warning">
                <p><strong>Warning:</strong> Keep your private key secure and do not share it with anyone. The public key can be shared, as it will be used to grant you access.</p>
            </div>

            <h3>Adding Your Public Key to Your Profile</h3>
            <p>To add your public key to your cluster profile, use the <code>add-ssh-key</code> tool:</p>
            <div class="language-bash highlighter-rouge">
                <div class="highlight">
                    <pre class="highlight"><code>ssh your_cnetid@cluster.uchicago.edu add-ssh-key &lt; ~/.ssh/id_rsa.pub</code></pre>
                </div>
            </div>
            <p>You will be prompted for your temporary password (provided in your access approval email). After successful key addition, you can log in using your SSH key.</p>

            <h3>Setting Your Password</h3>
            <p>To set your cluster password, use the <code>passwd</code> command:</p>
            <div class="language-bash highlighter-rouge">
                <div class="highlight">
                    <pre class="highlight"><code>ssh your_cnetid@cluster.uchicago.edu passwd</code></pre>
                </div>
            </div>
            <p>Follow the prompts to set a strong, unique password.</p>
        </section>

        <section id="assigning-permissions">
            <h2>Step 4: Assigning Permissions</h2>
            <p>Access to specific resources or software on the cluster may require additional permissions. These are typically managed by your research group or the system administrators.</p>

            <h3>Group Permissions</h3>
            <p>If you are part of a research group, you may be added to a group that grants access to shared resources. Contact your group lead or the system administrators to be added to the appropriate group.</p>

            <h3>Requesting Elevated Permissions</h3>
            <p>In rare cases, you may need elevated permissions (e.g., <code>sudo</code> access) for specific tasks. To request elevated permissions:</p>
            <ol>
                <li>Prepare a detailed justification explaining why elevated permissions are necessary for your work.</li>
                <li>Submit your request to the system administrators via email at <a href="mailto:cluster-support@example.com">cluster-support@example.com</a>.</li>
                <li>Include your CNetID, the specific permissions needed, and a clear description of the tasks requiring these permissions.</li>
            </ol>

            <div class="callout callout-info">
                <p><strong>Note:</strong> Elevated permissions are granted on a case-by-case basis and require a strong justification. The system administrators will review your request and may require additional information.</p>
            </div>
        </section>

        <section id="managing-user-roles">
            <h2>Managing User Roles</h2>
            <p>User roles define the level of access and permissions granted to a cluster user. There are typically several roles, such as:</p>
            <ul>
                <li><strong>User:</strong> Standard access for running jobs and accessing resources within their group.</li>
                <li><strong>Group Lead:</strong> Additional permissions to manage group resources and user access within the group.</li>
                <li><strong>Administrator:</strong> Full access to all cluster resources and configurations.</li>
            </ul>
            <p>Contact your group lead or the system administrators if you need to change your user role or manage roles within your group.</p>
        </section>

    </article>
</div>