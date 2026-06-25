Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D400C3E0087;
	Thu, 25 Jun 2026 12:48:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782391697; cv=none; b=Bix31ahHb02KcydvdY+FA6Dyw/qhDXjvAjg+QtQT+eLB6ZIojkTKpxbV96GwcxdpuKoEmF+C1T3dNkYo9peXFvALflaveAXM5O2/GslvnG9vBnGg0xFUYGxFtugzbuEkSNUcvaqCf+wWSslzxP3P5VPPDFYEs03D+HWOhhTpBO8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782391697; c=relaxed/simple;
	bh=ecLJHdbUnjnmkDuBnsFoc7yx6mBMRutUOLZTeBf3z3A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rHqZRQl7iYgBMPNsNmENNXHvk+fq2bpc0gqPVs4aIMhObq+VdF2iSnaXgJ6hxLI1jG/eHf53CHdrV0URG6wzKOy16+fsoBTy4nP/RsYWMbeJ+1vnWzvKWp1e3yHaaEny38aUH62UM7rgkkPdCw7RCyId9qCiVv7cYp6IAVgd/AU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KU5GQ6RQ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KU5GQ6RQ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ABD261F00A3A;
	Thu, 25 Jun 2026 12:48:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782391695;
	bh=weA31p2jD9lyyOrrXVeUZkppTq/z9neDeMb140Q9F1g=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=KU5GQ6RQ78mxKiRT6LJmoynYS3eMfEeBJDIVF+0qaNBRjZyFahgNtX9s3l0DGTjZC
	 wWpzohD+qLs5R+oTLKDUBDKKezxl2kJGo8dtTCDjKgCcH5HMETBHPGOAdBWd6rCr4d
	 SB9lVr9oLc3dI8gtR0OxqhnpcswtIg1NcJj8WpCRuQzOhlWrGWiMLONy7G/PPEBl19
	 MZQbhemnCwempOqwQrLkAG+Y0VvPqCiS1By69b2e6cH1QJVUNfJ/VOYSkSdjvFG/w0
	 GtPU9vRlL845MssBXnyxJos4WHL2RHuq1yGw3n/DRe/xhr0Ig6op1KebSNQt2az2S7
	 eF475JJKBjB4Q==
Date: Thu, 25 Jun 2026 13:48:10 +0100
From: Lorenzo Stoakes <ljs@kernel.org>
To: Xin Zhao <jackzxcui1989@163.com>
Cc: brauner@kernel.org, mjguzik@gmail.com, pfalcato@suse.de, 
	ebiederm@xmission.com, viro@zeniv.linux.org.uk, jack@suse.cz, jlayton@kernel.org, 
	chuck.lever@oracle.com, alex.aring@gmail.com, arnd@arndb.de, keescook@chromium.org, 
	mcgrof@kernel.org, j.granados@samsung.com, allen.lkml@gmail.com, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, 
	Jonathan Corbet <corbet@lwn.net>, Andrew Morton <akpm@linux-foundation.org>, 
	David Hildenbrand <david@kernel.org>, Ingo Molnar <mingo@redhat.com>, 
	Peter Zijlstra <peterz@infradead.org>, Juri Lelli <juri.lelli@redhat.com>, 
	Vincent Guittot <vincent.guittot@linaro.org>, "Liam R. Howlett" <liam@infradead.org>, 
	linux-doc@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH v4] coredump: Add /proc/<pid>/coredump_pre_exit for
 pre-exit before dumping
Message-ID: <aj0cUrwdXYKIicC-@lucifer>
References: <20260624145552.70143-1-jackzxcui1989@163.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260624145552.70143-1-jackzxcui1989@163.com>

+cc missing maintainers, lists.

NAK.

This is un-upstreamable for numerous reasons.

The stuff you're doing in mm is broken, wrong and invasive and you've not
even bothered to cc- mm people. I'm annoyed by this.

You're also doing incredibly silly mistakes at v4 of something that should have
been an RFC.

You don't seem to understand the concept of patch _series_ (break it up into
smaller patches!!!) and you haven't bothered cc'ing maintainers whose subsystems
you're radically alterting.

I'm annoyed as you have a history where you were told not to add insane hacks
before ([0], my reply at [1]).

