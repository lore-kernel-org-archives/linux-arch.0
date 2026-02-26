Received: from out-179.mta0.migadu.com (out-179.mta0.migadu.com [91.218.175.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88CC9311960
	for <linux-arch@vger.kernel.org>; Thu, 26 Feb 2026 11:38:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772105907; cv=none; b=QjL0iflOftvabJUc7QRpNyAGoZVRJ3T4slqkz7MmQN/JZNNNhrj5c7le48wNe7hxdAVnu2TM/9axjQuShFzmEPySTtOJBYS3LQKJ/niO1Y5ft7GOujLIk4JFNm7trLi/k2Ypra7XP4W8rVQgVonDX5Q5rJ/ECF93y65htI8x2NE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772105907; c=relaxed/simple;
	bh=kiZlvDtHTgwzoMQDveqxFFIRufbDKOxBRz+/jwOuhnM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DZSK1nD+crSU0+btUNDZWWmG0Ij4ptNGVXYJXmh9NJaIp+Fr/H22h29b6mEKZEVJnc/SRRzsYr+ntIWG3uajFiTWk17lD33Kk9Ha4VgFABq2Umwd8KVEzzCAml4o9O/R2F/E66Sb75IUQKI/F7c63CEE5nBIKUO95wi+xcvHL98=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=lJPkmtZ5; arc=none smtp.client-ip=91.218.175.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="lJPkmtZ5"
Message-ID: <e3cdcbfa-525d-4e0d-885a-8f7d69a7ee3d@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1772105904;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=oVaH2AoHyrpbqPRn9gALiYtw4uFm/ie/8+RysyrQGzU=;
	b=lJPkmtZ530h0RaT4fu91t/bNwWMNVEIXdYTEi99XumvWDHNOWee3IjKoAVImZWm7XhGvax
	qFCbJBGfyInnEuhW3QlCU4zoZFi8xwNvrt/aByDnCLNcPJIwuToPOKUcbglYKAHVqf4PSY
	9Koo9hEPLX0q59Rbu+eHXWAkrNeJw84=
Date: Thu, 26 Feb 2026 19:37:57 +0800
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v4 3/3] x86/tlb: add architecture-specific TLB IPI
 optimization support
Content-Language: en-US
To: Sean Christopherson <seanjc@google.com>
Cc: akpm@linux-foundation.org, david@kernel.org, dave.hansen@intel.com,
 dave.hansen@linux.intel.com, ypodemsk@redhat.com, hughd@google.com,
 will@kernel.org, aneesh.kumar@kernel.org, npiggin@gmail.com,
 peterz@infradead.org, tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
 x86@kernel.org, hpa@zytor.com, arnd@arndb.de, lorenzo.stoakes@oracle.com,
 ziy@nvidia.com, baolin.wang@linux.alibaba.com, Liam.Howlett@oracle.com,
 npache@redhat.com, ryan.roberts@arm.com, dev.jain@arm.com,
 baohua@kernel.org, shy828301@gmail.com, riel@surriel.com, jannh@google.com,
 jgross@suse.com, pbonzini@redhat.com, boris.ostrovsky@oracle.com,
 virtualization@lists.linux.dev, kvm@vger.kernel.org,
 linux-arch@vger.kernel.org, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, ioworker0@gmail.com
References: <20260202074557.16544-1-lance.yang@linux.dev>
 <20260202074557.16544-4-lance.yang@linux.dev> <aZ9Xcgxa0_ouGr31@google.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Lance Yang <lance.yang@linux.dev>
In-Reply-To: <aZ9Xcgxa0_ouGr31@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT



On 2026/2/26 04:11, Sean Christopherson wrote:
> On Mon, Feb 02, 2026, Lance Yang wrote:
>> diff --git a/arch/x86/kernel/kvm.c b/arch/x86/kernel/kvm.c
>> index 37dc8465e0f5..6a5e47ee4eb6 100644
>> --- a/arch/x86/kernel/kvm.c
>> +++ b/arch/x86/kernel/kvm.c
>> @@ -856,6 +856,12 @@ static void __init kvm_guest_init(void)
>>   #ifdef CONFIG_SMP
>>   	if (pv_tlb_flush_supported()) {
>>   		pv_ops.mmu.flush_tlb_multi = kvm_flush_tlb_multi;
>> +		/*
>> +		 * KVM's flush implementation calls native_flush_tlb_multi(),
>> +		 * which sends real IPIs when INVLPGB is not available.
> 
> Not on all (virtual) CPUs.  The entire point of KVM's PV TLB flush is to elide
> the IPIs.  If a vCPU was scheduled out by the host, the guest sets a flag and
> relies on the host to flush the TLB on behalf of the guest prior to the next
> VM-Enter.

Ah, I see. Thanks for the correction!

KVM only sends IPIs to running vCPUs; preempted ones are left out of the 
mask
and flushed on VM-Enter. So the old comment was wrong ...

IIUC, we still set the flag to true because only running vCPUs can be in a
software/lockless walk, and they all get the IPI, so the flush is enough.

Does that match what you had in mind?


Thanks,
Lance

> 
> 	for_each_cpu(cpu, flushmask) {
> 		/*
> 		 * The local vCPU is never preempted, so we do not explicitly
> 		 * skip check for local vCPU - it will never be cleared from
> 		 * flushmask.
> 		 */
> 		src = &per_cpu(steal_time, cpu);
> 		state = READ_ONCE(src->preempted);
> 		if ((state & KVM_VCPU_PREEMPTED)) {
> 			if (try_cmpxchg(&src->preempted, &state,
> 					state | KVM_VCPU_FLUSH_TLB))
> 				__cpumask_clear_cpu(cpu, flushmask);  <=== removes CPU from the IPI set
> 		}
> 	}
> 
> 	native_flush_tlb_multi(flushmask, info);
> 
>> +		if (!cpu_feature_enabled(X86_FEATURE_INVLPGB))
>> +			pv_ops.mmu.flush_tlb_multi_implies_ipi_broadcast = true;
>>   		pr_info("KVM setup pv remote TLB flush\n");
>>   	}

