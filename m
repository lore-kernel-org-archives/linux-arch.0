Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.219.52
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793997794;
	b=frd9t7IHmruTKxqg8mF04kCL6ML+me7K5oOBUKxufB6Qi4Pi9ZHjEghM9r1pQ8ZK8uFW
	 ntFkYa28+LAm50AJMP2CxogTq0eKq+QtS/InKDWB2SLBjihFMgP6K7Ra5uFJXPmd25BT/
	 KLgW3oHZJtyTj0IjcQEH13teX2bEUxL5GfhNKDS5zde+6caAcTvNp68n+4mnr3zh3Gxjk
	 DsKoN/dvam2RQpG2P2n1kCqkcgLqBxL3f1/E1MAneq6UOg8VO8dz1I40kMKX5gqxVfBGl
	 SFKiLpsLXNhzlYIEkIbIl9Va8qOZRILkG9b2Jeod19AkNFSGQG5XK3Qy6mghPBmO5jQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793997794;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Received:Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=ws2V6VbViJ6cnrlfEDvDEs6KCs0YOuB35XjyLfjvYOA=;
	b=rqIjveGwDdUraYawUUSxJBO4On1i1Kz8df6v3U8TUHo/aR3cEcvroBQSyLmPeFPO+5Qz
	 OTt1Cd7njb5HqJa7qnmLmsKxLTViD+YofNScQJfFyPz7uGHmAHCnSvZdfhz+D0BWQaCAm
	 Kv4UTpw6mF2zEDDMVKV0NFWV3N9v8WrWBiR14XPjAHvyK0M/w9na2Cbmcy/bO4U1zZB7K
	 xWjEnuJLqOWDx4RO8F1mW+NuBocX5/u5PvuZLswdX+CxbLESDvmIalIyxtirriqxMpvIg
	 pYY6NHjIm3iRM0uKoJzqJeV3PPyiccfgsSpSPy8DjSzmA2JKoJan/VGK/wVGK3vMLjg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=ziepe.ca;
	spf=pass smtp.mailfrom=ziepe.ca;
	dkim=pass header.d=ziepe.ca header.i=@ziepe.ca header.a=rsa-sha256 header.s=google header.b=REFEyl2N;
	arc=none smtp.remote-ip=209.85.219.52
Received: from mail-qv1-f52.google.com (mail-qv1-f52.google.com [209.85.219.52])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90CC8606A329
	for <linux-arch@vger.kernel.org>; Fri,  6 Nov 2026 20:43:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 90CC8606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=ziepe.ca header.i=@ziepe.ca header.a=rsa-sha256 header.s=google header.b=REFEyl2N
Received: by mail-qv1-f52.google.com with SMTP id 6a1803df08f44-91ccfb88e4dso12465426d6.0
        for <linux-arch@vger.kernel.org>; Fri, 06 Nov 2026 12:43:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1793997792; x=1794602592; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=ws2V6VbViJ6cnrlfEDvDEs6KCs0YOuB35XjyLfjvYOA=;
        b=REFEyl2N/lgmfldAVFpxIWxQa8mjfRZ+rZu+VbJlPELmGLoAMssVZsg4Bw+JPUe95Q
         Y/+7TrhaVb742lX5HOvfYl5c8tdB9czfTvg+/vPAkrj9deCRb9o77jvOHMvRN4NFT+Us
         ybtE7N/j08Yo8TizgspuDg/xp1VtRZGq6sUf6uJV1YrIhg2qFP9g5wF57DH9VkfVQStn
         4ZNBdx9BbGLhMDmmTMxt1/LSgHH4HYRUio31WfKrQQRxXVL0B2mrBDJi7luolVdmYxxx
         r+j1ArDIDr+vUF0me32H7jSKSjODetgV3j9jw0TC5pHi0hn9wyRUYJT4xRQMphXho2hD
         k69A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793997792; x=1794602592;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ws2V6VbViJ6cnrlfEDvDEs6KCs0YOuB35XjyLfjvYOA=;
        b=yTvLkAWkGwFns6Fu9or+ew2rXfwMO5HRxzQuKLvlDrqLVPS2eaSlQGdRRIdg2IHypm
         edt5FGtbGzQu4TmAxRcmBCuip25sp2SRJ0dk1lWdSO/K+LVavBRgAJ2L9W6zSQlgxZEu
         byPoVb3KZddZasUOoLpzgk2+wBDWSn57e8ICDpYTJGwQJqsyRQL9eJJeCPfM2KaAzXSC
         5OBwoEsZH87qzC1mjulNW4Dd9HbQC01fzG4mCbiEtMn5n0G2AYrZpo48JTqndDwGfwjP
         ceFBcrw1N81Y7ojC26V2c0JvimXIJKMsWJftwrXNchZIKyMya5mdWTRGaQm1XURttOSi
         PHOg==
