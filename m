Return-Path: <linux-arch-owner@vger.kernel.org>
Date: Fri, 4 Feb 2005 19:29:17 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: [patch 19/24] TASK_SIZE is variable.
In-Reply-To: <Pine.LNX.4.58.0502041806120.2165@ppc970.osdl.org>
Message-ID: <Pine.LNX.4.58.0502041919300.2165@ppc970.osdl.org>
References: <200502050150.j151osl11380@mail.osdl.org>
 <Pine.LNX.4.58.0502041806120.2165@ppc970.osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
To: Andrew Morton <akpm@osdl.org>
Cc: dwmw2@infradead.org, Linux Arch list <linux-arch@vger.kernel.org>
List-ID: <linux-arch.vger.kernel.org>



On Fri, 4 Feb 2005, Linus Torvalds wrote:
> 
> Would arch maintainers please look at fixing this in their architectures 
> instead? Make TASK_SIZE be the maximum size a process VM can have. 

Actually, thinking more about it, maybe the right idea (to avoid 
confusion) is to walk away from TASK_SIZE entirely.

For example, replacing TASK_SIZE in fs/namei.c with "thread->addr_limit" 
would actually clean up the code: it would mean that the games with 
"get_fs()" etc would just go away, to be replaced with something like

	unsigned long len;
	unsigned long limit = current_thread_info()->addr_limit;

	if ((unsigned long) filename >= limit)
		return -EFAULT;
	len = limit - (unsigned long) filename;
	if (len > PATH_MAX)
		len = PATH_MAX;

which looks cleaner.

(This also assumes that we would make mm_segment_t just be "unsigned
long", and stop playing games with segments looking like they were used a
few hundred million years ago in the paleozoic era Linux kernel. It made 
sense back when we did that long-ago conversion, it doesn't seem to make 
much sense any more ;).

			Linus
