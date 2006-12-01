Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mtagate5.de.ibm.com ([195.212.29.154]:92 "EHLO
	mtagate5.de.ibm.com") by vger.kernel.org with ESMTP
	id S1759298AbWLAOzT (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Fri, 1 Dec 2006 09:55:19 -0500
Received: from d12nrmr1607.megacenter.de.ibm.com (d12nrmr1607.megacenter.de.ibm.com [9.149.167.49])
	by mtagate5.de.ibm.com (8.13.8/8.13.8) with ESMTP id kB1EtHkD065364
	for <linux-arch@vger.kernel.org>; Fri, 1 Dec 2006 14:55:17 GMT
Received: from d12av02.megacenter.de.ibm.com (d12av02.megacenter.de.ibm.com [9.149.165.228])
	by d12nrmr1607.megacenter.de.ibm.com (8.13.6/8.13.6/NCO v8.1.1) with ESMTP id kB1EtH8x3031130
	for <linux-arch@vger.kernel.org>; Fri, 1 Dec 2006 15:55:17 +0100
Received: from d12av02.megacenter.de.ibm.com (loopback [127.0.0.1])
	by d12av02.megacenter.de.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id kB1EtGFU022435
	for <linux-arch@vger.kernel.org>; Fri, 1 Dec 2006 15:55:17 +0100
Date: Fri, 1 Dec 2006 15:53:40 +0100
From: Heiko Carstens <heiko.carstens@de.ibm.com>
Subject: Re: epoll_pwait
Message-ID: <20061201145340.GD8788@osiris.boeblingen.de.ibm.com>
References: <20061003002728.01133537.akpm@osdl.org> <1159862233.3438.45.camel@pmac.infradead.org> <1159864949.3438.55.camel@pmac.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1159864949.3438.55.camel@pmac.infradead.org>
Sender: linux-arch-owner@vger.kernel.org
To: David Woodhouse <dwmw2@infradead.org>
Cc: Andrew Morton <akpm@osdl.org>, linux-arch@vger.kernel.org, Davide Libenzi <davidel@xmailserver.org>, Michael Kerrisk <mtk-manpages@gmx.net>, Ulrich Drepper <drepper@redhat.com>, Roland McGrath <roland@redhat.com>, paulus@samba.org
List-ID: <linux-arch.vger.kernel.org>

On Tue, Oct 03, 2006 at 09:42:29AM +0100, David Woodhouse wrote:
> On Tue, 2006-10-03 at 08:57 +0100, David Woodhouse wrote:
> > On Tue, 2006-10-03 at 00:27 -0700, Andrew Morton wrote:
> > > 
> > > I'm about to send this Linuswards.  Architectures which implement
> > > TIF_RESTORE_SIGMASK can wire it up.
> > 
> > It needs compat_sys_epoll_wait() for the signal stuff though.
> 
> Something like the patch below ought to suffice, although it's not
> tested further than just building it.
> 
> ----
> [PATCH] Provide compat_sys_epoll_pwait(), wire up on PowerPC.
> 
> Also add a comment trying to make sense of the definition of
> struct epoll_event.
> 
> Signed-off-by: David Woodhouse <dwmw2@infradead.org>
> [...]
> +#ifdef CONFIG_COMPAT
> +extern void sigset_from_compat(sigset_t *set, compat_sigset_t *compat);
> +
> +asmlinkage long compat_sys_epoll_pwait(int epfd, struct epoll_event __user *events,
> +				       int maxevents, int timeout,
> +				       const compat_sigset_t __user *sigmask,
> +				       compat_size_t sigsetsize)
> [...]

What about this one? It's not in 2.6.19 nor in -mm. But sys_epoll_pwait is.
And even more strange is that mips uses sys_epoll_pwait for compat syscalls?!
Did I miss something?
