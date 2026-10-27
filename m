Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793130082;
	b=XyPAVyl6vmPN82Z4hEvSFe9Bgsok68afNEBxwEwGLllhKta98xbEYCfiKOQQ+xfiwsLo
	 yHuNtO7Tc0nGxigVTHYfqSPqojkob/OoVQ6Xof34n5WtDPNcDvcppp0cu0gixiOwiAaDz
	 2LsyDbcNerea3+bg4DICQvwm72ZRWkyewQLkVRnJDODBGnSIhWa5uxefZH6agNnkGmEF2
	 1RdHIJKasHwQ0K+sllfdFB4AFwiFsrKMtwqMREvR2YsrOrd0IOM0rlS+bKb7a6KTEqvjK
	 PdR2M1zNshfR7QqCdHz9sP4ZNgOMGDtXvbALRsKyKxMqiQMjscMoAaCfBSM17bhMILw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793130082;
	h=Received:DKIM-Signature:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:To:Cc:References:From:Content-Language:Autocrypt:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding;
	bh=0sFGvmgrvvdqPTtpY3ePN/YlR7rZ5HGLPPKOD8BQTbo=;
	b=3ZE9xJQQFL6uTzgEp6ERqCbU7m/O5asR7myd2CQeDGV3ZqglJoSkhPyUDsDUSsI3e2C4
	 nwJgJMGq6Wy/ChdhNcDjTZcQasIv/rnbxZuHv9xvWRm3rjJ8LWo9gVidV7GY46g7xdPLV
	 AHVH67GrpSPH3QUgkBaiNRv6uPAA02hQYqXmdRI7JAf4Evw345jL1ynXoTzFa4tj9qnzs
	 tgnJ5+RmrV1r77yZDOubR9ju7+cbfSE90DBhJLS1S9QlwuLQCT1GQKL2O+5ZxxURKDvLF
	 whQBRydEPcDBY1wkaihWLYHXVMD+Ggq8O5N/H3cC4PO5l2Ot9w0RZbpHEBuJH7D1zjQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=KUqg9k85;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F47F606A31A;
	Tue, 27 Oct 2026 19:41:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=KUqg9k85
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4BE191F01825;
	Tue, 27 Oct 2026 19:41:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793130081;
	bh=0sFGvmgrvvdqPTtpY3ePN/YlR7rZ5HGLPPKOD8BQTbo=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=KUqg9k85dXedpUxZlyCn3ouG4WACyQDbub3inF4OVMYoH5feG4/NNiPbptLeRhegn
	 SKw5wGbktOA7voLurZSAAgcuGFDFKzI0FM86U2UBPnHevtJL/EuTxW2KUq2JxeRzJN
	 5nmLyyESp6PMWhbXHarGTEtcNTKzLJNtMpjSX/IzCHpl7qWjhYf9YDX4fIHuu9q7XY
	 mXGKpCuLXFlzWTVByl9zw3cGL7GPSTFExRV9Q1oPtXh+YFoKSgzPvy/Y9up7fXsUPY
	 3xntQC4/GuQ64zNpykYrG0yZFoewu/pYCR6VED14ZnMVxIwO2hUi86jK1fgzMFZNXa
	 DjwyYVSOD4Jhw==
Message-ID: <87e3d64e-8b25-4d51-a984-7ab8a58f785d@kernel.org>
Date: Tue, 27 Oct 2026 20:41:02 +0100
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Post: <mailto:linux-arch@vger.kernel.org>
List-Help: <mailto:linux-arch+help@vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-arch+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 32/46] mm/memory_hotplug: avoid races in
 pfn_to_online_page() with dying pgmap