[0]:https://lore.kernel.org/all/20260116042817.3790405-1-jackzxcui1989@163.com/
[1]:https://lore.kernel.org/all/14110b70-19e7-474d-b0dd-ba80e8bed9b0@lucifer.local/

Was I wasting my time there? Am I wasting my time responding now?

And how hard is it to run a simple perl script?

Let me run it for you for _just_ the maintainers:

$ scripts/get_maintainer.pl --nogit --nogit-fallback --nor your_patch.patch
Jonathan Corbet <corbet@lwn.net> (maintainer:DOCUMENTATION)
Alexander Viro <viro@zeniv.linux.org.uk> (maintainer:FILESYSTEMS (VFS and infrastructure))
Christian Brauner <brauner@kernel.org> (maintainer:FILESYSTEMS (VFS and infrastructure))
Andrew Morton <akpm@linux-foundation.org> (maintainer:MEMORY MANAGEMENT - CORE)
David Hildenbrand <david@kernel.org> (maintainer:MEMORY MANAGEMENT - CORE)
Arnd Bergmann <arnd@arndb.de> (maintainer:GENERIC INCLUDE/ASM HEADER FILES)
Ingo Molnar <mingo@redhat.com> (maintainer:SCHEDULER)
Peter Zijlstra <peterz@infradead.org> (maintainer:SCHEDULER)
Juri Lelli <juri.lelli@redhat.com> (maintainer:SCHEDULER)
Vincent Guittot <vincent.guittot@linaro.org> (maintainer:SCHEDULER)
Kees Cook <kees@kernel.org> (maintainer:EXEC & BINFMT API, ELF)
"Liam R. Howlett" <liam@infradead.org> (maintainer:MEMORY MAPPING)
Lorenzo Stoakes <ljs@kernel.org> (maintainer:MEMORY MAPPING)
linux-doc@vger.kernel.org (open list:DOCUMENTATION)
linux-kernel@vger.kernel.org (open list)
linux-fsdevel@vger.kernel.org (open list:PROC FILESYSTEM)
linux-mm@kvack.org (open list:MEMORY MANAGEMENT - CORE)
linux-arch@vger.kernel.org (open list:GENERIC INCLUDE/ASM HEADER FILES)
EXEC & BINFMT API, ELF status: Supported

You're missing the majority of these. That's _not OK_.

On Wed, Jun 24, 2026 at 10:55:52PM +0800, Xin Zhao wrote:
> A coredump typically takes some time to complete. If we happen to hold a
> write lock with flock just before triggering the coredump, that write lock
> will not be released during the entire coredump process. As a result,
> other processes attempting to acquire the same write lock may experience
> significant delays. Another typical scenario is that shared memory, such
> as dma-buf, remains occupied and is not released for a long time due to
> core dumps.
>
> To address this, add /proc/<pid>/coredump_pre_exit node so that people can

This is a horrible idea.

> specify which resources they want to release before dumping core. This
> patch implements the early release of two types of resources: flock files
> and file-backed shared memory. Default settings are NOT pre-exit anything.

What, people set this ahead of time? For a dynamic thing like files?

>
> A temporary bit, O_TMPCLOS, is added to mark vma->vm_file->f_flags during
> the execution of the newly introduced exit_mmap_mapped_shared() function.
> In this way, the subsequent exit_files_pre_exit() function does not need
> to find the corresponding vma through the file to check for the VM_SHARED
> attribute, thereby reducing the traversal cost.

This sentence doesn't even make sense?

And also !VM_SHARED means !vma->vm_file so your code would NULL deref if you
didn't check that. But !VM_SHARED VMAs can absolutely be file-backed...

