Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=95.215.58.211
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793245049;
	b=2KQws/Iug0lL5BLFpc7OygBZdND8DsaqPDDit/o4ifYnRdMCqgzI7IIYTu1qt3YH/Yjh
	 K42kxw2kP0aUelfNaJI1hBnNr326qt80TJwfz+5C+inUMPGGLMd4EE5s+nfxfL6KO/NAA
	 EnjHcT6kg7iPyE8R/VKMnRTyuFZw17+JNiB+SygURQGd9HOiB5NVYIEzNTs5us/xn/uTI
	 oQZ5W9AVMr0abu6FY/4bW2obwAOw134bUCfIpdyrbhFwOWOHnQElNmcl6W5EwhTUB+Gbg
	 QQDz6H1KofGfcJ6wqYSo/oRDpkhk3WBhnRdmIMNUinprFtCdnso0m6EC1A+KyqAW6ag==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793245049;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:Content-Type:Mime-Version:Subject:From:
	 In-Reply-To:Date:Cc:Content-Transfer-Encoding:Message-Id:References:
	 To:X-Mailer;
	bh=0TYkcz3oi8Hce4FiXDXGEUsAkrCmcslpFK3fxjBXOUw=;
	b=M3PnYs78duG54PpmZEjGvEh1msaM/kSvpAYIKmcVpE8hhYW0jLEWeqpTAPTLrbUv93oL
	 /DnYbA5o17UrGDDmwRQnOcQHfPEASGBR3Gkx/3Di6zC/DYox2wopiuNejGO6SSvNw/Lst
	 ZoEBXZimKEJinMoEFFdIxrXC10MoHwoqoAd29DXuNsE/vf0dCdfwx/Fs03HKDY7VTiwrq
	 ArZA8+DRUimV/H/vr3YXOK7yn85sVREpYAfNTFsH9tnHg5h+I7CSarlOI73DKph0OKrbc
	 9bucrtWCwLhbcK39riJjWq5f8ikJoQPRvA1RXc8IxZxC0QQcbvVVUIbytoZXcex5jCQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=EwhdD0ta;
	arc=none smtp.remote-ip=95.215.58.211
Received: from mta1.migadu.com (out-211.mta1.migadu.com [95.215.58.211])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2982C606A31D
	for <linux-arch@vger.kernel.org>; Thu, 29 Oct 2026 03:37:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2982C606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=EwhdD0ta
X-Envelope-To: linux-arch@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=0TYkcz3oi8Hce4FiXDXGEUsAkrCmcslpFK3fxjBXOUw=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1793245046; v=1; x=1793849846;
 b=EwhdD0taQspvWOf1jRfVxj3kKfbzBcoW1Zh6PIQfZnIs/iXQRocbPuPpJfyNmtIfGQm3KGHU
 Oh06JsdTIGrNthlWEpv+6QrXR0Zdq/Zd63qqHMkLytRK+ku2AIn63jTXNRRnmPotzFTLiJNDfR3
 LZIOVGY4YGYH1FAzvkJnfq8Q=
X-Envelope-To: linux-arch@vger.kernel.org
Received: by mta12.migadu.com with ESMTPS id b3dc07f6f034e3dc;
	Thu, 29 Oct 2026 03:37:25 +0000
X-Mizu-Trace-ID: b3dc07f6f034e3dc
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
Subject: Re: [PATCH 01/15] hugetlbfs: fix integer overflow in fallocate()
From: Muchun Song <muchun.song@linux.dev>
In-Reply-To: <20261028-fixes_hugetlb-v1-1-a0a033db180f@kernel.org>
Date: Thu, 29 Oct 2026 11:37:01 +0800
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
 luojiajun <luojiajun3@huawei.com>,
 Josef Bacik <josef@toxicpanda.com>,
 stable@kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <497E3E4E-B423-46FA-AB00-5D2ABFB833A0@linux.dev>
References: <20261028-fixes_hugetlb-v1-0-a0a033db180f@kernel.org>
 <20261028-fixes_hugetlb-v1-1-a0a033db180f@kernel.org>
To: "David Hildenbrand (Arm)" <david@kernel.org>
X-Mailer: Apple Mail (2.3901.100.1.1.12)



> On Oct 29, 2026, at 04:13, David Hildenbrand (Arm) <david@kernel.org> =
wrote:
>=20
> hugetlbfs_fallocate() rounds the range end up by adding hpage_size - 1
> to offset + len. vfs_fallocate()'s existing overflow check only makes
> sure that offset + len does not overflow.
>=20
> Once we overflow for valid endpoints near LLONG_MAX, we can get a
> negative temporary result that is then converted to a very large
> huge page index.
>=20
> A one-byte allocation ending at LLONG_MAX can therefore consume all
> available huge pages. Pages added beyond LLONG_MAX are skipped during
> inode eviction, leaking them and triggering the BUG_ON() in =
clear_inode().
>=20
> To fix it, calculate the end index in a simpler way that cannot
> overflow. This also fixes the signed overflow reported by luojiajun in
> 2019.

Amazing that you remember something from so long ago!

>=20
> Backporting notes: without commit a08c7193e4f18 ("mm/filemap: remove
> hugetlb special casing in filemap.c"), remove_inode_hugepages() must
> include the final huge page during truncate and eviction.
>=20
> Reported-by: luojiajun <luojiajun3@huawei.com>
> Closes: =
https://lore.kernel.org/all/1554775226-67213-1-git-send-email-luojiajun3@h=
uawei.com/
> Reported-by: Josef Bacik <josef@toxicpanda.com>
> Fixes: 70c3547e36f5 ("hugetlbfs: add hugetlbfs_fallocate()")
> Cc: stable@kernel.org
> Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>

LGTM.

Acked-by: Muchun Song <muchun.song@linux.dev>

Thanks.

