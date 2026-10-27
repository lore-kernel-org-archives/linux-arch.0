Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.172
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793130214;
	b=FyI36d+qzpmdJIAG3g4jIhIMF7ydFIx4JMw/ZF8aJkpskzwljIOWXUxk9bUYitub6Oqu
	 6ChgAdlEEyKDLxa9glSnNKEOQ8gR1J4McXYrw5/tNRR83wVPX4s/XphsKiljorfOi0nYX
	 zRlerYWFMh6gLIdSQoqUjs/Et/Jde3PGItEs7c8t/5I8YTSjWajhk+sfni05Gx923AlXV
	 UWH2a28OfhiXzeMkEkKFReYfGE312b4Aj9BU12GBicXx/6NM4jnvcZPXg5rlScAYHPbsh
	 gd0Dsc45RyVERDpZlxKfHbquBSctY8yNrLoi/TUJmCq04qg2iJFYS+6XS+Cs14UlGdQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793130214;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=Kt3m2QX4pRtZBRcLH3IFIQTcdgR87dlcnUp5/WDyAss=;
	b=NRx2RPeLQY/ED+ZKngEbNhR7pMuFELXnd3hVwaW6kcyVZp9P3igBuO+zMro9Kyszxi/n
	 dbJ7zg7s7U2LNCXbNvpQh0kK1prA7LtNpuO8FZCcmy/Y2n+9a9ZdUjVtJsnquf6kPZH2g
	 q0mOKfguKZtjlB1dixEsb8ovZj9BsrOWivsJ3jQON5V0jklwGSHkt3o7FI/hxgcBqptLN
	 EZt25f4wB6xnV5LksFTsf85kSR8yInJQSboTwOJeai7jJF/cwuuzH0+Lw/81f0SFqfS+F
	 fn/4oKRagC/YBxOIxwxWdcZRkBlPoBVzEPoB5xkSCbwuY8vXDWzKduF+rfUV5i+MP5Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=fKvu3sFl;
	arc=none smtp.remote-ip=209.85.214.172
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0026606A31E
	for <linux-arch@vger.kernel.org>; Tue, 27 Oct 2026 19:43:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org F0026606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=fKvu3sFl
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-2db33db4de9so14855ad.0
        for <linux-arch@vger.kernel.org>; Tue, 27 Oct 2026 12:43:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1793130212; x=1793735012; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Kt3m2QX4pRtZBRcLH3IFIQTcdgR87dlcnUp5/WDyAss=;
        b=fKvu3sFl+ouMpBGe8QCxA/Po0tluUmY2cadQ5kspAESt99gU0otrCAvnCSeV7d6AMG
         nOJN76SW+5T4b89TdCObf7StqhqC5yuKT0Xa/e/MapWdVtpzLtKN2Qlut3EgtOYh/7BP
         MPFGdTIbjbI3NMLynzjswqcJUo6qUs4Fbp/l6sbS7XErYabWce0lM97r2Muq1h+B+NOY
         yACxHY1q+u2K8gXE1fj0nLilv5P5r0KMvBJx1xD0NR2cp9VharpDnFu2LcIgoIKT6gV2
         PJlApj1CY8zjAhY9JN3oV8+YwlHOQb/i9h/w7so1nt9/GQ6yRkZ8QtO/Y3IZocJ0d2Lu
         EPaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793130212; x=1793735012;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Kt3m2QX4pRtZBRcLH3IFIQTcdgR87dlcnUp5/WDyAss=;
        b=nNnbDWB1/hv0h8KSDzgBav452GHHUd8fdZ3E9pWYaHc56mAoA3316F0+LHw6QC2zFs
         eu+jAFzcFb8oHODNVTGgAAoT3j8fEqd/JSeJRlCer8NZRQVPvBOZLbZHcZtLS98U3Ylb
         V30g5pphgppCI5oYlW+7HYtSIrBDsHTnlXqVzrQFasfZZSxAZ2HnKULmsXJ0wcuD7qE9
         1OSkzlR/P4neG5sP2D7iezdc3tBP/i7Mm5zx1V1eeuZI6pJTeRR4tmoCSm9SbqX9Sk1+
         xoRms1nouPgrd2f+FLHwj930z3GGmh09ooIbcCxUp3K5qz58KK115GVzMF5GFZa8RUHk
         znhA==
