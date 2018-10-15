From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH 12/18] arch/tlb: Clean up simple architectures
Date: Mon, 15 Oct 2018 16:14:58 +0200
Message-ID: <20181015141458.GQ9867@hirez.programming.kicks-ass.net>
References: <20180926113623.863696043@infradead.org>
 <20180926114801.146189550@infradead.org>
 <C2D7FE5348E1B147BCA15975FBA23075012B09A59E@us01wembx1.internal.synopsys.com>
 <20181011150406.GL9848@hirez.programming.kicks-ass.net>
 <C2D7FE5348E1B147BCA15975FBA23075012B0ADA16@US01WEMBX2.internal.synopsys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <C2D7FE5348E1B147BCA15975FBA23075012B0ADA16@US01WEMBX2.internal.synopsys.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Vineet Gupta <vineet.gupta1@synopsys.com>
Cc: "will.deacon@arm.com" <will.deacon@arm.com>, "aneesh.kumar@linux.vnet.ibm.com" <aneesh.kumar@linux.vnet.ibm.com>, "akpm@linux-foundation.org" <akpm@linux-foundation.org>, "npiggin@gmail.com" <npiggin@gmail.com>, "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, "linux-mm@kvack.org" <linux-mm@kvack.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux@armlinux.org.uk" <linux@armlinux.org.uk>, "heiko.carstens@de.ibm.com" <heiko.carstens@de.ibm.com>, "riel@surriel.com" <riel@surriel.com>, Richard Henderson <rth@twiddle.net>, Mark Salter <msalter@redhat.com>, Richard Kuo <rkuo@codeaurora.org>, Michal Simek <monstr@monstr.eu>, Paul Burton <paul.burton@mips.com>, Greentime Hu <green.hu@gmail.com>, Ley Foon Tan <lftan@altera.com>
List-Id: linux-arch.vger.kernel.org

On Fri, Oct 12, 2018 at 07:40:04PM +0000, Vineet Gupta wrote:
> Very nice. Thx for doing this.
> 
> Once you have redone this, please point me to a branch so I can give this a spin.
> I've always been interested in tracking down / optimizing the full TLB flushes -
> which ARC implements by simply moving the MMU/process to a new ASID (TLB entries
> tagged with an 8 bit value - unique per process). When I started looking into this
> , a simple ls (fork+execve) would increment the ASID by 13 which I'd optimized to
> a reasonable 4. Haven't checked that in recent times though so would be fun to
> revive that measurement.

I just pushed out the latest version to:

  git://git.kernel.org/pub/scm/linux/kernel/git/peterz/queue.git mm/tlb

(mandatory caution: that tree is unstable / throw-away)

I'll wait a few days to see what, if anything, comes back from 0day
before posting again.
