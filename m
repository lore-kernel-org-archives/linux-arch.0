Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from bedivere.hansenpartnership.com ([66.63.167.143]:53069 "EHLO
	bedivere.hansenpartnership.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752760Ab2A3WpY (ORCPT
	<rfc822;linux-arch@vger.kernel.org>);
	Mon, 30 Jan 2012 17:45:24 -0500
Message-ID: <1327963522.21193.92.camel@dabdike.int.hansenpartnership.com>
Subject: Re: [PATCH] fix compile break caused by iomap: make IOPORT/PCI
 mapping functions conditional
From: James Bottomley <James.Bottomley@HansenPartnership.com>
Date: Mon, 30 Jan 2012 16:45:22 -0600
In-Reply-To: <1539148.qFWsuy2OOI@eto>
References: <1327941647.21193.53.camel@dabdike.int.hansenpartnership.com>
	 <1539148.qFWsuy2OOI@eto>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Mime-Version: 1.0
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Rolf Eike Beer <eike-kernel@sf-tec.de>
Cc: Randy Dunlap <rdunlap@xenotime.net>, Linus Torvalds <torvalds@linux-foundation.org>, linux-arch@vger.kernel.org, Parisc List <linux-parisc@vger.kernel.org>
Message-ID: <20120130224522.CuBIBsRnMdcUfmoJfIwgoxzRiuY_4rb9N5sg-tumy6E@z>

On Mon, 2012-01-30 at 21:10 +0100, Rolf Eike Beer wrote:
> Am Montag 30 Januar 2012, 10:40:47 schrieb James Bottomley:
> > The problem in
> > 
> > commit fea80311a939a746533a6d7e7c3183729d6a3faf
> > Author: Randy Dunlap <rdunlap@xenotime.net>
> > Date:   Sun Jul 24 11:39:14 2011 -0700
> > 
> >     iomap: make IOPORT/PCI mapping functions conditional
> > 
> > 
> > is that if your architecture supplies pci_iomap/pci_iounmap, it expects
> > always to supply them.  Adding empty body defitions in the !CONFIG_PCI
> > case, which is what this patch does, breaks the parisc compile because
> > the functions become doubly defined.  It took us a while to spot this,
> > because we don't actually build !CONFIG_PCI very often (only if someone
> > is brave enough to test the snake/asp machines).
> > 
> > Since the note in the commit log says this is to fix a
> > CONFIG_GENERIC_IOMAP issue (which it does because CONFIG_GENERIC_IOMAP
> > supplies pci_iounmap only if CONFIG_PCI is set), there should actually
> > have been a condition upon this.  This should make sure no other
> > architecture's !CONFIG_PCI compile breaks in the same way as parisc.
> > 
> > The fix had to be updated to take account of the GENERIC_PCI_IOMAP
> > separation.
> 
> So this means we end up still building the PA-RISC PCI code even if the config 
> says no PCI. That doesn't really sound consistent to me. I really would have 
> expected that we do not build any non-void PCI code then.

The first object is to fix the build breakage which likely affects more
than just parisc. Having a non-stub for the pci functions is just a few
spurious bytes in a kernel that's megabytes big (and it's what we were
doing previously).

James


