Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([212.227.126.187]:51996 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S943234AbcJSPDQ (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 19 Oct 2016 11:03:16 -0400
From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH] kbuild: provide include/asm/asm-prototypes.h for ARM
Date: Wed, 19 Oct 2016 17:02:55 +0200
Message-ID: <3114442.xCAy34UQCk@wuerfel>
In-Reply-To: <fafba13a-c64c-2578-534c-c344f18d0fc5@suse.com>
References: <20161017065131.GA27863@angband.pl> <6556201.qTG4Pa4aHk@wuerfel> <fafba13a-c64c-2578-534c-c344f18d0fc5@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Michal Marek <mmarek@suse.com>, Russell King <rmk+kernel@armlinux.org.uk>
Cc: Nicholas Piggin <npiggin@gmail.com>, Adam Borowski <kilobyte@angband.pl>, Omar Sandoval <osandov@osandov.com>, Linus Torvalds <torvalds@linux-foundation.org>, adobriyan@gmail.com, sfr@canb.auug.org.au, viro@zeniv.linux.org.uk, linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
Message-ID: <20161019150255.ej-N4vYoM0o064fcjWl5ADuF_RAQBNUM-euivVY8ajE@z>

On Wednesday, October 19, 2016 4:52:06 PM CEST Michal Marek wrote:
> Dne 17.10.2016 v 14:26 Arnd Bergmann napsal(a):
> > This adds an asm/asm-prototypes.h header for ARM to fix the
> > broken symbol versioning for symbols exported from assembler
> > files.
> > 
> > In addition to the header, we have to do these other small
> > changes:
> > 
> > - move the 'extern' declarations out of memset_io/memcpy_io
> >   to make them visible to the symbol version generator
> > - move the exports from bitops.h to {change,clear,set,...}bit.S
> > - move the exports from csumpartialgeneric.S into the files
> >   including it
> > 
> > I couldn't find the correct prototypes for the compiler builtins,
> > so I went with the fake 'void f(void)' prototypes that we had
> > before.
> > 
> > Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> 
> Hi Arnd,
> 
> just to make sure I'm looking at the right code - is this based on the
> patch by Nick here: https://patchwork.kernel.org/patch/9377783/?
> 

(adding Russell to Cc, I missed him during my earlier mail, which
is now archived at https://lkml.org/lkml/2016/10/17/356)

Correct.  I had imported Nick's patch into my randconfig tree and
this is what I needed to build all configurations cleanly with it.

	Arnd
