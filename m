Return-Path: <linux-arch-owner@vger.kernel.org>
Date: Fri, 4 Feb 2005 18:16:11 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: [patch 19/24] TASK_SIZE is variable.
In-Reply-To: <200502050150.j151osl11380@mail.osdl.org>
Message-ID: <Pine.LNX.4.58.0502041806120.2165@ppc970.osdl.org>
References: <200502050150.j151osl11380@mail.osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
To: Andrew Morton <akpm@osdl.org>
Cc: dwmw2@infradead.org, Linux Arch list <linux-arch@vger.kernel.org>
List-ID: <linux-arch.vger.kernel.org>



On Fri, 4 Feb 2005 akpm@osdl.org wrote:
> 
> From: David Woodhouse <dwmw2@infradead.org>
> 
> Bad things can happen if a 32-bit process is the last user of a 64-bit mm. 
> TASK_SIZE isn't a constant, and we can end up clearing page tables only up
> to the 32-bit TASK_SIZE instead of all the way.  We should probably
> double-check every instance of TASK_SIZE or USER_PTRS_PER_PGD for this kind
> of problem.

I think this is the wrong thing.

I think this is a bug in the architectures that play games with TASK_SIZE. 
They shouldn't.

TASK_SIZE and USER_PTRS_PER_PGD should _not_ be dependent on whether some 
process is in compatibility mode or not. 

The fact that a 32-bit process on a 64-bit kernel wants to limit certain
things to the low bits does _not_ mean that TASK_SIZE should change. It
should mean that "TASK_UNMAPPED_BASE" might change (preferably not even
that, actually - just make the damn arch_get_unmapped_area() have explicit
knowledge about min/max issues instead!), and that "tsk->addr_limit" might
change. But changing TASK_SIZE is crazy. And leads to exactly the kinds of 
problems this patch tries to fix (and who knows how many others).

Would arch maintainers please look at fixing this in their architectures 
instead? Make TASK_SIZE be the maximum size a process VM can have. 

		Linus
