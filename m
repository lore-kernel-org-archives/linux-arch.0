Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=95.215.58.125
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793094065;
	b=eKhHUcWGTFAciAcD1nuDd0A5ZvUHdrvw+GaVH+7Tm3OZck692JcamG8zoy1k7+26lb19
	 hdTvafpbHCRiO+vj6QYj7BdNuHKjuHqLtmh2kvXjhFM98yis9qGlRAM4i3/RcQD9FFQru
	 xhf+TaF+kjI2rbVoR/0oSIb+pp7YaAU5d6uBIeInpCYBmuo5vxSaO4VHjVqqDWoCmmbIV
	 o960D9CxZWmx58TF7cFezMfCDPyvzRrTX7OVm7p1dfEQwLTGgD5gTKxxsP/KmApRw1Brb
	 0hkAgvRmdDNqgs1+Mm9FVU8j136md3dLnMr4ZuoYwimj6hrWQZ2e9WTKDPnqW5wkv3w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793094065;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:Content-Type:Mime-Version:Subject:From:
	 In-Reply-To:Date:Cc:Content-Transfer-Encoding:Message-Id:References:
	 To:X-Mailer;
	bh=SFKyeuO1JPOzpTH1nQSbh9oibxPGA9YOhGPCshroXxs=;
	b=vpkPNqgc52vJl9Nue/tDdWkIIPQi4ZGLO8Z3VuC4k2RelVb+jE/4EHstYhtRnpCJxdVD
	 Xn639t8sSSjWSgH7iltpDesZ8WcrBzL3crYs35iAoskZDvxGYYOPI6VaYfiWZZA1F7MJn
	 uhT2rRKUum3KupThzKxP5xFkYaxEWBy6BWj6TEEQeAd7JJl1RPyQWsx3847B/3V2i71zo
	 u60L9UcLlx7aEcTExDS+902LYl965YOBNKyJ68Qr6Q2grfdNKoc06BzlewL+7k8wRFXnW
	 JXWypomJgqSbnJKPFQ9yPWM0m+BBjwmpAl0tJqq/t+lUJuu7zSRxdDw+jE4VcgzL8NQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=Wy8rVp9D;
	arc=none smtp.remote-ip=95.215.58.125
Received: from mta1.migadu.com (out-125.mta1.migadu.com [95.215.58.125])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E74BE606A334
	for <linux-arch@vger.kernel.org>; Tue, 27 Oct 2026 09:41:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E74BE606A334
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=Wy8rVp9D
X-Envelope-To: linux-arch@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=SFKyeuO1JPOzpTH1nQSbh9oibxPGA9YOhGPCshroXxs=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1793094062; v=1; x=1793698862;
 b=Wy8rVp9DDbUKlyVz5wuK1Feezur9xae+q/Z6Hz9yNW58v47WUH5wcaD9Hrg3xWbyvhu39BqI
 ExWkcwZHN1517KLsoJWC0uj/l5WpUULFpWzYP0SvVGopmxnWl4TptAwsG4qqUQ92vI72Mtsn8k9
 0zb7+9ocVTbtmM6u1o472cEA=
X-Envelope-To: linux-arch@vger.kernel.org
Received: by mta12.migadu.com with ESMTPS id caa1b482120fcdcd;
	Tue, 27 Oct 2026 09:41:01 +0000
X-Mizu-Trace-ID: caa1b482120fcdcd
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
Subject: Re: [PATCH 21/46] mm/gup: fix out-of-bounds write for nr_pages == 0
 in GUP-fast
