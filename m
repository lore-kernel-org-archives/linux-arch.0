Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F14234752F;
	Thu, 17 Sep 2026 01:06:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.97.179.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789607207; cv=none; b=guUQtKDUwR7Vy1uG2sX4tABEMJXv1++tRf68FS9PqmJRC07DyeicmyUNn65i8OBRyZsMhpvZAupEzfBr5rDsEa7rHrhh/vh73UoPtF91ki60zON/5ZKGgy05EAVxuhq7tlVFYICR6+V58nA9GpCv6u3UzleszrM3vowON7b7s1E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789607207; c=relaxed/simple;
	bh=HjJPykUI6x5xKvlPTKYDNbGmcYytNHdoOXY2MxeFKgM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nxpzJ+2xQjCXDDrtqt2EZpUDWZCjAMNRF2xtyujxd2kjVkoaLgBAuIOQ+cIUi810m2JO46qoJe332yFoOHA1NJ0xBLsp/jTS38sf2Sko/LtnMFcAqQ4VP1q/MJejeqvIrbThxsSp6/pMX94vtEdOtbKvW/u9O6KhR51/C/nDXyI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=cwNGCf8M; arc=none smtp.client-ip=213.97.179.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="cwNGCf8M"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:Content-Type:From:Cc:To:Subject:
	MIME-Version:Date:Message-ID:From:Reply-To;
	bh=kK8U6zcu30eUa/1IbzABeDAbejpvCtmmWV8KgWoo5Rk=; b=cwNGCf8MIXZ2L60DbxLuFPmX7W
	JiVby/b8Yhn2u12nHkMVRivHAqQoSblV+6t3Rf1Tbiz+lpm3A5JwL6m3tE/GoblOR2pWa8SVAgViZ
	GBIwyfXZUBTj13/6roIKj6qIeidn0mieCAO0ayuwdbAROtmT365vBWyffznNMnOvvVhRbekBLwvim
	nrEy1RYAuoaLf9wB3uNg6BNvI+WWBhXtElbEpXaohqhVcbCDf9zxrSOE0gv0YB2YPAItpWx4rakhA
	v9dnjJRyUubB0DJvfnXrD5c1xcXbbQvKPYDvzOfNOJHm6uIMFLLvbsQIH6ARYBL/RJEd4jMPapItY
	P/SdQEng==;
Received: from [177.172.123.214] (helo=[192.168.15.100])
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
	id 1x70a2-003Bpv-Nq; Thu, 17 Sep 2026 03:06:26 +0200
Message-ID: <9d9a804f-c1f3-4c0c-b12a-975206f6c34c@igalia.com>
Date: Wed, 16 Sep 2026 22:06:25 -0300
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 2/4] arm64: vdso: Implement
 __vdso_futex_robust_try_unlock()
To: Mark Rutland <mark.rutland@arm.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>,
 Thomas Gleixner <tglx@kernel.org>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 Peter Zijlstra <peterz@infradead.org>, Florian Weimer <fweimer@redhat.com>,
 Darren Hart <dvhart@infradead.org>, Ingo Molnar <mingo@kernel.org>,
 Davidlohr Bueso <dave@stgolabs.net>, Arnd Bergmann <arnd@arndb.de>,
 Uros Bizjak <ubizjak@gmail.com>, =?UTF-8?Q?Thomas_Wei=C3=9Fschuh?=
 <linux@weissschuh.net>, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
 kernel-dev@igalia.com
References: <20260821-tonyk-robust_arm-v8-0-077707b6f1c7@igalia.com>
 <20260821-tonyk-robust_arm-v8-2-077707b6f1c7@igalia.com>
 <aqqkX8GyxgdtoOmc@J2N7QTR9R3>
Content-Language: en-US
From: =?UTF-8?Q?Andr=C3=A9_Almeida?= <andrealmeid@igalia.com>
In-Reply-To: <aqqkX8GyxgdtoOmc@J2N7QTR9R3>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Em 16/09/2026 11:27, Mark Rutland escreveu:
> Hi André,
> 
> I have a few comments below. I'm not sure what the plan is for 32-bit
> robust lists, and I think there are a few problems with the assembly.
> 
> On Fri, Aug 21, 2026 at 06:50:43PM -0300, André Almeida wrote:

[...]

