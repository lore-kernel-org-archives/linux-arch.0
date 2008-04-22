From: Kyle McMartin <kyle-pfcGkIkfWfAsA/PxXw9srA@public.gmane.org>
Subject: Re: [RFC] Introduce __ARCH_WANT_SYS_SYSFS
Date: Tue, 22 Apr 2008 11:21:22 -0400
Message-ID: <20080422152122.GF19802@phobos.i.cabal.ca>
References: <87a5b0800804220513t75690ceao938a288596b5ad0c@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <87a5b0800804220513t75690ceao938a288596b5ad0c-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: linux-arch-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-arch.vger.kernel.org>
To: Will Newton <will.newton-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Linux Kernel list <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linux-arch-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

On Tue, Apr 22, 2008 at 01:13:39PM +0100, Will Newton wrote:
> Hi,
> 
> This patch introduces a __ARCH_WANT_SYS_SYSFS #define for
> architectures that support the sysfs(2) system call. At the moment
> that's everybody but blackfin, but future architectures may want to
> save the (admittedly small) code size that it adds to the kernel as
> well.
> 

This should (imnsho, at least),
	1 - Add a cond_syscall for sys_sysfs to sys_ni.c
	2 - Use a CONFIG_EMBEDDED dependent option that defaults on,
	    possibly depend on BLACKFIN if you really want to.

Adding this junk to every arch header is, in my opinion, completely
unacceptable just because blackfin wants to be different.

--Kyle
