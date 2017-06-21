From: Nicholas Piggin <npiggin@gmail.com>
Subject: Re: [PATCH 1/5] kbuild: thin archives final link close
 --whole-archives option
Date: Thu, 22 Jun 2017 07:30:24 +1000
Message-ID: <20170622073024.4822ed6d@roar.ozlabs.ibm.com>
References: <20170609052417.561-1-npiggin@gmail.com>
        <20170619182714.2cb60e17@roar.ozlabs.ibm.com>
        <CAK7LNATznx=5A1KnhkFHpjencsJj7AGUsHtDUu6M-Qkw=jvpPQ@mail.gmail.com>
        <20170620015205.329519b2@roar.ozlabs.ibm.com>
        <CAK7LNAS6zucv54-XwqfTbm=y20eFVQYLwgsVCdtS7mYknsYK+Q@mail.gmail.com>
        <20170621124708.6bce7692@roar.ozlabs.ibm.com>
        <CAK7LNATPyoVcsDtFjRhdmFh7v_HE9F=2GVX=z+XVWV2fXsEukA@mail.gmail.com>
        <20170621140445.4d6fd92a@roar.ozlabs.ibm.com>
        <CAK8P3a34gWKqPCFDAnWki4H-eyj50Xgar+YFT_+2Og-qJb_i8A@mail.gmail.com>
        <20170621191607.33c8db74@roar.ozlabs.ibm.com>
        <CAK8P3a0NT42HKOU+ZDRg_-1hA+RzYnL0RtzqbMsLbY=yTUxGRA@mail.gmail.com>
        <20170621203824.719ffdc5@roar.ozlabs.ibm.com>
        <CAK8P3a1o91guXimc99sY3UOUjKTX5QxhQyOfY+j-x7MMCdRbdw@mail.gmail.com>
        <20170621211002.44525d9b@roar.ozlabs.ibm.com>
        <CAK8P3a2A9fMrNZPWJft2t+52kmGkGgm3gv_fxJntjevWtJ69Zw@mail.gmail.com>
        <CAK8P3a01Q7OgFd8KThvJWu_UBr3unxJ=JZoGrsN7X9p-3maOAg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-pg0-f66.google.com ([74.125.83.66]:36703 "EHLO
        mail-pg0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752399AbdFUVaj (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 21 Jun 2017 17:30:39 -0400
In-Reply-To: <CAK8P3a01Q7OgFd8KThvJWu_UBr3unxJ=JZoGrsN7X9p-3maOAg@mail.gmail.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Arnd Bergmann <arnd@arndb.de>
Cc: Masahiro Yamada <yamada.masahiro@socionext.com>, Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>, linux-arch <linux-arch@vger.kernel.org>, Michal Marek <mmarek@suse.com>, Linus Torvalds <torvalds@linux-foundation.org>, Stephen Rothwell <sfr@canb.auug.org.au>, kbuild test robot <fengguang.wu@intel.com>, Josh Triplett <josh@joshtriplett.org>, Nicolas Pitre <nicolas.pitre@linaro.org>

On Wed, 21 Jun 2017 22:52:25 +0200
Arnd Bergmann <arnd@arndb.de> wrote:

> On Wed, Jun 21, 2017 at 1:32 PM, Arnd Bergmann <arnd@arndb.de> wrote:
> > On Wed, Jun 21, 2017 at 1:10 PM, Nicholas Piggin <npiggin@gmail.com> wrote:  
> >> On Wed, 21 Jun 2017 12:49:10 +0200
> >> Arnd Bergmann <arnd@arndb.de> wrote:
> >>  
> >>> On Wed, Jun 21, 2017 at 12:38 PM, Nicholas Piggin <npiggin@gmail.com> wrote:  
> >>> > On Wed, 21 Jun 2017 12:21:16 +0200
> >>> > Arnd Bergmann <arnd@arndb.de> wrote:
> >>> >  
> >>>
> >>> I'm building on top of yesterday's linux-next at the moment,
> >>> with a number of my own patches applied
> >>>  
> >>> > I can take a look at ARM and try to get it at least to parity with
> >>> > incremental link. Any particular config options required?  
> >>>
> >>> This is the patch I am testing with:
> >>>
> >>> https://pastebin.com/HQuhCEmK
> >>> I have not looked at that in a while, no idea if it works, or
> >>> if it has known problems.
> >>>
> >>> I last posted the patch in March for discussion:
> >>>
> >>> https://patchwork.kernel.org/patch/9626207/  
> >>
> >> Well I just mean the stuff now in kbuild/thin-ac, not the LD_DCDE.
> >> Just want to try getting thin archives up to a point where there are
> >> no serious regressions first.  
> >
> > For my build testing, I have now reverted most of my patch and only
> > left the 'select THIN_ARCHIVES'. I'll let you know if I run into problems.  
> 
> I just got one build failure on a randconfig build with THIN_ARCHIVES
> but without LD_DCDE:
> 
> /home/arnd/cross-gcc/bin/arm-linux-gnueabi-ld: section .data VMA
> [0000000000808000,000000000096cc7f] overlaps section .text VMA
> [0000000000080080,00000000008a8427]
> /home/arnd/cross-gcc/bin/arm-linux-gnueabi-ld: section .rodata VMA
> [00000000008a9000,0000000000ea216f] overlaps section .data VMA
> [0000000000808000,000000000096cc7f]
> /home/arnd/cross-gcc/bin/arm-linux-gnueabi-ld: section .bss VMA
> [000000000096cd00,000000000157896f] overlaps section .rodata VMA
> [00000000008a9000,0000000000ea216f]
> /home/arnd/cross-gcc/bin/arm-linux-gnueabi-ld: section __param VMA
> [0000000000ea2170,0000000000ea5257] overlaps section .bss VMA
> [000000000096cd00,000000000157896f]
> 
> haven't spent any time analyzing it further, maybe you can see right
> away what caused this. If not, you could try the .config file at
> https://pastebin.com/raw/YTZKH9Xe

It's due to vmlinux-xip.lds.S explicitly putting sections inside each
other

        . = PAGE_OFFSET + TEXT_OFFSET;

Same config fails without thin archives for me.

If XIP can't place these dynamically, at least you should use an
ASSERT() linker script function if sizes overlap. E.g.,

    ASSERT(. <= PAGE_OFFSET + TEXT_OFFSET, "kernel too big");
    . = PAGE_OFFSET + TEXT_OFFSET;
