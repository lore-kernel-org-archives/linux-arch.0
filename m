Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1109C279358;
	Mon,  1 Jun 2026 16:18:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.97.179.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780330710; cv=none; b=YFcAr4Yqn6A0JIMd+s0Eoo3D96ASVBK9RCMvzuIWoEVP01N/JHD0NOVjkCvTHYiO9BnpvwLGgkVxvK85ukW12zuE+rumwdsO1tG7mUPWo/3R7UNojx3O/heldHRL3ppvaWqz7kiASIinDApm+vMi6PEkM588XJLH4OVRE12PqcM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780330710; c=relaxed/simple;
	bh=+9b7RjQJQuXZy0Jp2ebaO6VQe59KIG1m+70EKnmJnCk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Vsp4faQxJDcWz4ebD7uCaavEG8ZK6K572NnGSFvforJbRKhM+XgzJMRejNAVEtUn/pR/4baGpvZwZywS1omApPTYwcNQFKsVosaHGyUh7qOA8LWO3aZ6REa+k58tiWmIgaB5xSM9NRSkNNkLqAmNTly/3q4DVP9VdM7F08ekm50=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=n77TsKRM; arc=none smtp.client-ip=213.97.179.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="n77TsKRM"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
	References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=fJZwHBlIWaVYPF8vygrFg9lljHY6FPv3NF+DSCaap04=; b=n77TsKRMNIYCQvziJZDQgDPZj8
	ch2YgEyPpWEvLvIkddOI/GIEScSlRTqv9BHqxLpLMh7zC0GUtKGlRzNqUQPbDZRGG34obWh7274IO
	B+7VDNm1DUwjHXXJzK+33Lxh+tV2Ou6TsBtMrj6LUHLOQCg89keCABC0zRi4PflDv6oX4RTke3Lpw
	qqdrVrZF1cFrXDNf59OswVDsWGdn3GsbGLrX78pI6MWz2Io6Jz5XJb11dUuAcC7NpavdJ/OgZFq42
	4VJow5UsiC3Q0AMEXHgTyjE0EGEqODFO83UTr82O6jlaXqwdBhZAhJMJrYRPabGbWnykA4o59C+ac
	sGceAO7A==;
Received: from [177.172.121.54] (helo=[192.168.15.100])
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
	id 1wU5Ke-00B6HW-N9; Mon, 01 Jun 2026 18:17:40 +0200
Message-ID: <ae090604-4ea0-416e-b79b-6a4f5eba4e85@igalia.com>
Date: Mon, 1 Jun 2026 13:17:33 -0300
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/5] arm64: vdso: Prepare for robust futex unlock
 support
To: =?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Cc: Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>,
 Thomas Gleixner <tglx@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 Carlos O'Donell <carlos@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
 Florian Weimer <fweimer@redhat.com>, Rich Felker <dalias@aerifal.cx>,
 Torvald Riegel <triegel@redhat.com>, Darren Hart <dvhart@infradead.org>,
 Ingo Molnar <mingo@kernel.org>, Davidlohr Bueso <dave@stgolabs.net>,
 Arnd Bergmann <arnd@arndb.de>, "Liam R . Howlett" <Liam.Howlett@oracle.com>,
 Uros Bizjak <ubizjak@gmail.com>, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
 kernel-dev@igalia.com
References: <20260529-tonyk-robust_arm-v3-0-a6f02684d4fe@igalia.com>
 <20260529-tonyk-robust_arm-v3-1-a6f02684d4fe@igalia.com>
 <b23ab875-fd4c-4095-a661-6a19b6a070e3@t-8ch.de>
Content-Language: en-US
From: =?UTF-8?Q?Andr=C3=A9_Almeida?= <andrealmeid@igalia.com>
In-Reply-To: <b23ab875-fd4c-4095-a661-6a19b6a070e3@t-8ch.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Em 29/05/2026 14:16, Thomas Weißschuh escreveu:
> On 2026-05-29 13:33:53-0300, André Almeida wrote:
>> There will be a VDSO function to unlock non-contended robust futexes in
>> user space. The unlock sequence is racy vs. clearing the list_pending_op
>> pointer in the task's robust list head. To plug this race the kernel needs
>> to know the critical section window so it can clear the pointer when the
>> task is interrupted within that race window. The window is determined by
>> labels in the inline assembly.
>>
>> Signed-off-by: André Almeida <andrealmeid@igalia.com>
>> ---
>> Notes:
>>   - The diff futex_set_vdso_cs_range() should happen in the commit that
>>   introduced it, and rebase will clear it from here
>>   - So far I couldn't figure out why current->rseq.event.user_irq is never set in
>>   aarch64
> 
> Why not put these unrelated changes into their own commits?
> It makes reviewing and integrating it into the original series easier.
> 

OK, I will separated them for a next version. But hopefully those 
changes won't be needed for the next one.

