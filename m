From: Catalin Marinas <catalin.marinas@arm.com>
Subject: Re: [PATCH v8 2/4] arm64: tlbflush: Introduce
 __flush_tlb_kernel_pgtable
Date: Fri, 27 Apr 2018 11:29:01 +0100
Message-ID: <20180427102900.4e63lo4eksk23vtn@armageddon.cambridge.arm.com>
References: <1522742446-5084-1-git-send-email-cpandya@codeaurora.org>
 <1522742446-5084-3-git-send-email-cpandya@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1522742446-5084-3-git-send-email-cpandya@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Chintan Pandya <cpandya@codeaurora.org>
Cc: will.deacon@arm.com, mark.rutland@arm.com, toshi.kani@hpe.com, linux-arch@vger.kernel.org, arnd@arndb.de, ard.biesheuvel@linaro.org, marc.zyngier@arm.com, gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org, kristina.martsenko@arm.com, takahiro.akashi@linaro.org, james.morse@arm.com, tglx@linutronix.de, akpm@linux-foundation.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-arch.vger.kernel.org

On Tue, Apr 03, 2018 at 01:30:44PM +0530, Chintan Pandya wrote:
> Add an interface to invalidate intermediate page tables
> from TLB for kernel.
> 
> Signed-off-by: Chintan Pandya <cpandya@codeaurora.org>
> ---
>  arch/arm64/include/asm/tlbflush.h | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/arch/arm64/include/asm/tlbflush.h b/arch/arm64/include/asm/tlbflush.h
> index 9e82dd7..6a4816d 100644
> --- a/arch/arm64/include/asm/tlbflush.h
> +++ b/arch/arm64/include/asm/tlbflush.h
> @@ -209,6 +209,12 @@ static inline void __flush_tlb_pgtable(struct mm_struct *mm,
>  	dsb(ish);
>  }
>  
> +static inline void __flush_tlb_kernel_pgtable(unsigned long addr)
> +{
> +	addr >>= 12;
> +	__tlbi(vaae1is, addr);
> +	dsb(ish);
> +}
>  #endif

Please use __TLBI_VADDR here as it does some additional masking.

-- 
Catalin
