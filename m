Received: from out-171.mta0.migadu.com (out-171.mta0.migadu.com [91.218.175.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0B6E41163D
	for <linux-arch@vger.kernel.org>; Mon,  2 Mar 2026 15:48:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772466526; cv=none; b=Gr9cZebEF59zKtVe/V1+3XOdcY/OwbEBHDtkxULd9lLj0NL2aW99l+1EMmx/OwO+Q8F6ru3qll7jHd4YrzolnzSx0E8A3laG/M3CK1thEZbwt1h8ZxCK+k11zHU9nUZXk+7jt9UncLDc6Irazc2rU31EoSux9G8hDqCsjbVthqM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772466526; c=relaxed/simple;
	bh=+EtwxgqdOWRZ2FQfy7w/Q9MnqfJZ8XSUbgIqg74laiY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fSkJhUDwfZ6HUfTRo++1WCzG4qQdqiDpx8QyiW62jtAUStWl3MyKK4dpAO48W8rP7X0ZkFQ9voUHZsIow2jINM10+tUEiv9XVTwUX6N2KlaxrFOhQkUIHdrnVGBSXFQiyDP8xjlwM96H3hohMRqn0ecDCCXWkip6Bo91DvqgwoU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=qn2tNu2a; arc=none smtp.client-ip=91.218.175.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="qn2tNu2a"
Message-ID: <42a719d3-5fbd-4b96-a150-6c0b4a1521a3@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1772466512;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=FTECatV7Hem2M5Whzj/+5qLaShaqM0faNoQsDp0E1eI=;
	b=qn2tNu2asGcPBaNPiLBEHqPA1ISUAYvFdlA3yDgMEjvnV9wFHAHANAKzMMQI7p+eoGhJbw
	GB+5m+Qs2PPeTQk6Pxy5HsBkMVi/kh8tLAqThalAcm3txH4p/T0ROgVUJGN2DzQ2qMT7uD
	UjSW9pewzRKpXJGWz1nxJ1hYJh2XlGg=
Date: Mon, 2 Mar 2026 23:48:11 +0800
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v5 2/2] x86/tlb: skip redundant sync IPIs for native TLB
 flush
Content-Language: en-US
To: Peter Zijlstra <peterz@infradead.org>
Cc: akpm@linux-foundation.org, david@kernel.org, dave.hansen@intel.com,
 dave.hansen@linux.intel.com, ypodemsk@redhat.com, hughd@google.com,
 will@kernel.org, aneesh.kumar@kernel.org, npiggin@gmail.com,
 tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, x86@kernel.org,
 hpa@zytor.com, arnd@arndb.de, lorenzo.stoakes@oracle.com, ziy@nvidia.com,
 baolin.wang@linux.alibaba.com, Liam.Howlett@oracle.com, npache@redhat.com,
 ryan.roberts@arm.com, dev.jain@arm.com, baohua@kernel.org,
 shy828301@gmail.com, riel@surriel.com, jannh@google.com, jgross@suse.com,
 seanjc@google.com, pbonzini@redhat.com, boris.ostrovsky@oracle.com,
 virtualization@lists.linux.dev, kvm@vger.kernel.org,
 linux-arch@vger.kernel.org, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, ioworker0@gmail.com
References: <20260302063048.9479-1-lance.yang@linux.dev>
 <20260302063048.9479-3-lance.yang@linux.dev>
 <20260302145652.GH1395266@noisy.programming.kicks-ass.net>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Lance Yang <lance.yang@linux.dev>
In-Reply-To: <20260302145652.GH1395266@noisy.programming.kicks-ass.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT



On 2026/3/2 22:56, Peter Zijlstra wrote:
> On Mon, Mar 02, 2026 at 02:30:36PM +0800, Lance Yang wrote:
> 
> 
>> @@ -221,3 +222,18 @@ NOKPROBE_SYMBOL(native_load_idt);
>>   
>>   EXPORT_SYMBOL(pv_ops);
>>   EXPORT_SYMBOL_GPL(pv_info);
>> +
>> +void __init native_pv_tlb_init(void)
>> +{
>> +	/*
>> +	 * If PV backend already set the property, respect it.
>> +	 * Otherwise, check if native TLB flush sends real IPIs to all target
>> +	 * CPUs (i.e., not using INVLPGB broadcast invalidation).
>> +	 */
>> +	if (pv_ops.mmu.flush_tlb_multi_implies_ipi_broadcast)
>> +		return;
>> +
>> +	if (pv_ops.mmu.flush_tlb_multi == native_flush_tlb_multi &&
>> +	    !cpu_feature_enabled(X86_FEATURE_INVLPGB))
>> +		pv_ops.mmu.flush_tlb_multi_implies_ipi_broadcast = true;
>> +}
> 
> How about making this a static_branch instead?

Cool. Thanks for the suggestion!

> 
>> diff --git a/arch/x86/include/asm/tlb.h b/arch/x86/include/asm/tlb.h
>> index 866ea78ba156..87ef7147eac8 100644
>> --- a/arch/x86/include/asm/tlb.h
>> +++ b/arch/x86/include/asm/tlb.h
>> @@ -5,10 +5,23 @@
>>   #define tlb_flush tlb_flush
>>   static inline void tlb_flush(struct mmu_gather *tlb);
>>   
>> +#define tlb_table_flush_implies_ipi_broadcast tlb_table_flush_implies_ipi_broadcast
>> +static inline bool tlb_table_flush_implies_ipi_broadcast(void);
>> +
>>   #include <asm-generic/tlb.h>
>>   #include <linux/kernel.h>
>>   #include <vdso/bits.h>
>>   #include <vdso/page.h>
>> +#include <asm/paravirt.h>
>> +
>> +static inline bool tlb_table_flush_implies_ipi_broadcast(void)
>> +{
>> +#ifdef CONFIG_PARAVIRT
>> +	return pv_ops.mmu.flush_tlb_multi_implies_ipi_broadcast;
>> +#else
>> +	return !cpu_feature_enabled(X86_FEATURE_INVLPGB);
>> +#endif
>> +}
> 
> Then this turns into:
> 
> static inline bool tlb_table_flush_implies_ipi_broadcast(void)
> {
> 	return static_branch_likely(&tlb_ipi_broadcast_key);
> }

Right. That would be cleaner and faster, eliminating the branch overhead.

Trying using static_branch on top of this series, something like:

---8<---
diff --git a/arch/x86/include/asm/tlb.h b/arch/x86/include/asm/tlb.h
index 87ef7147eac8..409bbf335f26 100644
--- a/arch/x86/include/asm/tlb.h
+++ b/arch/x86/include/asm/tlb.h
@@ -10,17 +10,16 @@ static inline bool 
tlb_table_flush_implies_ipi_broadcast(void);

  #include <asm-generic/tlb.h>
  #include <linux/kernel.h>
+#include <linux/jump_label.h>
  #include <vdso/bits.h>
  #include <vdso/page.h>
  #include <asm/paravirt.h>

+DECLARE_STATIC_KEY_FALSE(tlb_ipi_broadcast_key);
+
  static inline bool tlb_table_flush_implies_ipi_broadcast(void)
  {
-#ifdef CONFIG_PARAVIRT
-	return pv_ops.mmu.flush_tlb_multi_implies_ipi_broadcast;
-#else
-	return !cpu_feature_enabled(X86_FEATURE_INVLPGB);
-#endif
+	return static_branch_likely(&tlb_ipi_broadcast_key);
  }

  static inline void tlb_flush(struct mmu_gather *tlb)
diff --git a/arch/x86/kernel/paravirt.c b/arch/x86/kernel/paravirt.c
index b681b8319295..bcf28980c319 100644
--- a/arch/x86/kernel/paravirt.c
+++ b/arch/x86/kernel/paravirt.c
@@ -15,6 +15,7 @@
  #include <linux/kprobes.h>
  #include <linux/pgtable.h>
  #include <linux/static_call.h>
+#include <linux/jump_label.h>

  #include <asm/bug.h>
  #include <asm/paravirt.h>
@@ -223,6 +224,8 @@ NOKPROBE_SYMBOL(native_load_idt);
  EXPORT_SYMBOL(pv_ops);
  EXPORT_SYMBOL_GPL(pv_info);

+DEFINE_STATIC_KEY_FALSE(tlb_ipi_broadcast_key);
+
  void __init native_pv_tlb_init(void)
  {
  	/*
@@ -230,10 +233,14 @@ void __init native_pv_tlb_init(void)
  	 * Otherwise, check if native TLB flush sends real IPIs to all target
  	 * CPUs (i.e., not using INVLPGB broadcast invalidation).
  	 */
-	if (pv_ops.mmu.flush_tlb_multi_implies_ipi_broadcast)
+	if (pv_ops.mmu.flush_tlb_multi_implies_ipi_broadcast) {
+		static_branch_enable(&tlb_ipi_broadcast_key);
  		return;
+	}

  	if (pv_ops.mmu.flush_tlb_multi == native_flush_tlb_multi &&
-	    !cpu_feature_enabled(X86_FEATURE_INVLPGB))
+	    !cpu_feature_enabled(X86_FEATURE_INVLPGB)) {
  		pv_ops.mmu.flush_tlb_multi_implies_ipi_broadcast = true;
+		static_branch_enable(&tlb_ipi_broadcast_key);
+	}
  }
---


Thanks,
Lance

