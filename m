From: Kyle McMartin <kyle@infradead.org>
Subject: Re: flock, FAGAIN, and FWOULDBLOCK
Date: Sun, 22 Feb 2009 21:54:14 -0500
Message-ID: <20090223025414.GC13157@bombadil.infradead.org>
References: <200902222252.45051.sf@sfritsch.de> <20090222224924.GA13157@bombadil.infradead.org> <20090223014224.GB13157@bombadil.infradead.org> <119aab440902221843y7e664581w99a9d44257672ae2@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from bombadil.infradead.org ([18.85.46.34]:35867 "EHLO
	bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752629AbZBWCyW (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Sun, 22 Feb 2009 21:54:22 -0500
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
> 

Right, I had confused flock and flockfile in the index.

> > This is really going to suck, it looks like a lot of the locking
> > primitives used EAGAIN and EWOULDBLOCK interchangeably... The fcntl
> > manpage says 'EAGAIN or EWOULDBLOCK' so is flock(2) the only problem
> > here? From a quick glance at posix, fcntl(2) returning EAGAIN is
> > correct.
> 
> I would warn you that the linux man pages are often incorrect.
> 
> I use http://www.opengroup.org/onlinepubs/009695399/ for check POSIX
> requirements.
> 

I wouldn't be nearly so negative.

> A more robust solution would be?
> 
> if ((ret == -EAGAIN) || (ret == -EWOULDBLOK))
>         ret = -EWOULDBLOCK
> 
> This covers our ass since POSIX says that EAGAIN and EWOULDBLOCK *may*
> be the same.
> 

I have no idea what you're on about here, this is a parisc specific
file, where we know they aren't. I don't want to pollute generic linux
code with workarounds for moronic HPUX "let's be different for
difference sake" crap.

> > but somehow I suspect this interchangeable use of EAGAIN and EWOULDBLOCK
> > is going to reveal latent problems in this part of the kernel I would
> > rather not delve into...
> 
> The ABI is fixed, so all we can do is cleanup the uses in the kernel,
> and make sure we adhere to the documented APIs.
> 

I ain't volunteering...

> Don't get too upset ;-)
