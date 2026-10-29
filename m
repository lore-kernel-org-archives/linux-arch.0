Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.218.54
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793283235;
	b=bKFUn6GYxprPVdGVk02AY1UjkPp+vGGxCf97YWrjhE4Tm5hq0+/gIwi2c7WCVko/xFdb
	 zVZXxxvWl2oFdljLF2TtHj/ETYW1fwFG7UlzFL6watLpY5nUjMUxFYRHRthSiPq3xl4Y9
	 RDxrg0LMxN01vcOLw3Lyct1HzJlDjIYi3Y/5w4+Q3F1vUIPD3SHmoQfPQhoy7lnD8YDet
	 jYpr+N4PqSUZZgRKE5ZjjneCDJnWWBTYS8+pmMn02J/FgGBPP+MckDjYuibh+XMJISwrU
	 N2aVo2LF/TjvcTo+9C+pvgO+WgIM0JaLcSXInON9TqIVxL1erMny3toAAbHE7aPHJug==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793283235;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Subject:From:To:
	 Cc:In-Reply-To:References:Date:Message-Id:X-Mailer;
	bh=VHQCBBokr9ANF1mnkSximMg4YC5imaFH/YUHtOF7V4U=;
	b=ui5cFEMOpaoY6yFG0XB9YKvWKEDsNKN1j8GBPmi1yMYFh/VlztwSZt2s3XE4ttONqVtm
	 jrZg9H9/GjJ+8UOZVtIqhVVkc7M7vqy4PsBsvJqT8ZoxCrvHATNVQ6dJ6jO64JUP5Cxsr
	 wlGdYr9ZrLrksG7p9ODjzqvhMAUL4/iMg0ikGRIdJeqLhPo7vBQg/Xn98aEQRS+SJ4j0P
	 Gs6RWcrtRSyCRsKwmcGk7RSM134QtHitTvENzc0flV5RFAlBzKTvVEY+sGk8LqPtLRnXb
	 rPfGmyyaH589iU45Jq1yytavnCxVghaYhWT925cpQnCn1jPMddzpF6Zxo7clhAlnIrQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=gourry.net;
	spf=pass smtp.mailfrom=gourry.net;
	dkim=pass header.d=gourry.net header.i=@gourry.net header.a=rsa-sha256 header.s=google header.b="e5/0LFuu";
	arc=none smtp.remote-ip=209.85.218.54
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90343606A324
	for <linux-arch@vger.kernel.org>; Thu, 29 Oct 2026 14:13:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 90343606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gourry.net header.i=@gourry.net header.a=rsa-sha256 header.s=google header.b=e5/0LFuu
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-c4203bbb1e9so349565166b.3
        for <linux-arch@vger.kernel.org>; Thu, 29 Oct 2026 07:13:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1793283233; x=1793888033; darn=vger.kernel.org;
        h=message-id:date:references:in-reply-to:cc:to:from:subject
         :content-transfer-encoding:content-type:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=VHQCBBokr9ANF1mnkSximMg4YC5imaFH/YUHtOF7V4U=;
        b=e5/0LFuukNHW7lzYuFosRJh+HCYXR9pyFNiQxvyIIBVipBFBgPFdS4+6o0e/VLtSHP
         D2NV+uWECYwfjgApOljWOGHKCse0y1GozqH0FgOpVe2BGPs5fNsPIa/znV1SPRUcfRzC
         S2HvVwG+whXsWeX2XViUnh1wbiyPOAgZYzqXUt26yduzQ4O2OmGCssgjZkXAmf+1GtpK
         qCiL3bvCUG1uU/sMo60Z4jhr+nRw7l3FkT58U3zkvqVemdPsgtw1581thB5KWAkrpUg5
         ZQXV5QFXWQJRc25kncj0f/n/AZy335nPp8YBto+psFG1ofitw09eWSoKIi34kVGWTlCu
         Ewrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793283233; x=1793888033;
        h=message-id:date:references:in-reply-to:cc:to:from:subject
         :content-transfer-encoding:content-type:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=VHQCBBokr9ANF1mnkSximMg4YC5imaFH/YUHtOF7V4U=;
        b=kiBkqfc0oT0W1SkV/b8SakcGTAJhj/Myn0R2VRFSunLyCSp1YeFG3llzErUzOCK5jy
         v2WH7vwgeEhy97itwsYpBE2rntnRT9jRIDBE+4zksc9Q546jl7XloFYSW7G3tIP7rCO3
         Wp5VX4TtDG6i9l8yapbGXnY4MTNC+uBTlkWVhjcZbqTwDWlGyaObA8zKoER9N48YbCgt
         LXRoKXDNVflCvHopMucrmLzzahjYjL1fXzqLXBjBeV9+eS59V0cKgQkXZsZNzReBJ7JA
         33XbHZqnQymvJaC/NentPrU7ZjKfkUCEZIDrXHSXWH2J8XY5B8UIHCi5oqIpfZ2C4VHg
         RetA==
