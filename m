Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.222.179
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794606433;
	b=mvZNq/+fviq0ZFxhy9a85q2oHX27zjKRaHok5j3Lw/05gZrBtzPqcn+DLRNbws6lRAGY
	 DeIdS0ipjN31rttmiLnRo9sLcnexrXnqvQW1Pyx8HIMJzQh7tGT0teafrBCqsIgnGMO9H
	 TT2OkXBV+XwYZ3sUAtX3wjWTZx5fr/lxC30QUqTnOQjoAkJfwdx6N7CVGgNNzdIAQqR4Y
	 mR5ixxo+8+BYKiCEM7PcRKDhaXbwf4NCLLCh1cLqFdjxOCOm5dYCW83tmF2sCYMt6zHKG
	 ZXPji6Z/r0NmNVssTIwvTHijX/KyIu2i/5/tjsT53VIiLXX0DmxnqDfMbdT/ZpTEC5w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794606433;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Subject:From:To:
	 Cc:In-Reply-To:References:Date:Message-Id:X-Mailer;
	bh=kmWJl7xpM9EiZrdM4st9QmllTAXM7O1m5Iu9qvicGyw=;
	b=rrSj0fKdUYDSxzMpSYjX1xlIm2iQlKJOi/dGY3BRAHi3yPN6z8DQ0qDh7lu6zg9yaEhv
	 l6OdiPgFfPapYKQUHlT5IGNAS1egAASaXOEkT9HKgrPrSHrN7Kp9nUCadkODab6CyOuwZ
	 dusE/+2BBiA1L5kNMvEnR4vDJPhwnfveedtrQiw0EKvImE34fKceJVSGM7tpSL3zD5qbL
	 K67PdugcfskMMNqxsFTNEZ7AJMcQduKmbnMysviZxe2bt1ngdkQjMnL2srR2U35R5Qrr+
	 M69H4qeQKXup8l/Mhjyz9YWbHw7+f/ynoBMGf4ZfSXtpl4cBB42Q+uWWnPZALF9dCLA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=gourry.net;
	spf=pass smtp.mailfrom=gourry.net;
	dkim=pass header.d=gourry.net header.i=@gourry.net header.a=rsa-sha256 header.s=google header.b=eaa0H2aL;
	arc=none smtp.remote-ip=209.85.222.179
Received: from mail-qk1-f179.google.com (mail-qk1-f179.google.com [209.85.222.179])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3810E606A334
	for <linux-arch@vger.kernel.org>; Fri, 13 Nov 2026 21:47:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3810E606A334
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.a=rsa-sha256 header.s=google header.b=eaa0H2aL
Received: by mail-qk1-f179.google.com with SMTP id af79cd13be357-93f20c3aaa5so309270585a.2
        for <linux-arch@vger.kernel.org>; Fri, 13 Nov 2026 13:47:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1794606432; x=1795211232; darn=vger.kernel.org;
        h=message-id:date:references:in-reply-to:cc:to:from:subject
         :content-transfer-encoding:content-type:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=kmWJl7xpM9EiZrdM4st9QmllTAXM7O1m5Iu9qvicGyw=;
        b=eaa0H2aLTwIv1fF9DlES7zpndhp3z4IRgePEZs2NN4KH8l196BoqVtJMOQoreLCYNB
         pOsyMZrWiiWWEYh99FWQcRzLwUkmUQG0Z6hXXczle32dIaNGY3hVRAwAZF4u+LqQGeDl
         HW/Qi7lP/gayyA5HyH4yHz9T2KcK3IAp4jj2dA1Q8qWqf67B8DNQa36x3Wf1p+BqoYeV
         09E1Oth2PXXi3zYvT0jz0Q46Ub14UsGzxUIXD4+zxf0zDuIBi9HdIfF7bPAV5OJw1wez
         IQ1H4vTfGvCU94LsWlmfOA1MvRSD4iIueptYlFuflsyzxqnZzZl++fo1JvUP6RClXRoD
         h3pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794606432; x=1795211232;
        h=message-id:date:references:in-reply-to:cc:to:from:subject
         :content-transfer-encoding:content-type:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=kmWJl7xpM9EiZrdM4st9QmllTAXM7O1m5Iu9qvicGyw=;
        b=ipJLRg+ff3rHdtM6p09UntuVQVGojEmRqSxbRfYromCoBuvApu8rSD0oMxHmMTCYHn
         qOqtQ6hJYl1JtDhMzjiOc8wxlrI4x5gOU4EYKRReiGENVAHzpT16n93hH/XjD3aMAl55
         L3vOgNJLWquoaCUMVgGCdY1wTK8GF9EK8QGpz9H5yIldVekZN0h7R2g2NDd5TJI+BIcO
         T7dGcKE9LFIkJ01SI7N2geLxTJwGMvTDZvkJvqSlpTNvU9BfzOlIMOPHamPzAW2bFIxY
         T3vioU73M5iXN67MpSykbMAdnhA/NE/7ae0ayBs+j4Ht3GEekDQwtXbZBEGTtw95Rtc1
         KMfw==
