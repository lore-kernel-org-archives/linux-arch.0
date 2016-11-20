From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH 1/2] kbuild: provide include/asm/asm-prototypes.h for ARM
Date: Sun, 20 Nov 2016 10:32:50 -0800
Message-ID: <CA+55aFxh=F77vDAG0Ta9p7Fxf8-b4nCSv1ewfY6ikx3X42zwkA@mail.gmail.com>
References: <20161017065131.GA27863@angband.pl> <20161020150814.42951f61@roar.ozlabs.ibm.com>
 <3446653.W8FbGAKSeQ@wuerfel> <14534456.e6dv16VA3R@wuerfel>
 <20161025193200.1f4d9e24@roar.ozlabs.ibm.com> <20161120132127.GU1041@n2100.armlinux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-oi0-f66.google.com ([209.85.218.66]:34474 "EHLO
        mail-oi0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752831AbcKTScw (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sun, 20 Nov 2016 13:32:52 -0500
In-Reply-To: <20161120132127.GU1041@n2100.armlinux.org.uk>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Russell King - ARM Linux <linux@armlinux.org.uk>
Cc: Nicholas Piggin <npiggin@gmail.com>, Arnd Bergmann <arnd@arndb.de>, Michal Marek <mmarek@suse.com>, Adam Borowski <kilobyte@angband.pl>, Omar Sandoval <osandov@osandov.com>, Alexey Dobriyan <adobriyan@gmail.com>, Stephen Rothwell <sfr@canb.auug.org.au>, Al Viro <viro@zeniv.linux.org.uk>, Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>

On Sun, Nov 20, 2016 at 5:21 AM, Russell King - ARM Linux
<linux@armlinux.org.uk> wrote:
> On Tue, Oct 25, 2016 at 07:32:00PM +1100, Nicholas Piggin wrote:
>>
>> Michal, what's your thoughts? If you merge my patch 2/2 and skip 1/2, it
>> should not give any new build warnings or errors, so then arch patches can
>> go via arch trees. 1/2 could go in after everyone is up to date.
>
> So what's the conclusion on this?  I've just had a failure due to
> CONFIG_TRIM_UNUSED_KSYMS reported on ARM, and it looks like (at
> least some of) patch 1 could resolve it.

Hmm. I've got

  cc6acc11cad1 kbuild: be more careful about matching preprocessed asm
___EXPORT_SYMBOL
  4efca4ed05cb kbuild: modversions for EXPORT_SYMBOL() for asm

in my tree. Is that sufficient, or do we still have issues?

             Linus
