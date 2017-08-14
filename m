From: Minchan Kim <minchan@kernel.org>
Subject: Re: [PATCH v6 4/7] mm: refactoring TLB gathering API
Date: Mon, 14 Aug 2017 09:49:10 +0900
Message-ID: <20170814004910.GA25427@bbox>
References: <20170802000818.4760-1-namit@vmware.com>
 <20170802000818.4760-5-namit@vmware.com>
 <20170811092334.rmeazkklvordrmrl@hirez.programming.kicks-ass.net>
 <EBBFF419-4E4C-440A-853B-25FB6F0DE7F6@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from LGEAMRELO13.lge.com ([156.147.23.53]:54342 "EHLO
        lgeamrelo13.lge.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751395AbdHNAtQ (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sun, 13 Aug 2017 20:49:16 -0400
Content-Disposition: inline
In-Reply-To: <EBBFF419-4E4C-440A-853B-25FB6F0DE7F6@gmail.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Nadav Amit <nadav.amit@gmail.com>
Cc: Peter Zijlstra <peterz@infradead.org>, "open list:MEMORY MANAGEMENT" <linux-mm@kvack.org>, LKML <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@linux-foundation.org>, Ingo Molnar <mingo@redhat.com>, Russell King <linux@armlinux.org.uk>, Tony Luck <tony.luck@intel.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>, "David S. Miller" <davem@davemloft.net>, Heiko Carstens <heiko.carstens@de.ibm.com>, Yoshinori Sato <ysato@users.sourceforge.jp>, Jeff Dike <jdike@addtoit.com>, linux-arch@vger.kernel.org, Mel Gorman <mgorman@techsingularity.net>

On Fri, Aug 11, 2017 at 10:12:45AM -0700, Nadav Amit wrote:
> Peter Zijlstra <peterz@infradead.org> wrote:
> 
> > On Tue, Aug 01, 2017 at 05:08:15PM -0700, Nadav Amit wrote:
> >> From: Minchan Kim <minchan@kernel.org>
> >> 
> >> This patch is a preparatory patch for solving race problems caused by
> >> TLB batch.  For that, we will increase/decrease TLB flush pending count
> >> of mm_struct whenever tlb_[gather|finish]_mmu is called.
> >> 
> >> Before making it simple, this patch separates architecture specific
> >> part and rename it to arch_tlb_[gather|finish]_mmu and generic part
> >> just calls it.
> > 
> > I absolutely hate this. We should unify this stuff, not diverge it
> > further.
> 
> Agreed, but I don’t see how this patch makes the situation any worse.

Agree with Nadav. I don't think this patch makes things diverge further.
Peter, If you are strong against of it, please tell us what part you
are hating.
