Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from bombadil.infradead.org ([198.137.202.133]:40326 "EHLO
 bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with
 ESMTP id S1727093AbgA0IMI (ORCPT <rfc822;linux-arch@vger.kernel.org>); Mon,
 27 Jan 2020 03:12:08 -0500
Date: Mon, 27 Jan 2020 09:11:34 +0100
From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH mk-II 08/17] asm-generic/tlb: Provide
 MMU_GATHER_TABLE_FREE
Message-ID: <20200127081134.GI14914@hirez.programming.kicks-ass.net>
References: <20191211120713.360281197@infradead.org>
 <20191211122956.112607298@infradead.org>
 <20191212093205.GU2827@hirez.programming.kicks-ass.net>
 <20200126155205.GA19169@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200126155205.GA19169@roeck-us.net>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Guenter Roeck <linux@roeck-us.net>
Cc: Will Deacon <will@kernel.org>, "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>, Andrew Morton <akpm@linux-foundation.org>, Nick Piggin <npiggin@gmail.com>, linux-arch@vger.kernel.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org, Yoshinori Sato <ysato@users.sourceforge.jp>, Rich Felker <dalias@libc.org>, "David S. Miller" <davem@davemloft.net>, Helge Deller <deller@gmx.de>, Geert Uytterhoeven <geert@linux-m68k.org>, Paul Burton <paulburton@kernel.org>, Tony Luck <tony.luck@intel.com>, Richard Henderson <rth@twiddle.net>, Nick Hu <nickhu@andestech.com>, Paul Walmsley <paul.walmsley@sifive.com>
Message-ID: <20200127081134.fWonNLQpEA98v2F-7G0QKhg4QPgyAJlyvbMop7qt9uY@z>

On Sun, Jan 26, 2020 at 07:52:05AM -0800, Guenter Roeck wrote:
> On Thu, Dec 12, 2019 at 10:32:05AM +0100, Peter Zijlstra wrote:
> > As described in the comment, the correct order for freeing pages is:
> > 
> >  1) unhook page
> >  2) TLB invalidate page
> >  3) free page
> > 
> > This order equally applies to page directories.
> > 
> > Currently there are two correct options:
> > 
> >  - use tlb_remove_page(), when all page directores are full pages and
> >    there are no futher contraints placed by things like software
> >    walkers (HAVE_FAST_GUP).
> > 
> >  - use MMU_GATHER_RCU_TABLE_FREE and tlb_remove_table() when the
> >    architecture does not do IPI based TLB invalidate and has
> >    HAVE_FAST_GUP (or software TLB fill).
> > 
> > This however leaves architectures that don't have page based
> > directories but don't need RCU in a bind. For those, provide
> > MMU_GATHER_TABLE_FREE, which provides the independent batching for
> > directories without the additional RCU freeing.
> > 
> > Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> > ---
> 
> Various sparc64 builds (allnoconfig, tinyconfig, as well as builds
> with SMP disabled):
> 
> mm/mmu_gather.c: In function '__tlb_remove_table_free':
> mm/mmu_gather.c:101:3: error: implicit declaration of function '__tlb_remove_table'; did you mean 'tlb_remove_table'?

Thanks; I'll respin these patches against Aneesh' pile and make sure to
look into this when I do so.
