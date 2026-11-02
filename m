Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=95.215.58.37
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793595487;
	b=ETfw1kH6gxywnhKtoi7+Tzjt1gtUneaBYOUVbYbwyy6ewSMMMx63tGj5W3l/Yxz/MaVk
	 WC3CMUgmsHGJlNCVBun6pKAkIjq3kwB4kXZ7Hm8+xR82XMCn9rZYsjGGJrvYb6ckIx44B
	 qC+KkR6bW6lHI3SIb8P6x3ydH1FbnGtjOXQVqnh7YLsEvnXMHNd2KkEVYu843H20Q3HUL
	 mxO84lkqsNG6DHeDl+SEkRi2S2sHsrCceRLGDjPYoqvssb4Q/JlhfGd4ZjISGgh1+7jSU
	 V5CVMhYUyUaiu8sHuG7EHBMluBNa6Wa/n6hW7H0N+X/VkQZKPCvSlIzWfMy+d+eUuHA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793595487;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=VjEa8aUzoMl3SYNFpAhF7zUKPZ6wHLLQaYP9asa0BH0=;
	b=U32KJ8Z3/YOKAzpkW4ZCG2e2E5UOYh/ZxVbjoqHazW+cdcNmRSOof9SSMZbzRyNCigrC
	 It5tsCMPuECv7Y2pHoLDAJlUbY2Fe/pj/3arcWeFNo0v/ols0dbpEyIZK1UOPRVlClaYI
	 kfpyM7Sth8LMWbhub/D/8ewAr6KMlpnsm8C70tyS+bJo/9Htt3/INmH754fJ4lZnNkS1X
	 mUTIBIwofq4Q6PQDzGT0dOlSEcL/yadzoU4vsBFSnN9xVBeIxJoZMGX9L+WeIkpYXIK6C
	 yJgLNpvTRrZ4ax/JG1q6e0NAl4hqKHwhm8HwJ7AUKYFZCCASdQCAcbaptxi9sFw/lFA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b="Hd5/4EfZ";
	arc=none smtp.remote-ip=95.215.58.37
Received: from mta1.migadu.com (out-37.mta1.migadu.com [95.215.58.37])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D1E8606A327
	for <linux-arch@vger.kernel.org>; Mon,  2 Nov 2026 04:58:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2D1E8606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=Hd5/4EfZ
X-Envelope-To: linux-arch@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=VjEa8aUzoMl3SYNFpAhF7zUKPZ6wHLLQaYP9asa0BH0=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1793595483; v=1; x=1794200283;
 b=Hd5/4EfZTqDJhoJQj3RsxtDVnqKy1aamG9WHQGlhuYDbiUFMRMuVUh4U5WZxWeDr/5mCNBgn
 FHjhJk19Z2BSSg+yJ71g766NnsgHdRSQLGkOUEsKwe+DVjg5v3ia4eonJn1QqSAdzJyZEe1pud3
 zdEAiA5fQmMfolu9HsRAjM9w=
X-Envelope-To: linux-arch@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 36faa33dfd74c51c;
	Mon, 02 Nov 2026 04:58:02 +0000
X-Mizu-Trace-ID: 36faa33dfd74c51c
X-Migadu-Flow: FLOW_OUT
From: Lance Yang <lance.yang@linux.dev>
To: david@kernel.org
Cc: akpm@linux-foundation.org,
	hannes@cmpxchg.org,
	mhocko@kernel.org,
	qi.zheng@linux.dev,
	shakeel.butt@linux.dev,
	ljs@kernel.org,
	kasong@tencent.com,
	baohua@kernel.org,
	axelrasmussen@google.com,
	yuanchu@google.com,
	weixugc@google.com,
	baoquan.he@linux.dev,
	baolin.wang@linux.alibaba.com,
	liam@infradead.org,
	vbabka@kernel.org,
	rppt@kernel.org,
	surenb@google.com,
	mhocko@suse.com,
	kees@kernel.org,
	peterz@infradead.org,
	jannh@google.com,
	pfalcato@suse.de,
	hughd@google.com,
	pasha.tatashin@soleen.com,
	pratyush@kernel.org,
	willy@infradead.org,
	jack@suse.cz,
	ziy@nvidia.com,
	lance.yang@linux.dev,
	riel@surriel.com,
	harry@kernel.org,
	apopple@nvidia.com,
	nico.pache@linux.dev,
	ryan.roberts@arm.com,
	dev.jain@arm.com,
	usama.arif@linux.dev,
	kas@kernel.org,
	matthew.brost@intel.com,
	jhubbard@nvidia.com,
	peterx@redhat.com,
	will@kernel.org,
	aneesh.kumar@kernel.org,
	npiggin@gmail.com,
	osalvador@suse.de,
	minchan@kernel.org,
	muchun.song@linux.dev,
	xu.xin@linux.dev,
	chengming.zhou@linux.dev,
	chrisl@kernel.org,
	shikemeng@huaweicloud.com,
	nphamcs@gmail.com,
	youngjun.park@lge.com,
	gourry@gourry.net,
	joshua.hahnjy@gmail.com,
	rakie.kim@sk.com,
	ying.huang@linux.alibaba.com,
	jgg@ziepe.ca,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	kexec@lists.infradead.org,
	linux-fsdevel@vger.kernel.org,
	linux-arch@vger.kernel.org,
	linux-cxl@vger.kernel.org,
	josef@toxicpanda.com,
	stable@vger.kernel.org,
	usama.anjum@arm.com
Subject: Re: [PATCH v3 15/47] mm/khugepaged: always recheck the pmd in try_collapse_pte_mapped_thp()
Date: Mon,  2 Nov 2026 12:57:53 +0800
Message-ID: <20261102045753.34901-1-lance.yang@linux.dev>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20261031-fixes_core-v3-15-d6437171ecc3@kernel.org>
References: <20261031-fixes_core-v3-15-d6437171ecc3@kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Post: <mailto:linux-arch@vger.kernel.org>
List-Help: <mailto:linux-arch+help@vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-arch+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit


On Sat, Oct 31, 2026 at 10:39:44AM +0100, David Hildenbrand (Arm) wrote:
>From: Josef Bacik <josef@toxicpanda.com>
>
>try_collapse_pte_mapped_thp() drops the PTE lock after it has cleared the
>page table, and takes the PMD lock and the PTE lock to remove it.
>
>In between, MADV_DONTNEED with CONFIG_PT_RECLAIM can reclaim the
>page table. The pmd_same() check is supposed to handle this, but it is
>only done with CONFIG_SPLIT_PTE_PTLOCKS.
>
>Fix it by performing the check unconditionally.
>
>Fix generated by an LLM and sent by Josef Bacik in private.
>
>Fixes: 6375e95f381e ("mm: pgtable: reclaim empty PTE page in madvise(MADV_DONTNEED)")
>Cc: stable@vger.kernel.org
>Signed-off-by: Josef Bacik <josef@toxicpanda.com>
>[ david: adjust description ]
>Reviewed-by: Gregory Price (Meta) <gourry@gourry.net>
>Tested-by: Gregory Price (Meta) <gourry@gourry.net>
>Tested-by: Muhammad Usama Anjum <usama.anjum@arm.com>
>Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>
>---

Nothing jumped out at me, so:

Reviewed-by: Lance Yang <lance.yang@linux.dev>