X-Forwarded-Encrypted: i=1; AKwUvBwr+qG53Z4zGPwwFixmTyx6EjKQJ3u/SX9v8GYv/DNmLaKSEOOAHM3DfTt5MUgJUqD5E77JUfX3efnX@vger.kernel.org
X-Gm-Message-State: AFq9FYL/Wh+Up+/mJOV+PsQXSw9CcBf2KPz3XUa4ilTdywdA0c9XSYhi
	4CuWWg7qOgbjzVHp6GCN8ExdHynLiNvup48ks5NDAWwki5fqY5nf9iPsqBZrgaNODg==
X-Gm-Gg: AYBFou1oQEzGJUKNCpqP66r3fMYB8zZ2iR3gaG7Qnzg6irN9WJkVQynEEftQVh6Jcst
	H2bgfReRwFD2hQE4DXq4/e+uqWSlOt077ikKFQTYOkElmwRVLHY9ntnQpGKeYS5HQRHBbhj022Y
	DsX85yQYa5lXjwnEH+g285d+t//9wzCSOmqHZAJTTbMGP1TbUIZFQeaVKvxVNLYONrZ02HTQesa
	QyRBKTV08BA4N1CdfiLMJswudFopMcjhRlNoxnR0UPhL3W3uh6vXzFeIcH5XcxpqpoTol+jwiT8
	PRU9rCJPPgEyMALoCFEYklQTWmAWXUtyjgGAl+9SH2OcOouzveLnFIuZg8K216ZgvTnexlSMCNS
	WcDfptWrvGGwA0x1nrTMrpxOY8CJAEfUst+5/OpAW3pBJpHOc6Ly8W/nmhSWMUdAke2c6FXSVJ0
	4bF19j911pPgeQvw91EuDSGElfY4i7cfGMQlSh9D+fWv16sT5smW5a9iafCI/jbizrZF8CTPxl5
	Hsl/GxpzypoGsr33I82fgMSNScrertcwzwO/tfRTOqNFBpeOIx/FJvqV2O7G/CtHcpu4N4If7uH
	Pc0skI+wm1lmih5e6E/IKUEG5OeV7z948p23Z8t0UpQMXtHo
X-Received: by 2002:a17:902:d550:b0:2ea:4a1:e8a4 with SMTP id d9443c01a7336-2eb01986bddmr124955ad.13.1793130211108;
        Tue, 27 Oct 2026 12:43:31 -0700 (PDT)
