Received: from out-182.mta1.migadu.com (out-182.mta1.migadu.com [95.215.58.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF2FD163
	for <linux-arch@vger.kernel.org>; Mon,  2 Feb 2026 14:29:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770042575; cv=none; b=JznM0RpWb+mRGf9gqLeOBq6YAeGu5dkhFpHq3n48syWGg97FjoASBhDOaitAU90mMnW12+FHcJzeiK6WGBi7UXUTQwsl6NM5GMhZFABrCiFKMoTD8JQlbr3qjBsF+fWn/jdtKJnZ5sfM2NnPV16IhKx2sn2JzzpX3nzoKlSK7cA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770042575; c=relaxed/simple;
	bh=nYi4m+o2VxRuDkq+4h0mjs8Svw38acK9eHCM64IveUQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CPIWSHwbPuJ9sLBY73l1Qdb+B17gEOpY7jj2Qlxzv6tStySStrJCCGCDhGm6ivSk9yUfcD7lsiJKavthFkWSFAmZ2W/KzXDrgd8YuxLMMQ4rp+vq5sK/4XHoUri1HLfgOZNABJWfp6ZZicwmQKS8D2e+HnFd0G0miPlzmYxrYUY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Xa/s9WA2; arc=none smtp.client-ip=95.215.58.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Xa/s9WA2"
Message-ID: <4a928cbe-d4d2-4af3-bb3c-e57074d385e0@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1770042570;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5LNr0+fZCzfcBa5F60oDM1uqpqeQaPLlDr7VaXJZk/g=;
	b=Xa/s9WA2Y/6hJdCO94IgSQKVCT302nt2S50MHJ9ILaoPbQLI4iZyxn5gBI4T6fGHmtVz6r
	MJz2s+U9tbczDM0Mzz/W+mR9Z6NJe/Ir1uF1+sKQ9ngTGoPzAkdG0YbaJeaIkh2GVH+Xi8
	IU0zekLg3nAy9G5jJ0xUExxfwrPFGUk=
Date: Mon, 2 Feb 2026 22:28:47 +0800
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v4 1/3] mm: use targeted IPIs for TLB sync with lockless
 page table walkers
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
References: <20260202074557.16544-1-lance.yang@linux.dev>
 <20260202074557.16544-2-lance.yang@linux.dev>
 <20260202094245.GD2995752@noisy.programming.kicks-ass.net>
 <0f44dfb7-fce3-44c1-ab25-b013ba18a59b@linux.dev>
 <20260202125146.GC1395266@noisy.programming.kicks-ass.net>
 <a79a6421-ca97-4a3f-8ec3-55e88da1ec83@linux.dev>
 <20260202134233.GG1395266@noisy.programming.kicks-ass.net>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Lance Yang <lance.yang@linux.dev>
In-Reply-To: <20260202134233.GG1395266@noisy.programming.kicks-ass.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT



On 2026/2/2 21:42, Peter Zijlstra wrote:
> On Mon, Feb 02, 2026 at 09:23:07PM +0800, Lance Yang wrote:
> 
>> Hmm... we need MB rather than RMB on the sync side. Is that correct?
>>
>> Walker:
>> [W]active_lockless_pt_walk_mm = mm -> MB -> [L]page-tables
>>
>> Sync:
>> [W]page-tables -> MB -> [L]active_lockless_pt_walk_mm
>>
> 
> This can work -- but only if the walker and sync touch the same
> page-table address.
> 
> Now, typically I would imagine they both share the p4d/pud address at
> the very least, right?

Thanks. I think I see the confusion ...

To be clear, the goal is not to make the walker see page-table writes 
through the
MB pairing, but to wait for any concurrent lockless page table walkers 
to finish.

The flow is:

1) Page tables are modified
2) TLB flush is done
3) Read active_lockless_pt_walk_mm (with MB to order page-table writes 
before
    this read) to find which CPUs are locklessly walking this mm
4) IPI those CPUs
5) The IPI forces them to sync, so after the IPI returns, any in-flight 
lockless
    page table walk has finished (or will restart and see the new page 
tables)

The synchronization relies on the IPI to ensure walkers stop before 
continuing.

I would assume the TLB flush (step 2) should imply some barrier.

Does that clarify?
