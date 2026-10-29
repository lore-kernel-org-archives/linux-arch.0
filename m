Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=95.215.58.60
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793245192;
	b=WIOt52XaGTPHwoovRxgGd8pJhAJrbGV117/WiulVQ0VYeB4AlBLupI7wJORYbLFBjUEo
	 cRvYeHZihLN1qVWTzXo5brC96GeYJVfudsWeVZ7SOpo9xYLQAYkEfJq0ARycTj/1dubym
	 smKpxczXe0JgTOCqiCETDS/hnqPKuUcUnzBSyrT1YWsuVZ5ZvJk1nMxFtXo4nqmZg3Ebw
	 3y0wxdy9mGcgCGdLUllOP1ZQjJKR51mCyfpb/g1ndDQw0Uknw2PwBiCEMzdpfWhtNe4qB
	 Ui4hT5o127PSqZQ3jp73/iHgtOXPk68EPw+xlgEoynMOIsNFGf7NfCzjwgGPjaXQfiA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793245192;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:Content-Type:Mime-Version:Subject:From:
	 In-Reply-To:Date:Cc:Content-Transfer-Encoding:Message-Id:References:
	 To:X-Mailer;
	bh=nHYJzejo29azPzDNOxZ+tmpvvDu3XTTv89JLTyFVqd4=;
	b=3vGu5c0SHrrC123FHXEfRYW79KEhRhFRJJiPm8wUK2adoy5qYOyuvvGu4KTLbmjC4Mxs
	 VoAx/gP3rZcPvNLVLqrWJqkzlHZKd7MbrFNqsbk1T3xiKfAeTTpoWgpYyt3K99FvqCL5i
	 5DJ5bPqSJTyfuLMXLDDas/bdjFH7ewPq8Fkk+mr9OM7r5/bO0rySKTEtoUOGo71cNQIy/
	 ulEwetY4jR6B5aPsT+IKLpE0lUAKAFbHCPwktxLHBS03agl+VH6fplv5I5MrsAb2MsXjj
	 kZmv8NfC6xN0Ok63hu4pjleLebHbF0fEKjNhWMcTSYsXVzMImzLT8BY+3linV5GCnTg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=JwHCiaU6;
	arc=none smtp.remote-ip=95.215.58.60
Received: from mta1.migadu.com (out-60.mta1.migadu.com [95.215.58.60])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B275F606A31D
	for <linux-arch@vger.kernel.org>; Thu, 29 Oct 2026 03:39:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B275F606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=JwHCiaU6
X-Envelope-To: linux-arch@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=R50k7qXAG33bbhagggBhqvchCPQ52saBCXt3awMCb6U=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1793245189; v=1; x=1793849989;
 b=JwHCiaU6wNlgkZwersY6AMgWtViVtjskMcecd/6+Od2qPv/mWGKr7rlSGPwoiVQjWtSEquTl
 jz8ubRhsB/Dyc/RqHacrPomgc4WK1uts7m7DL8ZDejrhXjpDsM5Zh945kHdyhP94x2zIdgWwum6
 47kzoRxtALGbiybFTOALoFVw=
X-Envelope-To: linux-arch@vger.kernel.org
Received: by mta12.migadu.com with ESMTPS id 5ac0218b5b613cc1;
	Thu, 29 Oct 2026 03:39:48 +0000
X-Mizu-Trace-ID: 5ac0218b5b613cc1
X-Migadu-Flow: FLOW_OUT
Content-Type: text/plain;
	charset=us-ascii
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Post: <mailto:linux-arch@vger.kernel.org>
List-Help: <mailto:linux-arch+help@vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-arch+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3901.100.1.1.12\))
Subject: Re: [PATCH 02/15] mm/hugetlb: compare against persistent count when
 freeing lowmem folios
