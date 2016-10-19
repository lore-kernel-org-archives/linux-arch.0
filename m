Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:43867 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S942975AbcJSOwK (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Wed, 19 Oct 2016 10:52:10 -0400
Subject: Re: [PATCH] kbuild: provide include/asm/asm-prototypes.h for ARM
References: <20161017065131.GA27863@angband.pl>
 <20161017175951.31d8f4b7@roar.ozlabs.ibm.com> <6556201.qTG4Pa4aHk@wuerfel>
From: Michal Marek <mmarek@suse.com>
Message-ID: <fafba13a-c64c-2578-534c-c344f18d0fc5@suse.com>
Date: Wed, 19 Oct 2016 16:52:06 +0200
MIME-Version: 1.0
In-Reply-To: <6556201.qTG4Pa4aHk@wuerfel>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Arnd Bergmann <arnd@arndb.de>, Nicholas Piggin <npiggin@gmail.com>
Cc: Adam Borowski <kilobyte@angband.pl>, Omar Sandoval <osandov@osandov.com>, Linus Torvalds <torvalds@linux-foundation.org>, adobriyan@gmail.com, sfr@canb.auug.org.au, viro@zeniv.linux.org.uk, linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
Message-ID: <20161019145206.SkwXcmt2kU4_zmeu9tyuEmd0_eNng_OsnS-omv66P48@z>

Dne 17.10.2016 v 14:26 Arnd Bergmann napsal(a):
> This adds an asm/asm-prototypes.h header for ARM to fix the
> broken symbol versioning for symbols exported from assembler
> files.
> 
> In addition to the header, we have to do these other small
> changes:
> 
> - move the 'extern' declarations out of memset_io/memcpy_io
>   to make them visible to the symbol version generator
> - move the exports from bitops.h to {change,clear,set,...}bit.S
> - move the exports from csumpartialgeneric.S into the files
>   including it
> 
> I couldn't find the correct prototypes for the compiler builtins,
> so I went with the fake 'void f(void)' prototypes that we had
> before.
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Hi Arnd,

just to make sure I'm looking at the right code - is this based on the
patch by Nick here: https://patchwork.kernel.org/patch/9377783/?

Thanks,
Michal
