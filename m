Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=91.218.175.176
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793245904;
	b=PyM7/auBxaSPLaKWECSGWwZ7rV0e11wnVQyFLaWLi89Ieh6FhONwxj82KW7ux97cOd4g
	 u2TVR/MyirJfvX0LM1kBrNQCaD52kI0hV9YmAW9LObo8bqlrnDhav/co/n2+3skL/xRRv
	 Dqc1Hr+g/G2UOP2Lb2pylmHyPB5wnzRBY8y9HdaAiu2B3N+5fbF2S5eHOMoVEUkj4lBq4
	 mMn/GFOb1fGYuf0isEBfx8KXd4jFdzUCpsEJXwPMJ5FITIFGsz61gG0rFqrKObbEtk7pe
	 kbc+vrgn6QlOEumxCnpSELn3hDPkIl523WO1SwJOlGiKcvEx3y1S2K0dLRUH3ixemcQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793245904;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:Content-Type:Mime-Version:Subject:From:
	 In-Reply-To:Date:Cc:Content-Transfer-Encoding:Message-Id:References:
	 To:X-Mailer;
	bh=YXfmsX/yQpRThvRvFibuXD3vPcTXDbmM4UJssVVOAKc=;
	b=XdkY6ygXx9QiWSuR7wzotaIMoxpZ3zhoBj4XpeS8EQEYgXhgqr5YdxF89c3fS7KBXydx
	 z/FKjzyMLtkAczEEnAPLFa07a+UGS93oqcPReZghyknKt4j8g+CezkQsjFcbdmGexxYHC
	 +2HE3eqRpiFX1SRWk+NzbeLZwz7o+jXsaGdbKX3obusWSsTd+WSSpcxrxTTUZw2LADRaP
	 0HjxTcS0lJ6beezLKXHX+0tb8F8EUwX15uMCSU3+vwAcQxPnQEoj9zgdORjQHOd0iAv42
	 ZuUfh+nn9HBwbSqYj72aaX9dzpX4sDva4R4zcebyBmI4IwtZ/jS4ATcY/zGg6S7R6ug==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=kKimkzyM;
	arc=none smtp.remote-ip=91.218.175.176
Received: from mta0.migadu.com (out-176.mta0.migadu.com [91.218.175.176])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F26F6606A31C
	for <linux-arch@vger.kernel.org>; Thu, 29 Oct 2026 03:51:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org F26F6606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=kKimkzyM
X-Envelope-To: linux-arch@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=716xbJigIsWZtYo06Vb5k1w3O79is5fyZrfOLJIQCDQ=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1793245901; v=1; x=1793850701;
 b=kKimkzyMPeC7s5+fbgeXF8tpg/Q20CMWuvnl55Scox90nZ4dUkgyeG+w0oApM+0nWA4fRHkg
 q/pfBgaWt9rb3eD6HUd7Wny2AINRQQZRfUAHY9eATkwakdCHmJE5s3+3NeXmKraZBCz+10zFbr1
 2tzeKUEeN5Os5kX7uiceRtZA=
X-Envelope-To: linux-arch@vger.kernel.org
Received: by mta10.migadu.com with ESMTPS id 718d34fddc079b55;
	Thu, 29 Oct 2026 03:51:40 +0000
X-Mizu-Trace-ID: 718d34fddc079b55
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
Subject: Re: [PATCH 05/15] mm/hugetlb: keep surplus folios when the pool
 shrinks
From: Muchun Song <muchun.song@linux.dev>
In-Reply-To: <20261028-fixes_hugetlb-v1-5-a0a033db180f@kernel.org>
Date: Thu, 29 Oct 2026 11:51:13 +0800
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
 Josef Bacik <josef@toxicpanda.com>,
 stable@kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <8DF234F5-8EAF-427C-928C-8DD6E53FC501@linux.dev>
References: <20261028-fixes_hugetlb-v1-0-a0a033db180f@kernel.org>
 <20261028-fixes_hugetlb-v1-5-a0a033db180f@kernel.org>
To: "David Hildenbrand (Arm)" <david@kernel.org>
X-Mailer: Apple Mail (2.3901.100.1.1.12)



> On Oct 29, 2026, at 04:13, David Hildenbrand (Arm) <david@kernel.org> =
wrote:
>=20
> From: Josef Bacik <josef@toxicpanda.com>
>=20
> Surplus folios are accounted per node. When shrinking the pool,
> set_max_huge_pages() removes free folios through
> remove_pool_hugetlb_folio() and accounts them as persistent folios.
>=20
> It can select a node whose folios are all surplus and leave its =
surplus
> count larger than its total count. Free surplus folios can back
> reservations created by gather_surplus_pages().
>=20
> For example, with nr_overcommit_hugepages =3D 8 on two nodes:
>=20
>  (node columns show total/free/surplus)
>=20
>                                      total free surp   node0   node1
>  mmap() of one page, bound to node 0     1    1    1   1 1 1   0 0 0
>  node1/nr_hugepages =3D 7                  8    8    1   1 1 1   7 7 0
>  nr_hugepages =3D 6                        7    7    1   0 0 1   7 7 0
>  munmap()                                7    7    1   0 0 1   7 7 0
>  nr_hugepages =3D 0                        1    1    1   0 0 1   1 1 0
>=20
> After shrinking to six persistent folios, node 0 has no folios but its
> surplus count is still one. Releasing the reservation cannot clear =
that
> count, and shrinking the pool to zero leaves one free page on node 1.
>=20
> A later write to node0/nr_hugepages underflows the unsigned per-node
> persistent count: 0 - 1, resulting in allocation of many folios.
>=20
> Use persistent_huge_pages_node() to skip nodes with no persistent =
folios,
> as adjust_pool_surplus() does. This also excludes temporary folios.
>=20
> Fixes: e4e574b767ba ("hugetlb: Try to grow hugetlb pool for MAP_SHARED =
mappings")
> Cc: stable@kernel.org
> Signed-off-by: Josef Bacik <josef@toxicpanda.com>
> [ david: cleanup code and description ]
> Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>

Acked-by: Muchun Song <muchun.song@linux.dev>

Thanks.

