From: ebiederm@xmission.com (Eric W. Biederman)
Subject: Re: [PATCH 6/6] exec: use force_uaccess_begin during exec and exit
Date: Tue, 14 Jul 2020 22:33:05 -0500
Message-ID: <87v9ip4fm6.fsf@x220.int.ebiederm.org>
References: <20200714105505.935079-1-hch@lst.de>
        <20200714105505.935079-7-hch@lst.de>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from out03.mta.xmission.com ([166.70.13.233]:42686 "EHLO
        out03.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726648AbgGODgB (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 14 Jul 2020 23:36:01 -0400
In-Reply-To: <20200714105505.935079-7-hch@lst.de> (Christoph Hellwig's message
        of "Tue, 14 Jul 2020 12:55:05 +0200")
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Nick Hu <nickhu@andestech.com>, Greentime Hu <green.hu@gmail.com>, Vincent Chen <deanbo422@gmail.com>, Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>, Andrew Morton <akpm@linux-foundation.org>, Linus Torvalds <torvalds@linux-foundation.org>, linux-riscv@lists.infradead.org, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org

Christoph Hellwig <hch@lst.de> writes:

> Both exec and exit want to ensure that the uaccess routines actually do
> access user pointers.  Use the newly added force_uaccess_begin helper
> instead of an open coded set_fs for that to prepare for kernel builds
> where set_fs() does not exist.

Acked-by: "Eric W. Biederman" <ebiederm@xmission.com>

Have you played with a tree with all of your patches
and placing force_uaccess_begin in init/main.c:start_kernel?

Somewhere deep in the arch code we seem to have it all backwards
and kernel threads are all set_fs(KERNEL_DS).  So just putting
a force_uaccess_begin somewhere very early should be enough
to switch things around.

> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  fs/exec.c     | 7 ++++++-
>  kernel/exit.c | 2 +-
>  2 files changed, 7 insertions(+), 2 deletions(-)
>
> diff --git a/fs/exec.c b/fs/exec.c
> index e6e8a9a7032784..769af470b69124 100644
> --- a/fs/exec.c
> +++ b/fs/exec.c
> @@ -1380,7 +1380,12 @@ int begin_new_exec(struct linux_binprm * bprm)
>  	if (retval)
>  		goto out_unlock;
>  
> -	set_fs(USER_DS);
> +	/*
> +	 * Ensure that the uaccess routines can actually operate on userspace
> +	 * pointers:
> +	 */
> +	force_uaccess_begin();
> +
>  	me->flags &= ~(PF_RANDOMIZE | PF_FORKNOEXEC | PF_KTHREAD |
>  					PF_NOFREEZE | PF_NO_SETAFFINITY);
>  	flush_thread();
> diff --git a/kernel/exit.c b/kernel/exit.c
> index 727150f2810338..17d486a20f0dc6 100644
> --- a/kernel/exit.c
> +++ b/kernel/exit.c
> @@ -731,7 +731,7 @@ void __noreturn do_exit(long code)
>  	 * mm_release()->clear_child_tid() from writing to a user-controlled
>  	 * kernel address.
>  	 */
> -	set_fs(USER_DS);
> +	force_uaccess_begin();
>  
>  	if (unlikely(in_atomic())) {
>  		pr_info("note: %s[%d] exited with preempt_count %d\n",
