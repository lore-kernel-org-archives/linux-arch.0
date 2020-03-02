From: =?UTF-8?Q?Micka=c3=abl_Sala=c3=bcn?= <mic-WFhQfpSGs3bR7s880joybQ@public.gmane.org>
Subject: Re: [RFC PATCH v14 10/10] landlock: Add user and kernel documentation
Date: Mon, 2 Mar 2020 11:03:55 +0100
Message-ID: <e22709f2-af4f-9316-d83e-b794f083595c@digikod.net>
References: <20200224160215.4136-1-mic@digikod.net>
 <20200224160215.4136-11-mic@digikod.net>
 <cc8da381-d3dc-3c0a-5afd-96824362b636@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-api-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <cc8da381-d3dc-3c0a-5afd-96824362b636-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>
Content-Language: fr
Sender: linux-api-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Randy Dunlap <rdunlap-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: Al Viro <viro-RmSDqhL/yNMiFSDQTTA3OLVCufUGDwFn@public.gmane.org>, Andy Lutomirski <luto-kltTT9wpgjJwATOyAt5JVQ@public.gmane.org>, Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>, Casey Schaufler <casey-iSGtlc1asvQWG2LlvL+J4A@public.gmane.org>, Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, James Morris <jmorris-gx6/JNMH7DfYtjvyW6yDsg@public.gmane.org>, Jann Horn <jann-XZ1E9jl8jIdeoWH0uzbU5w@public.gmane.org>, Jonathan Corbet <corbet-T1hC0tSOHrs@public.gmane.org>, Kees Cook <keescook-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>, Michael Kerrisk <mtk.manpages-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, =?UTF-8?Q?Micka=c3=abl_Sala=c3=bcn?= <mickael.salaun-D9rjmswh09VWj0EZb7rXcA@public.gmane.org>, "Serge E . Hallyn" <serge-A9i7LUbDfNHQT0dZR+AlfA@public.gmane.org>, Shuah Khan <shuah-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Vincent Dagonneau <vincent.dagonneau-D9rjmswh09VWj0EZb7rXcA@public.gmane.org>, kernel-hardening-ZwoEplunGu1jrUoiu81ncdBPR1lH4CV8@public.gmane.org, linux-api-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arch-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-doc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-fsdevel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kselftest-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-security-module@vger.k
List-Id: linux-arch.vger.kernel.org


