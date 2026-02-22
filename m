Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7029352F87
	for <linux-arch@vger.kernel.org>; Sun, 22 Feb 2026 19:42:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771789323; cv=none; b=PA3kxnjkl2R//roMcY9FzciwiSgn9ynFq3feD/6nUPQ5WmdybDA7ZOr7B1LuK6K4BOxNhU0pwIOwB+QlYWo7jhFaLDMilCjUKV9sNrcFmQMlUIlmYmBV6dUORkP6izj7a16NHccCIXC0dqeLZdYMIOYsO6AIHuW7HtlEz/y6nEA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771789323; c=relaxed/simple;
	bh=WSWutob4EOAt5DkaggBIrCV8MoWbhp++zfA32xz8roc=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=SRheQClbnxyJDWKLe6HHMfY6KUdXvGqAVn4Wdt1UAOtu3ccOyJcpbHs648EJ5jUkswbc8hTj4AqYqRU3eQ00aDlG34ddpBHizgzaDql3na29DolmiemWDfMlOaQo+tk4lr/f2FG2kR2LGuAf4bonnSiBMGxZSdLKzV1wOa3DSvA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=t1KLx/Nd; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="t1KLx/Nd"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 35D40C116D0;
	Sun, 22 Feb 2026 19:42:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1771789322;
	bh=WSWutob4EOAt5DkaggBIrCV8MoWbhp++zfA32xz8roc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=t1KLx/NdrNsWfrGrfuTViwSseXvCj72+/EPMEMP3/KwAxs1cYn9RV823rHFgsBmi5
	 UvvyQ/UGaVRoFpZoVzVZhpfp94aqoQABL4891Q/kvGyYENNSw36h4BjGE2Nd7vzsy2
	 iHpAqjPkGWZyawz7rhr4NREdKl1PlOSMr44ZcnRE=
Date: Sun, 22 Feb 2026 11:42:01 -0800
From: Andrew Morton <akpm@linux-foundation.org>
To: Wei Yang <richard.weiyang@gmail.com>
Cc: will@kernel.org, aneesh.kumar@kernel.org, npiggin@gmail.com,
 peterz@infradead.org, linux-arch@vger.kernel.org, linux-mm@kvack.org, Qi
 Zheng <qi.zheng@linux.dev>, "David Hildenbrand (Arm)" <david@kernel.org>
Subject: Re: [PATCH] mm/mmu_gather: define RCU version
 tlb_remove_table_one() in CONFIG_MMU_GATHER_RCU_TABLE_FREE
Message-Id: <20260222114201.095379dd766b68dcecbab1c5@linux-foundation.org>
In-Reply-To: <20260222004512.839-1-richard.weiyang@gmail.com>
References: <20260222004512.839-1-richard.weiyang@gmail.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun, 22 Feb 2026 00:45:12 +0000 Wei Yang <richard.weiyang@gmail.com> wrote:

> Before commit 718b13861d22 ("x86: mm: free page table pages by RCU
> instead of semi RCU"), the page table pages will be freed by semi RCU,
> that is:
> 
>   - batch table freeing: asynchronous free by RCU
>   - single table freeing: IPI + synchronous free
> 
> This commit introduce a RCU version for single table freeing to support
> PT_RECLAIM. While it is not necessary to limit the RCU version only in
> CONFIG_PT_RECLAIM. It is reasonable to asynchronous free single table by
> RCU if CONFIG_MMU_GATHER_RCU_TABLE_FREE.
> 
> This patch moves the definition of single table freeing in
> CONFIG_MMU_GATHER_RCU_TABLE_FREE, so we have both RCU version
> batch/single table freeing if CONFIG_MMU_GATHER_RCU_TABLE_FREE.

What are the expected (and measured!) benefits of this?


