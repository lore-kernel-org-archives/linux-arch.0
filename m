From: Catalin Marinas <catalin.marinas@arm.com>
Subject: Re: [PATCH v4 04/12] arm64: Basic Branch Target Identification support
Date: Fri, 10 Jan 2020 18:28:00 +0000
Message-ID: <20200110182800.GI8786@arrakis.emea.arm.com>
References: <20191211154206.46260-1-broonie@kernel.org>
 <20191211154206.46260-5-broonie@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane-mx.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <20191211154206.46260-5-broonie@kernel.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane-mx.org@lists.infradead.org
To: Mark Brown <broonie@kernel.org>
Cc: Paul Elliott <paul.elliott@arm.com>, Peter Zijlstra <peterz@infradead.org>, Andrew Jones <drjones@redhat.com>, Amit Kachhap <amit.kachhap@arm.com>, Vincenzo Frascino <vincenzo.frascino@arm.com>, Will Deacon <will@kernel.org>, linux-arch@vger.kernel.org, Marc Zyngier <maz@kernel.org>, Eugene Syromiatnikov <esyr@redhat.com>, Szabolcs Nagy <szabolcs.nagy@arm.com>, Dave Martin <Dave.Martin@arm.com>, "H.J. Lu" <hjl.tools@gmail.com>, Yu-cheng Yu <yu-cheng.yu@intel.com>, Kees Cook <keescook@chromium.org>, Arnd Bergmann <arnd@arndb.de>, Jann Horn <jannh@google.com>, Richard Henderson <richard.henderson@linaro.org>, Kristina =?utf-8?Q?Mart=C5=A1enko?= <kristina.martsenko@arm.com>, Thomas Gleixner <tglx@linutronix.de>, linux-arm-kernel@lists.infradead.org, Florian Weimer <fweimer@redhat.com>, linux-kernel@vger.kernel.org, Sudakshina Das <sudi.das@arm.com>
List-Id: linux-arch.vger.kernel.org

On Wed, Dec 11, 2019 at 03:41:58PM +0000, Mark Brown wrote:
> diff --git a/arch/arm64/include/asm/ptrace.h b/arch/arm64/include/asm/ptrace.h
> index fbebb411ae20..212bba1f8d84 100644
> --- a/arch/arm64/include/asm/ptrace.h
> +++ b/arch/arm64/include/asm/ptrace.h
> @@ -35,8 +35,16 @@
>  #define GIC_PRIO_PSR_I_SET		(1 << 4)
>  
>  /* Additional SPSR bits not exposed in the UABI */
> +#define PSR_BTYPE_SHIFT		10
> +
>  #define PSR_IL_BIT		(1 << 20)
>  
> +/* Convenience names for the values of PSTATE.BTYPE */
> +#define PSR_BTYPE_NONE		(0b00 << PSR_BTYPE_SHIFT)
> +#define PSR_BTYPE_JC		(0b01 << PSR_BTYPE_SHIFT)
> +#define PSR_BTYPE_C		(0b10 << PSR_BTYPE_SHIFT)
> +#define PSR_BTYPE_J		(0b11 << PSR_BTYPE_SHIFT)

Would these be better placed in the uapi/ptrace.h?

> diff --git a/arch/arm64/kernel/syscall.c b/arch/arm64/kernel/syscall.c
> index 9a9d98a443fc..ef80ecbd6eaf 100644
> --- a/arch/arm64/kernel/syscall.c
> +++ b/arch/arm64/kernel/syscall.c
> @@ -98,6 +98,24 @@ static void el0_svc_common(struct pt_regs *regs, int scno, int sc_nr,
>  	regs->orig_x0 = regs->regs[0];
>  	regs->syscallno = scno;
>  
> +	/*
> +	 * BTI note:
> +	 * The architecture does not guarantee that SPSR.BTYPE is zero
> +	 * on taking an SVC, so we could return to userspace with a
> +	 * non-zero BTYPE after the syscall.

On page 2580 of the ARM ARM there is a statement that "any instruction
other than BR, ..." sets BTYPE to 0. Wouldn't SVC fall into the same
category?

> +	 *
> +	 * This shouldn't matter except when userspace is explicitly
> +	 * doing something stupid, such as setting PROT_BTI on a page
> +	 * that lacks conforming BTI/PACIxSP instructions, falling
> +	 * through from one executable page to another with differing
> +	 * PROT_BTI, or messing with BYTPE via ptrace: in such cases,

s/BYTPE/BTYPE/

Apart from the nitpicks above, the patch looks good to me:

Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>
