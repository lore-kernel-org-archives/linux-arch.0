From: Mel Gorman <mgorman@techsingularity.net>
Subject: Re: [PATCH v2 1/4] mm: refactoring TLB gathering API
Date: Tue, 1 Aug 2017 11:30:55 +0100
Message-ID: <20170801103032.h7tnxryoxx7k7aqg@techsingularity.net>
References: <1501566977-20293-1-git-send-email-minchan@kernel.org>
 <1501566977-20293-2-git-send-email-minchan@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1501566977-20293-2-git-send-email-minchan@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Minchan Kim <minchan@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org, linux-mm@kvack.org, kernel-team <kernel-team@lge.com>, Ingo Molnar <mingo@redhat.com>, Russell King <linux@armlinux.org.uk>, Tony Luck <tony.luck@intel.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>, "David S. Miller" <davem@davemloft.net>, Heiko Carstens <heiko.carstens@de.ibm.com>, Yoshinori Sato <ysato@users.sourceforge.jp>, Jeff Dike <jdike@addtoit.com>, linux-arch@vger.kernel.org, Nadav Amit <nadav.amit@gmail.com>
List-Id: linux-arch.vger.kernel.org

On Tue, Aug 01, 2017 at 02:56:14PM +0900, Minchan Kim wrote:
> This patch is ready for solving race problems caused by TLB batch.

s/is ready/is a preparatory patch/

> For that, we will increase/decrease TLB flush pending count of
> mm_struct whenever tlb_[gather|finish]_mmu is called.
> 
> Before making it simple, this patch separates architecture specific
> part and rename it to arch_tlb_[gather|finish]_mmu and generic part
> just calls it.
> 
> It shouldn't change any behavior.
> 
> Cc: Ingo Molnar <mingo@redhat.com>
> Cc: Russell King <linux@armlinux.org.uk>
> Cc: Tony Luck <tony.luck@intel.com>
> Cc: Martin Schwidefsky <schwidefsky@de.ibm.com>
> Cc: "David S. Miller" <davem@davemloft.net>
> Cc: Heiko Carstens <heiko.carstens@de.ibm.com>
> Cc: Yoshinori Sato <ysato@users.sourceforge.jp>
> Cc: Jeff Dike <jdike@addtoit.com>
> Cc: linux-arch@vger.kernel.org
> Cc: Nadav Amit <nadav.amit@gmail.com>
> Cc: Mel Gorman <mgorman@techsingularity.net>
> Signed-off-by: Minchan Kim <minchan@kernel.org>

You could alias arch_generic_tlb_finish_mmu as arch_tlb_gather_mmu
simiilar to how other arch-generic helpers are done to avoid some
#ifdeffery but otherwise

Acked-by: Mel Gorman <mgorman@techsingularity.net>

-- 
Mel Gorman
SUSE Labs
