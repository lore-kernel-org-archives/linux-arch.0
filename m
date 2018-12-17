From: Julien Thierry <julien.thierry@arm.com>
Subject: Re: [PATCH v7 01/25] arm64: Fix HCR.TGE status for NMI contexts
Date: Mon, 17 Dec 2018 08:49:01 +0000
Message-ID: <19f8c91b-0879-30dd-09dd-c0657b53bb33@arm.com>
References: <1544633245-6036-1-git-send-email-julien.thierry@arm.com>
 <1544633245-6036-2-git-send-email-julien.thierry@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1544633245-6036-2-git-send-email-julien.thierry@arm.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
Cc: linux-kernel@vger.kernel.org, daniel.thompson@linaro.org, joel@joelfernandes.org, marc.zyngier@arm.com, christoffer.dall@arm.com, james.morse@arm.com, catalin.marinas@arm.com, will.deacon@arm.com, mark.rutland@arm.com, Arnd Bergmann <arnd@arndb.de>, linux-arch@vger.kernel.org, stable@vger.kernel.org
List-Id: linux-arch.vger.kernel.org



On 12/12/2018 16:47, Julien Thierry wrote:
> When using VHE, the host needs to clear HCR_EL2.TGE bit in order
> to interract with guest TLBs, switching from EL2&0 translation regime
> to EL1&0.
> 
> However, some non-maskable asynchronous event could happen while TGE is
> cleared like SDEI. Because of this address translation operations
> relying on EL2&0 translation regime could fail (tlb invalidation,
> userspace access, ...).
> 
> Fix this by properly setting HCR_EL2.TGE when entering NMI context and
> clear it if necessary when returning to the interrupted context.
> 
> Signed-off-by: Julien Thierry <julien.thierry@arm.com>
> Suggested-by: Marc Zyngier <marc.zyngier@arm.com>
> Cc: Arnd Bergmann <arnd@arndb.de>
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Will Deacon <will.deacon@arm.com>
> Cc: Marc Zyngier <marc.zyngier@arm.com>
> Cc: James Morse <james.morse@arm.com>
> Cc: linux-arch@vger.kernel.org
> Cc: stable@vger.kernel.org
> ---
>  arch/arm64/include/asm/hardirq.h | 28 ++++++++++++++++++++++++++++
>  arch/arm64/kernel/irq.c          |  3 +++
>  include/asm-generic/hardirq.h    |  3 +++
>  include/linux/hardirq.h          |  2 ++
>  4 files changed, 36 insertions(+)
> 
> diff --git a/include/asm-generic/hardirq.h b/include/asm-generic/hardirq.h
> index d14214d..c33b53f20 100644
> --- a/include/asm-generic/hardirq.h
> +++ b/include/asm-generic/hardirq.h
> @@ -12,6 +12,9 @@
>  #include <linux/irq_cpustat.h>	/* Standard mappings for irq_cpustat_t above */
>  #include <linux/irq.h>
>  
> +#define arch_nmi_enter()	do { } while (0)
> +#define arch_nmi_exit()		do { } while (0)
> +

As spotted by the build bot, this needs to go in include/linux/hardirq.h
under a #ifndef arch_nmi_enter.

>  #ifndef ack_bad_irq
>  static inline void ack_bad_irq(unsigned int irq)
>  {
> diff --git a/include/linux/hardirq.h b/include/linux/hardirq.h
> index 0fbbcdf..776a60f 100644
> --- a/include/linux/hardirq.h
> +++ b/include/linux/hardirq.h
> @@ -62,6 +62,7 @@ static inline void rcu_nmi_exit(void)
>  
>  #define nmi_enter()						\
>  	do {							\
> +		arch_nmi_enter();				\
>  		printk_nmi_enter();				\
>  		lockdep_off();					\
>  		ftrace_nmi_enter();				\
> @@ -80,6 +81,7 @@ static inline void rcu_nmi_exit(void)
>  		ftrace_nmi_exit();				\
>  		lockdep_on();					\
>  		printk_nmi_exit();				\
> +		arch_nmi_exit();				\
>  	} while (0)
>  
>  #endif /* LINUX_HARDIRQ_H */
> 

-- 
Julien Thierry
