Received: from out-172.mta1.migadu.com (out-172.mta1.migadu.com [95.215.58.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BD0D1C5D44
	for <linux-arch@vger.kernel.org>; Tue, 24 Feb 2026 02:06:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771898789; cv=none; b=deRKXYbLcsN0lh5Xoef/KGihjO5/Z94kDq+b4K0w2ha4MB2Idnvk3gHEcBVsYmQS1IvltNoRdc/iJRGgz3xHiaj5w5L/7VbCnzmouYK6MxTPVyxpYYSinPvTtZFYh1zWXENJIBfA5vDy+8QmRmX3w8gYpwUFH5gbkz+r2ns8X4g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771898789; c=relaxed/simple;
	bh=9cmN57YEF/nHPX0nb+nzMP1y9QEZjX8MK7/oUFRKFeE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=I7JcK3/UpiZ1vFPbCPF26tvlF4PIsYE7GD/rnNdj/9B5RqTuJVUkBQWMytGv4/klwpK/9zljReci/XqpVO1uY9sKwTCz5rdrj/1vln5nvffg94mRO0JdYMErKDK6r/IuWBIo426YaF+f7o3S6I1rKHOKge7w8TkU8txw3CwAs5g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=G0ds5akF; arc=none smtp.client-ip=95.215.58.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="G0ds5akF"
Message-ID: <26ffb92e-1e62-4e1a-b31b-465a882c2ec4@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1771898786;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=pGujA8hS1VQqUbv75LvcnfS357Yi5nLYG7BGVulGCoI=;
	b=G0ds5akFrIA0kgIZ2TZoxRkmowm+ZNSacUP47Irv3kLMysJFvnDZftaxaHKh2dE6U+NnpP
	7ZFsSIjaM4xzt/2/0qIRBSqHS9pHEfEftOm+ah+xqpMHoIjm7AHkAfNJnJz3lG19xt0g/w
	ncDUJzbnENjBnHnqWzlDZ1arS7Cqw9g=
Date: Tue, 24 Feb 2026 10:06:13 +0800
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH 1/1] mm/mmu_gather: replace IPI with synchronize_rcu()
 when batch allocation fails
To: Dave Hansen <dave.hansen@intel.com>
Cc: akpm@linux-foundation.org, aneesh.kumar@kernel.org,
 linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-mm@kvack.org, npiggin@gmail.com, peterz@infradead.org,
 will@kernel.org, david@kernel.org
References: <2a6c4e62-1663-4a98-9adc-406a6a1ebfd3@kernel.org>
 <20260223125826.28207-1-lance.yang@linux.dev>
 <a0c434c4-ec65-4a37-9422-5614249124bc@intel.com>
 <1373db93-3977-425f-ad59-5970e7e50b48@linux.dev>
 <c348453a-6a1f-43e4-acbb-02bbeb2ce805@intel.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Lance Yang <lance.yang@linux.dev>
In-Reply-To: <c348453a-6a1f-43e4-acbb-02bbeb2ce805@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT



On 2026/2/24 00:35, Dave Hansen wrote:
> On 2/23/26 08:29, Lance Yang wrote:
>>
>> Note: Use this when code really needs to wait for synchronization,
>> *not* for freeing memory. Memory freeing should use RCU callbacks
>> that don't cause latency spikes in this thread.
> 
> Yeah, but I'd probably mix it in with the other chit chat about
> non-atomic contexts. I'd also make it something like:
> 
> 	Do not use for freeing memory. Use RCU callbacks instead to
> 	avoid latency spikes.
> 
> to make the commands clear.

Got it, thanks. I'll update it in v2.