From: Muchun Song <muchun.song@linux.dev>
In-Reply-To: <20261027-fixes_core-v1-21-6f74bec9a5bb@kernel.org>
Date: Tue, 27 Oct 2026 17:40:31 +0800
Cc: Andrew Morton <akpm@linux-foundation.org>,
 Johannes Weiner <hannes@cmpxchg.org>,
 Michal Hocko <mhocko@kernel.org>,
 Qi Zheng <qi.zheng@linux.dev>,
 Shakeel Butt <shakeel.butt@linux.dev>,
 Lorenzo Stoakes <ljs@kernel.org>,
 Kairui Song <kasong@tencent.com>,
 Barry Song <baohua@kernel.org>,
 Axel Rasmussen <axelrasmussen@google.com>,
 Yuanchu Xie <yuanchu@google.com>,
 Wei Xu <weixugc@google.com>,
 Baoquan He <baoquan.he@linux.dev>,
 Baolin Wang <baolin.wang@linux.alibaba.com>,
 "Liam R. Howlett" <liam@infradead.org>,
 Vlastimil Babka <vbabka@kernel.org>,
 Mike Rapoport <rppt@kernel.org>,
 Suren Baghdasaryan <surenb@google.com>,
 Michal Hocko <mhocko@suse.com>,
 Kees Cook <kees@kernel.org>,
 Peter Zijlstra <peterz@infradead.org>,
 Jann Horn <jannh@google.com>,
 Pedro Falcato <pfalcato@suse.de>,
 Hugh Dickins <hughd@google.com>,
 Pasha Tatashin <pasha.tatashin@soleen.com>,
 Pratyush Yadav <pratyush@kernel.org>,
 "Matthew Wilcox (Oracle)" <willy@infradead.org>,
 Jan Kara <jack@suse.cz>,
 Zi Yan <ziy@nvidia.com>,
 Lance Yang <lance.yang@linux.dev>,
 Rik van Riel <riel@surriel.com>,
 Harry Yoo <harry@kernel.org>,
 Alistair Popple <apopple@nvidia.com>,
 Nico Pache <nico.pache@linux.dev>,
 Ryan Roberts <ryan.roberts@arm.com>,
 Dev Jain <dev.jain@arm.com>,
 Usama Arif <usama.arif@linux.dev>,
 Kiryl Shutsemau <kas@kernel.org>,
 Matthew Brost <matthew.brost@intel.com>,
 John Hubbard <jhubbard@nvidia.com>,
 Peter Xu <peterx@redhat.com>,
 Will Deacon <will@kernel.org>,
 "Aneesh Kumar K.V" <aneesh.kumar@kernel.org>,
 Nick Piggin <npiggin@gmail.com>,
 Oscar Salvador <osalvador@suse.de>,
 Minchan Kim <minchan@kernel.org>,
 Xu Xin <xu.xin@linux.dev>,
 Chengming Zhou <chengming.zhou@linux.dev>,
 Chris Li <chrisl@kernel.org>,
 Kemeng Shi <shikemeng@huaweicloud.com>,
 Nhat Pham <nphamcs@gmail.com>,
 Youngjun Park <youngjun.park@lge.com>,
 Gregory Price <gourry@gourry.net>,
 Joshua Hahn <joshua.hahnjy@gmail.com>,
 Rakie Kim <rakie.kim@sk.com>,
 Ying Huang <ying.huang@linux.alibaba.com>,
 Jason Gunthorpe <jgg@ziepe.ca>,
 linux-mm@kvack.org,
 linux-kernel@vger.kernel.org,
 kexec@lists.infradead.org,
 linux-fsdevel@vger.kernel.org,
 linux-arch@vger.kernel.org,
 linux-cxl@vger.kernel.org,
 Chris Mason <mason@kernel.org>,
 stable@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <31275548-1D1D-46D7-A0FE-36D16C03384F@linux.dev>
References: <20261027-fixes_core-v1-0-6f74bec9a5bb@kernel.org>
 <20261027-fixes_core-v1-21-6f74bec9a5bb@kernel.org>
To: "David Hildenbrand (Arm)" <david@kernel.org>
X-Mailer: Apple Mail (2.3901.100.1.1.12)



> On Oct 27, 2026, at 07:17, David Hildenbrand (Arm) <david@kernel.org> =
wrote:
>=20
> From: Chris Mason <mason@kernel.org>
>=20
> With nr_pages =3D=3D 0, GUP-fast still enters its page table walk and =
can
> write past the caller's page array. The old end <=3D start check =
caught
> empty ranges, but was replaced with an overflow check.
>=20
> Users such as OrangeFS can pass a zero page count derived from a
> userspace-supplied length. So let's return zero for nr_pages =3D=3D 0 =
before
> starting the walk, just like GUP-slow.
>=20
> Fix generated by an LLM and sent by Chris Mason in private.
>=20
> Fixes: c28b1fc70390 ("mm/gup: reorganize =
internal_get_user_pages_fast()")
> Cc: stable@vger.kernel.org
> Signed-off-by: Chris Mason <mason@kernel.org>
> [ david: simplify description ]
> Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>

Acked-by: Muchun Song <muchun.song@linux.dev>

Thanks.