From: Muchun Song <muchun.song@linux.dev>
In-Reply-To: <20261028-fixes_hugetlb-v1-2-a0a033db180f@kernel.org>
Date: Thu, 29 Oct 2026 11:39:27 +0800
Cc: Oscar Salvador <osalvador@suse.de>,
 Naoya Horiguchi <nao.horiguchi@gmail.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Mel Gorman <mgorman@suse.de>,
 Andy Whitcroft <apw@canonical.com>,
 Miaohe Lin <linmiaohe@huawei.com>,
 Michal Hocko <mhocko@suse.com>,
 Rik van Riel <riel@surriel.com>,
 Hugh Dickins <hughd@google.com>,
 Baolin Wang <baolin.wang@linux.alibaba.com>,
 Vivek Kasireddy <vivek.kasireddy@intel.com>,
 Dave Airlie <airlied@redhat.com>,
 Jason Gunthorpe <jgg@ziepe.ca>,
 Lorenzo Stoakes <ljs@kernel.org>,
 "Liam R. Howlett" <liam@infradead.org>,
 Vlastimil Babka <vbabka@kernel.org>,
 Mike Rapoport <rppt@kernel.org>,
 Suren Baghdasaryan <surenb@google.com>,
 Jonathan Corbet <corbet@lwn.net>,
 Shuah Khan <skhan@linuxfoundation.org>,
 Randy Dunlap <rdunlap@infradead.org>,
 Peter Xu <peterx@redhat.com>,
 Breno Leitao <leitao@debian.org>,
 Will Deacon <will@kernel.org>,
 "Aneesh Kumar K.V" <aneesh.kumar@kernel.org>,
 Nick Piggin <npiggin@gmail.com>,
 Peter Zijlstra <peterz@infradead.org>,
 Heiko Carstens <hca@linux.ibm.com>,
 Vasily Gorbik <gor@linux.ibm.com>,
 Alexander Gordeev <agordeev@linux.ibm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Sven Schnelle <svens@linux.ibm.com>,
 Arnd Bergmann <arnd@arndb.de>,
 linux-mm@kvack.org,
 linux-kernel@vger.kernel.org,
 Gerd Hoffmann <kraxel@redhat.com>,
 linux-doc@vger.kernel.org,
 linux-arch@vger.kernel.org,
 linux-s390@vger.kernel.org,
 stable@kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <68EFA1E5-4898-4278-8718-06B1A010DFFD@linux.dev>
References: <20261028-fixes_hugetlb-v1-0-a0a033db180f@kernel.org>
 <20261028-fixes_hugetlb-v1-2-a0a033db180f@kernel.org>
To: "David Hildenbrand (Arm)" <david@kernel.org>
X-Mailer: Apple Mail (2.3901.100.1.1.12)



> On Oct 29, 2026, at 04:13, David Hildenbrand (Arm) <david@kernel.org> =
wrote:
>=20
> try_to_free_low() gets a target number of persistent folios, but
> compares it with "nr_huge_pages", which includes surplus folios. As a
> result, it can free lowmem folios below that target.
>=20
> For example, with two persistent folios and one surplus folio, a =
target
> of two can still end up freeing one persistent folio.
>=20
> Compare against persistent_huge_pages() instead. Convert the macro to =
a
> helper function and place it before try_to_free_low().
>=20
> Fixes: 7893d1d505d5 ("hugetlb: Try to grow hugetlb pool for =
MAP_PRIVATE mappings")
> Cc: stable@kernel.org
> Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>

Acked-by: Muchun Song <muchun.song@linux.dev>

One nit bellow.

> ---
> mm/hugetlb.c | 8 ++++++--
> 1 file changed, 6 insertions(+), 2 deletions(-)
>=20
> diff --git a/mm/hugetlb.c b/mm/hugetlb.c
> index da5d04edf7c1..3a94ea1c9457 100644
> --- a/mm/hugetlb.c
> +++ b/mm/hugetlb.c
> @@ -1335,6 +1335,11 @@ static unsigned long =
available_huge_pages(struct hstate *h)
> 	return h->free_huge_pages - h->resv_huge_pages;
> }
>=20
> +static unsigned long persistent_huge_pages(struct hstate *h)

Better to make *h const?

Thanks.

> +{
> +	return h->nr_huge_pages - h->surplus_huge_pages;
> +}
> +
> static struct folio *dequeue_hugetlb_folio(struct hstate *h, gfp_t =
gfp_mask,
> 					   struct mempolicy_interpreted =
*mpoli)
> {
> @@ -3719,7 +3724,7 @@ static void try_to_free_low(struct hstate *h, =
unsigned long count,
> 		struct folio *folio, *next;
> 		struct list_head *freel =3D &h->hugepage_freelists[i];
> 		list_for_each_entry_safe(folio, next, freel, lru) {
> -			if (count >=3D h->nr_huge_pages)
> +			if (count >=3D persistent_huge_pages(h))
> 				goto out;
> 			if (folio_test_highmem(folio))
> 				continue;
> @@ -3773,7 +3778,6 @@ static int adjust_pool_surplus(struct hstate *h, =
nodemask_t *nodes_allowed,
> 	return 1;
> }
>=20
> -#define persistent_huge_pages(h) (h->nr_huge_pages - =
h->surplus_huge_pages)
> static int set_max_huge_pages(struct hstate *h, unsigned long count, =
int nid,
> 			      nodemask_t *nodes_allowed)
> {
>=20
> --=20
> 2.43.0
>=20