X-Forwarded-Encrypted: i=1; AL+hErEDo2sj8CxHXvr7wrldjYZ0x1nl3eWQ7me5BlNb3ot3b7AkpNJHTk50egKfdeneZNLufdcllSFcKlRO@vger.kernel.org
X-Gm-Message-State: APuU4Z/YE24a2KZ1sXcKZtDdKLhPPEWbAFxXx15nLeq5Bcu+9EYa4nb+
	xFvELqW4IYJtKaa6YzXw+mXYj2hY7TdcXHt3/+Ilp2NFBPdJPGemSUxJr6DEnXtbRVs=
X-Gm-Gg: AYBFou0aY4VqCnnaMyrgDD0y6a8UHhkO/smXX/N2XGPai7WI68EU1JxdkQlQoxAFoNd
	NdzdjkzqjpDh9qJGPkHSri+DjKqJt/hfnkmx241aUZ+YReRRbXe5cqj5o52xDy+14hOMv/nJp2z
	zJKm74MixHaTJNcPwD1mAYX64yWdtnETZMQ4fvZ/VNorQ6JJxkydVigcchLOT5DQquMxEUghKoe
	zqfanAAgh1Dnu0mi+Zop9S6aBoHkMAQ23l7t396l0VdZP01N4hlILaHwAoN4T9m28zFIB6EyUMn
	xz5DoCeGLQQp0VfKpwUasCVOpTiA6fC7iMv2XwjjiENzL/pYORm0BDdIto1nZHnEM8CZPQQLL+A
	sqmpaV4bQJSi1hnAKC0NxJpzG4uu6t2/o+fT2aiuH7tZsnJXepnEjk0Rgd3+yr6Q1ScFkAFX511
	PsKsHboq9XY3KXizd54L1I4tmgkt2pyQM0kDiT8aFZRfaCwJDzHYcRcfG9i608SVi1c/aTwXO0m
	Nh7NGsfCy7B7u26tQDuxGMI+7wKOxa+nviEymRF4LieYJdChA8r03ik2TQe0dg/ffGjzXIufpjK
	g6RgTpd7GqoLxcuD2mHwmk+dWHje6baMGztqpxnLc6yEL+Bo3Q/Al9N3HiaXqQ4LaE6OXpJkq/h
	9BLzuhlM=
X-Received: by 2002:a05:620a:4042:b0:93f:3120:6c6d with SMTP id af79cd13be357-9494bb56dfbmr651566785a.35.1794606432092;
        Fri, 13 Nov 2026 13:47:12 -0800 (PST)
Received: from [192.168.50.231] (pool-71-191-145-202.washdc.fios.verizon.net. [71.191.145.202])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-9494c8b5c1dsm279333985a.33.2026.11.13.13.47.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Nov 2026 13:47:11 -0800 (PST)
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Post: <mailto:linux-arch@vger.kernel.org>
List-Help: <mailto:linux-arch+help@vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-arch+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH 05/15] mm/hugetlb: keep surplus folios when the pool
 shrinks
