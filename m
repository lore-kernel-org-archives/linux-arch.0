From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH] arch/tile: new multi-core architecture for Linux
Date: Tue, 25 May 2010 17:30:18 +0200
Message-ID: <201005251730.18830.arnd@arndb.de>
References: <201005200543.o4K5hFRF006079@farm-0002.internal.tilera.com> <201005251703.11613.arnd@arndb.de> <4BFBE8FF.6080208@tilera.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.17.10]:63622 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751024Ab0EYPaZ (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Tue, 25 May 2010 11:30:25 -0400
In-Reply-To: <4BFBE8FF.6080208@tilera.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Chris Metcalf <cmetcalf@tilera.com>
Cc: Ulrich Drepper <drepper@gmail.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linus Torvalds <torvalds@linux-foundation.org>, linux-arch@vger.kernel.org, Chen Liqin <liqin.chen@sunplusct.com>

On Tuesday 25 May 2010, Chris Metcalf wrote:
> >  The idea was to only have them around as a transitional helper for
> > new architectures while getting merged, but nothing should ever
> > use these in production.
> >   
> 
> Perhaps the best strategy for Tile for now is to enable the transitional
> helpers, and then when glibc no longer requires any of those syscalls,
> we can remove them from the kernel.  If this happens in the relatively
> short term (e.g. before our 3.0 release later this year) all the better,
> but for now we can separate this into a first change that preserves most
> of the compatibility syscalls, and work towards remove them in a later
> release.

I don't like the idea of adding syscalls first and then disabling them
again. We tried that on score and now we're stuck with the wrong syscall
table there because they never got removed.

Instead, I'd suggest you do the minimal syscall table for upstream and
just carry a private patch to enable the other syscalls until you get
a working glibc/eglibc/uclibc with the official kernel.

	Arnd
