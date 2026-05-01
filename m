Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7F6872622;
	Fri,  1 May 2026 07:07:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777619279; cv=none; b=FlqAIz9t1DhkfZ7n9JF6nwgST6I3gdxgPZJS3Io4Ea3gopysvmY3MONm7nc0hPduAFs3zfIOJlq32JEnWJGGaUtYS4n1+Djh0i8ir9/Fo1RXbZ4tniYuEsGftW3E6OlklxQVMcLBXa0cT0KoF4iR2RLQkmE/LBBdiCT3RxQdF84=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777619279; c=relaxed/simple;
	bh=epgThRWo7zS+qWmwPbDJ5PG4Q9G1rxWn4n0y5BifbUg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SqRG6//3IohWNJSXOPtyy5xAY2ClJzDHIh1EN/KAK5a/kNGU4uhDTECii4KCgfFxpY02YQCRIkmkPjGzIGKgbtHFwTzRluEkbtPeYBXSxN0Gm3SDFZi5KNJtbCTdFF9RzFBnF67gnF1F7vUSLhF7s/FMogevVRk6JMjOP9kYdxk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ORtiKrhy; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ORtiKrhy"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 02066C2BCB7;
	Fri,  1 May 2026 07:07:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777619279;
	bh=epgThRWo7zS+qWmwPbDJ5PG4Q9G1rxWn4n0y5BifbUg=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=ORtiKrhy9dQ7aJ6eNDoOyGh/r29yIWz8o4UuwJqiwXIdGOvGO+6U72J2GUMD3ec91
	 V6m7B/tDiTW7v12gJFf0MTXVDSU8OJS21pstXmrIdFDVjKM4YNqok2BKnca0UdC83f
	 XrNglRxq8nVD3uDqHnAbM2zhIn6ta+qnoBVuQCiQalWSTU7E9Gw3Bo2VGk0jaqmanQ
	 XgXYmdx+/lIXs3TA8PzHjKr0NlLNkV0P29tkqgdaSmYmdoAec/BRZhj3f5RDfTBluZ
	 JZcoI5Eg71bzQjkmZ2TO90k8tgsG4S+bYf1VtvkhfwPQKfq3jriHCIVrrZRKyk9EPv
	 ogGVMMcEAP2gQ==
Message-ID: <b5379cd3-f7bf-47f9-8a60-c7300b4415a2@kernel.org>
Date: Fri, 1 May 2026 09:07:49 +0200
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/5] mm: Support selecting doing direct COW for anonymous
 pmd entry
To: Luka Bai <lukafocus@icloud.com>, linux-mm@kvack.org
Cc: Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>,
 Andrew Morton <akpm@linux-foundation.org>, Lorenzo Stoakes <ljs@kernel.org>,
 Zi Yan <ziy@nvidia.com>, Baolin Wang <baolin.wang@linux.alibaba.com>,
 "Liam R. Howlett" <liam@infradead.org>, Nico Pache <npache@redhat.com>,
 Ryan Roberts <ryan.roberts@arm.com>, Dev Jain <dev.jain@arm.com>,
 Barry Song <baohua@kernel.org>, Lance Yang <lance.yang@linux.dev>,
 Vlastimil Babka <vbabka@kernel.org>, Mike Rapoport <rppt@kernel.org>,
 Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>,
 Jann Horn <jannh@google.com>, Arnd Bergmann <arnd@arndb.de>,
 Kairui Song <kasong@tencent.com>, linux-kernel@vger.kernel.org,
 linux-arch@vger.kernel.org, linux-doc@vger.kernel.org,
 Luka Bai <lukabai@tencent.com>
References: <20260501-thp_cow-v1-0-005377483738@tencent.com>
From: "David Hildenbrand (Arm)" <david@kernel.org>
Content-Language: en-US
Autocrypt: addr=david@kernel.org; keydata=
 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
 qIws/H2t
In-Reply-To: <20260501-thp_cow-v1-0-005377483738@tencent.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 5/1/26 07:55, Luka Bai wrote:

Hi,

> Copy on write support for anonymous pmd level THP is simple right now:
> firstly we'll check whether the folio can be exclusively used by the
> faulting process, if we can (when the ref of the folio is only 1 after
> trying to free swapcache or the page flag AnonExclusive is setup) we'll
> directly use it with few further handling. If we cannot, then we'll
> split the pmd into 512 4K ptes, and do copy on write only for the
> specific 4K page that we faulted on.
> 
> This logic is truly memory efficient since for most workloads we don't
> want to allocate 2M new memory simply on a small write. However, it also
> makes the original 2M page for the process suddenly splitted on a
> write which will generate some performance thrashing. For example, if
> process A and process B share an anonymous 2M pmd, if process B chooses
> to do a writing, then its page table mapping will be changed from 1
> pmd entry into 512 4K pte entries at once, so the tlb benifit will
> suddenly just "vanish" for process B, which sometimes may cause a
> observable performance degeneration. After that, we can only wait for
> khugepaged to do the collapse for this area and merge the pmd back, which
> is not easy to happen.

You probably know that, historically, we did exactly what you describe in this
patch set. It was rather bad regarding memory waste and COW latency, so we
switched to the current model.

Note that there was a recent related discussion for executable, which was rejected:

https://lore.kernel.org/r/20251226100337.4171191-1-zhangqilong3@huawei.com

> 
> In addition to the problem above, this logic can also generate some
> deficiency for THP itself. Currently THP is just a "best-effort" choice
> with no "certainty". THP is easily splitted into multiple small pages
> on common calling path like reclaiming, COW. A transparent splitting
> can cause throughput fluctuation for some workloads. For these workloads,
> we may want to give THP some "certainty" just like hugetlbfs,

There are no such guarantees, though. And We wouldn't want to commit to any such
guarantees today. For example, simple page migration can split the folio.
Allocation failures will fallback to small pages etc.

If you need guarantees, use hugetlb for now.

> The effect
> we want is: after some customized setup, if only the system has usable
> folio, and the virtual memory alignment permits (or we setup to), we can
> make sure we always use THP for it, the system will never split it except
> the user wants to do so.
> 
> This patchset is about both two things above, firstly we add pmd level
> THP COW support by revising the code in do_huge_pmd_wp_page, we added
> switch for it because different workloads may need different resources,

The switch is bad, and we won't accept any toggle like that. A system-wide
setting does not make sense for such behavior.

A per-VMA flag? Maybe, but I expect pushback as well, as it is way too specific.
So we'd have to find some concept that abstracts these semantics. But I expect
pushback as well.

We messed up enough with toggles in THP space, unfortunately.

Also, anything that only works for PMD-sized THPs is a warning sign in 2026 :)

You don't really raise any concrete use cases or performance numbers for these
use cases. Some details about applications that use fork() and rely on such
behavior would be helpful.

Note that an application that does fork() could use MADV_COLLAPSE after fork()
to make sure that it immediately gets THPs back.

There is also the option to just use MADV_DONTFORK to not even share ranges with
a child process in the first place, avoiding page copies entirely.

-- 
Cheers,

David
