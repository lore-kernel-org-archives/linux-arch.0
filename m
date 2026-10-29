Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.218.45
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793237244;
	b=qsuTRgxkzx2OMWf6Ae2mr1e90PGR5iltlO4919yUhVl+rVWQKvWRX+uEvTBaq+GxlDuR
	 PSCJdiRX8Dv6llX1JXlzGnxS3nqKGSmnuQsy4sPrDfQs5oebzaU159+VAo67xKUBfy3j2
	 hbqWrnNb0vZ5cYhStGfAnwKqj6OINVuL4nrcsrsvGdHul5sglhsJNpvjnIS6JxVdFEXgA
	 0C890Eul1bU5mK2Doilu74V2FXpkB0JkWahqllQ4ltnUUB9npbqqVgfClRq4uewSpQkMv
	 omTa1eDXpYeRp0ipbb9s0w4EmD8+j7LjsMb8xEJ6xrYIJ4qZqu5jZyX+x3zFRhXieLA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793237244;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Subject:From:To:
	 Cc:In-Reply-To:References:Date:Message-Id:X-Mailer;
	bh=CDgUtS6BmV52eDuX4xnh+bC+kNpwLNlhCSGJQEIkHH8=;
	b=EnOPkg2402aIqMnnjG/NpxiBfn2uCq8VhTlatprD0N0HzKpqxcUVrAiZjLkwxngs11Py
	 YrHrkRcN2azxDr9dw7ATRtlmLnv7pF928m3QHfAJOyJ3XENB9/Me4OdOzOJTx1yVnfYJt
	 3YAVvv17wywlZ0blYruu+gGsRNXvHSbnDemKcg35llKU45Sf7Y4LRbAfU5zhe3Mm5QBoK
	 PBCSWQfFHLMseZR4c436GHk9aUZI0OFNaXW1Vxpnd55fuSCFpcHFbE27iw40hI15AdJuL
	 OxichxAjQA5GXn6b2bkHjXidO3gTREG5lZJENeqqdXaK+oROLzZl8kevW2ZyQRnW2EQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=gourry.net;
	spf=pass smtp.mailfrom=gourry.net;
	dkim=pass header.d=gourry.net header.i=@gourry.net header.a=rsa-sha256 header.s=google header.b=FXWQ6ewc;
	arc=none smtp.remote-ip=209.85.218.45
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD9EA606A31D
	for <linux-arch@vger.kernel.org>; Thu, 29 Oct 2026 01:27:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CD9EA606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gourry.net header.i=@gourry.net header.a=rsa-sha256 header.s=google header.b=FXWQ6ewc
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-c45551fa84eso173150366b.3
        for <linux-arch@vger.kernel.org>; Wed, 28 Oct 2026 18:27:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1793237242; x=1793842042; darn=vger.kernel.org;
        h=message-id:date:references:in-reply-to:cc:to:from:subject
         :content-transfer-encoding:content-type:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=CDgUtS6BmV52eDuX4xnh+bC+kNpwLNlhCSGJQEIkHH8=;
        b=FXWQ6ewcYH8Z/hLIkNQzCLuCWPzSaYfc+WvfTKDINHzz6s7rbVE9BJ2+9zIQLx9hcf
         5QhEQRLk1p/wOOpcVFwFqvrOTiRdB9drepMbsO+yfRcHtioZaMLr2crqKLoflECJwLsn
         V4wJZMikH6YAQ3/HUqqdUVWr1EG1fH1Kmpi5p+WwhySvjLryewMk16yp8r0+f+srRosG
         iBpd+vnvF1qQrgNM9OR2aoNMnGP5IPFEMd3OWprxewqYz+6WifZnH/aZyCKQzXvy2h0D
         Sd3hmGrbh9x78UvmNGcQlqVIooZQZrhPh2+RFCNKawphmZ9hpaptmMuogQz3pxM1Kgl6
         xqJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793237242; x=1793842042;
        h=message-id:date:references:in-reply-to:cc:to:from:subject
         :content-transfer-encoding:content-type:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=CDgUtS6BmV52eDuX4xnh+bC+kNpwLNlhCSGJQEIkHH8=;
        b=J/afEOFCpJUqv8FXwXYasehLYWh4E1DzbEkGPTsOIzmo/0O45Uxrg3xZY3A/7Jk2eo
         /iG3M0yFtvKoughluLq6aoevj9l9/tzerArR39zX0PehjihDXr8yZwLDGBQiJoKSihxk
         c2QLSj4kpVSM1G/FGnJIxGNN4QrHd+BrQ7Mem/CmWG7FvxoykbMvgowbMPBEuS1tjQb2
         r6GzaNvC0p6qz+l4njJOeyRM16zU2TUHim6216YhywT+rijS3cP4zZY+4Tv+l6MobClg
         DMQnM1j6MofgEPpAzao9f4KwMlHVtCpgLicBxnHEFbCPKsvCyka5hQl0O3ACx5g7904p
         6qmQ==
