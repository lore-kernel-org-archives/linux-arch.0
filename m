Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from LGEAMRELO12.lge.com ([156.147.23.52]:47008 "EHLO
        lgeamrelo12.lge.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751029AbdHBAxt (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 1 Aug 2017 20:53:49 -0400
Date: Wed, 2 Aug 2017 09:53:46 +0900
From: Minchan Kim <minchan@kernel.org>
Subject: Re: [PATCH v2 1/4] mm: refactoring TLB gathering API
Message-ID: <20170802005346.GA6388@bbox>
References: <1501566977-20293-1-git-send-email-minchan@kernel.org>
 <1501566977-20293-2-git-send-email-minchan@kernel.org>
 <20170801103032.h7tnxryoxx7k7aqg@techsingularity.net>
 <59138710-3EFB-4D59-BD5B-D97CAFEBF098@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <59138710-3EFB-4D59-BD5B-D97CAFEBF098@gmail.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Nadav Amit <nadav.amit@gmail.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, LKML <linux-kernel@vger.kernel.org>, "open list:MEMORY MANAGEMENT" <linux-mm@kvack.org>, kernel-team <kernel-team@lge.com>, Ingo Molnar <mingo@redhat.com>, Russell King <linux@armlinux.org.uk>, Tony Luck <tony.luck@intel.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>, "David S. Miller" <davem@davemloft.net>, Heiko Carstens <heiko.carstens@de.ibm.com>, Yoshinori Sato <ysato@users.sourceforge.jp>, Jeff Dike <jdike@addtoit.com>, linux-arch@vger.kernel.org, Mel Gorman <mgorman@techsingularity.net>
Message-ID: <20170802005346.l0kVJpzpNRMUHeNfRYwJlikeH4BAIl6q7Cl9UCcdhDI@z>

Hi Nadav,

On Tue, Aug 01, 2017 at 05:46:14PM -0700, Nadav Amit wrote:
> Mel Gorman <mgorman@techsingularity.net> wrote:
> 
> > On Tue, Aug 01, 2017 at 02:56:14PM +0900, Minchan Kim wrote:
> >> This patch is ready for solving race problems caused by TLB batch.
> > 
> > s/is ready/is a preparatory patch/
> > 
> >> For that, we will increase/decrease TLB flush pending count of
> >> mm_struct whenever tlb_[gather|finish]_mmu is called.
> >> 
> >> Before making it simple, this patch separates architecture specific
> >> part and rename it to arch_tlb_[gather|finish]_mmu and generic part
> >> just calls it.
> >> 
> >> It shouldn't change any behavior.
> >> 
> >> Cc: Ingo Molnar <mingo@redhat.com>
> >> Cc: Russell King <linux@armlinux.org.uk>
> >> Cc: Tony Luck <tony.luck@intel.com>
> >> Cc: Martin Schwidefsky <schwidefsky@de.ibm.com>
> >> Cc: "David S. Miller" <davem@davemloft.net>
> >> Cc: Heiko Carstens <heiko.carstens@de.ibm.com>
> >> Cc: Yoshinori Sato <ysato@users.sourceforge.jp>
> >> Cc: Jeff Dike <jdike@addtoit.com>
> >> Cc: linux-arch@vger.kernel.org
> >> Cc: Nadav Amit <nadav.amit@gmail.com>
> >> Cc: Mel Gorman <mgorman@techsingularity.net>
> >> Signed-off-by: Minchan Kim <minchan@kernel.org>
> > 
> > You could alias arch_generic_tlb_finish_mmu as arch_tlb_gather_mmu
> > simiilar to how other arch-generic helpers are done to avoid some
> > #ifdeffery but otherwise
> 
> Minchan,
> 
> Andrew wishes me to send one series that combines both series. What about
> this comment from Mel? It seems you intentionally did not want to alias
> them...

It was not intentional but just forgot it. :(
I really appreciate if you could do for me. :)

> 
> BTW: patch 4 should add “#include <asm/tlb.h>" - I’ll add it. 

Thanks!