X-Forwarded-Encrypted: i=1; AKwUvBya1D/EI1UqkBOk96nuryxMzqShuTGe6TTnf4OyAQvhifoFR+nRs17uoyytgKHd/7476yf+k6DKAZ+M@vger.kernel.org
X-Gm-Message-State: AFq9FYJKAty1uo01nPElcBRl1bSl82t49GkgGrzQXog5AzctoAAxl9KX
	Ba942YM0HthcVVXxxA/wP3CYleWu0IHEl6TpK9JXwjBo0UzQv0cSCykgd5z/nqWg3bM=
X-Gm-Gg: AYBFou0ka4DmYMRY9NoDUlQlWuAAsK5mpITEYDLxjkKm/FDAwQ6d2hAatbulsRVyqQE
	cOuJ3K7Xw+0jNqiZxyvhAgQ2o1crG4tt0ZKR5XyZfJs2oubaOK/0U82xRxcrdXg82U3jCX+5GA9
	aB2+UCMcUyCoSpx/EeSfCaVWUwfox1cTHIuwR5AhcIdp+DM0y0uE6TfsYxXHNPzzrYLzCuPyPAd
	Pba6YLIKaJ42kBYEyZQ0ZYVwKV3EK4L63s26GzIqV+Y8eCP5YI02tcavyMiGUCLhYyQnP0NrTmD
	U094zc6racfQuTnCQcBhJr82GMdg6G3hDvoGuMWd6AT/GMLtd9FPy76VWm9psiE7KdgZCcNzx0w
	mIUbX+DzHu22Yd/McA9Iczhj8q7n2HCVGtCx1sd/FK2U8zIzY0Ug0ES8bux4rDqOsP8AqUFVjha
	2ZDgjv4uPIeLgAyiDfiWtTA81mFC6SpbawGK+OjzDCmR5Q9Z1YSjPdLMZYBih6AuA008ilWAaNf
	ASASx94v3HciO+O4Q1CF45Ur1yg7+/dwRa7OcGUeSF82jA4lERzOCbmn+tSja4cnRyuc/RKYxMQ
	AEW+F3PhzO7VmiTTsp4=
X-Received: by 2002:a17:906:7313:b0:c45:c030:732c with SMTP id a640c23a62f3a-c49be03a73amr545832866b.41.1793283232717;
        Thu, 29 Oct 2026 07:13:52 -0700 (PDT)
Received: from localhost ([2a03:2880:32ff:4::])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c4992141068sm521507866b.60.2026.10.29.07.13.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Oct 2026 07:13:52 -0700 (PDT)
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
Subject: Re: [PATCH 18/46] mm/khugepaged: check if PTE table is empty in
 try_collapse_pte_mapped_thp()
From: Gregory Price <gourry@gourry.net>
To: "David Hildenbrand (Arm)" <david@kernel.org>
Cc: Gregory Price <gourry@gourry.net>, 
 Andrew Morton <akpm@linux-foundation.org>, 
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
 Joshua Hahn <joshua.hahnjy@gmail.com>, Rakie Kim <rakie.kim@sk.com>, 
 Ying Huang <ying.huang@linux.alibaba.com>, Jason Gunthorpe <jgg@ziepe.ca>, 
 linux-mm@kvack.org, linux-kernel@vger.kernel.org, kexec@lists.infradead.org, 
 linux-fsdevel@vger.kernel.org, linux-arch@vger.kernel.org, 
 linux-cxl@vger.kernel.org
In-Reply-To: <f9067f65-fcdc-4ebb-bbf8-84db9e22af0d@kernel.org>
References: <20261027-fixes_core-v1-0-6f74bec9a5bb@kernel.org>
 <20261027-fixes_core-v1-18-6f74bec9a5bb@kernel.org>
 <179323853182.453251.8510731747954180380.b4-reply@b4>
 <f9067f65-fcdc-4ebb-bbf8-84db9e22af0d@kernel.org>
Date: Thu, 29 Oct 2026 07:13:51 -0700
Message-Id: <179328323124.453251.12177231963891458248.b4-reply@b4>
X-Mailer: b4 0.17-dev

On 2026-10-29 12:01 +0100, David Hildenbrand (Arm) wrote:
> On 10/29/26 02:48, Gregory Price wrote:
> > On 2026-10-27 00:17 +0100, David Hildenbrand (Arm) wrote:
> > 
> > I get that you want to avoid taking both locks while zapping, but
> > wouldn't it be simpler?  I suppose we don't know what kind of
> > regressions might pop up with that though, bah.
> 
> Exactly, that's the spirit of the original code. We would just block a 1GiB
> range of va space for the entire operation.
> 
> If you think there is a more elegant way of doing it (while minimizing holding
> the pmd lock), please shoot :)
> 

Elegant and this code do not appear to be compatible.

Another look, i think this is the preferred route.

Reviewed-by: Gregory Price (Meta) <gourry@gourry.net>

-- 
Gregory Price (Meta) <gourry@gourry.net>
