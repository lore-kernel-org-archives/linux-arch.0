From: Michal Marek <mmarek@suse.com>
Subject: Re: [PATCH] kbuild: provide include/asm/asm-prototypes.h for ARM
Date: Sat, 22 Oct 2016 21:51:17 +0200
Message-ID: <20161022195117.GA1583@sepie.suse.cz>
References: <20161017065131.GA27863@angband.pl>
 <6556201.qTG4Pa4aHk@wuerfel>
 <fafba13a-c64c-2578-534c-c344f18d0fc5@suse.com>
 <3114442.xCAy34UQCk@wuerfel>
 <20161019153159.GQ1041@n2100.armlinux.org.uk>
 <20161020150814.42951f61@roar.ozlabs.ibm.com>
 <20161020131702.GX1041@n2100.armlinux.org.uk>
 <20161021012017.67b75a90@roar.ozlabs.ibm.com>
 <20161020143327.GY1041@n2100.armlinux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:46939 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751816AbcJVTvX (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Sat, 22 Oct 2016 15:51:23 -0400
Content-Disposition: inline
In-Reply-To: <20161020143327.GY1041@n2100.armlinux.org.uk>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Russell King - ARM Linux <linux@armlinux.org.uk>
Cc: Nicholas Piggin <npiggin@gmail.com>, Arnd Bergmann <arnd@arndb.de>, Adam Borowski <kilobyte@angband.pl>, Omar Sandoval <osandov@osandov.com>, Linus Torvalds <torvalds@linux-foundation.org>, adobriyan@gmail.com, sfr@canb.auug.org.au, viro@zeniv.linux.org.uk, linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org

On Thu, Oct 20, 2016 at 03:33:27PM +0100, Russell King - ARM Linux wrote:
> On Fri, Oct 21, 2016 at 01:20:17AM +1100, Nicholas Piggin wrote:
> > Good catch, I'm surprised you're the first one who reported it. This patch
> > seems to do the trick for me:
> 
> And me, thanks, so...
> 
> > 
> > From: Nicholas Piggin <npiggin@gmail.com>
> > Date: Fri, 21 Oct 2016 01:13:33 +1100
> > Subject: [PATCH] kbuild: prevent lib-ksyms.o rebuilds
> > 
> > Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
> 
> Reported-by: Russell King <rmk+kernel@armlinux.org.uk>
> Tested-by: Russell King <rmk+kernel@armlinux.org.uk>

Thanks. Added to kbuild.git#rc-fixes.

Michal
