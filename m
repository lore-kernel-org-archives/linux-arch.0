From: Kyle McMartin <kyle@infradead.org>
Subject: Re: flock, FAGAIN, and FWOULDBLOCK
Date: Sun, 22 Feb 2009 22:50:29 -0500
Message-ID: <20090223035029.GD13157@bombadil.infradead.org>
References: <200902222252.45051.sf@sfritsch.de> <20090222224924.GA13157@bombadil.infradead.org> <20090223014224.GB13157@bombadil.infradead.org> <cfd18e0f0902221920o3fafe56w73e3534dfe355abb@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from bombadil.infradead.org ([18.85.46.34]:34181 "EHLO
	bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751104AbZBWDud (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Sun, 22 Feb 2009 22:50:33 -0500
Content-Disposition: inline
In-Reply-To: <cfd18e0f0902221920o3fafe56w73e3534dfe355abb@mail.gmail.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: mtk.manpages@gmail.com
Cc: Kyle McMartin <kyle@infradead.org>, linux-arch@vger.kernel.org, Stefan Fritsch <sf@sfritsch.de>, debian-hppa@lists.debian.org

On Mon, Feb 23, 2009 at 04:20:53PM +1300, Michael Kerrisk wrote:
> * POSIX has no specification of flock() (only fcntl() locking is
> specified by POSIX.1).
> 

*nod* My mistake.

> * My understanding is that EAGAIN originated on System V, and was the
> error returned instead of blocking for system calls performing I/O,
> semaphore operations, message queue operations, and (fcntl()) file
> locking.  EWOULDBLOCK originated on BSD, and was returned by (flock())
> file locking and socket-related system calls.
> 
> * flock() is a BSDism, and the associated error was EWOULDBLOCK.
> 
> * Generally POSIX requires that each error name must have  distinct
> associated value.  EAGAIN and EWOULDBLOCK are one of the few
> exceptions: POSIX permits, but does not require, that these error
> constants have the same value.  On most systems they of course do have
> the same value.  HP-UX is the most notable exception.
> 

You appear to be be quite correct, I would imagine this is 'hysterical
raisins.' Helpfully FreeBSD seems to have ancient BSD manpages on
their cgi search page, which seems to confirm this ancestry.

> > This is really going to suck, it looks like a lot of the locking
> > primitives used EAGAIN and EWOULDBLOCK interchangeably...  The fcntl
> > manpage says 'EAGAIN or EWOULDBLOCK'
> 
> Whoa -- that text in fcntl(2) relates to non-blocking I/O -- not file locking.
> (There is a different mess for fcntl() file locking: if a non-blocking
> log request is made (F_SETLK), then the call fails with the error
> EACCES of EAGAIN -- POSIX explicitly allows this since there was
> historical variation across systems.)
> 

*nod* the perils of relying solely on grep without context. :/

> > so is flock(2) the only problem
> > here? From a quick glance at posix, fcntl(2) returning EAGAIN is
> > correct.
> 
> Returning EAGIN is correct, but returning EACCES is also permitted, as
> noted above.
> 
> > My guess is, I'll be able to sort this out with a simple
> 
> Maybe.  I suppose that it depends on what (broken) userland apps expect.
> 

Yeah, hopefully I can just paper over flock and pretend the issue
doesn't exist. :/

Thanks for clarifying, Michael. I really appreciate you taking the time.

regards, Kyle

> Cheers,
> 
> Michael
> 
> > diff --git a/arch/parisc/kernel/sys_parisc.c
> > b/arch/parisc/kernel/sys_parisc.c
> > index 71b3195..18e8542 100644
> > --- a/arch/parisc/kernel/sys_parisc.c
> > +++ b/arch/parisc/kernel/sys_parisc.c
> > @@ -156,6 +156,17 @@ asmlinkage unsigned long sys_mmap(unsigned long addr,
> > unsigned long len,
> >
> >  /* Fucking broken ABI */
> >
> > +asmlinkage long parisc_flock(unsigned int fd, unsigned int cmd)
> > +{
> > +	long ret;
> > +
> > +	ret = sys_flock(fd, cmd);
> > +	if (ret == -EAGAIN)
> > +		ret = -EWOULDBLOCK;	/* fuck you HPUX */
> > +
> > +	return ret;
> > +}
> > +
> >  #ifdef CONFIG_64BIT
> >  asmlinkage long parisc_truncate64(const char __user * path,
> >  					unsigned int high, unsigned int low)
> > diff --git a/arch/parisc/kernel/syscall_table.S
> > b/arch/parisc/kernel/syscall_table.S
> > index 303d2b6..8c62951 100644
> > --- a/arch/parisc/kernel/syscall_table.S
> > +++ b/arch/parisc/kernel/syscall_table.S
> > @@ -226,7 +226,7 @@
> >  	/* it is POSSIBLE that select will be OK because even though fd_set
> >  	 * contains longs, the macros and sizes are clever. */
> >  	ENTRY_COMP(select)
> > -	ENTRY_SAME(flock)
> > +	ENTRY_OURS(flock)
> >  	ENTRY_SAME(msync)
> >  	/* struct iovec contains pointers */
> >  	ENTRY_COMP(readv)		/* 145 */
> >
> > but somehow I suspect this interchangeable use of EAGAIN and EWOULDBLOCK
> > is going to reveal latent problems in this part of the kernel I would
> > rather not delve into...
> >
> > cheers, Kyle
> > --
> > To unsubscribe from this list: send the line "unsubscribe linux-arch" in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> >
> 
> 
> -- 
> Michael Kerrisk
> Linux man-pages maintainer; http://www.kernel.org/doc/man-pages/
> git://git.kernel.org/pub/scm/docs/man-pages/man-pages.git
> man-pages online: http://www.kernel.org/doc/man-pages/online_pages.html
> Found a bug? http://www.kernel.org/doc/man-pages/reporting_bugs.html
> --
> To unsubscribe from this list: send the line "unsubscribe linux-arch" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