>> v3:
>>   - Fix adding vdso base addr twice
>>   - Call vdso_futex_robust_unlock_update_ips() on remap as well
>> v2:
>>   - Fixed linker not finding VDSO symbols
>> ---
>>   arch/arm64/kernel/vdso.c          | 25 +++++++++++++++++++++++++
>>   arch/arm64/kernel/vdso/vdso.lds.S |  5 +++++
>>   arch/x86/entry/vdso/vma.c         |  4 ++--
>>   include/linux/futex.h             | 13 ++-----------
>>   4 files changed, 34 insertions(+), 13 deletions(-)
>>
>> diff --git a/arch/arm64/kernel/vdso.c b/arch/arm64/kernel/vdso.c
>> index 592dd8668de4..76f22ea8e181 100644
>> --- a/arch/arm64/kernel/vdso.c
>> +++ b/arch/arm64/kernel/vdso.c
>> @@ -11,6 +11,7 @@
>>   #include <linux/clocksource.h>
>>   #include <linux/elf.h>
>>   #include <linux/err.h>
>> +#include <linux/futex.h>
>>   #include <linux/errno.h>
>>   #include <linux/gfp.h>
>>   #include <linux/kernel.h>
>> @@ -57,11 +58,31 @@ static struct vdso_abi_info vdso_info[] __ro_after_init = {
>>   #endif /* CONFIG_COMPAT_VDSO */
>>   };
>>   
>> +#ifdef CONFIG_FUTEX_ROBUST_UNLOCK
>> +static void vdso_futex_robust_unlock_update_ips(enum vdso_abi abi, struct mm_struct *mm)
>> +{
>> +	unsigned long vdso = (unsigned long) mm->context.vdso;
>> +	struct futex_mm_data *fd = &mm->futex;
>> +	uintptr_t success, end;
>> +
>> +	if (abi == VDSO_ABI_AA64) {
>> +		success = (uintptr_t) VDSO_SYMBOL(vdso, futex_list64_try_unlock_cs_success);
>> +		end = (uintptr_t) VDSO_SYMBOL(vdso, futex_list64_try_unlock_cs_end);
>> +
>> +		futex_set_vdso_cs_range(fd, 0, success, end, false);
>> +	}
>> +}
>> +#else
>> +static inline void vdso_futex_robust_unlock_update_ips(enum vdso_abi abi, struct mm_struct *mm) { }
>> +#endif /* CONFIG_FUTEX_ROBUST_UNLOCK */
>> +
>>   static int vdso_mremap(const struct vm_special_mapping *sm,
>>   		struct vm_area_struct *new_vma)
>>   {
>>   	current->mm->context.vdso = (void *)new_vma->vm_start;
>>   
>> +	vdso_futex_robust_unlock_update_ips(VDSO_ABI_AA64, current->mm);
>> +
>>   	return 0;
>>   }
>>   
>> @@ -134,6 +155,8 @@ static int __setup_additional_pages(enum vdso_abi abi,
>>   	if (IS_ERR(ret))
>>   		goto up_fail;
>>   
>> +	vdso_futex_robust_unlock_update_ips(abi, mm);
>> +
>>   	return 0;
>>   
>>   up_fail:
>> @@ -159,6 +182,8 @@ static int aarch32_sigpage_mremap(const struct vm_special_mapping *sm,
>>   {
>>   	current->mm->context.sigpage = (void *)new_vma->vm_start;
>>   
>> +	vdso_futex_robust_unlock_update_ips(VDSO_ABI_AA32, current->mm);
> 
> This is for the sigpage remap, not the vDSO, is it really necessary?
> If yes it should be part of the later VDSO_ABI_AA32 patch IMO.
> 

Ok, I don't think it moves the vDSO indeed.

> 
> If there is a way for a 64-bit application to call 32-bit syscalls then
> the 64-bit vDSO also needs the 32-bit functions. See:
> [0] https://lore.kernel.org/lkml/875x4zw4bp.ffs@tglx/
> 

I believe this is true for x86, but not for aarch64. Currently x86 apps 
running on top of arm64 have no way to register a 32 bit list, but this 
will change with the upcoming multi list feature.
>>   	return 0;
>>   }
>>   
>> diff --git a/arch/arm64/kernel/vdso/vdso.lds.S b/arch/arm64/kernel/vdso/vdso.lds.S
>> index 52314be29191..8633aafe6b81 100644
>> --- a/arch/arm64/kernel/vdso/vdso.lds.S
>> +++ b/arch/arm64/kernel/vdso/vdso.lds.S
>> @@ -104,6 +104,7 @@ VERSION
>>   		__kernel_clock_gettime;
>>   		__kernel_clock_getres;
>>   		__kernel_getrandom;
>> +		__vdso_futex_robust_list64_try_unlock;
> 
> Guard behind CONFIG_FUTEX_ROBUST_UNLOCK ?
> 
> ld.lld fails when a function mentioned in the linker script is missing.

Yes, you are right, thanks for the review!

> 
>>   	local: *;
>>   	};
>>   }
>> @@ -112,3 +113,7 @@ VERSION
>>    * Make the sigreturn code visible to the kernel.
>>    */
>>   VDSO_sigtramp		= __kernel_rt_sigreturn;
>> +
>> +VDSO_futex_list64_try_unlock_cs_start = __futex_list64_try_unlock_cs_start;
>> +VDSO_futex_list64_try_unlock_cs_success = __futex_list64_try_unlock_cs_success;
>> +VDSO_futex_list64_try_unlock_cs_end = __futex_list64_try_unlock_cs_end;
> 
> (...)