>
> Signed-off-by: Xin Zhao <jackzxcui1989@163.com>
> ---
>
> Change in v4:
> - Christian pointed out that the coredump process will traverse file
>   descriptors (fd), so certain fds should not be closed by default.
>   Rework the whole feature, add /proc/<pid>/coredump_pre_exit for user
>   pre-exit resources selection, default is NOT pre-exit anything.
> - Mateusz suggested that walking the fd table and release the file-lock is
>   reasonable. No longer release all the fd(s). Based on user config, only
>   the flock fd(s) and the fd(s) correspondent to file-backed shared memory
>   will be released at most.
>
> Change in v3:
> - Add comment and commit-log to explain why do the MMF_DUMP_MAPPED_SHARED
>   mm_flags_test() check, note that memory mapped files keep their own
>   separate references to the files. The case to work around is that early
>   unlocking a flock on a file allows other processes to lock and modify
>   the mapped data protected by the flock,
>   as suggested by Pedro Falcato.
> - Link to v3: https://lore.kernel.org/all/20260619122419.3954581-1-jackzxcui1989@163.com/
>
> Change in v2:
> - Get rid of the implement of adding new fcntl API, the issue does not
>   worth inflicting the cost on everyone,
>   as suggested by Al Viro.
> - Call exit_files() in coredump_wait(),
>   as suggested by Eric W. Biederman.
>   Add MMF_DUMP_MAPPED_SHARED mm_flags_test() check to filter cases that
>   need to dump file-backed shared memory.
> - Link to v2: https://lore.kernel.org/lkml/20260618150301.3226517-1-jackzxcui1989@163.com/
>
> v1:
> - Link to v1: https://lore.kernel.org/all/20260618030700.2511668-1-jackzxcui1989@163.com/
> ---
>  .../admin-guide/kernel-parameters.txt         |  5 ++
>  Documentation/filesystems/proc.rst            | 58 +++++++++-----
>  fs/coredump.c                                 | 23 ++++++
>  fs/file.c                                     | 46 +++++++++++
>  fs/proc/base.c                                | 78 +++++++++++++++++++
>  include/linux/mm.h                            |  1 +

No.

>  include/linux/mm_types.h                      |  9 +++

No.

>  include/linux/sched/task.h                    |  1 +
>  include/uapi/asm-generic/fcntl.h              |  4 +
>  kernel/fork.c                                 | 12 +++
>  mm/mmap.c                                     | 21 +++++

No.

>  11 files changed, 238 insertions(+), 20 deletions(-)

This is a completely insane diffstat for a single patch. Ridiculous.

AND YOU HAVEN'T ADDED A SINGLE TEST.