X-Forwarded-Encrypted: i=1; AL+hErGM0/rRNzY0ga2VocrIFBItqLIFhcYSC2t5D9MQaZGTPZQUh5AWvDVmKENTwPUJFVpW1exGW6SAYsnC@vger.kernel.org
X-Gm-Message-State: APuU4Z9X0EYJwP3nOh9Ue2fzK6qDQmzKRvYXcjvh9QfnAP8cvTQqhwG8
	MLueBjq7OjDstxeLPDwcopiYpS6yitopuFB2hRc+GlWNgEV/HpM18JMpCSy9qr4euvY=
X-Gm-Gg: AYBFou1qBbXDKBZSJ509k5BJVgilh0YZ1qJEQVlXY4X7ZxyTIGRCundb8fVuIi8v83X
	pjcN9VS60fZdLYlV+gYesGliDbl67jOj6K1qisUs3jJj120RhQg3gnzAaV+WGAAETWr1UP3gCFR
	uLWsvDRp6vlLPUDNWcl4zNJ74xK16CZthbNWkESI+QVPM0VVIY1Rg+5XcK1jMANfIUqtxi5oPDd
	vnFxFkhoMBSLyJMvnPe2q+oF/nnovNkOHx5Au6LupneaH33INlnU99GuDagY3a4jhXCi4sDwVwa
	Iyh9xsRIns8+FwnFx3m9x/3OTtYcOYPEnpXaZhgTqQhrh9FRDMcgrSO/AeKMZwYQn5dvt6/Rohg
	F3N24lLDBbphN/hTdQsg8cODghdWf+x7fUV76lKkwZ3OucfxXHdGMIpnTwtErP9mjGNXoWK4z5B
	4vXfJHETmrC8YNcQM2vJ7nFU/mjarj/kbzjdWV8sQrdcRjL/EnfpOw561+p+xgQPh1AMW7iwR7u
	M4ySuMhWb8soa1w8Sr+j77mtzXvRup3nHUclmqR9t1D51JipOw8bqPgzSXqH1RLIapYne2lkaCg
	BLr8G8rcpIQxoFhegGn+MzHRqc3oy6nD35r89cDoolS2g/YrBTlgJTzdliiL59sBAsBBkf5NJGu
	s5s0KxtNxgA==
X-Received: by 2002:ad4:4ee5:0:b0:91e:a5c2:37f7 with SMTP id 6a1803df08f44-91ea97a22b7mr53003846d6.42.1793997792129;
        Fri, 06 Nov 2026 12:43:12 -0800 (PST)
Received: from ziepe.ca (hlfxns010zw-159-2-239-150.pppoe-dynamic.high-speed.ns.bellaliant.net. [159.2.239.150])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-91ea6a2c742sm29232026d6.11.2026.11.06.12.43.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Nov 2026 12:43:11 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1xPQmE-00000007ent-3ktJ;
	Fri, 06 Nov 2026 16:43:10 -0400
Date: Fri, 6 Nov 2026 16:43:10 -0400
From: Jason Gunthorpe <jgg@ziepe.ca>
To: "David Hildenbrand (Arm)" <david@kernel.org>
Cc: Josef Bacik <josef@toxicpanda.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Lorenzo Stoakes <ljs@kernel.org>,
	"Liam R. Howlett" <liam@infradead.org>,
	Vlastimil Babka <vbabka@kernel.org>,
	Mike Rapoport <rppt@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Michal Hocko <mhocko@suse.com>,
	"Matthew Wilcox (Oracle)" <willy@infradead.org>,
	Jan Kara <jack@suse.cz>, Zi Yan <ziy@nvidia.com>,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	Nico Pache <nico.pache@linux.dev>,
	Ryan Roberts <ryan.roberts@arm.com>, Dev Jain <dev.jain@arm.com>,
	Barry Song <baohua@kernel.org>, Lance Yang <lance.yang@linux.dev>,
	Usama Arif <usama.arif@linux.dev>, Kiryl Shutsemau <kas@kernel.org>,
	Matthew Brost <matthew.brost@intel.com>,
	Joshua Hahn <joshua.hahnjy@gmail.com>,
	Byungchul Park <byungchul@sk.com>,
	Gregory Price <gourry@gourry.net>,
	Ying Huang <ying.huang@linux.alibaba.com>,
	Alistair Popple <apopple@nvidia.com>, Peter Xu <peterx@redhat.com>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Song Liu <songliubraving@fb.com>, Rik van Riel <riel@surriel.com>,
	Hugh Dickins <hughd@google.com>, Will Deacon <will@kernel.org>,
	"Aneesh Kumar K.V" <aneesh.kumar@kernel.org>,
	Nick Piggin <npiggin@gmail.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Kevin Tian <kevin.tian@intel.com>,
	"Joerg Roedel (AMD)" <joro@8bytes.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Steve Sistare <steven.sistare@oracle.com>,
	John Hubbard <jhubbard@nvidia.com>, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	linux-arch@vger.kernel.org, iommu@lists.linux.dev,
	stable@vger.kernel.org
