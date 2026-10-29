Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.208.48
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793236833;
	b=XcIx7jZPa2Oan0oTvy/nwU5za72IENwKwiMwoMFLuBpAstMOhlM7QEiO3ybc5PYdDo1c
	 qBFgpFRr9ZkSahfCZRLUIcMgOjEgiPMpXaOwyGuA2+12PY88DYE4yX+r9h9gIS7T9FwU7
	 HSliJSQ5QxXnGrso25fpkODUGqdS5OzyU00RlwOeYviRQGsdZHB8BbGLDEqx3gPjTeQ2q
	 Xnheeakrab4xRvyb2Hm8xsfZu6cVU9iVbvRpb5whSMf/2GAFyA1cExmvHajQy9AGkjBmQ
	 7NyrCiqnpblepovG9T4zrlu9xqZ3ykqEtz8y5uLZ2TgWaDdcFAnHw2Yh8fzd9btxDXw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793236833;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Subject:From:To:
	 Cc:In-Reply-To:References:Date:Message-Id:X-Mailer;
	bh=TWYN3MXkVQTFS4ykvP4ULAqrY98K2LtbRow9MYNtF9g=;
	b=ibwvV7Pd6BYhIDQb0LcJNX0CjhXAczqlFdTumA3ILeHTCmzPXd5iv8DSRbTGtzbpvk3r
	 JyCqE3UhphPLuN4gKjotINwzpB224jb9gZQKzx68u21hxX7L9Y7iwPhFj01PGcZdJwieO
	 xCFX5DnNdwcIC8ZccGRdnAXt5c3rkKGvjcybQpWy0nafpg/dfjLn1c3usBog2PeAG0Qrf
	 AKPRRoRje2DxyMnxIJZZOX3l105ozMBwFdpG5IIJqFs9fB1VMcUvcur7ogREuYAX8Z3fa
	 d9JK1XwvAWZgZqXbUzcOD07MkssCu20nKO+RpCo4wDRotM598rwiVu2qFNm8ef0CBGg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=gourry.net;
	spf=pass smtp.mailfrom=gourry.net;
	dkim=pass header.d=gourry.net header.i=@gourry.net header.a=rsa-sha256 header.s=google header.b="X0XY/GAi";
	arc=none smtp.remote-ip=209.85.208.48
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DF68606A320
	for <linux-arch@vger.kernel.org>; Thu, 29 Oct 2026 01:20:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1DF68606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gourry.net header.i=@gourry.net header.a=rsa-sha256 header.s=google header.b=X0XY/GAi
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-6b1f31c63ebso421271a12.0
        for <linux-arch@vger.kernel.org>; Wed, 28 Oct 2026 18:20:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1793236830; x=1793841630; darn=vger.kernel.org;
        h=message-id:date:references:in-reply-to:cc:to:from:subject
         :content-transfer-encoding:content-type:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=TWYN3MXkVQTFS4ykvP4ULAqrY98K2LtbRow9MYNtF9g=;
        b=X0XY/GAiMek/vFbkNlCS++xCJPhcJpRxEM4fx1Ljjv6aCGTfMX2iHg06Cuvz3jbJ3x
         Q0dDwGr1BIBMf5kqCtqsb5bfcPFaFZlUqEnSi6skik2W1J4zJ5GeZ5elYQvrlDRe91e/
         CP3Ywj3kmY6/6N/XufcgSAxLlc+irLxiHwNEWl3k5M1t7aKrd+VArviVR+LRPwX+IZPm
         GpA3SbXg+reoCoke8l+SC4GaT3nXvce2SqP/adtt8ITzlbRj4F9bRx8OgSUJIJiobyeZ
         u80Of7gLVfSgCHHisozRXuwKcVBjIh2eid1AKfwHBlqSo1BxKhOy27h+nd0r4z6VpL4i
         tJBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793236830; x=1793841630;
        h=message-id:date:references:in-reply-to:cc:to:from:subject
         :content-transfer-encoding:content-type:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=TWYN3MXkVQTFS4ykvP4ULAqrY98K2LtbRow9MYNtF9g=;
        b=oXl4Hl33oRPkB3oVoXmhtN6NIDTXpYYiHMafXD08b24Ip1wusGw3Ag5p/NX0n+ydY4
         ARQm9Xj3b03XqRXodhH1F91FqBy4KasXBZkhBRE+p6cFEQFS2tC+Xm+fNm/hoNADqu68
         YrESJUUKRzPTzobvRceTvvORSf1NrteaEclklklDpnpd6DSGqk8Hcwzd7l0iDEG8JB6G
         I4nuP4W2G+3dJWzjlCVCAZGR4pJYFfKVvDSisvJqMynqFfsoUkoPdIFUDlf4UNy3qJ8k
         xxkurDWWcU08ZrdZIGBWOuUgb5Vr9EcDaRX7k5ZYuzIuoGln2p6mFVNknjmjW898mLR4
         lb0A==