>
> diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
> index f575d4508..bc6d3859f 100644
> --- a/Documentation/admin-guide/kernel-parameters.txt
> +++ b/Documentation/admin-guide/kernel-parameters.txt
> @@ -1024,6 +1024,11 @@ Kernel parameters
>  			/proc/<pid>/coredump_filter.
>  			See also Documentation/filesystems/proc.rst.
>
> +	coredump_pre_exit=
> +			[KNL] Change the default value for
> +			/proc/<pid>/coredump_pre_exit.
> +			See also Documentation/filesystems/proc.rst.
> +
>  	coresight_cpu_debug.enable
>  			[ARM,ARM64]
>  			Format: <bool>
> diff --git a/Documentation/filesystems/proc.rst b/Documentation/filesystems/proc.rst
> index db6167bef..6a637d31d 100644
> --- a/Documentation/filesystems/proc.rst
> +++ b/Documentation/filesystems/proc.rst
> @@ -39,16 +39,17 @@ fixes/update part 1.1  Stefani Seibold <stefani@seibold.net>    June 9 2009
>    3.2	/proc/<pid>/oom_score - Display current oom-killer score
>    3.3	/proc/<pid>/io - Display the IO accounting fields
>    3.4	/proc/<pid>/coredump_filter - Core dump filtering settings
> -  3.5	/proc/<pid>/mountinfo - Information about mounts
> -  3.6	/proc/<pid>/comm  & /proc/<pid>/task/<tid>/comm
> -  3.7   /proc/<pid>/task/<tid>/children - Information about task children
> -  3.8   /proc/<pid>/fdinfo/<fd> - Information about opened file
> -  3.9   /proc/<pid>/map_files - Information about memory mapped files
> -  3.10  /proc/<pid>/timerslack_ns - Task timerslack value
> -  3.11	/proc/<pid>/patch_state - Livepatch patch operation state
> -  3.12	/proc/<pid>/arch_status - Task architecture specific information
> -  3.13  /proc/<pid>/fd - List of symlinks to open files
> -  3.14  /proc/<pid>/ksm_stat - Information about the process's ksm status.
> +  3.5  /proc/<pid>/coredump_pre_exit - Core dump pre-exit settings
> +  3.6	/proc/<pid>/mountinfo - Information about mounts
> +  3.7	/proc/<pid>/comm  & /proc/<pid>/task/<tid>/comm
> +  3.8   /proc/<pid>/task/<tid>/children - Information about task children
> +  3.9   /proc/<pid>/fdinfo/<fd> - Information about opened file
> +  3.10   /proc/<pid>/map_files - Information about memory mapped files
> +  3.11  /proc/<pid>/timerslack_ns - Task timerslack value
> +  3.12	/proc/<pid>/patch_state - Livepatch patch operation state
> +  3.13	/proc/<pid>/arch_status - Task architecture specific information
> +  3.14  /proc/<pid>/fd - List of symlinks to open files
> +  3.15  /proc/<pid>/ksm_stat - Information about the process's ksm status.
>
>    4	Configuring procfs
>    4.1	Mount options
> @@ -1961,7 +1962,24 @@ For example::
>    $ echo 0x7 > /proc/self/coredump_filter
>    $ ./some_program
>
> -3.5	/proc/<pid>/mountinfo - Information about mounts
> +3.5 /proc/<pid>/coredump_pre_exit - Core dump pre-exit settings
> +---------------------------------------------------------------
> +A coredump typically takes some time to complete. If we happen to hold a write
> +lock with flock just before triggering the coredump, that write lock will not
> +be released during the entire coredump process. As a result, other processes
> +attempting to acquire the same write lock may experience significant delays.
> +Another typical scenario is that shared memory, such as dma-buf, remains
> +occupied and is not released for a long time due to core dumps.
> +
> +/proc/<pid>/coredump_pre_exit allows you to pre-exit some resources before
> +dumping core.
> +
> +The following two types are supported:
> +
> +  - (bit 0) flock files
> +  - (bit 1) file-backed shared memory
> +
> +3.6	/proc/<pid>/mountinfo - Information about mounts
>  --------------------------------------------------------
>
>  This file contains lines of the form::
> @@ -2001,7 +2019,7 @@ For more information on mount propagation see:
>    Documentation/filesystems/sharedsubtree.rst
>
>
> -3.6	/proc/<pid>/comm  & /proc/<pid>/task/<tid>/comm
> +3.7	/proc/<pid>/comm  & /proc/<pid>/task/<tid>/comm
>  --------------------------------------------------------
>  These files provide a method to access a task's comm value. It also allows for
>  a task to set its own or one of its thread siblings comm value. The comm value
> @@ -2010,7 +2028,7 @@ then the kernel's TASK_COMM_LEN (currently 16 chars, including the NUL
>  terminator) will result in a truncated comm value.
>
>
> -3.7	/proc/<pid>/task/<tid>/children - Information about task children
> +3.8	/proc/<pid>/task/<tid>/children - Information about task children
>  -------------------------------------------------------------------------
>  This file provides a fast way to retrieve first level children pids
>  of a task pointed by <pid>/<tid> pair. The format is a space separated
> @@ -2027,7 +2045,7 @@ pids, so one needs to either stop or freeze processes being inspected
>  if precise results are needed.
>
>
> -3.8	/proc/<pid>/fdinfo/<fd> - Information about opened file
> +3.9	/proc/<pid>/fdinfo/<fd> - Information about opened file
>  ---------------------------------------------------------------
>  This file provides information associated with an opened file. The regular
>  files have at least four fields -- 'pos', 'flags', 'mnt_id' and 'ino'.
> @@ -2198,7 +2216,7 @@ VFIO Device files
>  where 'vfio-device-syspath' is the sysfs path corresponding to the VFIO device
>  file.
>
> -3.9	/proc/<pid>/map_files - Information about memory mapped files
> +3.10	/proc/<pid>/map_files - Information about memory mapped files
>  ---------------------------------------------------------------------
>  This directory contains symbolic links which represent memory mapped files
>  the process is maintaining.  Example output::
> @@ -2220,7 +2238,7 @@ time one can open(2) mappings from the listings of two processes and
>  comparing their inode numbers to figure out which anonymous memory areas
>  are actually shared.
>
> -3.10	/proc/<pid>/timerslack_ns - Task timerslack value
> +3.11	/proc/<pid>/timerslack_ns - Task timerslack value
>  ---------------------------------------------------------
>  This file provides the value of the task's timerslack value in nanoseconds.
>  This value specifies an amount of time that normal timers may be deferred
> @@ -2236,7 +2254,7 @@ Valid values are from 0 - ULLONG_MAX
>  An application setting the value must have PTRACE_MODE_ATTACH_FSCREDS level
>  permissions on the task specified to change its timerslack_ns value.
>
> -3.11	/proc/<pid>/patch_state - Livepatch patch operation state
> +3.12	/proc/<pid>/patch_state - Livepatch patch operation state
>  -----------------------------------------------------------------
>  When CONFIG_LIVEPATCH is enabled, this file displays the value of the
>  patch state for the task.
> @@ -2253,7 +2271,7 @@ patched.  If the patch is being enabled, then the task has already been
>  patched.  If the patch is being disabled, then the task hasn't been
>  unpatched yet.
>
> -3.12 /proc/<pid>/arch_status - task architecture specific status
> +3.13 /proc/<pid>/arch_status - task architecture specific status
>  -------------------------------------------------------------------
>  When CONFIG_PROC_PID_ARCH_STATUS is enabled, this file displays the
>  architecture specific status of the task.
> @@ -2298,7 +2316,7 @@ AVX512_elapsed_ms
>    the task is unlikely an AVX512 user, but depends on the workload and the
>    scheduling scenario, it also could be a false negative mentioned above.
>
> -3.13 /proc/<pid>/fd - List of symlinks to open files
> +3.14 /proc/<pid>/fd - List of symlinks to open files
>  -------------------------------------------------------
>  This directory contains symbolic links which represent open files
>  the process is maintaining.  Example output::
> @@ -2313,7 +2331,7 @@ The number of open files for the process is stored in 'size' member
>  of stat() output for /proc/<pid>/fd for fast access.
>  -------------------------------------------------------
>
> -3.14 /proc/<pid>/ksm_stat - Information about the process's ksm status
> +3.15 /proc/<pid>/ksm_stat - Information about the process's ksm status
>  ----------------------------------------------------------------------
>  When CONFIG_KSM is enabled, each process has this file which displays
>  the information of ksm merging status.
> diff --git a/fs/coredump.c b/fs/coredump.c
> index bb6fdb1f4..e08a8a6c4 100644
> --- a/fs/coredump.c
> +++ b/fs/coredump.c
> @@ -521,6 +521,27 @@ static int zap_threads(struct task_struct *tsk,
>  	return nr;
>  }
>
> +static void coredump_pre_exit(void)
> +{
> +	struct task_struct *tsk = current;
> +	unsigned long flags = __mm_flags_get_dumpable(tsk->mm);
> +
> +	if (!likely(flags & MMF_DUMP_PRE_EXIT_MASK))
> +		return;
> +
> +	/*
> +	 * Set O_TMPCLOS of file f_flags if file needs to be closed.
> +	 */
> +	if (test_bit(MMF_DUMP_PRE_EXIT_FILE_BACKED_SHARED, &flags) &&
> +	    !test_bit(MMF_DUMP_MAPPED_SHARED, &flags))
> +		exit_mmap_mapped_shared(tsk->mm);

What the hell are you doing?

This is not where we unmap VMAs?

This is likely broken in subtle ways.

> +
> +	/*
> +	 * Check O_TMPCLOS of file f_flags to close file and clear it.
> +	 */
> +	exit_files_pre_exit(tsk, mm_flags_test(MMF_DUMP_PRE_EXIT_FLOCK, tsk->mm));
> +}
> +
>  static int coredump_wait(int exit_code, struct core_state *core_state)
>  {
>  	struct task_struct *tsk = current;
> @@ -1100,6 +1121,8 @@ static void do_coredump(struct core_name *cn, struct coredump_params *cprm,
>  		return;
>  	}
>
> +	coredump_pre_exit();
> +
>  	switch (cn->core_type) {
>  	case COREDUMP_FILE:
>  		if (!coredump_file(cn, cprm, binfmt))
> diff --git a/fs/file.c b/fs/file.c
> index 2c81c0b16..a58ffffcc 100644
> --- a/fs/file.c
> +++ b/fs/file.c
> @@ -23,6 +23,7 @@
>  #include <linux/file_ref.h>
>  #include <net/sock.h>
>  #include <linux/init_task.h>
> +#include <linux/filelock.h>
>
>  #include "internal.h"
>
> @@ -527,6 +528,51 @@ void exit_files(struct task_struct *tsk)
>  	}
>  }
>
> +void exit_files_pre_exit(struct task_struct *tsk, bool checkflock)
> +{
> +	struct files_struct *files = tsk->files;
> +	struct fdtable *fdt;
> +	struct file *file;
> +	unsigned int i, j = 0;
> +
> +	if (!files)
> +		return;
> +
> +	fdt = rcu_dereference_raw(files->fdt);
> +	for (;;) {
> +		unsigned long set;
> +
> +		i = j * BITS_PER_LONG;
> +		if (i >= fdt->max_fds)
> +			break;
> +		set = fdt->open_fds[j++];
> +		while (set) {
> +			if (!(set & 1))
> +				goto next_fd;
> +			file = fdt->fd[i];
> +			if (!file)
> +				goto next_fd;
> +			if (file->f_flags & O_TMPCLOS) {
> +				file->f_flags &= ~O_TMPCLOS;
> +				goto close_fd;
> +			}
> +			if (!checkflock)
> +				goto next_fd;
> +			if (!vfs_inode_has_locks(file_inode(file)))
> +				goto next_fd;
> +
> +close_fd:
> +			fdt->fd[i] = NULL;
> +			filp_close(file, files);
> +			cond_resched();
> +
> +next_fd:
> +			i++;
> +			set >>= 1;
> +		}
> +	}

This code hurts my eyes.

> +}
> +
>  struct files_struct init_files = {
>  	.count		= ATOMIC_INIT(1),
>  	.fdt		= &init_files.fdtab,
> diff --git a/fs/proc/base.c b/fs/proc/base.c
> index d9acfa89c..99b5f219f 100644
> --- a/fs/proc/base.c
> +++ b/fs/proc/base.c
> @@ -3026,6 +3026,83 @@ static const struct file_operations proc_coredump_filter_operations = {
>  	.write		= proc_coredump_filter_write,
>  	.llseek		= generic_file_llseek,
>  };
> +

No comment, obviously.

> +static ssize_t proc_coredump_pre_exit_read(struct file *file, char __user *buf,
> +					   size_t count, loff_t *ppos)
> +{
> +	struct task_struct *task = get_proc_task(file_inode(file));
> +	struct mm_struct *mm;
> +	char buffer[PROC_NUMBUF];
> +	size_t len;
> +	int ret;
> +
> +	if (!task)
> +		return -ESRCH;
> +
> +	ret = 0;
> +	mm = get_task_mm(task);
> +	if (mm) {
> +		unsigned long flags = __mm_flags_get_dumpable(mm);
> +
> +		len = snprintf(buffer, sizeof(buffer), "%08lx\n",
> +			       ((flags & MMF_DUMP_PRE_EXIT_MASK) >>
> +				MMF_DUMP_PRE_EXIT_SHIFT));
> +		mmput(mm);
> +		ret = simple_read_from_buffer(buf, count, ppos, buffer, len);
> +	}
> +
> +	put_task_struct(task);
> +
> +	return ret;
> +}
> +

Yeah who needs a comment...

> +static ssize_t proc_coredump_pre_exit_write(struct file *file,
> +					    const char __user *buf,
> +					    size_t count,
> +					    loff_t *ppos)
> +{
> +	struct task_struct *task;
> +	struct mm_struct *mm;
> +	unsigned int val;
> +	int ret;
> +	int i;
> +	unsigned long mask;
> +
> +	ret = kstrtouint_from_user(buf, count, 0, &val);
> +	if (ret < 0)
> +		return ret;
> +
> +	ret = -ESRCH;
> +	task = get_proc_task(file_inode(file));
> +	if (!task)
> +		goto out_no_task;
> +
> +	mm = get_task_mm(task);
> +	if (!mm)
> +		goto out_no_mm;
> +	ret = 0;
> +
> +	for (i = 0, mask = 1; i < MMF_DUMP_PRE_EXIT_BITS; i++, mask <<= 1) {

What?

> +		if (val & mask)
> +			mm_flags_set(i + MMF_DUMP_PRE_EXIT_SHIFT, mm);
> +		else
> +			mm_flags_clear(i + MMF_DUMP_PRE_EXIT_SHIFT, mm);
> +	}
> +
> +	mmput(mm);
> + out_no_mm:
> +	put_task_struct(task);
> + out_no_task:
> +	if (ret < 0)
> +		return ret;
> +	return count;
> +}
> +
> +static const struct file_operations proc_coredump_pre_exit_operations = {
> +	.read		= proc_coredump_pre_exit_read,
> +	.write		= proc_coredump_pre_exit_write,
> +	.llseek		= generic_file_llseek,
> +};
>  #endif
>
>  #ifdef CONFIG_TASK_IO_ACCOUNTING
> @@ -3391,6 +3468,7 @@ static const struct pid_entry tgid_base_stuff[] = {
>  #endif
>  #ifdef CONFIG_ELF_CORE
>  	REG("coredump_filter", S_IRUGO|S_IWUSR, proc_coredump_filter_operations),
> +	REG("coredump_pre_exit", S_IRUGO|S_IWUSR, proc_coredump_pre_exit_operations),
>  #endif
>  #ifdef CONFIG_TASK_IO_ACCOUNTING
>  	ONE("io",	S_IRUSR, proc_tgid_io_accounting),
> diff --git a/include/linux/mm.h b/include/linux/mm.h
> index af23453e9..dfd4717c7 100644
> --- a/include/linux/mm.h
> +++ b/include/linux/mm.h
> @@ -4066,6 +4066,7 @@ void anon_vma_interval_tree_verify(struct anon_vma_chain *node);
>  extern int __vm_enough_memory(const struct mm_struct *mm, long pages, int cap_sys_admin);
>  extern int insert_vm_struct(struct mm_struct *, struct vm_area_struct *);
>  extern void exit_mmap(struct mm_struct *);
> +extern void exit_mmap_mapped_shared(struct mm_struct *mm);

You don't use extern.

>  bool mmap_read_lock_maybe_expand(struct mm_struct *mm, struct vm_area_struct *vma,
>  				 unsigned long addr, bool write);
>
> diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
> index c7db35be6..0555aaf50 100644
> --- a/include/linux/mm_types.h
> +++ b/include/linux/mm_types.h
> @@ -1963,6 +1963,15 @@ enum {
>  	(BIT(MMF_DUMP_ANON_PRIVATE) | BIT(MMF_DUMP_ANON_SHARED) | \
>  	 BIT(MMF_DUMP_HUGETLB_PRIVATE) | MMF_DUMP_MASK_DEFAULT_ELF)
>
> +/* coredump pre-exit bits */
> +#define MMF_DUMP_PRE_EXIT_FLOCK	11
> +#define MMF_DUMP_PRE_EXIT_FILE_BACKED_SHARED 12

Err do we have space for this?

You really want to add 2 more bits to mm_struct flags for this insanity?

> +
> +#define MMF_DUMP_PRE_EXIT_SHIFT	(MMF_DUMPABLE_BITS + MMF_DUMP_FILTER_BITS)
> +#define MMF_DUMP_PRE_EXIT_BITS	2
> +#define MMF_DUMP_PRE_EXIT_MASK	\
> +	(((1 << MMF_DUMP_PRE_EXIT_BITS) - 1) << MMF_DUMP_PRE_EXIT_SHIFT)

So are these dumpable bits or not? Why are you not just incrementing
MMF_DUMPABLE_BITS?

> +
>  #ifdef CONFIG_CORE_DUMP_DEFAULT_ELF_HEADERS
>  # define MMF_DUMP_MASK_DEFAULT_ELF	BIT(MMF_DUMP_ELF_HEADERS)
>  #else
> diff --git a/include/linux/sched/task.h b/include/linux/sched/task.h
> index 41ed884cf..b4becbf6c 100644
> --- a/include/linux/sched/task.h
> +++ b/include/linux/sched/task.h
> @@ -93,6 +93,7 @@ static inline void exit_thread(struct task_struct *tsk)
>  extern __noreturn void do_group_exit(int);
>
>  extern void exit_files(struct task_struct *);
> +extern void exit_files_pre_exit(struct task_struct *, bool);
>  extern void exit_itimers(struct task_struct *);
>
>  extern pid_t kernel_clone(struct kernel_clone_args *kargs);
> diff --git a/include/uapi/asm-generic/fcntl.h b/include/uapi/asm-generic/fcntl.h
> index 613475285..360604d65 100644
> --- a/include/uapi/asm-generic/fcntl.h
> +++ b/include/uapi/asm-generic/fcntl.h
> @@ -95,6 +95,10 @@
>  #define O_NDELAY	O_NONBLOCK
>  #endif
>
> +#ifndef O_TMPCLOS
> +#define O_TMPCLOS	0x80000000	/* tag need close, temporarily used */
> +#endif
> +
>  #define F_DUPFD		0	/* dup */
>  #define F_GETFD		1	/* get close_on_exec */
>  #define F_SETFD		2	/* set/clear close_on_exec */
> diff --git a/kernel/fork.c b/kernel/fork.c
> index a679b2448..84f1ee7f3 100644
> --- a/kernel/fork.c
> +++ b/kernel/fork.c
> @@ -1030,6 +1030,18 @@ static int __init coredump_filter_setup(char *s)
>
>  __setup("coredump_filter=", coredump_filter_setup);
>
> +static unsigned long default_dump_pre_exit;
> +
> +static int __init coredump_pre_exit_setup(char *s)
> +{
> +	default_dump_pre_exit =
> +		(simple_strtoul(s, NULL, 0) << MMF_DUMP_PRE_EXIT_SHIFT) &
> +		MMF_DUMP_PRE_EXIT_MASK;
> +	return 1;
> +}
> +
> +__setup("coredump_pre_exit=", coredump_pre_exit_setup);
> +
>  #include <linux/init_task.h>
>
>  static void mm_init_aio(struct mm_struct *mm)
> diff --git a/mm/mmap.c b/mm/mmap.c
> index 5754d1c36..b955c47c0 100644
> --- a/mm/mmap.c
> +++ b/mm/mmap.c
> @@ -1326,6 +1326,27 @@ void exit_mmap(struct mm_struct *mm)
>  	vm_unacct_memory(nr_accounted);
>  }
>
> +void exit_mmap_mapped_shared(struct mm_struct *mm)
> +{
> +	struct vm_area_struct *vma;
> +	VMA_ITERATOR(vmi, mm, 0);
> +
> +	mmap_write_lock(mm);
> +	lru_add_drain();

Why?

> +
> +	for_each_vma(vmi, vma) {

Literally every single VMA? Including the gate VMA too?

No VMA locks... so that's already broken.

> +		if (vma->vm_flags & VM_HUGETLB)
> +			continue;

That's not how you test for hugetlb.

> +		if (!(vma->vm_flags & VM_SHARED) || !file_inode(vma->vm_file)->i_nlink)

This isn't how we work with flags any more.

> +			continue;
> +		vma->vm_file->f_flags |= O_TMPCLOS;


Not sure directly manipulating file flags like this is valid in any way, shape,
or form.

> +		do_munmap(mm, vma->vm_start, vma->vm_end - vma->vm_start, NULL);

This is utterly broken, the outer loop will be invalidated by you removing
these, do_munmap() has its own iterator...

And this is just madly inefficient. Why wouldn't you just loop over the VMAs to
alter flags then unmap the whole range?

But this is also introducing a completely separate, duplicative, version of
exit_mmap().

You're not doing any of what that function does. You're just very inefficiently
unmapping everything?

> +		cond_resched();

Of course!

> +	}
> +
> +	mmap_write_unlock(mm);

And VMAs can be mapped again now?

> +}
> +
>  /*
>   * Return true if the calling process may expand its vm space by the passed
>   * number of pages
> --
> 2.34.1
>

I'm not sure if this idea can be made upstreamble in any way. But this patch or
anything that looks like it or fundamentally alters mm is just not acceptable,
sorry.

Lorenzo
