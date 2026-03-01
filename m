Received: from out-173.mta1.migadu.com (out-173.mta1.migadu.com [95.215.58.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52DCF1DF980
	for <linux-arch@vger.kernel.org>; Sun,  1 Mar 2026 06:56:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772348189; cv=none; b=JKQjsYDNN+Ub6SqPlhGLE2wPb2i40hp6g7lEPqN4PqP4i1SdRXCj5yaEj95EOYgNnkAoAJTLTB9+0n8V1bP28fiXATHaqdjDyaTM1INcFAs8MvoE16OIZxncs9lFvOpFhIdtKAeLeJ6p0+IXZdAae/cxjQBFNFmk4yqRBnBN5FA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772348189; c=relaxed/simple;
	bh=o0y8DPmKyC9GpuR11MxEd1qNG1QYCLpqHggdKsZ9lak=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GYhTwL6mYFpFvTvIm3P681nLaGkAc+RH4dvDQJRdIamfL8OxEANqv3Kpk2goSlG3vbRp5xJR6djEfTUKVHsD+VVO+Ub/TXPa4uS15+jHeFprCRVPrqxyDX+0NPnBARdRHo7h+fpotlh0QP6dGioKo7rn6KgJKh9J2e3gOGkgevw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=EMKrQY7W; arc=none smtp.client-ip=95.215.58.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="EMKrQY7W"
Message-ID: <7454cd72-3816-4a05-89f1-ded8b99acb41@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1772348185;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7jVbiQXIQMX/1B8+z3NiDZcVvND9uVKdGlGO2tuqfdM=;
	b=EMKrQY7WRXO8kYWzx1xdMTU5rEVlMVp9IHizMuBLddZGHk9vGaaiFIPCtNKy/esjK1Fdcn
	0f4AVHD0lMvSwDLyupaQdautjy8Z5F5qRfp4hQHxi2VKY2kFJD6nVSIzo6ArC2A9XtumQ+
	DuHdDT4XyvQvlIfnfHqthTSkSmlZAzA=
Date: Sun, 1 Mar 2026 14:56:14 +0800
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
 <e3cdcbfa-525d-4e0d-885a-8f7d69a7ee3d@linux.dev>
 <aaCP95l-m8ISXF78@google.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Lance Yang <lance.yang@linux.dev>
In-Reply-To: <aaCP95l-m8ISXF78@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT



On 2026/2/27 02:24, Sean Christopherson wrote:
> On Thu, Feb 26, 2026, Lance Yang wrote:
>> On 2026/2/26 04:11, Sean Christopherson wrote:
>>> On Mon, Feb 02, 2026, Lance Yang wrote:
>>>> diff --git a/arch/x86/kernel/kvm.c b/arch/x86/kernel/kvm.c
>>>> index 37dc8465e0f5..6a5e47ee4eb6 100644
>>>> --- a/arch/x86/kernel/kvm.c
>>>> +++ b/arch/x86/kernel/kvm.c
>>>> @@ -856,6 +856,12 @@ static void __init kvm_guest_init(void)
>>>>    #ifdef CONFIG_SMP
>>>>    	if (pv_tlb_flush_supported()) {
>>>>    		pv_ops.mmu.flush_tlb_multi = kvm_flush_tlb_multi;
>>>> +		/*
>>>> +		 * KVM's flush implementation calls native_flush_tlb_multi(),
>>>> +		 * which sends real IPIs when INVLPGB is not available.
>>>
>>> Not on all (virtual) CPUs.  The entire point of KVM's PV TLB flush is to elide
>>> the IPIs.  If a vCPU was scheduled out by the host, the guest sets a flag and
>>> relies on the host to flush the TLB on behalf of the guest prior to the next
>>> VM-Enter.
>>
>> Ah, I see. Thanks for the correction!
>>
>> KVM only sends IPIs to running vCPUs; preempted ones are left out of the mask
>> and flushed on VM-Enter. So the old comment was wrong ...
>>
>> IIUC, we still set the flag to true because only running vCPUs can be in a
>> software/lockless walk, and they all get the IPI, so the flush is enough.
>>
>> Does that match what you had in mind?
> 
> No, because from the guest kernel's perspective, the vCPU is running.  The kernel
> can't make any assumptions about what code the vCPU was executing when the vCPU
> was preempted by the host scheduler, i.e. it's entirely possible the vCPU is in
> a software/lockless walk.

Thanks a lot for setting me straight!

So any PV that has its own things and doesn't call
native_flush_tlb_multi() directly cannot be trusted to provide the IPI
guarantees we need.

So we should only set the flag for the native path, which truly calls
native_flush_tlb_multi() directly.


Have a great weekend,
Lance