From: "Gregory Price (Meta)" <gourry@gourry.net>
To: "David Hildenbrand (Arm)" <david@kernel.org>
Cc: Muchun Song <muchun.song@linux.dev>, Oscar Salvador <osalvador@suse.de>, 
 Naoya Horiguchi <nao.horiguchi@gmail.com>, 
 Andrew Morton <akpm@linux-foundation.org>, Mel Gorman <mgorman@suse.de>, 
 Andy Whitcroft <apw@canonical.com>, Miaohe Lin <linmiaohe@huawei.com>, 
 Michal Hocko <mhocko@suse.com>, Rik van Riel <riel@surriel.com>, 
 Hugh Dickins <hughd@google.com>, 
 Baolin Wang <baolin.wang@linux.alibaba.com>, 
 Vivek Kasireddy <vivek.kasireddy@intel.com>, 
 Dave Airlie <airlied@redhat.com>, Jason Gunthorpe <jgg@ziepe.ca>, 
 Lorenzo Stoakes <ljs@kernel.org>, "Liam R. Howlett" <liam@infradead.org>, 
 Vlastimil Babka <vbabka@kernel.org>, Mike Rapoport <rppt@kernel.org>, 
 Suren Baghdasaryan <surenb@google.com>, Jonathan Corbet <corbet@lwn.net>, 
 Shuah Khan <skhan@linuxfoundation.org>, 
 Randy Dunlap <rdunlap@infradead.org>, Peter Xu <peterx@redhat.com>, 
 Breno Leitao <leitao@debian.org>, Will Deacon <will@kernel.org>, 
 "Aneesh Kumar K.V" <aneesh.kumar@kernel.org>, 
 Nick Piggin <npiggin@gmail.com>, Peter Zijlstra <peterz@infradead.org>, 
 Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, 
 Alexander Gordeev <agordeev@linux.ibm.com>, 
 Christian Borntraeger <borntraeger@linux.ibm.com>, 
 Sven Schnelle <svens@linux.ibm.com>, Arnd Bergmann <arnd@arndb.de>, 
 linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
 Gerd Hoffmann <kraxel@redhat.com>, linux-doc@vger.kernel.org, 
 linux-arch@vger.kernel.org, linux-s390@vger.kernel.org, 
 Josef Bacik <josef@toxicpanda.com>, stable@kernel.org
In-Reply-To: <20261028-fixes_hugetlb-v1-5-a0a033db180f@kernel.org>
References: <20261028-fixes_hugetlb-v1-0-a0a033db180f@kernel.org>
 <20261028-fixes_hugetlb-v1-5-a0a033db180f@kernel.org>
Date: Fri, 13 Nov 2026 16:47:10 -0500
Message-Id: <179460643069.482102.17806419339613384754.b4-reply@b4>
X-Mailer: b4 0.17-dev

On 2026-10-28 21:13 +0100, David Hildenbrand (Arm) wrote:
> From: Josef Bacik <josef@toxicpanda.com>
> 
> Surplus folios are accounted per node. When shrinking the pool,
> set_max_huge_pages() removes free folios through
> remove_pool_hugetlb_folio() and accounts them as persistent folios.
> 
> It can select a node whose folios are all surplus and leave its surplus
> count larger than its total count. Free surplus folios can back
> reservations created by gather_surplus_pages().
> 
> For example, with nr_overcommit_hugepages = 8 on two nodes:
> 
>   (node columns show total/free/surplus)
> 
>                                       total free surp   node0   node1
>   mmap() of one page, bound to node 0     1    1    1   1 1 1   0 0 0
>   node1/nr_hugepages = 7                  8    8    1   1 1 1   7 7 0
>   nr_hugepages = 6                        7    7    1   0 0 1   7 7 0
>   munmap()                                7    7    1   0 0 1   7 7 0
>   nr_hugepages = 0                        1    1    1   0 0 1   1 1 0
> 
> After shrinking to six persistent folios, node 0 has no folios but its
> surplus count is still one. Releasing the reservation cannot clear that
> count, and shrinking the pool to zero leaves one free page on node 1.
> 
> A later write to node0/nr_hugepages underflows the unsigned per-node
> persistent count: 0 - 1, resulting in allocation of many folios.
> 
> Use persistent_huge_pages_node() to skip nodes with no persistent folios,
> as adjust_pool_surplus() does. This also excludes temporary folios.
> 
> Fixes: e4e574b767ba ("hugetlb: Try to grow hugetlb pool for MAP_SHARED mappings")
> Cc: stable@kernel.org
> Signed-off-by: Josef Bacik <josef@toxicpanda.com>
> [ david: cleanup code and description ]
> Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>

Reproduced the total=0, surplus=1 issue and subsequent underflow, and
verified this patch fixes the issue.

Tested-by: Gregory Price (Meta) <gourry@gourry.net>

-- 
~Gregory