To: Lance Yang <lance.yang@linux.dev>
Cc: akpm@linux-foundation.org, hannes@cmpxchg.org, mhocko@kernel.org,
 qi.zheng@linux.dev, shakeel.butt@linux.dev, ljs@kernel.org,
 kasong@tencent.com, baohua@kernel.org, axelrasmussen@google.com,
 yuanchu@google.com, weixugc@google.com, baoquan.he@linux.dev,
 baolin.wang@linux.alibaba.com, liam@infradead.org, vbabka@kernel.org,
 rppt@kernel.org, surenb@google.com, mhocko@suse.com, kees@kernel.org,
 peterz@infradead.org, jannh@google.com, pfalcato@suse.de, hughd@google.com,
 pasha.tatashin@soleen.com, pratyush@kernel.org, willy@infradead.org,
 jack@suse.cz, ziy@nvidia.com, riel@surriel.com, harry@kernel.org,
 apopple@nvidia.com, nico.pache@linux.dev, ryan.roberts@arm.com,
 dev.jain@arm.com, usama.arif@linux.dev, kas@kernel.org,
 matthew.brost@intel.com, jhubbard@nvidia.com, peterx@redhat.com,
 will@kernel.org, aneesh.kumar@kernel.org, npiggin@gmail.com,
 osalvador@suse.de, minchan@kernel.org, muchun.song@linux.dev,
 xu.xin@linux.dev, chengming.zhou@linux.dev, chrisl@kernel.org,
 shikemeng@huaweicloud.com, nphamcs@gmail.com, youngjun.park@lge.com,
 gourry@gourry.net, joshua.hahnjy@gmail.com, rakie.kim@sk.com,
 ying.huang@linux.alibaba.com, jgg@ziepe.ca, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, kexec@lists.infradead.org,
 linux-fsdevel@vger.kernel.org, linux-arch@vger.kernel.org,
 linux-cxl@vger.kernel.org, josef@toxicpanda.com
References: <20261027-fixes_core-v1-32-6f74bec9a5bb@kernel.org>
 <20261027121307.40431-1-lance.yang@linux.dev>
From: "David Hildenbrand (Arm)" <david@kernel.org>
Content-Language: en-US
Autocrypt: addr=david@kernel.org; keydata=
 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
 qIws/H2t
In-Reply-To: <20261027121307.40431-1-lance.yang@linux.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

> LLM stumbled upon a possible race in kpage_read() ... 
> 
> Say the reader passes pfn_section_valid() for a device PFN in a section
> shared with online RAM, gets preempted, and resumes after
> pgmap_array_delete(). We'd then find no pgmap and return pfn_to_page(pfn),
> even though the subsection is no longer valid ...

I think that's similar to our pfn_to_online_page() vs. memory offlining races,
just slightly different. Getting these races down to 0 is pretty hard.

This patch here tries to do better and arguably almost looks like a cleanup.

I wouldn't worry about that one for now; it's extremely unlikely to hit. And it'

> 
> Could we take the memory hotplug read lock in kpage_read(), covering both
> the lookup and the metadata reads? We can drop it before put_user(), once
> we're done with the page.
> 
> Maybe along these lines?
> 
> ---8<---
> diff --git a/fs/proc/page.c b/fs/proc/page.c
> index 6aa99e42ec22..12bed36d76dc 100644
> --- a/fs/proc/page.c
> +++ b/fs/proc/page.c
> @@ -12,6 +12,7 @@
>  #include <linux/hugetlb.h>
>  #include <linux/memremap.h>
>  #include <linux/memcontrol.h>
> +#include <linux/memory_hotplug.h>
>  #include <linux/mmu_notifier.h>
>  #include <linux/page_idle.h>
>  #include <linux/kernel-page-flags.h>
> @@ -77,6 +78,8 @@ static ssize_t kpage_read(struct file *file, char __user *buf,
>  	count = min_t(unsigned long, count, (max_dump_pfn * KPMSIZE) - src);
> 
>  	while (count > 0) {
> +		/* Prevent memory removal while inspecting the memmap. */
> +		get_online_mems();
get_online_mems() is the big hammer we try to avoid (or ideally remove at some
point). And it's most pfn_to_online_page() users that are affected.

A seqcount in pfn_to_online_page() could detect concurrent pgmap removal and
retry from the start. But I'd rather delay something like that.

Thanks for taking a look! (Can I convince you to review some of the THP fixes?
pleeeeaaasseee :) )

-- 
Cheers,

David
