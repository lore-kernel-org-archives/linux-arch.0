Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 383882DB7B7;
	Thu, 23 Apr 2026 19:45:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776973504; cv=none; b=QHUpfgSwd8EwawTCvwGgs0I2vhGX+IGKBmHWNUEQmc9tF+jcIZ595vApBhEZ75n8bezlN3nPI5CMUt+CS5i6WjeDBrN/XoxRtImSXXbk8qZqAyMqTB3RA+h35K9LPhiJiKFble+C2z8T9Fq5v/MrNVvW9PVrMGwrggogw7PtYwc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776973504; c=relaxed/simple;
	bh=ENC60U4eoLTeOFgHvSyl4mRh0gHFD8ZCM+8UztNm+Oc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=B2s2W+ywfveimjx9jKuCoMIxcH0kcI4GZByU32DGE1eZDlcKYtURKauvVseVVv/TSwYjZOhgE25v/vvUKnM1fryMXbMCMXy3YyNZxs9jdQDo3WPJFN6K17xThXKp2E4yKRvSdZLNGZ/NfgLTiJOQc6rvE4RnBYwJeOK4lkZNYeY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WTjkhAl5; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WTjkhAl5"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A8445C2BCAF;
	Thu, 23 Apr 2026 19:44:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776973503;
	bh=ENC60U4eoLTeOFgHvSyl4mRh0gHFD8ZCM+8UztNm+Oc=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=WTjkhAl5drIfu9apC/Pi9agzSVtP58XXpDt2+cIt9h3kL6pdH1FmRKQU8q4lE5mb/
	 hCR0Jxqd4pQYChGR9GdRdJDAoZyFicegVlKibLa0Lufvv7X8N0JEYqUrGI0oh7Vv/M
	 3oEdsdTEVdvpkpGLwXo8VQyyOxHEPzYnM/aTsFCYPIyouxcSwpu1GHz0uUwGJEWkuj
	 iQ8omD6X26DJfCh4G4tx2nwQFQLflEQuYa9LlRrKm758y9dvJwkI7pjAZrffcRkPDV
	 Ki8Zekn7Y9+qoDgsT/rDBXYUiYpaOMrmIzWirEsXPA0oabydG9O3thHtUWGRWVMTlr
	 g14lLOI11hBYQ==
Message-ID: <1bcf0c90-7aee-47b2-a58c-7932e6ad088a@kernel.org>
Date: Thu, 23 Apr 2026 21:44:52 +0200
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 7.2 v9 2/2] x86/tlb: skip redundant sync IPIs for native
 TLB flush
To: Dave Hansen <dave.hansen@intel.com>, Lance Yang <lance.yang@linux.dev>,
 akpm@linux-foundation.org
Cc: peterz@infradead.org, dave.hansen@linux.intel.com, ypodemsk@redhat.com,
 hughd@google.com, will@kernel.org, aneesh.kumar@kernel.org,
 npiggin@gmail.com, tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
 x86@kernel.org, hpa@zytor.com, arnd@arndb.de, ljs@kernel.org,
 ziy@nvidia.com, baolin.wang@linux.alibaba.com, Liam.Howlett@oracle.com,
 npache@redhat.com, ryan.roberts@arm.com, dev.jain@arm.com,
 baohua@kernel.org, shy828301@gmail.com, riel@surriel.com, jannh@google.com,
 jgross@suse.com, seanjc@google.com, pbonzini@redhat.com,
 boris.ostrovsky@oracle.com, virtualization@lists.linux.dev,
 kvm@vger.kernel.org, linux-arch@vger.kernel.org, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, ioworker0@gmail.com
References: <20260420030851.6735-1-lance.yang@linux.dev>
 <20260420030851.6735-3-lance.yang@linux.dev>
 <f856051b-10c7-4d65-9dbe-6b1677af74bd@intel.com>
