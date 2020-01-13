From: Catalin Marinas <catalin.marinas@arm.com>
Subject: Re: [PATCH v4 08/12] arm64: unify native/compat instruction skipping
Date: Mon, 13 Jan 2020 16:43:12 +0000
Message-ID: <20200113164311.GC1876@arrakis.emea.arm.com>
References: <20191211154206.46260-1-broonie@kernel.org>
 <20191211154206.46260-9-broonie@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane-mx.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <20191211154206.46260-9-broonie@kernel.org>
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
Cc: Mark Rutland <mark.rutland@arm.com>, Paul Elliott <paul.elliott@arm.com>, Peter Zijlstra <peterz@infradead.org>, Andrew Jones <drjones@redhat.com>, Amit Kachhap <amit.kachhap@arm.com>, Vincenzo Frascino <vincenzo.frascino@arm.com>, Will Deacon <will@kernel.org>, linux-arch@vger.kernel.org, Marc Zyngier <maz@kernel.org>, Eugene Syromiatnikov <esyr@redhat.com>, Szabolcs Nagy <szabolcs.nagy@arm.com>, Dave Martin <Dave.Martin@arm.com>, "H.J. Lu" <hjl.tools@gmail.com>, Yu-cheng Yu <yu-cheng.yu@intel.com>, Kees Cook <keescook@chromium.org>, Arnd Bergmann <arnd@arndb.de>, Jann Horn <jannh@google.com>, Richard Henderson <richard.henderson@linaro.org>, Kristina =?utf-8?Q?Mart=C5=A1enko?= <kristina.martsenko@arm.com>, Thomas Gleixner <tglx@linutronix.de>, linux-arm-kernel@lists.infradead.org, Florian Weimer <fweimer@redhat.com>, linux-kernel@vger.kernel.org, Sudakshina Das <sudi.d>
List-Id: linux-arch.vger.kernel.org

On Wed, Dec 11, 2019 at 03:42:02PM +0000, Mark Brown wrote:
> diff --git a/arch/arm64/kernel/traps.c b/arch/arm64/kernel/traps.c
> index 84c7a88dd617..de01e5041d4d 100644
> --- a/arch/arm64/kernel/traps.c
> +++ b/arch/arm64/kernel/traps.c
> @@ -269,6 +269,8 @@ void arm64_notify_die(const char *str, struct pt_regs *regs,
>  	}
>  }
>  
> +static void advance_itstate(struct pt_regs *regs);
> +
>  void arm64_skip_faulting_instruction(struct pt_regs *regs, unsigned long size)
>  {
>  	regs->pc += size;
> @@ -279,6 +281,9 @@ void arm64_skip_faulting_instruction(struct pt_regs *regs, unsigned long size)
>  	 */
>  	if (user_mode(regs))
>  		user_fastforward_single_step(current);
> +
> +	if (regs->pstate & PSR_MODE32_BIT)
> +		advance_itstate(regs);

Nitpick: we have a compat_user_mode(regs) you can use here.

-- 
Catalin