Received: from google.com (163.1.145.34.bc.googleusercontent.com. [34.145.1.163])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ae578f19b3sm251941a91.17.2026.10.27.12.43.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Oct 2026 12:43:30 -0700 (PDT)
Date: Tue, 27 Oct 2026 19:43:26 +0000
From: Samiullah Khawaja <skhawaja@google.com>
To: "David Hildenbrand (Arm)" <david@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, 
	Johannes Weiner <hannes@cmpxchg.org>, Michal Hocko <mhocko@kernel.org>, Qi Zheng <qi.zheng@linux.dev>, 
	Shakeel Butt <shakeel.butt@linux.dev>, Lorenzo Stoakes <ljs@kernel.org>, 
	Kairui Song <kasong@tencent.com>, Barry Song <baohua@kernel.org>, 
	Axel Rasmussen <axelrasmussen@google.com>, Yuanchu Xie <yuanchu@google.com>, Wei Xu <weixugc@google.com>, 
	Baoquan He <baoquan.he@linux.dev>, Baolin Wang <baolin.wang@linux.alibaba.com>, 
	"Liam R. Howlett" <liam@infradead.org>, Vlastimil Babka <vbabka@kernel.org>, 
	Mike Rapoport <rppt@kernel.org>, Suren Baghdasaryan <surenb@google.com>, 
	Michal Hocko <mhocko@suse.com>, Kees Cook <kees@kernel.org>, 
	Peter Zijlstra <peterz@infradead.org>, Jann Horn <jannh@google.com>, Pedro Falcato <pfalcato@suse.de>, 
	Hugh Dickins <hughd@google.com>, Pasha Tatashin <pasha.tatashin@soleen.com>, 
	Pratyush Yadav <pratyush@kernel.org>, "Matthew Wilcox (Oracle)" <willy@infradead.org>, 
	Jan Kara <jack@suse.cz>, Zi Yan <ziy@nvidia.com>, Lance Yang <lance.yang@linux.dev>, 
	Rik van Riel <riel@surriel.com>, Harry Yoo <harry@kernel.org>, 
	Alistair Popple <apopple@nvidia.com>, Nico Pache <nico.pache@linux.dev>, 
	Ryan Roberts <ryan.roberts@arm.com>, Dev Jain <dev.jain@arm.com>, Usama Arif <usama.arif@linux.dev>, 
	Kiryl Shutsemau <kas@kernel.org>, Matthew Brost <matthew.brost@intel.com>, 
	John Hubbard <jhubbard@nvidia.com>, Peter Xu <peterx@redhat.com>, Will Deacon <will@kernel.org>, 
	"Aneesh Kumar K.V" <aneesh.kumar@kernel.org>, Nick Piggin <npiggin@gmail.com>, 
	Oscar Salvador <osalvador@suse.de>, Minchan Kim <minchan@kernel.org>, 
	Muchun Song <muchun.song@linux.dev>, Xu Xin <xu.xin@linux.dev>, 
	Chengming Zhou <chengming.zhou@linux.dev>, Chris Li <chrisl@kernel.org>, 
	Kemeng Shi <shikemeng@huaweicloud.com>, Nhat Pham <nphamcs@gmail.com>, 
	Youngjun Park <youngjun.park@lge.com>, Gregory Price <gourry@gourry.net>, 
	Joshua Hahn <joshua.hahnjy@gmail.com>, Rakie Kim <rakie.kim@sk.com>, 
	Ying Huang <ying.huang@linux.alibaba.com>, Jason Gunthorpe <jgg@ziepe.ca>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, kexec@lists.infradead.org, linux-fsdevel@vger.kernel.org, 
	linux-arch@vger.kernel.org, linux-cxl@vger.kernel.org, Chris Mason <mason@kernel.org>, 
	stable@vger.kernel.org
Subject: Re: [PATCH 20/46] mm/gup: fix clearing folios in memfd_pin_folios()
Message-ID: <auD-r_lTZ71vbSKu@google.com>
References: <20261027-fixes_core-v1-0-6f74bec9a5bb@kernel.org>
 <20261027-fixes_core-v1-20-6f74bec9a5bb@kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Post: <mailto:linux-arch@vger.kernel.org>
List-Help: <mailto:linux-arch+help@vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-arch+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20261027-fixes_core-v1-20-6f74bec9a5bb@kernel.org>

On Tue, Oct 27, 2026 at 12:17:40AM +0100, David Hildenbrand (Arm) wrote:
>From: Chris Mason <mason@kernel.org>
>
>memfd_pin_folios() pins folios obtained directly from the page cache
>without checking whether they are uptodate. However, shmem fallocate()
>can leave newly allocated folios uncleared and not uptodate. Callers
>such as udmabuf can then expose uninitialized memory to userspace.
>
>Clear non-uptodate folios and mark them uptodate under the folio lock
>before returning them to the caller.
>
>Fix generated by an LLM and sent by Chris Mason in private.
>
>Fixes: 89c1905d9c14 ("mm/gup: introduce memfd_pin_folios() for pinning memfd folios")
>Cc: stable@vger.kernel.org
>Signed-off-by: Chris Mason <mason@kernel.org>
>[ david: simplify description and comment ]
>Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>
>---
> mm/gup.c | 14 ++++++++++++++
> 1 file changed, 14 insertions(+)
>

Reviewed-by: Samiullah Khawaja <skhawaja@google.com>
Tested-by: Samiullah Khawaja <skhawaja@google.com>

Thanks,
Sami
