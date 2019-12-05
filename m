Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-pj1-f67.google.com ([209.85.216.67]:42348 "EHLO
        mail-pj1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725959AbfLEW4M (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 5 Dec 2019 17:56:12 -0500
Date: Thu, 5 Dec 2019 14:56:10 -0800
From: Guenter Roeck <linux@roeck-us.net>
Subject: Re: [PATCH v6 10/18] sh/tlb: Convert SH to generic mmu_gather
Message-ID: <20191205225610.GB2532@roeck-us.net>
References: <20190219103148.192029670@infradead.org>
 <20190219103233.443069009@infradead.org>
 <CAMuHMdW3nwckjA9Bt-_Dmf50B__sZH+9E5s0_ziK1U_y9onN=g@mail.gmail.com>
 <20191204104733.GR2844@hirez.programming.kicks-ass.net>
 <3c83eaec-8f33-1b90-1c70-9e7c1c8b1855@physik.fu-berlin.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3c83eaec-8f33-1b90-1c70-9e7c1c8b1855@physik.fu-berlin.de>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Cc: Peter Zijlstra <peterz@infradead.org>, Geert Uytterhoeven <geert@linux-m68k.org>, Will Deacon <will.deacon@arm.com>, "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>, Andrew Morton <akpm@linux-foundation.org>, Nicholas Piggin <npiggin@gmail.com>, Linux-Arch <linux-arch@vger.kernel.org>, Linux MM <linux-mm@kvack.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Russell King <linux@armlinux.org.uk>, Heiko Carstens <heiko.carstens@de.ibm.com>, Rik van Riel <riel@surriel.com>, Yoshinori Sato <ysato@users.sourceforge.jp>, Rich Felker <dalias@libc.org>, Linux-sh list <linux-sh@vger.kernel.org>
Message-ID: <20191205225610.P7U9XbbhYygUByWvKckt-kO7e3T60D743y-6W1rS7dY@z>

On Thu, Dec 05, 2019 at 08:30:17PM +0100, John Paul Adrian Glaubitz wrote:
> Hi!
> 
> On 12/4/19 11:47 AM, Peter Zijlstra wrote:
> >> I got remote access to an SH7722-based Migo-R again, which spews a long
> >> sequence of BUGs during userspace startup.  I've bisected this to commit
> >> c5b27a889da92f4a ("sh/tlb: Convert SH to generic mmu_gather").
> > 
> > Whoopsy.. also, is this really the first time anybody booted an SH
> > kernel in over a year ?!?
> 
> I have to admit, I have been very lazy with kernel updates. I have been
> planning to upgrade to a much more recent release on my boards for a while
> now, I have just been postponing it since the machines run very stable
> with the current kernel I am using.
> 

Hey, if you write a qemu emulation, I'll be happy to run it on a regular
basis :-)

Problem is really that the architecture doesn't get as much attention as
it needs. The backtrace pointed to by Rob has been seen for a long time,
but either there is no one with the knowledge to fix it, or they are all
busy with other stuff.

Guenter

> Adrian
> 
> -- 
>  .''`.  John Paul Adrian Glaubitz
> : :' :  Debian Developer - glaubitz@debian.org
> `. `'   Freie Universitaet Berlin - glaubitz@physik.fu-berlin.de
>   `-    GPG: 62FF 8A75 84E0 2956 9546  0006 7426 3B37 F5B5 F913
