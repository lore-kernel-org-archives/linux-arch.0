From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH 05/17] asm-generic/tlb: Rename
 HAVE_RCU_TABLE_NO_INVALIDATE
Date: Mon, 16 Dec 2019 13:37:52 +0100
Message-ID: <20191216123752.GM2844@hirez.programming.kicks-ass.net>
References: <20191211120713.360281197@infradead.org>
 <20191211122955.940455408@infradead.org>
 <87woawzc1t.fsf@linux.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <87woawzc1t.fsf@linux.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
Cc: Will Deacon <will@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, Nick Piggin <npiggin@gmail.com>, linux-arch@vger.kernel.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org, Yoshinori Sato <ysato@users.sourceforge.jp>, Rich Felker <dalias@libc.org>, "David S. Miller" <davem@davemloft.net>, Helge Deller <deller@gmx.de>, Geert Uytterhoeven <geert@linux-m68k.org>, Paul Burton <paulburton@kernel.org>, Tony Luck <tony.luck@intel.com>, Richard Henderson <rth@twiddle.net>, Nick Hu <nickhu@andestech.com>, Paul Walmsley <paul.walmsley@sifive.com>
List-Id: linux-arch.vger.kernel.org

On Mon, Dec 16, 2019 at 06:01:58PM +0530, Aneesh Kumar K.V wrote:
> Peter Zijlstra <peterz@infradead.org> writes:
> 
> > Towards a more consistent naming scheme.
> >
> > Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> > ---
> >  arch/Kconfig              |    3 ++-
> >  arch/powerpc/Kconfig      |    2 +-
> >  arch/sparc/Kconfig        |    2 +-
> >  include/asm-generic/tlb.h |    2 +-
> >  mm/mmu_gather.c           |    2 +-
> >  5 files changed, 6 insertions(+), 5 deletions(-)
> >
> > --- a/arch/Kconfig
> > +++ b/arch/Kconfig
> > @@ -396,8 +396,9 @@ config HAVE_ARCH_JUMP_LABEL_RELATIVE
> >  config MMU_GATHER_RCU_TABLE_FREE
> >  	bool
> >  
> > -config HAVE_RCU_TABLE_NO_INVALIDATE
> > +config MMU_GATHER_NO_TABLE_INVALIDATE
> >  	bool
> > +	depends on MMU_GATHER_RCU_TABLE_FREE
> 
> 
> Can we drop this Kernel config option instead use
> MMU_GATHER_RCU_TABLE_FREE? IMHO reducing the kernel config related to
> mmu_gather can reduce the complexity. 

I'm confused, are you saing you're happy to have PowerPC eat the extra
TLB invalidates? I thought you cared about PPC performance :-)