From: "David Hildenbrand (Arm)" <david@kernel.org>
Content-Language: en-US
Autocrypt: addr=david@kernel.org; keydata=
 xsFNBFXLn5EBEAC+zYvAFJxCBY9Tr1xZgcESmxVNI/0ffzE/ZQOiHJl6mGkmA1R7/uUpiCjJ
 dBrn+lhhOYjjNefFQou6478faXE6o2AhmebqT4KiQoUQFV4R7y1KMEKoSyy8hQaK1umALTdL
 QZLQMzNE74ap+GDK0wnacPQFpcG1AE9RMq3aeErY5tujekBS32jfC/7AnH7I0v1v1TbbK3Gp
 XNeiN4QroO+5qaSr0ID2sz5jtBLRb15RMre27E1ImpaIv2Jw8NJgW0k/D1RyKCwaTsgRdwuK
 Kx/Y91XuSBdz0uOyU/S8kM1+ag0wvsGlpBVxRR/xw/E8M7TEwuCZQArqqTCmkG6HGcXFT0V9
 PXFNNgV5jXMQRwU0O/ztJIQqsE5LsUomE//bLwzj9IVsaQpKDqW6TAPjcdBDPLHvriq7kGjt
 WhVhdl0qEYB8lkBEU7V2Yb+SYhmhpDrti9Fq1EsmhiHSkxJcGREoMK/63r9WLZYI3+4W2rAc
 UucZa4OT27U5ZISjNg3Ev0rxU5UH2/pT4wJCfxwocmqaRr6UYmrtZmND89X0KigoFD/XSeVv
 jwBRNjPAubK9/k5NoRrYqztM9W6sJqrH8+UWZ1Idd/DdmogJh0gNC0+N42Za9yBRURfIdKSb
 B3JfpUqcWwE7vUaYrHG1nw54pLUoPG6sAA7Mehl3nd4pZUALHwARAQABzS5EYXZpZCBIaWxk
 ZW5icmFuZCAoQ3VycmVudCkgPGRhdmlkQGtlcm5lbC5vcmc+wsGQBBMBCAA6AhsDBQkmWAik
 AgsJBBUKCQgCFgICHgUCF4AWIQQb2cqtc1xMOkYN/MpN3hD3AP+DWgUCaYJt/AIZAQAKCRBN
 3hD3AP+DWriiD/9BLGEKG+N8L2AXhikJg6YmXom9ytRwPqDgpHpVg2xdhopoWdMRXjzOrIKD
 g4LSnFaKneQD0hZhoArEeamG5tyo32xoRsPwkbpIzL0OKSZ8G6mVbFGpjmyDLQCAxteXCLXz
 ZI0VbsuJKelYnKcXWOIndOrNRvE5eoOfTt2XfBnAapxMYY2IsV+qaUXlO63GgfIOg8RBaj7x
 3NxkI3rV0SHhI4GU9K6jCvGghxeS1QX6L/XI9mfAYaIwGy5B68kF26piAVYv/QZDEVIpo3t7
 /fjSpxKT8plJH6rhhR0epy8dWRHk3qT5tk2P85twasdloWtkMZ7FsCJRKWscm1BLpsDn6EQ4
 jeMHECiY9kGKKi8dQpv3FRyo2QApZ49NNDbwcR0ZndK0XFo15iH708H5Qja/8TuXCwnPWAcJ
 DQoNIDFyaxe26Rx3ZwUkRALa3iPcVjE0//TrQ4KnFf+lMBSrS33xDDBfevW9+Dk6IISmDH1R
 HFq2jpkN+FX/PE8eVhV68B2DsAPZ5rUwyCKUXPTJ/irrCCmAAb5Jpv11S7hUSpqtM/6oVESC
 3z/7CzrVtRODzLtNgV4r5EI+wAv/3PgJLlMwgJM90Fb3CB2IgbxhjvmB1WNdvXACVydx55V7
 LPPKodSTF29rlnQAf9HLgCphuuSrrPn5VQDaYZl4N/7zc2wcWM7BTQRVy5+RARAA59fefSDR
 9nMGCb9LbMX+TFAoIQo/wgP5XPyzLYakO+94GrgfZjfhdaxPXMsl2+o8jhp/hlIzG56taNdt
 VZtPp3ih1AgbR8rHgXw1xwOpuAd5lE1qNd54ndHuADO9a9A0vPimIes78Hi1/yy+ZEEvRkHk
 /kDa6F3AtTc1m4rbbOk2fiKzzsE9YXweFjQvl9p+AMw6qd/iC4lUk9g0+FQXNdRs+o4o6Qvy
 iOQJfGQ4UcBuOy1IrkJrd8qq5jet1fcM2j4QvsW8CLDWZS1L7kZ5gT5EycMKxUWb8LuRjxzZ
 3QY1aQH2kkzn6acigU3HLtgFyV1gBNV44ehjgvJpRY2cC8VhanTx0dZ9mj1YKIky5N+C0f21
 zvntBqcxV0+3p8MrxRRcgEtDZNav+xAoT3G0W4SahAaUTWXpsZoOecwtxi74CyneQNPTDjNg
 azHmvpdBVEfj7k3p4dmJp5i0U66Onmf6mMFpArvBRSMOKU9DlAzMi4IvhiNWjKVaIE2Se9BY
 FdKVAJaZq85P2y20ZBd08ILnKcj7XKZkLU5FkoA0udEBvQ0f9QLNyyy3DZMCQWcwRuj1m73D
 sq8DEFBdZ5eEkj1dCyx+t/ga6x2rHyc8Sl86oK1tvAkwBNsfKou3v+jP/l14a7DGBvrmlYjO
 59o3t6inu6H7pt7OL6u6BQj7DoMAEQEAAcLBfAQYAQgAJgIbDBYhBBvZyq1zXEw6Rg38yk3e
 EPcA/4NaBQJonNqrBQkmWAihAAoJEE3eEPcA/4NaKtMQALAJ8PzprBEXbXcEXwDKQu+P/vts
 IfUb1UNMfMV76BicGa5NCZnJNQASDP/+bFg6O3gx5NbhHHPeaWz/VxlOmYHokHodOvtL0WCC
 8A5PEP8tOk6029Z+J+xUcMrJClNVFpzVvOpb1lCbhjwAV465Hy+NUSbbUiRxdzNQtLtgZzOV
 Zw7jxUCs4UUZLQTCuBpFgb15bBxYZ/BL9MbzxPxvfUQIPbnzQMcqtpUs21CMK2PdfCh5c4gS
 sDci6D5/ZIBw94UQWmGpM/O1ilGXde2ZzzGYl64glmccD8e87OnEgKnH3FbnJnT4iJchtSvx
 yJNi1+t0+qDti4m88+/9IuPqCKb6Stl+s2dnLtJNrjXBGJtsQG/sRpqsJz5x1/2nPJSRMsx9
 5YfqbdrJSOFXDzZ8/r82HgQEtUvlSXNaXCa95ez0UkOG7+bDm2b3s0XahBQeLVCH0mw3RAQg
 r7xDAYKIrAwfHHmMTnBQDPJwVqxJjVNr7yBic4yfzVWGCGNE4DnOW0vcIeoyhy9vnIa3w1uZ
 3iyY2Nsd7JxfKu1PRhCGwXzRw5TlfEsoRI7V9A8isUCoqE2Dzh3FvYHVeX4Us+bRL/oqareJ
 CIFqgYMyvHj7Q06kTKmauOe4Nf0l0qEkIuIzfoLJ3qr5UyXc2hLtWyT9Ir+lYlX9efqh7mOY
 qIws/H2t
