Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.160.172
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794904947;
	b=YGVoNAYOgjROAnSJ4pCeL3XsyInXYLwmpRLRNdm9meiQ/TJoEas8OfquVXp7v9Ysd1ni
	 yyC5TZo5txwR/Vm1LMMrxHEFW70xyHsDCOdznNpUZceE6F/eJUvB/wSUXtLlZfgBkuGnp
	 zTANpa7z/ZRkFVdlm1Ak8EwaZYDBVip3N3AxDNw/5KVfvszATkf9NiLEWfi3GjJp1fvis
	 RUT/7vI8RImekon9t8pTblSORFI0rMpJKpSemNVVrgVtQ3xiwTmTYaeaUZF+gmqW66XmZ
	 l/JLIEKSIEVH9rKwjVddWH9cVLemlKaxmk94EMBYg6lcqSjLXRjSvJ2/VL8lRAKs7Kw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794904947;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Subject:From:To:
	 Cc:In-Reply-To:References:Date:Message-Id:X-Mailer;
	bh=beHv4RWKzAGXqCj9AQIheRdqq9/SqD5ToQS6bWhTNyw=;
	b=F+G6uQ8B2zuXA9m2rfKYPh8EnawACFqW2PAj4mYtHZ9hiCIYDZsnoP4T1YKtP6XZM0q5
	 GcNyo4YI5FQrZn+gn/bk2dNi0SXUz2AaR9w8WZQ02QpuOv9+ciYR/c7Zdjf8z/LAhibpn
	 68wxs8x7hAQNAxcvL8nac2uHchVDDSt6bQdep5h6mL/z2fbDwyRDXNSTlF3mEbl5jZknV
	 Ni8DmNtD9B5iwjjbwwLI7JO4zdXNzUYIUQf/iqWsI2sZ4mCRz4WGGir0A6nV9Z4CMmGip
	 9AC16HwrNA9akI1ZOPWBlFAOGuK2fTeLztVJs/AnokWgJivefa2jz8F3oFVOh4V1Hfg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=gourry.net;
	spf=pass smtp.mailfrom=gourry.net;
	dkim=pass header.d=gourry.net header.i=@gourry.net header.a=rsa-sha256 header.s=google header.b=iz47Vl8v;
	arc=none smtp.remote-ip=209.85.160.172
Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com [209.85.160.172])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC95F606A88E
	for <linux-arch@vger.kernel.org>; Tue, 17 Nov 2026 08:42:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org EC95F606A88E
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.a=rsa-sha256 header.s=google header.b=iz47Vl8v
Received: by mail-qt1-f172.google.com with SMTP id d75a77b69052e-55d3563e50eso28093701cf.0
        for <linux-arch@vger.kernel.org>; Tue, 17 Nov 2026 00:42:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1794904943; x=1795509743; darn=vger.kernel.org;
        h=message-id:date:references:in-reply-to:cc:to:from:subject
         :content-transfer-encoding:content-type:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=beHv4RWKzAGXqCj9AQIheRdqq9/SqD5ToQS6bWhTNyw=;
        b=iz47Vl8v6JkIKZg9UYfyENByJGkp8YiAPJZj5aT+ZIWJtz26JLkljfdgVeOeTUHKpi
         fD+WdtGKspa4q2AxzmQeXoGQQk32iqFWo6zZZR3yDrVQ1vK/HbB3xBejTJBvr/T16oNW
         P1H614T3EMYfwy+o6FHrygopJOeOGa1XEaxFCJNqvbCTcx8I1gaWn0iBhdTWEqp6pW7I
         k8fPNOjH1RutKyHx2SDDsKfQoQn9h0StyHhNNC2VqNR0bEmdsDQA7kQxJTrh/gxuZqR+
         kfMtR0Yh9a2YiCZc6WHAGleSyiuHDgem22R+ssBXM/t8XJBZxYGh+Byyuv/RtLwZWCxo
         W/yA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794904943; x=1795509743;
        h=message-id:date:references:in-reply-to:cc:to:from:subject
         :content-transfer-encoding:content-type:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=beHv4RWKzAGXqCj9AQIheRdqq9/SqD5ToQS6bWhTNyw=;
        b=i3SJ6W+Sb5uymvaegZSlLw1RR6i6PhAxFxXQKX+FH5e2EYSUjGFOF40mzugPDTOnUK
         6RbkT8vZUNFdA7runJMFyb3XU+fiJ+dQskhhtu4IjmE6vQIGNGdV9/nK7nlb66QTWRfh
         FEg2ttSmiI6f4CW5JmPUgxPfhUTDLaQEk3ZG8TC4IhE3qe9hNHjb60z6r6r+1Rgwzjlc
         hsuauUYXbRu4CGJ4MgaR5ty9k62P4fv1Tm5dl4NdHqa3kkSFGDRVJAbZzZxdXdmAuYXW
         am7wNpTWw6zv2t3ENrdFqdXs0ZDoZsY3feOR/kv2DcbMAiECFWJRhXABYik3rU9apnhV
         wsVg==