On 29/02/2020 18:23, Randy Dunlap wrote:
> Hi,
> Here are a few corrections for you to consider.
> 
> 
> On 2/24/20 8:02 AM, Mickaël Salaün wrote:
>> This documentation can be built with the Sphinx framework.
>>
>> Another location might be more appropriate, though.
>>
>> Signed-off-by: Mickaël Salaün <mic-WFhQfpSGs3bR7s880joybQ@public.gmane.org>
>> Reviewed-by: Vincent Dagonneau <vincent.dagonneau-D9rjmswh09VWj0EZb7rXcA@public.gmane.org>
>> Cc: Andy Lutomirski <luto-kltTT9wpgjJwATOyAt5JVQ@public.gmane.org>
>> Cc: James Morris <jmorris-gx6/JNMH7DfYtjvyW6yDsg@public.gmane.org>
>> Cc: Kees Cook <keescook-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>
>> Cc: Serge E. Hallyn <serge-A9i7LUbDfNHQT0dZR+AlfA@public.gmane.org>
>> ---
>>
>> Changes since v13:
>> * Rewrote the documentation according to the major revamp.
>>
>> Previous version:
>> https://lore.kernel.org/lkml/20191104172146.30797-8-mic-WFhQfpSGs3bR7s880joybQ@public.gmane.org/
>> ---
>>  Documentation/security/index.rst           |   1 +
>>  Documentation/security/landlock/index.rst  |  18 ++
>>  Documentation/security/landlock/kernel.rst |  44 ++++
>>  Documentation/security/landlock/user.rst   | 233 +++++++++++++++++++++
>>  4 files changed, 296 insertions(+)
>>  create mode 100644 Documentation/security/landlock/index.rst
>>  create mode 100644 Documentation/security/landlock/kernel.rst
>>  create mode 100644 Documentation/security/landlock/user.rst
>>
>> diff --git a/Documentation/security/landlock/index.rst b/Documentation/security/landlock/index.rst
>> new file mode 100644
>> index 000000000000..dbd33b96ce60
>> --- /dev/null
>> +++ b/Documentation/security/landlock/index.rst
>> @@ -0,0 +1,18 @@
>> +=========================================
>> +Landlock LSM: unprivileged access control
>> +=========================================
>> +
>> +:Author: Mickaël Salaün
>> +
>> +The goal of Landlock is to enable to restrict ambient rights (e.g.  global
>> +filesystem access) for a set of processes.  Because Landlock is a stackable
>> +LSM, it makes possible to create safe security sandboxes as new security layers
>> +in addition to the existing system-wide access-controls. This kind of sandbox
>> +is expected to help mitigate the security impact of bugs or
>> +unexpected/malicious behaviors in user-space applications. Landlock empower any
> 
>                                                                        empowers
> 
>> +process, including unprivileged ones, to securely restrict themselves.
>> +
>> +.. toctree::
>> +
>> +    user
>> +    kernel
>> diff --git a/Documentation/security/landlock/kernel.rst b/Documentation/security/landlock/kernel.rst
>> new file mode 100644
>> index 000000000000..b87769909029
>> --- /dev/null
>> +++ b/Documentation/security/landlock/kernel.rst
>> @@ -0,0 +1,44 @@
>> +==============================
>> +Landlock: kernel documentation
>> +==============================
>> +
>> +Landlock's goal is to create scoped access-control (i.e. sandboxing).  To
>> +harden a whole system, this feature should be available to any process,
>> +including unprivileged ones.  Because such process may be compromised or
>> +backdoored (i.e. untrusted), Landlock's features must be safe to use from the
>> +kernel and other processes point of view.  Landlock's interface must therefore
>> +expose a minimal attack surface.
>> +
>> +Landlock is designed to be usable by unprivileged processes while following the
>> +system security policy enforced by other access control mechanisms (e.g. DAC,
>> +LSM).  Indeed, a Landlock rule shall not interfere with other access-controls
>> +enforced on the system, only add more restrictions.
>> +
>> +Any user can enforce Landlock rulesets on their processes.  They are merged and
>> +evaluated according to the inherited ones in a way that ensure that only more
> 
>                                                            ensures
> 
>> +constraints can be added.
>> +
>> +
>> +Guiding principles for safe access controls
>> +===========================================
>> +
>> +* A Landlock rule shall be focused on access control on kernel objects instead
>> +  of syscall filtering (i.e. syscall arguments), which is the purpose of
>> +  seccomp-bpf.
>> +* To avoid multiple kind of side-channel attacks (e.g. leak of security
> 
>                        kinds
> 
>> +  policies, CPU-based attacks), Landlock rules shall not be able to
>> +  programmatically communicate with user space.
>> +* Kernel access check shall not slow down access request from unsandboxed
>> +  processes.
>> +* Computation related to Landlock operations (e.g. enforce a ruleset) shall
>> +  only impact the processes requesting them.
>> +
>> +
>> +Landlock rulesets and domains
>> +=============================
>> +
>> +A domain is a read-only ruleset tied to a set of subjects (i.e. tasks).  A
>> +domain can transition to a new one which is the intersection of the constraints
>> +from the current and a new ruleset.  The definition of a subject is implicit
>> +for a task sandboxing itself, which makes the reasoning much easier and helps
>> +avoid pitfalls.
>> diff --git a/Documentation/security/landlock/user.rst b/Documentation/security/landlock/user.rst
>> new file mode 100644
>> index 000000000000..cbd7f61fca8c
>> --- /dev/null
>> +++ b/Documentation/security/landlock/user.rst
>> @@ -0,0 +1,233 @@
>> +=================================
>> +Landlock: userspace documentation
>> +=================================
>> +
>> +Landlock rules
>> +==============
>> +
>> +A Landlock rule enables to describe an action on an object.  An object is
>> +currently a file hierarchy, and the related filesystem actions are defined in
>> +`Access rights`_.  A set of rules are aggregated in a ruleset, which can then
> 
>                                      is
> 
>> +restricts the thread enforcing it, and its future children.
> 
>    restrict
> 
>> +
>> +
>> +Defining and enforcing a security policy
>> +----------------------------------------
>> +
>> +Before defining a security policy, an application should first probe for the
>> +features supported by the running kernel, which is important to be compatible
>> +with older kernels.  This can be done thanks to the `landlock` syscall (cf.
>> +:ref:`syscall`).
>> +
>> +.. code-block:: c
>> +
>> +    struct landlock_attr_features attr_features;
>> +
>> +    if (landlock(LANDLOCK_CMD_GET_FEATURES, LANDLOCK_OPT_GET_FEATURES,
>> +            sizeof(attr_features), &attr_features)) {
>> +        perror("Failed to probe the Landlock supported features");
>> +        return 1;
>> +    }
>> +
>> +Then, we need to create the ruleset that will contains our rules.  For this
> 
>                                                  contain
> 
>> +example, the ruleset will contains rules which only allow read actions, but
> 
>                              contain
> 
>> +write actions will be denied.  The ruleset then needs to handle both of these
>> +kind of actions.  To have a backward compatibility, these actions should be
>> +ANDed with the supported ones.
>> +
>> +.. code-block:: c
>> +
>> +    int ruleset_fd;
>> +    struct landlock_attr_ruleset ruleset = {
>> +        .handled_access_fs =
>> +            LANDLOCK_ACCESS_FS_READ |
>> +            LANDLOCK_ACCESS_FS_READDIR |
>> +            LANDLOCK_ACCESS_FS_EXECUTE |
>> +            LANDLOCK_ACCESS_FS_WRITE |
>> +            LANDLOCK_ACCESS_FS_TRUNCATE |
>> +            LANDLOCK_ACCESS_FS_CHMOD |
>> +            LANDLOCK_ACCESS_FS_CHOWN |
>> +            LANDLOCK_ACCESS_FS_CHGRP |
>> +            LANDLOCK_ACCESS_FS_LINK_TO |
>> +            LANDLOCK_ACCESS_FS_RENAME_FROM |
>> +            LANDLOCK_ACCESS_FS_RENAME_TO |
>> +            LANDLOCK_ACCESS_FS_RMDIR |
>> +            LANDLOCK_ACCESS_FS_UNLINK |
>> +            LANDLOCK_ACCESS_FS_MAKE_CHAR |
>> +            LANDLOCK_ACCESS_FS_MAKE_DIR |
>> +            LANDLOCK_ACCESS_FS_MAKE_REG |
>> +            LANDLOCK_ACCESS_FS_MAKE_SOCK |
>> +            LANDLOCK_ACCESS_FS_MAKE_FIFO |
>> +            LANDLOCK_ACCESS_FS_MAKE_BLOCK |
>> +            LANDLOCK_ACCESS_FS_MAKE_SYM,
>> +    };
>> +
>> +    ruleset.handled_access_fs &= attr_features.access_fs;
>> +    ruleset_fd = landlock(LANDLOCK_CMD_CREATE_RULESET,
>> +                    LANDLOCK_OPT_CREATE_RULESET, sizeof(ruleset), &ruleset);
>> +    if (ruleset_fd < 0) {
>> +        perror("Failed to create a ruleset");
>> +        return 1;
>> +    }
>> +
>> +We can now add a new rule to this ruleset thanks to the returned file
>> +descriptor referring to this ruleset.  The rule will only enable to read the
>> +file hierarchy ``/usr``.  Without other rule, write actions would then be
> 
>                              Without other rules,
> or
>                              Without another rule,
> 
>> +denied by the ruleset.  To add ``/usr`` to the ruleset, we open it with the
>> +``O_PATH`` flag and fill the &struct landlock_attr_path_beneath with this file
>> +descriptor.
>> +
>> +.. code-block:: c
>> +
>> +    int err;
>> +    struct landlock_attr_path_beneath path_beneath = {
>> +        .ruleset_fd = ruleset_fd,
>> +        .allowed_access =
>> +            LANDLOCK_ACCESS_FS_READ |
>> +            LANDLOCK_ACCESS_FS_READDIR |
>> +            LANDLOCK_ACCESS_FS_EXECUTE,
>> +    };
>> +
>> +    path_beneath.allowed_access &= attr_features.access_fs;
>> +    path_beneath.parent_fd = open("/usr", O_PATH | O_CLOEXEC);
>> +    if (path_beneath.parent_fd < 0) {
>> +        perror("Failed to open file");
>> +        close(ruleset_fd);
>> +        return 1;
>> +    }
>> +    err = landlock(LANDLOCK_CMD_ADD_RULE, LANDLOCK_OPT_ADD_RULE_PATH_BENEATH,
>> +            sizeof(path_beneath), &path_beneath);
>> +    close(path_beneath.parent_fd);
>> +    if (err) {
>> +        perror("Failed to update ruleset");
>> +        close(ruleset_fd);
>> +        return 1;
>> +    }
>> +
>> +We now have a ruleset with one rule allowing read access to ``/usr`` while
>> +denying all accesses featured in ``attr_features.access_fs`` to everything else
>> +on the filesystem.  The next step is to restrict the current thread from
>> +gaining more privileges (e.g. thanks to a SUID binary).
>> +
>> +.. code-block:: c
>> +
>> +    if (prctl(PR_SET_NO_NEW_PRIVS, 1, 0, 0, 0)) {
>> +        perror("Failed to restrict privileges");
>> +        close(ruleset_fd);
>> +        return 1;
>> +    }
>> +
>> +The current thread is now ready to sandbox itself with the ruleset.
>> +
>> +.. code-block:: c
>> +
>> +    struct landlock_attr_enforce attr_enforce = {
>> +        .ruleset_fd = ruleset_fd,
>> +    };
>> +
>> +    if (landlock(LANDLOCK_CMD_ENFORCE_RULESET, LANDLOCK_OPT_ENFORCE_RULESET,
>> +            sizeof(attr_enforce), &attr_enforce)) {
>> +        perror("Failed to enforce ruleset");
>> +        close(ruleset_fd);
>> +        return 1;
>> +    }
>> +    close(ruleset_fd);
>> +
>> +If this last system call succeeds, the current thread is now restricted and
> 
>    If this last landlock system call succeeds,
> 
> [because close() is the last system call]
> 
>> +this policy will be enforced on all its subsequently created children as well.
>> +Once a thread is landlocked, there is no way to remove its security policy,
> 
>                                                    preferably:         policy;
> 
>> +only adding more restrictions is allowed.  These threads are now in a new
>> +Landlock domain, merge of their parent one (if any) with the new ruleset.
>> +
>> +A full working code can be found in `samples/landlock/sandboxer.c`_.
> 
>    Full working code
> 
>> +
>> +
>> +Inheritance
>> +-----------
>> +
>> +Every new thread resulting from a :manpage:`clone(2)` inherits Landlock program
>> +restrictions from its parent.  This is similar to the seccomp inheritance (cf.
>> +:doc:`/userspace-api/seccomp_filter`) or any other LSM dealing with task's
>> +:manpage:`credentials(7)`.  For instance, one process' thread may apply
> 
>                                                  process's
> 
>> +Landlock rules to itself, but they will not be automatically applied to other
>> +sibling threads (unlike POSIX thread credential changes, cf.
>> +:manpage:`nptl(7)`).
> 
> [snip]
> 
> thanks for the documentation.
> 

Done. Thanks for this attentive review!