X-Forwarded-Encrypted: i=1; AKwUvBydB/4VQUKFVeT73k9PliykC1bmV3RC1RTpeccOP9wBEfpCBwWKfmxh15uEKcR97wBGDvegBqobVCk7@vger.kernel.org
X-Gm-Message-State: AFq9FYI2I6rjNVjR3SupoomNaWXmrs3QtgGXHWV2RQNiDgNYZFov9eF3
	maYMra8wdgsVacTfCh0WAi7uZdawAqIgC23ZjAyBQ5fZCDO1rXZVZMVV1RU9/1fYknQ=
X-Gm-Gg: AYBFou2pMKp29uzMj8sajWyxDku+aWXMHj1dufhKbG4XREaNBu6yhVsIE3uTSyLRj29
	szyxDjdr8gqrwN22GB87mBKgl341lcmm7xIZF7XKMdvep0MDv3S/FhLNpXwEzE271ytUW85BYWJ
	+2RqSKULgy9T3zAH4ssA6EZbBgIUt7pFUlWCAZ4yuxn9da8GI8syjk5gYj4q1tztTs7OmJsrE69
	QskFnNaZJ2h/MorW64hBmV+DOTBdBnKTpW3b6halo5MXuSJHsPWQI95X5BOxmmaoc2IL4CLMraC
	Kf6ijaL/Uqlvr2zL+6Kwr386AUlxsOFVdEAhUwEbAruodHKBqNUSL5mQIpyDTNuSCIqlrXpRT3S
	fCce2vwW/5oC/Ltq+VWIC11YpMjslGhFC0JkFtCXSXsp9vjluXCM2f3/6tnrWireY+LKoFDI0yg
	l79uxhLgUl7mX0oOnaqvW3/wNZLbFYCevCreSNlCpyt0s4I6anmBLrz9u3QgqYoCRW/9rEovC9t
	2cPLctFD0ApajZqVoYrzEgAKmCv233cX2prxNV6XX0wJwoK0KcEt4FNZ60dJ5sCBMieFaWBfZnx
	9RosbLrpN8hB4AqrODlr
X-Received: by 2002:a17:907:97d5:b0:c29:c079:676d with SMTP id a640c23a62f3a-c49bdd744a5mr330020866b.3.1793237242153;
        Wed, 28 Oct 2026 18:27:22 -0700 (PDT)
Received: from localhost ([2a03:2880:32ff:70::])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6b4964488e8sm2081290a12.31.2026.10.28.18.27.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Oct 2026 18:27:20 -0700 (PDT)
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
Subject: Re: [PATCH 17/46] mm/khugepaged: preserve dirty bits when
 collapsing PTE-mapped THPs
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
 linux-cxl@vger.kernel.org, Chris Mason <mason@kernel.org>, 
 stable@vger.kernel.org
In-Reply-To: <20261027-fixes_core-v1-17-6f74bec9a5bb@kernel.org>
References: <20261027-fixes_core-v1-0-6f74bec9a5bb@kernel.org>
 <20261027-fixes_core-v1-17-6f74bec9a5bb@kernel.org>
Date: Wed, 28 Oct 2026 18:27:18 -0700
Message-Id: <179323723859.453251.1630776487784216917.b4-reply@b4>
X-Mailer: b4 0.17-dev

On 2026-10-27 00:17 +0100, David Hildenbrand (Arm) wrote:
> From: Chris Mason <mason@kernel.org>
> 
> try_collapse_pte_mapped_thp() clears PTEs without transferring their dirty
> bits to the folio. A shmem read fault can map a clean folio writable, so
> a later store only dirties the PTE. Losing that dirty bit allows reclaim
> to discard modified data.
> 
> The assumption that regular files are read-only is also obsolete since
> commit 1b6444331bebb ("mm/khugepaged: enable clean pagecache folio collapse
> for writable files"). In any case, transferring PTE dirty bits to the folio
> when removing mappings (and while the folio is still mapped) is the right
> thing to do.
> 
> Use get_and_clear_ptes() to collect the dirty bits and mark the folio
> dirty before unmapping it. Update the comment.
> 
> This was reproduced with shmem using MADV_COLLAPSE followed by
> MADV_PAGEOUT.
> 
> Fix generated by an LLM and sent by Chris Mason in private.
> 
> Fixes: 27e1f8273113 ("khugepaged: enable collapse pmd for pte-mapped THP")
> Fixes: 1b6444331bebb ("mm/khugepaged: enable clean pagecache folio collapse for writable files")
> Cc: stable@vger.kernel.org
> Signed-off-by: Chris Mason <mason@kernel.org>
> [ david: adjust comment; simplify description; cover file-thp as well ]
> Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>

Reviewed-by: Gregory Price (Meta) <gourry@gourry.net>
Tested-by: Gregory Price (Meta) <gourry@gourry.net>

-- 
Gregory Price (Meta) <gourry@gourry.net>