X-Forwarded-Encrypted: i=1; AL+hErFGI2J4GbFLAI8l/GQ2ZsP0DHEfcyk5yP3DwMFM2JLNdUKxxLgh2W2NifQEVTXx1X2ttsZPHp+zaJ1t@vger.kernel.org
X-Gm-Message-State: APuU4Z+rYCtluflcj/klrXZO3bs7/ZcMCWPseHjXHGgMytBpJdmBnTyD
	mC8/CAZc7jcba97mmjdjUB4n6Db+UF5Z2FkroU8RwWlHv971iJUUMgsoUVgRwZAeHCg=
X-Gm-Gg: AYBFou0Z7+WXjIsjHah1kxXJOeEuaw5Tv5p8HSfSVgv0DM1izCQsvuOW1pTTrI2NyxF
	8nwQ469iGie9uuCmQdnyJYGHgNcw4AvT5zaBNtI1yQ+GECqs/+dmhYbfZQoElYl44/8cfHCW11J
	3JCOTcCgAh3KXyaZdst70bjyxA8LGG3I0cJoIlEP1L9IUxf0h59Bkev5UGMNMq5TSMlKR82SRpH
	r1BOp0JORSZ/ytzF6VzsLMaSrMZTOofagNFLdWHSZ5vtPOmX3z8tKzz0Z5k3hbXGEGC7YqfHA3K
	nvnPaE4EF2t7NK6jJdUAT3HxWnaNkjpWP6JCQyaPYC5nu98JNzReP6cuLKtA7DKdDVC7ceFVFrS
	Npe2qlVwju2a7mITYAs/PNYh5wtwbjqvB4Ptk8D1Q+fK4nU0tokXc5HgbBqJlyA6pXQXbXAC94V
	HqoQlB6eLnCl37Ph8VR9z8WvzD5A6ZhtktJx2ybbXrnh2qslrdl8uG2ZqKSeWswGHBp3OAyl2md
	1gaIp3SrAytW8F+bKSxW185vK0GhXPbeDIORI+MBmVZMiyT0ipipT24DtawxvD2ds6SiOPXi9zk
	/0llHWobh5GlcTBKecW93q8kC32vGRFcdzwdaH3un10d3MXNzdqeM03qgYwWkZ/Vhg7+Tvu2aVd
	WlcqjCawyoDc1z4G8QEomqs2hciTr
X-Received: by 2002:a05:622a:758e:b0:55c:5ebd:8823 with SMTP id d75a77b69052e-55c5ebd936dmr138487931cf.66.1794904942797;
        Tue, 17 Nov 2026 00:42:22 -0800 (PST)
Received: from [192.168.50.231] (pool-71-191-145-202.washdc.fios.verizon.net. [71.191.145.202])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-55d37daf422sm44268211cf.15.2026.11.17.00.42.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Nov 2026 00:42:22 -0800 (PST)
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
Subject: Re: [PATCH v2 06/15] mm/hugetlb: fix mremap() racing with page
 migration
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
 linux-arch@vger.kernel.org, linux-s390@vger.kernel.org, stable@kernel.org, 
 Chris Mason <mason@kernel.org>
In-Reply-To: <20261116-fixes_hugetlb-v2-6-4dd9e94ea9ac@kernel.org>
References: <20261116-fixes_hugetlb-v2-0-4dd9e94ea9ac@kernel.org>
 <20261116-fixes_hugetlb-v2-6-4dd9e94ea9ac@kernel.org>
Date: Tue, 17 Nov 2026 03:42:20 -0500
Message-Id: <179490494079.482102.4618915344813254218.b4-reply@b4>
X-Mailer: b4 0.17-dev

On 2026-11-16 19:29 +0100, David Hildenbrand (Arm) wrote:
> Migration of anon hugetlb folios walks the anon_vma, so the file's
> i_mmap_rwsem does not serialize it against move_hugetlb_page_tables().
> 
> There are various issues with that. Most importantly, move_huge_pte()
> releases both page table locks before the TLB is flushed. Migration can
> then find the destination entry and finish migration, reusing the old
> folio while the TLB still has entries cached.
> 
> Hold the anon_vma write lock across the move and the final TLB flush.
> This also prevents concurrent rmap walks from missing entries moved
> during rollback.
> 
> When we must allocate a destination page table, flush the TLB before
> dropping the anon_vma lock, then reacquire it after allocation.
> 
> Dropping the lock only works around lockdep: hugetlb folios are not
> reclaimed or migrated by allocation compaction, but their anon_vmas
> share the lock class used by ordinary anonymous memory. Having a
> separate lock class for hugetlb's anon_vma (like already done for
> i_mmap_rwsem via hugetlbfs_i_mmap_rwsem_key) requires more thought.
> 
> There is a concern that this can block page migration of anonymous
> folios quite a while ... which is not really different to what happens
> to page-cache folios today. If ever a problem, we can temporarily
> release the lock.
> 
> So let's keep it simple for now.
> 
> It is a shame that hugetlb has to implement everything core-mm implements
> in a different way that just screams for problems.
> 
> Fixes: 550a7d60bd5e ("mm, hugepages: add mremap() support for hugepage backed vma")
> Cc: stable@kernel.org
> Reported-by: Chris Mason <mason@kernel.org>
> Acked-by: Muchun Song <muchun.song@linux.dev>
> Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>

Tested-by: Gregory Price (Meta) <gourry@gourry.net>
Reviewed-by: Gregory Price (Meta) <gourry@gourry.net>

-- 
~Gregory

