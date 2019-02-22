From: Mark Rutland <mark.rutland@arm.com>
Subject: Re: [PATCH v5 11/23] arm64: compat: Generate asm offsets for signals
Date: Fri, 22 Feb 2019 14:22:05 +0000
Message-ID: <20190222142204.GK42419@lakrids.cambridge.arm.com>
References: <20190222122430.21180-1-vincenzo.frascino@arm.com>
 <20190222122430.21180-12-vincenzo.frascino@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <20190222122430.21180-12-vincenzo.frascino@arm.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Vincenzo Frascino <vincenzo.frascino@arm.com>
Cc: linux-arch@vger.kernel.org, Shuah Khan <shuah@kernel.org>, Arnd Bergmann <arnd@arndb.de>, Catalin Marinas <catalin.marinas@arm.com>, Daniel Lezcano <daniel.lezcano@linaro.org>, Will Deacon <will.deacon@arm.com>, Russell King <linux@armlinux.org.uk>, Ralf Baechle <ralf@linux-mips.org>, Mark Salyzyn <salyzyn@android.com>, Paul Burton <paul.burton@mips.com>, Dmitry Safonov <0x7f454c46@gmail.com>, Rasmus Villemoes <linux@rasmusvillemoes.dk>, Thomas Gleixner <tglx@linutronix.de>, Peter Collingbourne <pcc@google.com>, linux-arm-kernel@lists.infradead.org
List-Id: linux-arch.vger.kernel.org

On Fri, Feb 22, 2019 at 12:24:18PM +0000, Vincenzo Frascino wrote:
> diff --git a/arch/arm64/include/asm/signal32.h b/arch/arm64/include/asm/signal32.h
> index 1f05268f4c6d..a6fd7be1b22a 100644
> --- a/arch/arm64/include/asm/signal32.h
> +++ b/arch/arm64/include/asm/signal32.h
> @@ -52,7 +52,7 @@ struct compat_ucontext {
>  	compat_stack_t			uc_stack;
>  	struct compat_sigcontext	uc_mcontext;
>  	compat_sigset_t			uc_sigmask;
> -	int 				__unused[32 - (sizeof(compat_sigset_t) / sizeof(int))];
> +	int				__unused[32 - (sizeof(compat_sigset_t) / sizeof(int))];

Spurious whitespace change?

> +/* Macros for asm-offsets.c */
> +#define OFFSET_OF_COMPAT_SIGFRAME_REGS (				\
> +			offsetof(struct compat_sigframe, uc) +		\
> +			offsetof(struct compat_ucontext, uc_mcontext) +	\
> +			offsetof(struct compat_sigcontext, arm_r0))
> +
> +#define OFFSET_OF_COMPAT_RT_SIGFRAME_REGS (				\
> +			offsetof(struct compat_rt_sigframe, sig) +	\
> +			offsetof(struct compat_sigframe, uc) +		\
> +			offsetof(struct compat_ucontext, uc_mcontext) +	\
> +			offsetof(struct compat_sigcontext, arm_r0))
> +
>  int compat_setup_frame(int usig, struct ksignal *ksig, sigset_t *set,
>  		       struct pt_regs *regs);
>  int compat_setup_rt_frame(int usig, struct ksignal *ksig, sigset_t *set,
> diff --git a/arch/arm64/kernel/asm-offsets.c b/arch/arm64/kernel/asm-offsets.c
> index 4adb52190a90..afd28ccda174 100644
> --- a/arch/arm64/kernel/asm-offsets.c
> +++ b/arch/arm64/kernel/asm-offsets.c
> @@ -30,6 +30,7 @@
>  #include <asm/fixmap.h>
>  #include <asm/thread_info.h>
>  #include <asm/memory.h>
> +#include <asm/signal32.h>
>  #include <asm/smp_plat.h>
>  #include <asm/suspend.h>
>  #include <linux/kbuild.h>
> @@ -84,6 +85,11 @@ int main(void)
>    DEFINE(S_STACKFRAME,		offsetof(struct pt_regs, stackframe));
>    DEFINE(S_FRAME_SIZE,		sizeof(struct pt_regs));
>    BLANK();
> +#ifdef CONFIG_COMPAT
> +  DEFINE(COMPAT_SIGFRAME_REGS_OFFSET,		OFFSET_OF_COMPAT_SIGFRAME_REGS);
> +  DEFINE(COMPAT_RT_SIGFRAME_REGS_OFFSET,	OFFSET_OF_COMPAT_RT_SIGFRAME_REGS);

Can't we do:

DEFINE(COMPAT_SIGFRAME_REGS_OFFSET,	offsetof(struct compat_sigframe, uc.us_mcontext.arm_r0)
DEFINE(COMPAT_RT_SIGFRAME_REGS_OFFSET,	offsetof(struct compat_rt_sigframe, sig.uc.us_mcontext.arm_r0)

... and avoid the OFFSET_OF_* macros entirely?

Thanks,
Mark.
