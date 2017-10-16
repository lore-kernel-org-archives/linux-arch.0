Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:59546 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753003AbdJPQ2E (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Mon, 16 Oct 2017 12:28:04 -0400
Subject: Re: [PATCH v3 16/28] arm64/sve: Probe SVE capabilities and usable
 vector lengths
References: <1507660725-7986-1-git-send-email-Dave.Martin@arm.com>
 <1507660725-7986-17-git-send-email-Dave.Martin@arm.com>
 <a39354fb-9f21-47ff-2ad9-b5bcb04e9990@arm.com>
 <20171016154557.GR19485@e103592.cambridge.arm.com>
From: Suzuki K Poulose <Suzuki.Poulose@arm.com>
Message-ID: <812b6d11-2458-6d5d-c490-3421f7d3afb3@arm.com>
Date: Mon, 16 Oct 2017 17:27:59 +0100
MIME-Version: 1.0
In-Reply-To: <20171016154557.GR19485@e103592.cambridge.arm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Dave Martin <Dave.Martin@arm.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-arch@vger.kernel.org, Okamoto Takayuki <tokamoto@jp.fujitsu.com>, libc-alpha@sourceware.org, Ard Biesheuvel <ard.biesheuvel@linaro.org>, Szabolcs Nagy <szabolcs.nagy@arm.com>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, Richard Sandiford <richard.sandiford@arm.com>, =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>, kvmarm@lists.cs.columbia.edu
Message-ID: <20171016162759.VMHNjHxSXz_cWdRBXMztg2LZ5Cwf64pQ6XpbRb1fZ-0@z>

On 16/10/17 16:46, Dave Martin wrote:
> On Thu, Oct 12, 2017 at 01:56:51PM +0100, Suzuki K Poulose wrote:
>> On 10/10/17 19:38, Dave Martin wrote:
>>> This patch uses the cpufeatures framework to determine common SVE
>>> capabilities and vector lengths, and configures the runtime SVE
>>> support code appropriately.
>>>
>>> ZCR_ELx is not really a feature register, but it is convenient to
>>> use it as a template for recording the maximum vector length
>>> supported by a CPU, using the LEN field.  This field is similar to
>>> a feature field in that it is a contiguous bitfield for which we
>>> want to determine the minimum system-wide value.  This patch adds
>>> ZCR as a pseudo-register in cpuinfo/cpufeatures, with appropriate
>>> custom code to populate it.  Finding the minimum supported value of
>>> the LEN field is left to the cpufeatures framework in the usual
>>> way.
>>>
>>> The meaning of ID_AA64ZFR0_EL1 is not architecturally defined yet,
>>> so for now we just require it to be zero.
>>>
>>> Note that much of this code is dormant and SVE still won't be used
>>> yet, since system_supports_sve() remains hardwired to false.
>>>
>>> Signed-off-by: Dave Martin <Dave.Martin@arm.com>
>>> Cc: Alex Bennée <alex.bennee@linaro.org>
>>> Cc: Suzuki K Poulose <Suzuki.Poulose@arm.com>
>>>
>>> ---
>>>
>>> Dropped Alex Bennée's Reviewed-by, since there is new logic in this
>>> patch.
>>>
>>> Changes since v2
>>> ----------------
>>>
>>> Bug fixes:
>>>
>>>   * Got rid of dynamic allocation of the shadow vector length map during
>>>     secondary boot.  Secondary CPU boot takes place in atomic context,
>>>     and relying on GFP_ATOMIC here doesn't seem justified.
>>>
>>>     Instead, the needed additional bitmap is allocated statically.  Only
>>>     one shadow map is needed, because CPUs don't boot concurrently.
>>>
>>> Requested by Alex Bennée:
>>>
>>>   * Reflowed untidy comment above read_zcr_features()
>>>
>>>   * Added comments to read_zcr_features() to explain what it's trying to do
>>>     (which is otherwise not readily apparent).
>>>
>>> Requested by Catalin Marinas:
>>>
>>>   * Moved disabling of the EL1 SVE trap to the cpufeatures C code.
>>>     This allows addition of new assembler in __cpu_setup to be
>>>     avoided.
>>>
>>> Miscellaneous:
>>>
>>>   * Added comments explaining the intent, purpose and basic constraints
>>>     for fpsimd.c helpers.
>>
>> ...
>>
>>> diff --git a/arch/arm64/kernel/cpufeature.c b/arch/arm64/kernel/cpufeature.c
>>> index 92a9502..c5acf38 100644
>>> --- a/arch/arm64/kernel/cpufeature.c
>>> +++ b/arch/arm64/kernel/cpufeature.c
>>
>> ...
>>
>>> @@ -670,6 +689,14 @@ void update_cpu_features(int cpu,
>>>   					info->reg_mvfr2, boot->reg_mvfr2);
>>>   	}
>>> +	if (id_aa64pfr0_sve(info->reg_id_aa64pfr0)) {
>>> +		taint |= check_update_ftr_reg(SYS_ZCR_EL1, cpu,
>>> +					info->reg_zcr, boot->reg_zcr);
>>> +
>>> +		if (!sys_caps_initialised)
>>> +			sve_update_vq_map();
>>> +	}
>>
>> nit: I am not sure if we should also check if the "current" sanitised value
>> of the id_aa64pfr0 also supports sve and skip the update if it isn't. The code
>> is as such fine without the check, its just that we can avoid computing the
>> map. It is in the CPU boot up path and hence is not performance critical.
>> So, either way we are fine.
>>
>> Reviewed-by: Suzuki K Poulose <suzuki.poulose@arm.com>
> 
> I think I prefer to avoid adding extra code to optimise the "broken SoC
> design" case.
> 

Sure.

> Maybe we could revisit this later if needed.
> 
> Can you suggest some code?  Maybe the check is simpler than I think.

Something like :

if (id_aa64pfr0_sve(read_sanitised_ftr_reg(SYS_IDAA64PFR0)) &&
     id_aa64pfr0_sve(id_aa64pfr0)) {
     ...
}

should be enough.

Or even we could hack it to :

if (id_aa64pfr0_sve(id_aa64pfr0 | read_sanitised_ftr_reg(SYS_IDAA64PFR0)))

As I mentioned, the code as such is fine. Its just that we try to detect
if the SVE is already moot and skip the steps for this CPU.


Cheers
Suzuki
