Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.110.172]:34020 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728394AbfJKOZA (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Fri, 11 Oct 2019 10:25:00 -0400
Date: Fri, 11 Oct 2019 15:24:55 +0100
From: Mark Rutland <mark.rutland@arm.com>
Subject: Re: [PATCH v2 12/12] KVM: arm64: BTI: Reset BTYPE when skipping
 emulated instructions
Message-ID: <20191011142454.GD33537@lakrids.cambridge.arm.com>
References: <1570733080-21015-1-git-send-email-Dave.Martin@arm.com>
 <1570733080-21015-13-git-send-email-Dave.Martin@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1570733080-21015-13-git-send-email-Dave.Martin@arm.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Dave Martin <Dave.Martin@arm.com>
Cc: linux-kernel@vger.kernel.org, Andrew Jones <drjones@redhat.com>, Arnd Bergmann <arnd@arndb.de>, Catalin Marinas <catalin.marinas@arm.com>, Eugene Syromiatnikov <esyr@redhat.com>, Florian Weimer <fweimer@redhat.com>, "H.J. Lu" <hjl.tools@gmail.com>, Jann Horn <jannh@google.com>, Kees Cook <keescook@chromium.org>, Kristina =?utf-8?Q?Mart=C5=A1enko?= <kristina.martsenko@arm.com>, Mark Brown <broonie@kernel.org>, Paul Elliott <paul.elliott@arm.com>, Peter Zijlstra <peterz@infradead.org>, Richard Henderson <richard.henderson@linaro.org>, Sudakshina Das <sudi.das@arm.com>, Szabolcs Nagy <szabolcs.nagy@arm.com>, Thomas Gleixner <tglx@linutronix.de>, Will Deacon <will.deacon@arm.com>, Yu-cheng Yu <yu-cheng.yu@intel.com>, Amit Kachhap <amit.kachhap@arm.com>, Vincenzo Frascino <vincenzo.frascino@arm.com>, linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Message-ID: <20191011142455.ypW3n74Zvk9TZpXDZLwdjp44lYIXIECgqDeE07b-qy8@z>

On Thu, Oct 10, 2019 at 07:44:40PM +0100, Dave Martin wrote:
> Since normal execution of any non-branch instruction resets the
> PSTATE BTYPE field to 0, so do the same thing when emulating a
> trapped instruction.
> 
> Branches don't trap directly, so we should never need to assign a
> non-zero value to BTYPE here.
> 
> Signed-off-by: Dave Martin <Dave.Martin@arm.com>
> ---
>  arch/arm64/include/asm/kvm_emulate.h | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/include/asm/kvm_emulate.h b/arch/arm64/include/asm/kvm_emulate.h
> index d69c1ef..33957a12 100644
> --- a/arch/arm64/include/asm/kvm_emulate.h
> +++ b/arch/arm64/include/asm/kvm_emulate.h
> @@ -452,8 +452,10 @@ static inline void kvm_skip_instr(struct kvm_vcpu *vcpu, bool is_wide_instr)
>  {
>  	if (vcpu_mode_is_32bit(vcpu))
>  		kvm_skip_instr32(vcpu, is_wide_instr);
> -	else
> +	else {
>  		*vcpu_pc(vcpu) += 4;
> +		*vcpu_cpsr(vcpu) &= ~(u64)PSR_BTYPE_MASK;
> +	}

Style nit: both sides of an if-else should match brace-wise. i.e. please
add braces to the other side.

As with the prior patch, the u64 cast can also go.

Otherwise, this looks right to me.

Thanks,
Mark.
