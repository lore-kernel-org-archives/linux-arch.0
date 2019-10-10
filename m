Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from bombadil.infradead.org ([198.137.202.133]:55018 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733043AbfJJHaD (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 10 Oct 2019 03:30:03 -0400
Date: Thu, 10 Oct 2019 09:29:52 +0200
From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH 0/3] eldie generated code for folded p4d/pud
Message-ID: <20191010072952.GM2311@hirez.programming.kicks-ass.net>
References: <20191009222658.961-1-vgupta@synopsys.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191009222658.961-1-vgupta@synopsys.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Vineet Gupta <Vineet.Gupta1@synopsys.com>
Cc: linux-mm@kvack.org, linux-snps-arc@lists.infradead.org, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>, Will Deacon <will@kernel.org>, "Aneesh Kumar K . V" <aneesh.kumar@linux.ibm.com>, Andrew Morton <akpm@linux-foundation.org>, Nick Piggin <npiggin@gmail.com>, "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>
Message-ID: <20191010072952.oTtFbOQ4sEotyqs8Zy3kF2psmNws6aEfpiB8xFgmpcY@z>

On Wed, Oct 09, 2019 at 03:26:55PM -0700, Vineet Gupta wrote:
> Hi,
> 
> This series elides extraneous generate code for folded p4d/pud.
> This came up when trying to remove __ARCH_USE_5LEVEL_HACK from ARC port.
> The code saving are not a while lot, but still worthwhile IMHO.
> 
> bloat-o-meter2 vmlinux-A-baseline vmlinux-E-elide-p?d_clear_bad
> add/remove: 0/2 grow/shrink: 0/1 up/down: 0/-146 (-146)
> function                                     old     new   delta
> p4d_clear_bad                                  2       -      -2
> pud_clear_bad                                 20       -     -20
> free_pgd_range                               546     422    -124
> Total: Before=4137148, After=4137002, chg -1.000000%
> 

Works for me, thanks!
