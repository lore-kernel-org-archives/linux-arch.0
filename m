Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD47F246768;
	Mon, 27 Apr 2026 03:39:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777261160; cv=none; b=heAU3kHp6dKFdWYb31cbjaGesjBDEi4oXpH0Y4fUUUoCDx57PLCahMyKJzpqF/8UUCwxX5EhfvCRmuLY/nqG5+3/MmUIjScJB/uPO79ssBEKDi/Mh156R7zdUoIYuwzmAKZS/FoQ+vjNVTlw9RuNJiZiocLXR2e/WpUqLUzMaB4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777261160; c=relaxed/simple;
	bh=LCn0RaEC1G+RSX7YHBiuKpju1CY4aw/B8Hwl6UvdVVs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Hw8KCTANbncFNyghUKBGfgEji1mZrOJeyCnsnNrclnKvamkfz9x/ePUJrjKfAW9vY5nDvTSJwCpzjWrfE9luMrdoeO1AQjsib+Px/6NFkXwIeRcf/TWD71sIyZSFrwIwUY4KuoDlGhQtgQTaYMHZC+H5mbv5to+hI7KR6hyA8T0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=a7iLWY4Q; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="a7iLWY4Q"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 18B641684;
	Sun, 26 Apr 2026 20:39:12 -0700 (PDT)
Received: from [10.164.148.37] (MacBook-Pro.blr.arm.com [10.164.148.37])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 956BF3F763;
	Sun, 26 Apr 2026 20:39:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1777261157; bh=LCn0RaEC1G+RSX7YHBiuKpju1CY4aw/B8Hwl6UvdVVs=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=a7iLWY4QB8QkFuzmIeDOuDWqi+s4PDrdRofCrcgpwk7g0s79ucMCB53kHVem1hj2T
	 pSQCImk33dpBgQBRs2a5GPjNO98tgnqSqiwrUjeWuJ5Tt9BG/N4hCvQsUw154sQYGh
	 pPozkR//I3ob+wI5OyOxh8kYU1kfwlNXCDM5b8RY=
Message-ID: <440a7ae5-7070-46d2-8644-3fc2fa6a707f@arm.com>
Date: Mon, 27 Apr 2026 09:08:53 +0530
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/3] vmalloc: add __GFP_SKIP_KASAN support
To: Catalin Marinas <catalin.marinas@arm.com>
Cc: arnd@arndb.de, kees@kernel.org, mingo@redhat.com, peterz@infradead.org,
 juri.lelli@redhat.com, vincent.guittot@linaro.org,
 akpm@linux-foundation.org, david@kernel.org, urezki@gmail.com,
 dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
 mgorman@suse.de, vschneid@redhat.com, ljs@kernel.org,
 Liam.Howlett@oracle.com, vbabka@kernel.org, rppt@kernel.org,
 surenb@google.com, mhocko@suse.com, tglx@kernel.org, usama.anjum@arm.com,
 mathieu.desnoyers@efficios.com, linux-arch@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-mm@kvack.org,
 Ryan Roberts <ryan.roberts@arm.com>
References: <20260424130157.3163009-1-dev.jain@arm.com>
 <20260424130157.3163009-2-dev.jain@arm.com> <aeyF-pEruWRMk5bS@arm.com>
Content-Language: en-US
From: Dev Jain <dev.jain@arm.com>
In-Reply-To: <aeyF-pEruWRMk5bS@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 25/04/26 2:44 pm, Catalin Marinas wrote:
> On Fri, Apr 24, 2026 at 06:31:55PM +0530, Dev Jain wrote:
>> diff --git a/mm/vmalloc.c b/mm/vmalloc.c
>> index b31b208f6ecb3..c94fcb2725b6b 100644
>> --- a/mm/vmalloc.c
>> +++ b/mm/vmalloc.c
>> @@ -3939,7 +3939,7 @@ static void *__vmalloc_area_node(struct vm_struct *area, gfp_t gfp_mask,
>>  				__GFP_NOFAIL | __GFP_ZERO |\
>>  				__GFP_NORETRY | __GFP_RETRY_MAYFAIL |\
>>  				GFP_NOFS | GFP_NOIO | GFP_KERNEL_ACCOUNT |\
>> -				GFP_USER | __GFP_NOLOCKDEP)
>> +				GFP_USER | __GFP_NOLOCKDEP | __GFP_SKIP_KASAN)
>>  
>>  static gfp_t vmalloc_fix_flags(gfp_t flags)
>>  {
>> @@ -3980,6 +3980,9 @@ static gfp_t vmalloc_fix_flags(gfp_t flags)
>>   *
>>   * %__GFP_NOWARN can be used to suppress failure messages.
>>   *
>> + * %__GFP_SKIP_KASAN can be used to skip unpoisoning of mapped pages
>> + * (when prot=%PAGE_KERNEL).
> 
> I just realised, if we go with this flag for vmalloc(), there's also a
> comment in gfp_types.h implying that pages are unpoisoned by
> kasan_unpoison_vmalloc() instead. This is no longer the case with this
> patch.
> 
> A VM_SKIP_KASAN flag may have been nicer but we already have
> THREADINFO_GFP and GFP_VMAP_STACK, so all those call sites would have to
> be moved to call the lower-level __vmalloc_node_range().

Yep we were discussing this only on v2, and realized the wider cleanup
is not trivial and should be made separately.

But I should change the documentation of GFP_SKIP_KASAN to say that
if it passed on to vmalloc then it will also skip unpoisoning.

> 

