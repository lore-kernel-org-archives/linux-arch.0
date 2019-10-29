Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-pf1-f194.google.com ([209.85.210.194]:41003 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730112AbfJ2NYi (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 29 Oct 2019 09:24:38 -0400
Received: by mail-pf1-f194.google.com with SMTP id p26so5445815pfq.8
        for <linux-arch@vger.kernel.org>; Tue, 29 Oct 2019 06:24:37 -0700 (PDT)
Subject: Re: [PATCH v2 1/1] arm64: Implement archrandom.h for ARMv8.5-RNG
References: <20191028203254.7152-1-richard.henderson@linaro.org>
 <20191028203254.7152-2-richard.henderson@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <bfda9074-a866-d5d6-7f2a-3d91258a7113@linaro.org>
Date: Tue, 29 Oct 2019 14:24:27 +0100
MIME-Version: 1.0
In-Reply-To: <20191028203254.7152-2-richard.henderson@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-arm-kernel@lists.infradead.org
Cc: linux-arch@vger.kernel.org, mark.rutland@arm.com, ard.biesheuvel@linaro.org, catalin.marinas@arm.com, will@kernel.org, Dave.Martin@arm.com
Message-ID: <20191029132427.2bYinOlMT2C0YW70bKRdLPp32QPk362qdzuUs1oNtq4@z>

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
