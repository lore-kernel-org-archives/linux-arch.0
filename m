Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.218.44
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793072434;
	b=c9APN/tYLlJgPFiK9O1aAhW6pB08ectozGil9XdowGBFYYh69X1uVm6BVttgE0Cd7piD
	 UtpCuanX0YehWntS5ANFIMeI/9g3gaDj4xgZYpGVH3zeoJjpGDv5ZyXw8yCCblqxifsQH
	 +Xo2pWUn8fH4yVhXtCWx/tygecQkdEWj41AIMJJTSKUT2yjKzCdpZP1TFUFGcwxHQp3U1
	 RXAlaL3x+Pe3A/wm6Xtkeo2kjjBW1AkLvykz7VTrX9xNdhSQXlddq36+R5dNd7gboh5PK
	 IhG9gkuD1SanWZ6GmGGTBpPacp8vKM6FZgfNCjeAg6t0xHJbMXuYrenqIdtYKs1ps5Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793072434;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Subject:From:To:
	 Cc:In-Reply-To:References:Date:Message-Id:X-Mailer;
	bh=cRzqF3pZC9T9+mgqazzI3wB0gyIKv4okDYmmTH+ci9I=;
	b=cpY5hL2JcAgsTVBX4NbeHMvMqs2ui4XcTkfHBIJggD+yL1r6NCaf3TzivhBcfIZqf99e
	 Aomq8zftAuTkSv+UCeNtitFWimKzdMtt9ZghStyIojsIcMegrEzCqiq/sWyyzxtGitTPz
	 rsqxojkJyS0mmSwLTq2IgK9nbupy95hBX/e33npkc2RRUr8aKDjipeaGclDubsaAvzQA7
	 0GPj392iXVDiT/fZJIoQtyJGUKZTlNdDIdeOGMuieYesejhmiZ325LCIHXxmyqcf4TBbk
	 LJ/261BXWyVytUETMJccwjMtiBE+LUnEYkh3xnkS8o5ORIrAx/44i8/vjQjEhHdSliw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=gourry.net;
	spf=pass smtp.mailfrom=gourry.net;
	dkim=pass header.d=gourry.net header.i=@gourry.net header.a=rsa-sha256 header.s=google header.b=klpxKBx6;
	arc=none smtp.remote-ip=209.85.218.44
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98D37606A31F
	for <linux-arch@vger.kernel.org>; Tue, 27 Oct 2026 03:40:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 98D37606A31F
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gourry.net header.i=@gourry.net header.a=rsa-sha256 header.s=google header.b=klpxKBx6
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-c37b612635bso481546666b.3
        for <linux-arch@vger.kernel.org>; Mon, 26 Oct 2026 20:40:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1793072432; x=1793677232; darn=vger.kernel.org;
        h=message-id:date:references:in-reply-to:cc:to:from:subject
         :content-transfer-encoding:content-type:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=cRzqF3pZC9T9+mgqazzI3wB0gyIKv4okDYmmTH+ci9I=;
        b=klpxKBx6XIdguBPv1gdEeaxX3Q5nBOE0QyQKgI+nQtmFi2e6yyGoD1z99atiOq/X0L
         29MGF1ep4EQ1gv/+055Qkplcqf1YtKuIcCv5aGSKHjEYK3jS7yM9nfCIB9wNkxkiBkUw
         3XYbbVntwybyBZUIqAVzhr/u8Gfrjw4XN/c1wAbiBcjL3VyyvbdMABrMl8JljkCI4HBP
         HDeVnIkL+LtyK7DjLzJaTMJ1PXNZWLEFJCqh4gUIf6KP43zgwJECwGuEgMjpM78oIwbB
         yrbDn8qUsI/PxLnPvbStsGGa4HcTlJR/M8tesdaSKCW5YkmlnkFTtYdIc+MJU/KUH2YX
         ocTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793072432; x=1793677232;
        h=message-id:date:references:in-reply-to:cc:to:from:subject
         :content-transfer-encoding:content-type:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=cRzqF3pZC9T9+mgqazzI3wB0gyIKv4okDYmmTH+ci9I=;
        b=H2D0lQqMQioHBoCGK3yCUCHSAJHJZ5fCEciP6XCgGm6eJZAYHcYphA5hOnN5KdFtpY
         lld2FbALF3kdBvGoNkXya5md7tkZ5bfjsEyBGML2zkwSpbotv+M5ZrfWOFqN8YAhvi1g
         z3BuBPQC/pLUvcyf5obbhleuRw9lLvku1g4m+1S7bHoXqChqbso2qA8ldt7smdxJ1DiE
         hagXkuWkyGYC5R5kYD5KJcKR8mSL+yKI6Ue94Y364aUyXMo40VrEsrpFdySzg3JrcMoq
         YJJRZ3X66sOZ9wkhcVggsK4bwF50/WdgFXMWyVHXekXsQC3wG1JjADz6yM6aQ0ubzotA
         ogGQ==
