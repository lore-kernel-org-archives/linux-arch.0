Return-Path: <linux-arch-owner@vger.kernel.org>
Date: Sat, 5 Feb 2005 09:06:19 +0000
From: Russell King <rmk@arm.linux.org.uk>
Subject: Re: [patch 19/24] TASK_SIZE is variable.
Message-ID: <20050205090619.C30866@flint.arm.linux.org.uk>
References: <200502050150.j151osl11380@mail.osdl.org> <Pine.LNX.4.58.0502041806120.2165@ppc970.osdl.org> <Pine.LNX.4.58.0502041919300.2165@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0502041919300.2165@ppc970.osdl.org>; from torvalds@osdl.org on Fri, Feb 04, 2005 at 07:29:17PM -0800
Sender: Russell King <rmk@arm.linux.org.uk>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Andrew Morton <akpm@osdl.org>, dwmw2@infradead.org, Linux Arch list <linux-arch@vger.kernel.org>
List-ID: <linux-arch.vger.kernel.org>

On Fri, Feb 04, 2005 at 07:29:17PM -0800, Linus Torvalds wrote:
> For example, replacing TASK_SIZE in fs/namei.c with "thread->addr_limit" 
> would actually clean up the code: it would mean that the games with 
> "get_fs()" etc would just go away, to be replaced with something like
> 
> 	unsigned long len;
> 	unsigned long limit = current_thread_info()->addr_limit;
> 
> 	if ((unsigned long) filename >= limit)
> 		return -EFAULT;
> 	len = limit - (unsigned long) filename;
> 	if (len > PATH_MAX)
> 		len = PATH_MAX;
> 
> which looks cleaner.

Except that "addr_limit" may be defined by an architecture to be zero
(which can be interpreted as 4GB by the arch specific code) for the
case where we allow kernel mode access.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 PCMCIA      - http://pcmcia.arm.linux.org.uk/
                 2.6 Serial core
