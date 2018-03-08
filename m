Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from out03.mta.xmission.com ([166.70.13.233]:50782 "EHLO
        out03.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750940AbeCHWlK (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 8 Mar 2018 17:41:10 -0500
From: ebiederm@xmission.com (Eric W. Biederman)
References: <1519926248-12591-1-git-send-email-Dave.Martin@arm.com>
        <1519926248-12591-3-git-send-email-Dave.Martin@arm.com>
        <20180308171153.GD14918@arm.com>
Date: Thu, 08 Mar 2018 16:40:12 -0600
In-Reply-To: <20180308171153.GD14918@arm.com> (Will Deacon's message of "Thu,
        8 Mar 2018 17:11:53 +0000")
Message-ID: <87o9jymbsj.fsf@xmission.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [PATCH v2 2/3] arm64: fpsimd: Fix bad si_code for undiagnosed SIGFPE
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Will Deacon <will.deacon@arm.com>
Cc: Dave Martin <Dave.Martin@arm.com>, linux-arm-kernel@lists.infradead.org, linux-arch@vger.kernel.org, linux-api@vger.kernel.org, Catalin Marinas <catalin.marinas@arm.com>, James Morse <james.morse@arm.com>
Message-ID: <20180308224012.q0KNC2YkuYoHq3P-6M2EANWvXJMHenkuWmmC-Fw5Aa8@z>

Will Deacon <will.deacon@arm.com> writes:

> On Thu, Mar 01, 2018 at 05:44:07PM +0000, Dave Martin wrote:
>> Currently a SIGFPE delivered in response to a floating-point
>> exception trap may have si_code set to 0 on arm64.  As reported by
>> Eric, this is a bad idea since this is the value of SI_USER -- yet
>> this signal is definitely not the result of kill(2), tgkill(2) etc.
>> and si_uid and si_pid make limited sense whereas we do want to
>> yield a value for si_addr (which doesn't exist for SI_USER).
>
> [...]
>
>> diff --git a/arch/arm64/kernel/fpsimd.c b/arch/arm64/kernel/fpsimd.c
>> index e7226c4..9040038 100644
>> --- a/arch/arm64/kernel/fpsimd.c
>> +++ b/arch/arm64/kernel/fpsimd.c
>> @@ -39,6 +39,7 @@
>>  #include <linux/slab.h>
>>  #include <linux/sysctl.h>
>>  
>> +#include <asm/esr.h>
>>  #include <asm/fpsimd.h>
>>  #include <asm/cputype.h>
>>  #include <asm/simd.h>
>> @@ -867,18 +868,20 @@ asmlinkage void do_fpsimd_acc(unsigned int esr, struct pt_regs *regs)
>>  asmlinkage void do_fpsimd_exc(unsigned int esr, struct pt_regs *regs)
>>  {
>>  	siginfo_t info;
>> -	unsigned int si_code = FPE_FIXME;
>> -
>> -	if (esr & FPEXC_IOF)
>> -		si_code = FPE_FLTINV;
>> -	else if (esr & FPEXC_DZF)
>> -		si_code = FPE_FLTDIV;
>> -	else if (esr & FPEXC_OFF)
>> -		si_code = FPE_FLTOVF;
>> -	else if (esr & FPEXC_UFF)
>> -		si_code = FPE_FLTUND;
>> -	else if (esr & FPEXC_IXF)
>> -		si_code = FPE_FLTRES;
>> +	unsigned int si_code = FPE_FLTUNK;
>
> Happy to take this patch once the dependency on FPE_FLTUNK in core code is
> resolved.

Would it help for me to take the FPE_FLTUNK patch into my siginfo-next
branch?   So that there is a common branch with the code so we don't
need to worry about conflicts.  If so I will look at that on Monday.

There is another FPE code that appears to be needed for one of the other
architectures as well.  If we can figure out how to head conflicts off
at the pass while everyone is fixing the FPE_FIXME type problems it
might help.

But it is all simple enough I expect a word to the wise when I send
Linus my pull request will be enough to sort things out.

Eric