> 
>> +	register __u64 *pop_reg asm("x2") = pop;
>> +	register __u32 result_reg asm("w3") = 0;
>> +	__u32 val;
>> +
>> +	asm volatile (
>> +		".globl						  "
>> +		"__futex_list64_try_unlock_cs_start,		  "
>> +		"__futex_list64_try_unlock_cs_success,		  "
>> +		"__futex_list64_try_unlock_cs_end		\n"
> 
> Sorry, when I mentioned putting these within the assembly, I meant doing
> something like:
> 
> | #define LABEL(l)						\
> | 	"	.globl " #l "\n"				\
> | 	#l ":\n"
> 
> ... and within the asssembly, having:
> 
> | 	"	insn1					\n"
> | 	"	insn2					\n"
> | 	LABEL(__futex_list64_try_unlock_cs_start)
> | 	"	insn2					\n"
> | 	LABEL(__futex_list64_try_unlock_cs_start)
> | 	"	insn4					\n"
> | 	LABEL(__futex_list64_try_unlock_cs_success)
> | 	"	insn5					\n"
> 
> That way we use the full strings, which are easy to grep for, and we
> only have to define each label string once.

Oh, I see, thanks! I will change that for the next version.

> 
>> +
>> +		"	prfm pstl1strm, %[lock]			\n"
>> +		"retry:						\n"
>> +		"	ldxr %w[val], %[lock]			\n"
>> +		"	cmp %w[tid], %w[val]			\n"
>> +		"	bne __futex_list64_try_unlock_cs_end	\n"
> 
> The 'bne' here should be 'b.ne'. IIUC assemblers accept the former by
> historical accident, and 'b.<cond>' is the architecturally defined
> mnemonic.
> 
> As general thing, we format assembly with a tab between the instruction
> and first operand, so the above should be:
> 
> | 	"	prfm	pstl1strm, %[lock]			\n"
> | 	"retry:							\n"
> | 	"	ldxr	%w[val], %[lock]			\n"
> | 	"	cmp	%w[tid], %w[val]			\n"
> | 	"	b.ne	__futex_list64_try_unlock_cs_end	\n"
> 
>> +		"	stlxr %w[result], wzr, %[lock]		\n"
>> +		"__futex_list64_try_unlock_cs_start:		\n"
>> +		"	cbnz %w[result], retry			\n"
>> +		"__futex_list64_try_unlock_cs_success:		\n"
>> +		"	str xzr, %[pop_reg]			\n"
>> +		"__futex_list64_try_unlock_cs_end:		\n"
>> +
>> +		: [val] "=&r" (val), [result] "=&r" (result_reg), [pop_reg] "+Q" (*pop_reg)
>> +		: [tid] "r" (tid), [lock] "Q" (*lock)
>> +		: "cc", "memory"
>> +	);
> 
> As a general note, for assembly constaints, please put each constraint
> on its own line, e.g.
> 
> 	: [val] "=&r" (val),
> 	  [result] "=&r" (result_reg),
> 	  [pop_reg] "+Q" (*pop_reg)
> 	: [tid] "r" (tid),
> 	  [lock] "Q" (*lock)
> 	: "cc", "memory"
> 
> That formatting makes it much easier to read each constraint
> individually, and it makes it easier to review changes to individual
> constaints.
> 
> Generally, for asm we have a preferred style:
> 
> 	asm volatile(
> 	"	// string starts aligned with 'asm'	\n"
> 	"	// with 1 tab indend within that.	\n"
> 	"						\n"
> 	"	insn	operand1, operand2		\n"
> 	"label:						\n"
> 	"	insn	operand1, operand2		\n"
> 	: [output1] "=r" (...),
> 	  [output2] "=r" (...)
> 	: [input1] "r" (...).
> 	  [input2] "r" (...)
> 	: "clobbers"
> 	);
> 
> I see a couple of problems with the constraints as-is.
> 
> Firstly, the constraints for [pop_reg] doesn't guarantee that x2 is
> used. The "+Q" constraint takes a memory operand (in this case the
> location pointed to by 'pop_reg', and limits the addressing mode to a
> single base register with no offset. The operand is the memroy location,
> not the register holding the memory location, so this constraint won't
> necessarily use x2. Unless 'pop_reg' itself is passed into a register
> constraint, the compiler might not ensure that 'x2' is populated.
> 
> For example:
> 
> | [mark@gravadlaks:~/tests/asm-operands-q-reg]% cat test.c
> | unsigned long foo(unsigned long *ptr)
> | {
> |         register unsigned long *ptr_reg asm("x2") = ptr;
> |         unsigned long val;
> |
> |         asm volatile(
> |         "       ldr     %[val], %[qptr]\n"
> |         : [val] "=&r" (val)
> |         : [qptr] "Q" (*ptr_reg)
> |         );
> |
> |         return val;
> | }
> | [mark@gravadlaks:~/tests/asm-operands-q-reg]% usekorg 16.2.0 aarch64-linux-gcc -c test.c -O2
> | [mark@gravadlaks:~/tests/asm-operands-q-reg]% usekorg 16.2.0 aarch64-linux-objdump -d test.o
> |
> | test.o:     file format elf64-littleaarch64
> |
> |
> | Disassembly of section .text:
> |
> | 0000000000000000 <foo>:
> |    0:   f9400001        ldr     x1, [x0]
> |    4:   aa0103e0        mov     x0, x1
> |    8:   d65f03c0        ret
> 
> We will need an "r" input constraint for 'pop_reg' to ensure that x2 is
> allocated. Either in addition to an "=Q" output constraint for the
> actual memory write, or we rely on the memory clobber to hazaard against
> other memory accesses.
> 
> Secondly, the "Q" input constaint for 'lock' looks inaccurate, given
> that we both read and write to 'lock'. Either that should be a "+Q"
> output constraint, or we rely on the memory clobber to hazard against
> other memory accesses.
> 

Thank you very much Mark, that is a lot of good information about 
writing arm64 asm!

If I understood correctly, the correct approach here would be to use 
pop_reg as an input operand, making sure that we store the address hold 
by *pop on x2 register right? So something along the lines:

__u32 __vdso_futex_robust_list64_try_unlock(__u32 *lock, __u32 tid, 
__u64 *pop)
{
	register __u64 pop_reg asm("x2") = (__u64) pop;

...

		"	str 	xzr, [%x[pop_reg]]		\n"
...

		: [val] "=&r" (val),
		  [result] "=&r" (result_reg),
		  [lock] "+Q" (*lock)
		: [tid] "r" (tid),
		  [pop_reg] "r" (pop_reg)
		: "cc", "memory"

Does that looks right?

Thanks again for the help


> Mark.
> 
>> +
>> +	return val;
>> +}
>>
>> -- 
>> 2.55.0
>>