X-Forwarded-Encrypted: i=1; AKwUvBzusyi63nRf4t8qYsI0TuJLK768FUHqkaNaj2uWTkM8T1tPXrateCxmSpd/otv0B2jAFSj6gM5HhNeE@vger.kernel.org
X-Gm-Message-State: AFq9FYKsKN6Uo9SB44pYWdC6iaO0vQnaBB8ncaYlMnd188Imfk6L4ugD
	JQGs9rV0HTyARq3cbS2gDA2MdJjqFCbKO7od69eI2/nbQvs8w4GyWRrYdBj3Fsm+eII=
X-Gm-Gg: AYBFou2050Gp5cCU+pRdsxV8Kl0zFMix0lemO6EqiJ/5P2XFi8PjIzBex6FRIc5vimA
	hVQ0R4OKtHU71OYJyy1hZhNkET0oC9Qdb2L6DlH3xIkB+eLfE6Hq/9i927HE9Op2QiStlx4qkhw
	knilQL5W+dE8eUhL5eQNBa0Xqd7ZfDfKM+fgXO7OLMgnHA+v4slw453EaHVNISxRU8zBYqgBlCe
	TrXmPgPNOL47/suHoEnhYZcYvJr2l7+mJvUs4V4T6Tivnj53Ze3eL2sSM4uQluyQweuyAHLHw9m
	chcXGLrWyQaaFqvLClafl+SBN+eKEOetQ4XfFSvsItahg5iHu6XTV0rel7/H9Zu8LJre7fklWtF
	q0w3VJZ/ysvdWGFRcuVAWlsip1Iakshbaa4oUIXXgXb8N9FMMQU0FZAgVcMFilQkvNPnqz+NuJ9
	hl5xkbEEL7ByVmnuAptvl1qu98+gcMSxhO1cRlw9HZg/Iqq2QMWoYwoWj3ZM1oEkL9N14DsSjpt
	7eCIH58/SyRxhNDemRQJSiXZLuNlj2omIi/CecwOQtK+I9uss+dpsDBeyRNRDVw3HbXx0f9vNt7
	LzxdtccKe4BzV/6n4YmW
X-Received: by 2002:a05:6402:c507:10b0:6b4:8d8e:c5c9 with SMTP id 4fb4d7f45d1cf-6b4b0b82678mr569270a12.4.1793236830233;
        Wed, 28 Oct 2026 18:20:30 -0700 (PDT)
Received: from localhost ([2a03:2880:32ff:72::])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c46bd649f69sm671275666b.43.2026.10.28.18.20.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Oct 2026 18:20:29 -0700 (PDT)
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
Subject: Re: [PATCH 15/46] mm/khugepaged: always recheck the pmd in
 try_collapse_pte_mapped_thp()
