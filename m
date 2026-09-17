Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D1C031328E;
	Thu, 17 Sep 2026 01:11:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.97.179.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789607483; cv=none; b=ae11fmeWnRr8fa75PAkk0ou+O1qbf2I5wl512DC9taxSti+CF02FjFu/Vzsgnj2EtWZkPSfWabYqZfWIi0YTKincI5Jvpv63FOaFAh5xObUFSyed35HC6JQshaauDaryNc71rKGDbjutKpysx57NHeM4hOrI2VpyaVIbdtb0nZQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789607483; c=relaxed/simple;
	bh=lIl1ALWpclX3R1zfPf6n0myrRk16LVQmVMr0yI0Z9ww=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=heMCP4otTA7GxUMYx4K1uAgvXo5vrAdLSbQiYIgbPAEqfpDnKlJoeVxRfd62DMB+eppCt4tXOFIB3fS0S2Z+RYEdt8rALjvEsuA2vFfnozL5wOMg70a0PaGvFNA8pqQpfUg63rPffWPRlCIpjOZBrTdk4uXeCjpmbHQcUdQnh2w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=QeUG+hax; arc=none smtp.client-ip=213.97.179.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="QeUG+hax"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:Content-Type:From:Cc:To:Subject:
	MIME-Version:Date:Message-ID:From:Reply-To;
	bh=8k9uasLdJhEnshQsGKu6floda4Zwvrq8480xbirB5/c=; b=QeUG+haxncT2aoj4+8ZiwFj81k
	PQHpNGVCyJ+k3b1K6eQZHsKWLdLYqzZtic4gC+c7RPb84NHFNwYX56QSbV38d6eE4FCCrIzA0WZKy
	G65j/qBrTfPoN2YYqGlagCxaclmZHmnS8c2bKL5tNwWYllpF3vS6bmap/WcdG9rVQFsn5NvvKtX1j
	JE9/I93oyz0dHzYAqxU0SxV/sJNsf+4VsEcb2+8qJSD3KRgNIn7UVU51Caql+dZySHQkhV9quNqHG
	Z0SErNOd8acuMPHe+YGOSTrlVWT9eixMZTihoonJgbDdaLoWMCpF+WqfUapyqqNn3b8KNcWuQXYzM
	q/5z3CiQ==;
Received: from [177.172.123.214] (helo=[192.168.15.100])
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
	id 1x70eU-003Bv7-Q5; Thu, 17 Sep 2026 03:11:02 +0200
Message-ID: <d0c5ada8-929f-4d39-9f8e-32860fa5b853@igalia.com>
Date: Wed, 16 Sep 2026 22:11:01 -0300
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 4/4] arm64: vdso32: Implement
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
 <20260821-tonyk-robust_arm-v8-4-077707b6f1c7@igalia.com>
 <aqqngEKC_CsrS62n@J2N7QTR9R3>
Content-Language: en-US
From: =?UTF-8?Q?Andr=C3=A9_Almeida?= <andrealmeid@igalia.com>
In-Reply-To: <aqqngEKC_CsrS62n@J2N7QTR9R3>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Em 16/09/2026 11:28, Mark Rutland escreveu:
> On Fri, Aug 21, 2026 at 06:50:45PM -0300, André Almeida wrote:
>> Based on aarch64 implementation, provide a 32 bit entry point for
>> this vDSO.
>>
>> In order to keep compatibility with arm64_futex_robust_unlock_get_pop(),
>> make sure to store the pop address at r2 and the compare result value
>> at r3.
> 
> Before we add this to the compat vdso, we'll need to implement this on
> arch/arm/.
> 
> Otherwise, my comments on the patch for the native vdso functions apply
> here too.
> 

Right, and the compat entry point at arch/arm64/ would point to the 
__vdso_futex_robust_list32_try_unlock implementation at arch/arm/?

