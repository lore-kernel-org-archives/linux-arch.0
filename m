Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from zeniv.linux.org.uk ([195.92.253.2]:43878 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750829AbdJRXFZ (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 18 Oct 2017 19:05:25 -0400
Date: Thu, 19 Oct 2017 00:05:21 +0100
From: Al Viro <viro@ZenIV.linux.org.uk>
Subject: Re: [PATCH 4/4][PoC][RFC] Allow to trace fd usage with rlimit-events
Message-ID: <20171018230521.GP21978@ZenIV.linux.org.uk>
References: <20171018203230.29871-1-k.opasiak@samsung.com>
 <CGME20171018203342epcas1p23933a20a33807f92c716433374374397@epcas1p2.samsung.com>
 <20171018203230.29871-5-k.opasiak@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20171018203230.29871-5-k.opasiak@samsung.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Krzysztof Opasiak <k.opasiak@samsung.com>
Cc: gregkh@linuxfoundation.org, arnd@arndb.de, linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-arch@vger.kernel.org, k.lewandowsk@samsung.com, l.stelmach@samsung.com, p.szewczyk@samsung.com, b.zolnierkie@samsung.com, andrzej.p@samsung.com, kopasiak90@gmail.com
Message-ID: <20171018230521.HFUUQKPAqgQBLxLb_cHFejr7V3RJ_iwBWlXAsyaT370@z>

On Wed, Oct 18, 2017 at 10:32:30PM +0200, Krzysztof Opasiak wrote:

> @@ -417,7 +417,7 @@ static int task_get_unused_fd_flags(struct binder_proc *proc, int flags)
>  	rlim_cur = task_rlimit(proc->tsk, RLIMIT_NOFILE);
>  	unlock_task_sighand(proc->tsk, &irqs);
>  
> -	return __alloc_fd(files, 0, rlim_cur, flags);
> +	return __alloc_fd(proc->tsk, 0, rlim_cur, flags);

Who said that proc->files will remain equal to proc->tsk->files?

> -static void __put_unused_fd(struct files_struct *files, unsigned int fd)
> +static void __put_unused_fd(struct task_struct *owner, unsigned int fd)
>  {
> +	struct files_struct *files = owner->files;
>  	struct fdtable *fdt = files_fdtable(files);
>  	__clear_open_fd(fd, fdt);
>  	if (fd < files->next_fd)
>  		files->next_fd = fd;
> +
> +	if (rlimit_noti_watch_active(owner, RLIMIT_NOFILE)) {
> +		unsigned int count;
> +
> +		count = count_open_fds(fdt);
> +		rlimit_noti_res_changed(owner, RLIMIT_NOFILE, count + 1, count);
> +	}
>  }

[... and similar for other __...fd() primitives]
This is blatantly wrong - you *CAN'T* modify files_struct unless it's
	a) yours (i.e. current->files) or
	b) you've had its refcount incremented for you by some process that
did, at the time, have current->files pointing to it.

There is a reason why binder keeps ->files explicitly, rather than going through
->tsk->files.
