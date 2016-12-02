Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([212.227.17.10]:50098 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933652AbcLBOwb (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 2 Dec 2016 09:52:31 -0500
From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [RFC, PATCH, v3.9] default exported asm symbols to zero
Date: Fri, 02 Dec 2016 15:51:22 +0100
Message-ID: <49974235.a4bETaqHmt@wuerfel>
In-Reply-To: <CAMuHMdUMdxKHY0O=fVZgZ9Gtp7zvm=F2HR=AACYDM=8c7NpFUQ@mail.gmail.com>
References: <20161129131922.GA31466@angband.pl> <8452191.39CeLIHTBT@wuerfel> <CAMuHMdUMdxKHY0O=fVZgZ9Gtp7zvm=F2HR=AACYDM=8c7NpFUQ@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Adam Borowski <kilobyte@angband.pl>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>, Michal Marek <mmarek@suse.com>, Ben Hutchings <ben@decadent.org.uk>, Debian kernel maintainers <debian-kernel@lists.debian.org>, "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, Ingo Molnar <mingo@kernel.org>, Nicholas Piggin <npiggin@gmail.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Alan Modra <amodra@gmail.com>
Message-ID: <20161202145122.RzUx7BLPizP6RH7v47Bika9dwuqL75TezN6FLjCSN0w@z>

On Friday, December 2, 2016 1:59:15 PM CET Geert Uytterhoeven wrote:
> On Fri, Dec 2, 2016 at 1:40 PM, Arnd Bergmann <arnd@arndb.de> wrote:
> > With binutils-2.16 and before, a weak missing symbol was kept during the
> 
> 2.26?
> 
> > final link, and a missing CRC for an export would lead to that CRC
> > being treated as zero implicitly. With binutils-2.17, the crc
> 
> 2.27?'

Yes, serious version number deficiency on my end. Also 4.9 instead of 3.9
in the subject...

	Arnd
