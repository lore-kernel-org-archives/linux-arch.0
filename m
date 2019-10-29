From: Richard Henderson <richard.henderson@linaro.org>
Subject: Re: [PATCH v2 1/1] arm64: Implement archrandom.h for ARMv8.5-RNG
Date: Tue, 29 Oct 2019 14:24:27 +0100
Message-ID: <bfda9074-a866-d5d6-7f2a-3d91258a7113@linaro.org>
References: <20191028203254.7152-1-richard.henderson@linaro.org>
 <20191028203254.7152-2-richard.henderson@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20191028203254.7152-2-richard.henderson@linaro.org>
Content-Language: en-US
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: linux-arm-kernel@lists.infradead.org
Cc: linux-arch@vger.kernel.org, mark.rutland@arm.com, ard.biesheuvel@linaro.org, catalin.marinas@arm.com, will@kernel.org, Dave.Martin@arm.com
List-Id: linux-arch.vger.kernel.org

On 10/28/19 9:32 PM, richard.henderson@linaro.org wrote:
> +bool arch_get_random_long(unsigned long *v)
> +{
> +	bool ok;
> +
> +	preempt_disable_notrace();
> +
> +	ok = this_cpu_has_cap(ARM64_HAS_RNG);
> +	if (ok) {
> +		/*
> +		 * Reads of RNDR set PSTATE.NZCV to 0b0000 on success,
> +		 * and set PSTATE.NZCV to 0b0100 otherwise.
> +		 */
> +		asm volatile(
> +			__mrs_s("%0", SYS_RNDR_EL0) "\n"
> +		"	cset %w1, ne\n"
> +		: "=r"(*v), "=r"(ok)
> +		:
> +		: "cc");
> +
> +		if (unlikely(!ok)) {
> +			pr_warn_ratelimited("cpu%d: sys_rndr failed\n",
> +					    read_cpuid_id());
> +		}
> +	}
> +
> +	preempt_enable_notrace();
> +	return ok;
> +}
...
> +bool arch_get_random_seed_long(unsigned long *v)
> +{
> +	preempt_disable_notrace();
> +
> +	if (this_cpu_has_cap(ARM64_HAS_RNG)) {
> +		unsigned long ok, val;
> +
> +		/*
> +		 * Reads of RNDRRS set PSTATE.NZCV to 0b0000 on success,
> +		 * and set PSTATE.NZCV to 0b0100 otherwise.
> +		 */
> +		asm volatile(
> +			__mrs_s("%0", SYS_RNDRRS_EL0) "\n"
> +		"	cset %1, ne\n"
> +		: "=r"(val), "=r"(ok)
> +		:
> +		: "cc");
> +
> +		if (likely(ok)) {
> +			*v = val;
> +			preempt_enable_notrace();
> +			return true;
> +		}
> +
> +		pr_warn_ratelimited("cpu%d: sys_rndrrs failed\n",
> +				    read_cpuid_id());
> +	}
> +
> +	preempt_enable_notrace();
> +	return false;
> +}

Ho hum.  The difference in form between these two functions is unintentional.
I had peeked at the assembly for arch_get_random_long, tweaked the structure a
bit, and meant to copy the result to arch_get_random_seed_long, but forgot.

The first form above produces fewer register spills from gcc8.  I'll use that
for both for v3, supposing there are further comments to be addressed in review.


r~
