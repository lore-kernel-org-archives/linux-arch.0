From: Will Deacon <will.deacon@arm.com>
Subject: Re: [PATCH v6 09/18] ia64/tlb: Conver to generic mmu_gather
Date: Tue, 19 Feb 2019 12:47:28 +0000
Message-ID: <20190219124728.GC8501@fuggles.cambridge.arm.com>
References: <20190219103148.192029670@infradead.org>
 <20190219103233.383087152@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190219103233.383087152@infradead.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Peter Zijlstra <peterz@infradead.org>
Cc: aneesh.kumar@linux.vnet.ibm.com, akpm@linux-foundation.org, npiggin@gmail.com, linux-arch@vger.kernel.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org, linux@armlinux.org.uk, heiko.carstens@de.ibm.com, riel@surriel.com, Tony Luck <tony.luck@intel.com>
List-Id: linux-arch.vger.kernel.org

On Tue, Feb 19, 2019 at 11:31:57AM +0100, Peter Zijlstra wrote:
> Generic mmu_gather provides everything ia64 needs (range tracking).
> 
> Cc: Will Deacon <will.deacon@arm.com>
> Cc: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Nick Piggin <npiggin@gmail.com>
> Cc: Tony Luck <tony.luck@intel.com>
> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> ---
>  arch/ia64/include/asm/tlb.h      |  256 ---------------------------------------
>  arch/ia64/include/asm/tlbflush.h |   25 +++
>  arch/ia64/mm/tlb.c               |   23 +++
>  3 files changed, 47 insertions(+), 257 deletions(-)

Typo in subject (s/Conver/Convert) but other than that this looks sensible:

Acked-by: Will Deacon <will.deacon@arm.com>

Will