X-Forwarded-Encrypted: i=1; AKwUvBwaBxYo49Q657NwpDIjA0enmYYI72Xomlwiz0jgWJIFv56qnhiLQm0hf8L7FpB2/rr/EO0bici9awiR@vger.kernel.org
X-Gm-Message-State: AFq9FYK/G7ZqWXL8EMdyJRS+Yes/yyYRkAfL8UTSwFSzEDTWVvGErNVp
	MkIOhYurfNux6pKgNTlVVG6RqOyrqaF40vMeNz+Kyohbxa0+JqFOPBRGTR/mUjFW0S0=
X-Gm-Gg: AYBFou2tc/IZrwvwRLz9NRVKFbfdvT8KlKOuUUs54+cWoJeszk3v8WRe7sGmPlGQ81l
	bQ7Z+dotfyC8JbdZjhwnEXILjXgY1kHRczXUVH8s+nw88+N8tG3SggWHKE9NeCFBI4g6ETMdiTs
	BuMGBK0pt2sT5SHJnqEBg43h1JCsHoy5GsiR4Pkf+l4SA61LCJpdT7FKZQ1O8OB7quYSDzQJnPV
	4g97ft+E2EpbzmPDMfNXCf7QnYjiXnsI1sktyzN4wKfQvOa9goqp284WYoWY6JbliDes3icCWci
	yaoXVBHD4P6rDOUwK+0M5ifhv0LTiChHroeq3uosPQyWHt4tCm1JFIiIGA72LvWJU5+i78BdEC7
	jqVhhX07VAoYtadm2z3tEAYU0P0vm0hL90yz6UDxjQ5UFcQHyqo+a0JfNYmah5I51YV3ngO9Jpg
	FEPxwWeEgwskiA1QY710UbPNIGFXzIIY01yJTaw6RDXl0rA0Tgq1TlzGFVo8j1Ze/cl8ZGJMSel
	H/P230YqWcj7BGK/7ZC73GPOlaGTF788n9NWcldd5kRQw==
X-Received: by 2002:a17:907:971e:b0:c46:723d:600 with SMTP id a640c23a62f3a-c46bde9f783mr916491966b.41.1793072431944;
        Mon, 26 Oct 2026 20:40:31 -0700 (PDT)
Received: from localhost ([2a03:2880:32ff:3::])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c46bd4e784esm379153566b.19.2026.10.26.20.40.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Oct 2026 20:40:29 -0700 (PDT)
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
Subject: Re: [PATCH 26/46] mm/mmu_gather: fix flushing ranges with 4 GiB or
 larger
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
In-Reply-To: <20261027-fixes_core-v1-26-6f74bec9a5bb@kernel.org>
References: <20261027-fixes_core-v1-0-6f74bec9a5bb@kernel.org>
 <20261027-fixes_core-v1-26-6f74bec9a5bb@kernel.org>
Date: Mon, 26 Oct 2026 20:40:28 -0700
Message-Id: <179307242835.1171062.11616590599815003560.b4-reply@b4>
X-Mailer: b4 0.17-dev

On 2026-10-27 00:17 +0100, David Hildenbrand (Arm) wrote:
> From: Josef Bacik <josef@toxicpanda.com>
> 
> __tlb_adjust_range() takes the size of the range which has to be flushed
> as an unsigned int. Its callers, tlb_flush_{pte,pmd,pud,p4d}_range(), get
> and pass an unsigned long. Consequently, a range that is 4 GiB or larger
> gets truncated, possibly to 0.
> 
> On arm64 with hugetlb, a 64k kernel can flush 16 GiB hugetlb PMDs, and a
> 16k kernel can flush 64 GiB PUDs through tlb_unshare_pmd_ptdesc(). So
> at least these two scenarios are affected.
> 
> Fix it by flushing the proper range instead of the truncated one.
> 
> Fix generated by an LLM and sent by Josef Bacik in private.
> 
> Fixes: b528e4b6405b ("mm/hugetlb: add tlb_remove_hugetlb_entry for handling hugetlb pages")
> Fixes: 8ce720d5bd91 ("mm/hugetlb: fix excessive IPI broadcasts when unsharing PMD tables using mmu_gather")
> Cc: stable@vger.kernel.org
> Signed-off-by: Josef Bacik <josef@toxicpanda.com>
> Acked-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>
> [ david: use two-tab indent, simplify description ]
> Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>

Reviewed-by: Gregory Price (Meta) <gourry@gourry.net>
Tested-by: Gregory Price (Meta) <gourry@gourry.net>

-- 
Gregory Price <gourry@gourry.net>
