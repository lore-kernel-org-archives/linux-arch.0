From: Richard Henderson <richard.henderson@linaro.org>
Subject: Re: [PATCH 1/1] arm64: Implement archrandom.h for ARMv8.5-RNG
Date: Sun, 27 Oct 2019 13:14:15 +0100
Message-ID: <bdadd4bf-1848-bef1-89c3-2d594cf3be16@linaro.org>
References: <20191019022048.28065-1-richard.henderson@linaro.org>
 <20191019022048.28065-2-richard.henderson@linaro.org>
 <20191024113239.GC4300@lakrids.cambridge.arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20191024113239.GC4300@lakrids.cambridge.arm.com>
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
To: Mark Rutland <mark.rutland@arm.com>
Cc: linux-arch@vger.kernel.org, ard.biesheuvel@linaro.org, catalin.marinas@arm.com, will@kernel.org, Dave.Martin@arm.com, linux-arm-kernel@lists.infradead.org
List-Id: linux-arch.vger.kernel.org

On 10/24/19 1:32 PM, Mark Rutland wrote:
> Please give this a menmoic in <asm/sysreg.h>, i.e.
> 
> #define SYS_RNDR	sys_reg(3, 3, 2, 4, 0)
> 
> ... and make this function:
> 
> static inline bool read_rndr(unsigned long *v)
> {
> 	unsigned long pass;
> 
> 	/*
> 	 * Reads of RNDR set PSTATE.NZCV to 0b0000 upon success, and set
> 	 * PSTATE.NZCV to 0b0100 otherwise.
> 	 */
> 	asm volatile(
> 		__mrs_s("%0", SYS_RNDR) "\n"
> 	"	cset %1, ne\n"
> 	: "=r" (*v), "=r" (pass);
> 	:
> 	: "cc");
> 
> 	return pass;
> }

Done.

> #define SYS_RNDRRS	sys_reg(3, 3, 2, 4, 1)
> 
> ...and here have:
> 
> static inline bool read_rndrrs(unsigned long *v)
> {
> 	unsigned long pass;
> 
> 	/*
> 	 * Reads of RNDRRS set PSTATE.NZCV to 0b0000 upon success, and
> 	 * set PSTATE.NZCV to 0b0100 otherwise.
> 	 */
> 	asm volatile (
> 		__mrs_s("%0", SYS_RNDRRS) "\n"
> 	"	cset %w1, ne\n"
> 	: "=r" (*v), "=r" (pass)
> 	:
> 	: "cc");
> 
> 	return pass;
> }

Done.

>> +static inline bool arch_get_random_seed_long(unsigned long *v)
>> +{
>> +	/* If RNDR fails, attempt to re-seed with RNDRRS.  */
>> +	return arch_has_random_seed() && (arm_rndr(v) || arm_rndrrs(v));
>> +}
> 
> Here we clobber the value at v even if the reads of RNDR and RNDRRS
> failed. Is that ok?

The x86 inline asm does, so I should think it is ok.

>> +#ifdef CONFIG_ARCH_RANDOM
>> +static bool can_use_rng(const struct arm64_cpu_capabilities *entry, int scope)
>> +{
>> +	unsigned long tmp;
>> +	int i;
>> +
>> +	if (!has_cpuid_feature(entry, scope))
>> +		return false;
>> +
>> +	/*
>> +	 * Re-seed from the true random number source.
>> +	 * If this fails, disable the feature.
>> +	 */
>> +	for (i = 0; i < 10; ++i) {
>> +		if (arm_rndrrs(&tmp))
>> +			return true;
>> +	}
> 
> The ARM ARM (ARM DDI 0487E.a) says:
> 
> | Reseeded Random Number. Returns a 64-bit random number which is
> | reseeded from the True Random Number source at an IMPLEMENTATION
> | DEFINED rate.
> 
> ... and:
> 
> | If the instruction cannot return a genuine random number in a
> | reasonable period of time, PSTATE.NZCV is set to 0b0100 and the data
> | value returned in UNKNOWN.
> 
> ... so it's not clear to me if the retry logic makes sense. Naively I'd
> expect "reasonable period of time" to include 10 attempts.
> 
> Given we'll have to handle failure elsewhere, I suspect that it might be
> best to assume that this works until we encounter evidence to the
> contrary.

Compare arch/x86/kernel/cpu/rdrand.c (x86_init_rdrand) and
arch/powerpc/platforms/powernv/rng.c (initialize_darn).

Both existing implementations have a small loop testing to see of the hardware
passes its own self-check at startup.  Perhaps it's simply paranoia, but it
didn't seem untoward to check.


>> +#ifdef CONFIG_ARCH_RANDOM
>> +	{
>> +		.desc = "Random Number Generator",
>> +		.capability = ARM64_HAS_RNG,
>> +		.type = ARM64_CPUCAP_STRICT_BOOT_CPU_FEATURE,
> 
> I strongly suspect we're going to encounter systems where this feature
> is mismatched, such that this can't be a boto CPU feature.
> 
> If we need entropy early in boot, we could detect if the boot CPU had
> the feature, and seed the pool using it, then later make use of a
> system-wide capability.

In the meantime, what do you suggest I place here and in
arch_has_random_seed(), so that it's at least detected early enough for the
boot cpu, but does not require support from all cpus?


r~
