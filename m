From: Nicholas Piggin <npiggin@gmail.com>
Subject: Re: [PATCH 1/2] kbuild: provide include/asm/asm-prototypes.h for
 ARM
Date: Tue, 25 Oct 2016 19:32:00 +1100
Message-ID: <20161025193200.1f4d9e24@roar.ozlabs.ibm.com>
References: <20161017065131.GA27863@angband.pl>
        <20161020150814.42951f61@roar.ozlabs.ibm.com>
        <3446653.W8FbGAKSeQ@wuerfel>
        <14534456.e6dv16VA3R@wuerfel>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-pf0-f194.google.com ([209.85.192.194]:36335 "EHLO
        mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1758355AbcJYIcN (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 25 Oct 2016 04:32:13 -0400
In-Reply-To: <14534456.e6dv16VA3R@wuerfel>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Arnd Bergmann <arnd@arndb.de>
Cc: Russell King - ARM Linux <linux@armlinux.org.uk>, Michal Marek <mmarek@suse.com>, Adam Borowski <kilobyte@angband.pl>, Omar Sandoval <osandov@osandov.com>, Linus Torvalds <torvalds@linux-foundation.org>, adobriyan@gmail.com, sfr@canb.auug.org.au, viro@zeniv.linux.org.uk, linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org

On Mon, 24 Oct 2016 17:05:26 +0200
Arnd Bergmann <arnd@arndb.de> wrote:

> This adds an asm/asm-prototypes.h header for ARM to fix the
> broken symbol versioning for symbols exported from assembler
> files.
> 
> In addition to the header, we have to do these other small
> changes:
> 
> - move the exports from bitops.h to {change,clear,set,...}bit.S
> - move the exports from csumpartialgeneric.S into the files
>   including it
> 
> I couldn't find the correct prototypes for the compiler builtins,
> so I went with the fake 'void f(void)' prototypes that we had
> before.
> 
> This leaves the mmioset/mmiocpy function for now, as it's not
> obvious how to best handle them.


This looks nicer. I like variant B because it keeps the GENKSYMS cruft to
a single location, but either one isn't too bad.

I'd like to get moving on this, so let's at least get the generic kbuild
change merged. In the end, the kbuild code does not prevent a maintainer
from putting their EXPORT_SYMBOL in whatever location they like, so there
is no reason not to merge it (certainly there will be archs that do use
it).

Michal, what's your thoughts? If you merge my patch 2/2 and skip 1/2, it
should not give any new build warnings or errors, so then arch patches can
go via arch trees. 1/2 could go in after everyone is up to date.

Thanks,
Nick
