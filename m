From: Matthew Wilcox <matthew@wil.cx>
Subject: Re: flock, FAGAIN, and FWOULDBLOCK
Date: Sun, 22 Feb 2009 20:03:15 -0700
Message-ID: <20090223030315.GC16891@parisc-linux.org>
References: <200902222252.45051.sf@sfritsch.de> <20090222224924.GA13157@bombadil.infradead.org> <20090223014224.GB13157@bombadil.infradead.org> <119aab440902221843y7e664581w99a9d44257672ae2@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from palinux.external.hp.com ([192.25.206.14]:38770 "EHLO
	mail.parisc-linux.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750895AbZBWDDR (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Sun, 22 Feb 2009 22:03:17 -0500
Content-Disposition: inline
In-Reply-To: <119aab440902221843y7e664581w99a9d44257672ae2@mail.gmail.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Carlos O'Donell <carlos@systemhalted.org>
Cc: Kyle McMartin <kyle@infradead.org>, linux-arch@vger.kernel.org, Stefan Fritsch <sf@sfritsch.de>, debian-hppa@lists.debian.org

On Sun, Feb 22, 2009 at 09:43:36PM -0500, Carlos O'Donell wrote:
> flock is not POSIX, it's an interface invented by 4.2BSD, and was
> previously emulated by glibc. The glibc wrapper implemented flock with
> fcntl and made sure to return EWOULDBLOCK.

glibc's emulation of flock() using fcntl() really belongs to the Dark
Ages of Linux.  According to the comments in the kernel, flock(2) was
added in June 1995.  That's four years before parisc-linux really got
going.

The semantics of flock-locks and fcntl-locks are really, really
different.  Emulating one with the other was a really bad idea.

> > +       ret = sys_flock(fd, cmd);
> > +       if (ret == -EAGAIN)
> > +               ret = -EWOULDBLOCK;     /* fuck you HPUX */
> 
> A more robust solution would be?
> 
> if ((ret == -EAGAIN) || (ret == -EWOULDBLOK))
>         ret = -EWOULDBLOCK

How would that differ from what Kyle wrote?  Why would you want to
assign -EWOULDBLOCK to ret if ret is already -EWOULDBLOCK?

> This covers our ass since POSIX says that EAGAIN and EWOULDBLOCK *may*
> be the same.

That's irrelevant.  The only thing that matters is what the kernel does.

> > but somehow I suspect this interchangeable use of EAGAIN and EWOULDBLOCK
> > is going to reveal latent problems in this part of the kernel I would
> > rather not delve into...
> 
> The ABI is fixed, so all we can do is cleanup the uses in the kernel,
> and make sure we adhere to the documented APIs.

We actually can do better than this ...

#ifdef __KERNEL__
#define EWOULDBLOCK	EAGAIN
#else
#define EWOULDBLOCK	/* whatever the fuck HPUX uses */
#endif

Now our kernel never returns -EWOULDBLOCK, only -EAGAIN.  Correct
applications must check for both.  Incorrect applications tend to only
check for AGAIN, not WOULDBLOCK.  Problem solved.

-- 
Matthew Wilcox				Intel Open Source Technology Centre
"Bill, look, we understand that you're interested in selling us this
operating system, but compare it to ours.  We can't possibly take such
a retrograde step."
