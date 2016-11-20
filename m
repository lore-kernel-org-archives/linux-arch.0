From: Russell King - ARM Linux <linux@armlinux.org.uk>
Subject: Re: [PATCH 1/2] kbuild: provide include/asm/asm-prototypes.h for ARM
Date: Sun, 20 Nov 2016 13:21:27 +0000
Message-ID: <20161120132127.GU1041@n2100.armlinux.org.uk>
References: <20161017065131.GA27863@angband.pl>
 <20161020150814.42951f61@roar.ozlabs.ibm.com>
 <3446653.W8FbGAKSeQ@wuerfel>
 <14534456.e6dv16VA3R@wuerfel>
 <20161025193200.1f4d9e24@roar.ozlabs.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from pandora.armlinux.org.uk ([78.32.30.218]:39322 "EHLO
        pandora.armlinux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752060AbcKTNVo (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sun, 20 Nov 2016 08:21:44 -0500
Content-Disposition: inline
In-Reply-To: <20161025193200.1f4d9e24@roar.ozlabs.ibm.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Nicholas Piggin <npiggin@gmail.com>
Cc: Arnd Bergmann <arnd@arndb.de>, Michal Marek <mmarek@suse.com>, Adam Borowski <kilobyte@angband.pl>, Omar Sandoval <osandov@osandov.com>, Linus Torvalds <torvalds@linux-foundation.org>, adobriyan@gmail.com, sfr@canb.auug.org.au, viro@zeniv.linux.org.uk, linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org

On Tue, Oct 25, 2016 at 07:32:00PM +1100, Nicholas Piggin wrote:
> On Mon, 24 Oct 2016 17:05:26 +0200
> Arnd Bergmann <arnd@arndb.de> wrote:
> 
> > This adds an asm/asm-prototypes.h header for ARM to fix the
> > broken symbol versioning for symbols exported from assembler
> > files.
> > 
> > In addition to the header, we have to do these other small
> > changes:
> > 
> > - move the exports from bitops.h to {change,clear,set,...}bit.S
> > - move the exports from csumpartialgeneric.S into the files
> >   including it
> > 
> > I couldn't find the correct prototypes for the compiler builtins,
> > so I went with the fake 'void f(void)' prototypes that we had
> > before.
> > 
> > This leaves the mmioset/mmiocpy function for now, as it's not
> > obvious how to best handle them.
> 
> 
> This looks nicer. I like variant B because it keeps the GENKSYMS cruft to
> a single location, but either one isn't too bad.
> 
> I'd like to get moving on this, so let's at least get the generic kbuild
> change merged. In the end, the kbuild code does not prevent a maintainer
> from putting their EXPORT_SYMBOL in whatever location they like, so there
> is no reason not to merge it (certainly there will be archs that do use
> it).
> 
> Michal, what's your thoughts? If you merge my patch 2/2 and skip 1/2, it
> should not give any new build warnings or errors, so then arch patches can
> go via arch trees. 1/2 could go in after everyone is up to date.

So what's the conclusion on this?  I've just had a failure due to
CONFIG_TRIM_UNUSED_KSYMS reported on ARM, and it looks like (at
least some of) patch 1 could resolve it.

Do we need to split patch 1?

Has any of these patches been committed yet?

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