In-Reply-To: <f856051b-10c7-4d65-9dbe-6b1677af74bd@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 4/23/26 19:56, Dave Hansen wrote:
> On 4/19/26 20:08, Lance Yang wrote:
>> -	flush_tlb_mm_range(tlb->mm, start, end, stride_shift, tlb->freed_tables);
>> +	/*
>> +	 * Treat unshared_tables just like freed_tables, such that lazy-TLB
>> +	 * CPUs also receive IPIs during unsharing of page tables, allowing
>> +	 * us to safely implement tlb_table_flush_implies_ipi_broadcast().
>> +	 */
>> +	flush_tlb_mm_range(tlb->mm, start, end, stride_shift,
>> +			   tlb->freed_tables || tlb->unshared_tables);
>>  }
> 
> I've been staring at this trying to make sense of it for too long.
> 
> Right now, flush_tlb_mm_range() literally has an argument named
> "freed_tables" and "tlb->freed_tables" is passed there. That seems
> totally sane. It's 100% straightforward to follow.
> 
> But it makes zero logical sense to me to now mix "tlb->unshared_tables"
> in there. Sure, what you _want_ is the freed_tables==1 behavior from
> tlb->unshared_tables==1, and this obviously hacks that in there, but
> it's not explained well enough and not maintainable like this. IOW, it's
> still just hack.
> 
> I think what's happened here is that info->freed_tables is being
> modified from being strictly related to page table freeing, and moved
> over to a bit which tells TLB flushing implementations whether they can
> respect CPUs in lazy TLB mode.
> 
> It's mentioned in the comment, but then ever reflected into the code.
> 
> Shouldn't we be doing something like the attached patch? Look at how
> that maps over to the flushing side, like in the hyperv code:
> 
>> -       bool do_lazy = !info->freed_tables;
>> +       bool do_lazy = !info->wake_lazy_cpus;
>>  
>>         trace_hyperv_mmu_flush_tlb_multi(cpus, info);
>>  
>> @@ -198,7 +198,7 @@ static u64 hyperv_flush_tlb_others_ex(co
>>  
>>         flush->hv_vp_set.format = HV_GENERIC_SET_SPARSE_4K;
>>         nr_bank = cpumask_to_vpset_skip(&flush->hv_vp_set, cpus,
>> -                       info->freed_tables ? NULL : cpu_is_lazy);
>> +                       info->wake_lazy_cpus ? NULL : cpu_is_lazy);
> 
> That even makes the hyperv code easier to read over what was there
> before, IMNHO.
> 
> Thoughts?

Looks better!

-- 
Cheers,

David
