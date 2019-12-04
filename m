Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-pl1-f196.google.com ([209.85.214.196]:43399 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728114AbfLDTDp (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 4 Dec 2019 14:03:45 -0500
Date: Wed, 4 Dec 2019 11:03:41 -0800
From: Guenter Roeck <linux@roeck-us.net>
Subject: Re: [PATCH v6 10/18] sh/tlb: Convert SH to generic mmu_gather
Message-ID: <20191204190341.GA11419@roeck-us.net>
References: <20190219103148.192029670@infradead.org>
 <20190219103233.443069009@infradead.org>
 <CAMuHMdW3nwckjA9Bt-_Dmf50B__sZH+9E5s0_ziK1U_y9onN=g@mail.gmail.com>
 <20191204104733.GR2844@hirez.programming.kicks-ass.net>
 <CAMuHMdXs_Fm93t=O9jJPLxcREZy-T53Z_U_RtHcvaWyV+ESdjg@mail.gmail.com>
 <156fa92f-4c5a-08bd-bcda-20029724c0de@roeck-us.net>
 <CAMuHMdVKcTum5vMmT1TdttVnGnhnQihGU1jrguF26TW7ZeOJPg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAMuHMdVKcTum5vMmT1TdttVnGnhnQihGU1jrguF26TW7ZeOJPg@mail.gmail.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Peter Zijlstra <peterz@infradead.org>, Will Deacon <will.deacon@arm.com>, "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>, Andrew Morton <akpm@linux-foundation.org>, Nicholas Piggin <npiggin@gmail.com>, Linux-Arch <linux-arch@vger.kernel.org>, Linux MM <linux-mm@kvack.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Russell King <linux@armlinux.org.uk>, Heiko Carstens <heiko.carstens@de.ibm.com>, Rik van Riel <riel@surriel.com>, Yoshinori Sato <ysato@users.sourceforge.jp>, Rich Felker <dalias@libc.org>, Linux-sh list <linux-sh@vger.kernel.org>
Message-ID: <20191204190341.KrmeiwycUiQK74YEChW56B54mabYX7aksv36sAjFV5o@z>

On Wed, Dec 04, 2019 at 04:17:26PM +0100, Geert Uytterhoeven wrote:
> Hi Günter,
> 
> > > Nah, but the v5.4-rc3 I booted recently on qemu -M r2d had
> > > CONFIG_PGTABLE_LEVELS=2, so it didn't show the problem.
> > >
> >
> > Guess that explains why I do not see the problem with my qemu boots.
> > I use rts7751r2dplus_defconfig. Is it possible to reproduce the problem
> > with qemu ? I don't think so, but maybe I am missing something.
> 
> Qemu seems to support r2d and shix only.
> For the latter, the website pointed to by the qemu sources no longer exists.
> But according to those sources, it's also sh7750-based, so no luck.
> 
Oh, well, worth asking. Thanks for the feedback.

Guenter