From: Gregory Price <gourry@gourry.net>
To: "David Hildenbrand (Arm)" <david@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, 
 Johannes Weiner <hannes@cmpxchg.org>, Michal Hocko <mhocko@kernel.org>, 
 Qi Zheng <qi.zheng@linux.dev>, Shakeel Butt <shakeel.butt@linux.dev>, 
 Lorenzo Stoakes <ljs@kernel.org>, Kairui Song <kasong@tencent.com>, 
 Barry Song <baohua@kernel.org>, Axel Rasmussen <axelrasmussen@google.com>, 
 Yuanchu Xie <yuanchu@google.com>, Wei Xu <weixugc@google.com>, 
 Baoquan He <baoquan.he@linux.dev>, 
 Baolin Wang <baolin.wang@linux.alibaba.com>, 
 "Liam R. Howlett" <liam@infradead.org>, Vlastimil Babka <vbabka@kernel.org>, 
 Mike Rapoport <rppt@kernel.org>, Suren Baghdasaryan <surenb@google.com>, 
 Michal Hocko <mhocko@suse.com>, Kees Cook <kees@kernel.org>, 
 Peter Zijlstra <peterz@infradead.org>, Jann Horn <jannh@google.com>, 
 Pedro Falcato <pfalcato@suse.de>, Hugh Dickins <hughd@google.com>, 
 Pasha Tatashin <pasha.tatashin@soleen.com>, 
 Pratyush Yadav <pratyush@kernel.org>, 
 "Matthew Wilcox (Oracle)" <willy@infradead.org>, Jan Kara <jack@suse.cz>, 
 Zi Yan <ziy@nvidia.com>, Lance Yang <lance.yang@linux.dev>, 
 Rik van Riel <riel@surriel.com>, Harry Yoo <harry@kernel.org>, 
 Alistair Popple <apopple@nvidia.com>, Nico Pache <nico.pache@linux.dev>, 
 Ryan Roberts <ryan.roberts@arm.com>, Dev Jain <dev.jain@arm.com>, 
 Usama Arif <usama.arif@linux.dev>, Kiryl Shutsemau <kas@kernel.org>, 
 Matthew Brost <matthew.brost@intel.com>, John Hubbard <jhubbard@nvidia.com>, 
 Peter Xu <peterx@redhat.com>, Will Deacon <will@kernel.org>, 
 "Aneesh Kumar K.V" <aneesh.kumar@kernel.org>, 
 Nick Piggin <npiggin@gmail.com>, Oscar Salvador <osalvador@suse.de>, 
 Minchan Kim <minchan@kernel.org>, Muchun Song <muchun.song@linux.dev>, 
 Xu Xin <xu.xin@linux.dev>, Chengming Zhou <chengming.zhou@linux.dev>, 
 Chris Li <chrisl@kernel.org>, Kemeng Shi <shikemeng@huaweicloud.com>, 
 Nhat Pham <nphamcs@gmail.com>, Youngjun Park <youngjun.park@lge.com>, 
 Gregory Price <gourry@gourry.net>, Joshua Hahn <joshua.hahnjy@gmail.com>, 
 Rakie Kim <rakie.kim@sk.com>, Ying Huang <ying.huang@linux.alibaba.com>, 
 Jason Gunthorpe <jgg@ziepe.ca>, linux-mm@kvack.org, 
 linux-kernel@vger.kernel.org, kexec@lists.infradead.org, 
 linux-fsdevel@vger.kernel.org, linux-arch@vger.kernel.org, 
 linux-cxl@vger.kernel.org, Josef Bacik <josef@toxicpanda.com>, 
 stable@vger.kernel.org
In-Reply-To: <20261027-fixes_core-v1-15-6f74bec9a5bb@kernel.org>
References: <20261027-fixes_core-v1-0-6f74bec9a5bb@kernel.org>
 <20261027-fixes_core-v1-15-6f74bec9a5bb@kernel.org>
Date: Wed, 28 Oct 2026 18:20:27 -0700
Message-Id: <179323682749.453251.17316394789253085295.b4-reply@b4>
X-Mailer: b4 0.17-dev

On 2026-10-27 00:17 +0100, David Hildenbrand (Arm) wrote:
> From: Josef Bacik <josef@toxicpanda.com>
> 
> try_collapse_pte_mapped_thp() drops the PTE lock after it has cleared the
> page table, and takes the PMD lock and the PTE lock to remove it.
> 
> In between, MADV_DONTNEED with CONFIG_PT_RECLAIM can reclaim the
> page table. The pmd_same() check is supposed to handle this, but it is
> only done with CONFIG_SPLIT_PTE_PTLOCKS.
> 
> Fix it by performing the check unconditionally.
> 
> Fix generated by an LLM and sent by Josef Bacik in private.
> 
> Fixes: 6375e95f381e ("mm: pgtable: reclaim empty PTE page in madvise(MADV_DONTNEED)")
> Cc: stable@vger.kernel.org
> Signed-off-by: Josef Bacik <josef@toxicpanda.com>
> [ david: adjust description ]
> Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>

Reviewed-by: Gregory Price (Meta) <gourry@gourry.net>
Tested-by: Gregory Price (Meta) <gourry@gourry.net>

-- 
Gregory Price (Meta) <gourry@gourry.net>
