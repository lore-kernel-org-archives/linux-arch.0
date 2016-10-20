From: Nicholas Piggin <npiggin@gmail.com>
Subject: Re: [PATCH] kbuild: provide include/asm/asm-prototypes.h for ARM
Date: Fri, 21 Oct 2016 01:51:35 +1100
Message-ID: <20161021015135.48a893bf@roar.ozlabs.ibm.com>
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
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20161020143327.GY1041@n2100.armlinux.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
To: Russell King - ARM Linux <linux@armlinux.org.uk>
Cc: Arnd Bergmann <arnd@arndb.de>, Michal Marek <mmarek@suse.com>, Adam Borowski <kilobyte@angband.pl>, Omar Sandoval <osandov@osandov.com>, Linus Torvalds <torvalds@linux-foundation.org>, adobriyan@gmail.com, sfr@canb.auug.org.au, viro@zeniv.linux.org.uk, linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
List-Id: linux-arch.vger.kernel.org

On Thu, 20 Oct 2016 15:33:27 +0100
Russell King - ARM Linux <linux@armlinux.org.uk> wrote:

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

Thanks for testing it.

Hopefully if Arnd is able to respin the ARM patch to something a bit more
to your liking that doesn't expose prototypes, and no other problems arise,
we can avoid reverting. You had a poor first impression, but we may yet win
you over.