Subject: Re: [PATCH 2/5] mm: limit pagecache folio refcount when splicing
 into pipes
Message-ID: <20261106204310.GK663069@ziepe.ca>
References: <20261105-refcount_overflow_stable-v1-0-70b9c655da3e@kernel.org>
 <20261105-refcount_overflow_stable-v1-2-70b9c655da3e@kernel.org>
 <n3l2cnx6d25jovloqyoxiz566mh62janclmiewjvumtmqfezo7@zmsmco5vvssn>
 <23f947e2-ff06-426d-adb7-396871304736@kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Post: <mailto:linux-arch@vger.kernel.org>
List-Help: <mailto:linux-arch+help@vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-arch+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <23f947e2-ff06-426d-adb7-396871304736@kernel.org>

On Fri, Nov 06, 2026 at 09:09:10PM +0100, David Hildenbrand (Arm) wrote:
> On 11/6/26 18:58, Josef Bacik wrote:
> > On Thu, Nov 05, 2026 at 02:10:11PM +0100, David Hildenbrand (Arm) wrote:
> >> Similar to mapping pagecache folios into page tables, let's reject splicing
> >> folios into a pipe if the refcount is at it's limit, similar to how we
> >> handle it during GUP.
> >>
> >> This will prevent more cases of possible folio refcount overflows with
> >> large pagecache folios.
> >>
> >> Let's keep it simple and check in the two callers of
> >> splice_folio_into_pipe().
> >>
> >> Also check in try_get_page() to cover pipe-buffer duplication by tee()
> >> and partial pipe-to-pipe splicing.
> >>
> >> Fixes: 800d8c63b2e9 ("shmem: add huge pages support")
> >> Fixes: 99cb0dbd47a1 ("mm,thp: add read-only THP support for (non-shmem) FS")
> >> Fixes: 793917d997df ("mm/readahead: Add large folio readahead")
> >> Cc: stable@vger.kernel.org
> >> Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>
> >> ---
> >>  include/linux/mm.h | 9 ++++++---
> >>  mm/filemap.c       | 4 ++++
> >>  mm/shmem.c         | 4 ++++
> >>  3 files changed, 14 insertions(+), 3 deletions(-)
> >>
> >> diff --git a/include/linux/mm.h b/include/linux/mm.h
> >> index 79ae8fc0d6bb4..a82cfbce18215 100644
> >> --- a/include/linux/mm.h
> >> +++ b/include/linux/mm.h
> >> @@ -2287,10 +2287,13 @@ static inline void get_page(struct page *page)
> >>  
> >>  static inline __must_check bool try_get_page(struct page *page)
> >>  {
> >> -	page = compound_head(page);
> >> -	if (WARN_ON_ONCE(page_ref_count(page) <= 0))
> >> +	struct folio *folio = page_folio(page);
> >> +
> >> +	if (WARN_ON_ONCE(folio_ref_count(folio) <= 0))
> > 
> > Since you're here anyway can you change this to something other than
> > WARN_ON_ONCE, since that results in an OOPS with panic_on_warn set?
> > Thanks,
> 
> If it actually turns negative (or 0) with out changes, we had an overflow and
> for sure want to know about it :)

Yeah, didn't you get Docs merged to clarify WARN_ON is fine if
userspace can't trigger it?

If you use panic_on_warn you *WANT* your system to stop if it detects
corruption, that's the whole point. Removing corruption detection so
panic doesn't trigger is pure 100% nonsense.

This keeps coming up and it's frustrating to go over again and again.

Jason