> Mark.
> 
>>
>> Signed-off-by: André Almeida <andrealmeid@igalia.com>
>> ---
>> v7:
>>   - The store needs to be a release store, so s/strex/stlex/
>>   - result reg clobber modified to "=&r" to make sure the compiler don't use
>>   the r3 reg for something else
>>   - pop_reg will be read after the execution so it should be an output
>>   parameter with "+Q"
>> ---
>>   arch/arm64/kernel/vdso.c            | 15 ++++++++++++++-
>>   arch/arm64/kernel/vdso32/Makefile   |  4 ++++
>>   arch/arm64/kernel/vdso32/vdso.lds.S |  9 +++++++++
>>   arch/arm64/kernel/vdso32/vfutex.c   | 34 ++++++++++++++++++++++++++++++++++
>>   4 files changed, 61 insertions(+), 1 deletion(-)
>>
>> diff --git a/arch/arm64/kernel/vdso.c b/arch/arm64/kernel/vdso.c
>> index dc6b582736d0..5cae9c17ec72 100644
>> --- a/arch/arm64/kernel/vdso.c
>> +++ b/arch/arm64/kernel/vdso.c
>> @@ -78,11 +78,19 @@ static inline void vdso_futex_update_ips(struct mm_struct *mm)
>>   				VDSO_SYMBOL(vdso, futex_list64_try_unlock_cs_end));
>>   }
>>   
>> +static inline void aarch32_vdso_futex_update_ips(struct mm_struct *mm)
>> +{
>> +	unsigned long vdso = (unsigned long) mm->context.vdso;
>> +
>> +	__vdso_futex_update_ips(mm, true,
>> +				VDSO_SYMBOL(vdso, futex_list32_try_unlock_cs_start),
>> +				VDSO_SYMBOL(vdso, futex_list32_try_unlock_cs_end));
>> +}
>>   #else
>>   static inline void vdso_futex_update_ips(struct mm_struct *mm) {}
>> +static inline void aarch32_vdso_futex_update_ips(struct mm_struct *mm) {}
>>   #endif /* CONFIG_FUTEX_ROBUST_UNLOCK */
>>   
>> -
>>   static int vdso_mremap(const struct vm_special_mapping *sm,
>>   		struct vm_area_struct *new_vma)
>>   {
>> @@ -195,6 +203,8 @@ static int aarch32_mremap(const struct vm_special_mapping *sm,
>>   {
>>   	current->mm->context.vdso = (void *)new_vma->vm_start;
>>   
>> +	aarch32_vdso_futex_update_ips(current->mm);
>> +
>>   	return 0;
>>   }
>>   
>> @@ -327,6 +337,7 @@ static int aarch32_sigreturn_setup(struct mm_struct *mm)
>>   	return PTR_ERR_OR_ZERO(ret);
>>   }
>>   
>> +
>>   int aarch32_setup_additional_pages(struct linux_binprm *bprm, int uses_interp)
>>   {
>>   	struct mm_struct *mm = current->mm;
>> @@ -347,6 +358,8 @@ int aarch32_setup_additional_pages(struct linux_binprm *bprm, int uses_interp)
>>   	}
>>   
>>   	ret = aarch32_sigreturn_setup(mm);
>> +
>> +	aarch32_vdso_futex_update_ips(mm);
>>   out:
>>   	mmap_write_unlock(mm);
>>   	return ret;
>> diff --git a/arch/arm64/kernel/vdso32/Makefile b/arch/arm64/kernel/vdso32/Makefile
>> index 4bd60f059f4a..f3190125c68b 100644
>> --- a/arch/arm64/kernel/vdso32/Makefile
>> +++ b/arch/arm64/kernel/vdso32/Makefile
>> @@ -97,6 +97,10 @@ munge := ../../../arm/vdso/vdsomunge
>>   hostprogs := $(munge)
>>   
>>   c-obj-vdso := note.o
>> +ifdef CONFIG_FUTEX_ROBUST_UNLOCK
>> +  c-obj-vdso += vfutex.o
>> +endif
>> +
>>   c-obj-vdso-gettimeofday := vgettimeofday.o
>>   
>>   ifneq ($(c-gettimeofday-y),)
>> diff --git a/arch/arm64/kernel/vdso32/vdso.lds.S b/arch/arm64/kernel/vdso32/vdso.lds.S
>> index 12bfc39e8aab..52ced27d6045 100644
>> --- a/arch/arm64/kernel/vdso32/vdso.lds.S
>> +++ b/arch/arm64/kernel/vdso32/vdso.lds.S
>> @@ -89,6 +89,15 @@ VERSION
>>   #endif /* CONFIG_COMPAT_32BIT_TIME */
>>   		__vdso_clock_gettime64;
>>   		__vdso_clock_getres_time64;
>> +#ifdef CONFIG_FUTEX_ROBUST_UNLOCK
>> +		__vdso_futex_robust_list32_try_unlock;
>> +#endif
>>   	local: *;
>>   	};
>>   }
>> +
>> +#ifdef CONFIG_FUTEX_ROBUST_UNLOCK
>> +VDSO_futex_list32_try_unlock_cs_success = __futex_list32_try_unlock_cs_success;
>> +VDSO_futex_list32_try_unlock_cs_start = __futex_list32_try_unlock_cs_start;
>> +VDSO_futex_list32_try_unlock_cs_end = __futex_list32_try_unlock_cs_end;
>> +#endif
>> diff --git a/arch/arm64/kernel/vdso32/vfutex.c b/arch/arm64/kernel/vdso32/vfutex.c
>> new file mode 100644
>> index 000000000000..0d9080b17965
>> --- /dev/null
>> +++ b/arch/arm64/kernel/vdso32/vfutex.c
>> @@ -0,0 +1,34 @@
>> +// SPDX-License-Identifier: GPL-2.0-or-later
>> +#include <linux/stringify.h>
>> +#include <vdso/futex.h>
>> +
>> +__u32 __vdso_futex_robust_list32_try_unlock(__u32 *lock, __u32 tid, __u32 *pop)
>> +{
>> +	register __u32 *pop_reg asm("r2") = pop, result_reg asm("r3") = 0;
>> +	__u32 val, zero = 0;
>> +
>> +	asm volatile (
>> +		".globl						  "
>> +		"__futex_list32_try_unlock_cs_start,		  "
>> +		"__futex_list32_try_unlock_cs_success,		  "
>> +		"__futex_list32_try_unlock_cs_end		\n"
>> +
>> +		"retry:						\n"
>> +		"	ldrex %[val], %[lock]			\n"
>> +		"	cmp %[tid], %[val]			\n"
>> +		"	bne __futex_list32_try_unlock_cs_end	\n"
>> +		"	stlex %[result], %[zero], %[lock]	\n"
>> +		"__futex_list32_try_unlock_cs_start:		\n"
>> +		"	cmp %[result], #0			\n"
>> +		"	bne retry				\n"
>> +		"__futex_list32_try_unlock_cs_success:		\n"
>> +		"	str %[zero], %[pop_reg]			\n"
>> +		"__futex_list32_try_unlock_cs_end:		\n"
>> +
>> +		: [val] "=&r" (val), [result] "=&r" (result_reg), [pop_reg] "+Q" (*pop_reg)
>> +		: [tid] "r" (tid), [lock] "Q" (*lock), [zero] "r" (zero)
>> +		: "cc", "memory"
>> +	);
>> +
>> +	return val;
>> +}
>>
>> -- 
>> 2.55.0
>>

