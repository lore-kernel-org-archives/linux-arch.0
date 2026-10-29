Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.208.52
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793237119;
	b=0LEwdF6ODG9nameEgKzMwQFEjwPpNMv+jHOb2eTIGIFd3CStdv3UZfiupjxu7Auo/aAU
	 0mMk9Q8OAufrDAxbx/O2h1fOBa4p9rLyiz0T+dszUOKdqzdkCGI8nghSxxYR8V0fooQBG
	 bST2ksnAPXjR726/iiZYbtDgTZnCjjoxJyb10D2YSAu1jWFpqEWwU90PJWNLzDew3HpXn
	 8dXsbtu2ABqmX5n6+rJ+9ifOiEs7XHXTZ7Z4I/SYagvvP7sXS1oy085NFdgdQ4HGXYR45
	 cB725Qw1c6khPzT0jw6mwis46YBhlE4qiSNzywgoB++esjfW/ioYQJ9HRr38unRl2Sg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793237119;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Subject:From:To:
	 Cc:In-Reply-To:References:Date:Message-Id:X-Mailer;
	bh=M/AMFbjA9JAsBdCFWz1LANgAn0knNna+7jo0zCTOlPs=;
	b=fKZdWgyeycayf4Z6WP98KEAKCnh58aOMHis5p9ejXzT2mDmu1+LAtPeiCwBvikMdhBQr
	 ekNHAK5d3PxsZjLwZ0n8FR4A8+/Al8adwPSF5RHGU0z5Zs5fw8Jehfed2UdcTUZnDzrX+
	 lEBhqZ0S6g0F1uMuoWcnovCHujt1B2wvHvudElJ+GY8RGK0L/cBtetMtICU2s5AFzbcEe
	 lWbx4ArdCeGuUiMLq1mRjnzNSGBpEdX7oGEpigytDWh9krE1eoL3TAvhgQL6EUvnBEnke
	 SiYWerwkbxdDF5R4wGcyu2Ai9co9mRgfSZj39cwDsB3JN2vHw/1K7vRBa1X/q3Hq2ag==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=gourry.net;
	spf=pass smtp.mailfrom=gourry.net;
	dkim=pass header.d=gourry.net header.i=@gourry.net header.a=rsa-sha256 header.s=google header.b="dKbXebD/";
	arc=none smtp.remote-ip=209.85.208.52
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50C31606A31E
	for <linux-arch@vger.kernel.org>; Thu, 29 Oct 2026 01:25:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 50C31606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gourry.net header.i=@gourry.net header.a=rsa-sha256 header.s=google header.b=dKbXebD/
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-6af9a9451daso1919040a12.0
        for <linux-arch@vger.kernel.org>; Wed, 28 Oct 2026 18:25:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1793237116; x=1793841916; darn=vger.kernel.org;
        h=message-id:date:references:in-reply-to:cc:to:from:subject
         :content-transfer-encoding:content-type:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=M/AMFbjA9JAsBdCFWz1LANgAn0knNna+7jo0zCTOlPs=;
        b=dKbXebD/Kz5RrzY9zIOX2TAzQyje12YXIX6BEU97N+70d743t4+zz64N2BY5+vNE13
         OXwYaxTZ8oKtLdTdYLTPLMEE9F2vNcrT6kyP1tf7Dmn7p57PYo4L9nBNQi/FudpFnR5b
         +XsB6boiBflVvOvMlOCFZPeFRZ3pFDdtuteDN4sen0mZmPK04Ov/NfQLal5Uyd6StLF8
         cEfUIMmY6v7kY0hK+enA+FF2fuBz2L0KEZLz2nWtzyW1/w7YOEkUsRVd5gRiHIE9jeJ1
         qP9Ufy5IhnamVXBXfMLGbEV+GTT/Rs1ck7iCVEv930CoSEkO80891Tu1LkvjM4F9UygK
         4/lQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793237116; x=1793841916;
        h=message-id:date:references:in-reply-to:cc:to:from:subject
         :content-transfer-encoding:content-type:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=M/AMFbjA9JAsBdCFWz1LANgAn0knNna+7jo0zCTOlPs=;
        b=ZFAeX3k5Mz/j5FzJizB0Lk0b5IbOl+iLart4FDizLQrXdmqK3tD1xFTFKEbB7dJ4Fm
         1q+VpRozF1oIktSdgrd3TKtbGYQE8gPP4iBogvjJ8gVvtU/k+4t4tPWg8OnVQfFyyNT3
         tXlmfZWMiP2YuawU+AH4+2Oob6SBAP1+s9kiQTMx58WaY/f4mkXsGtVdS+Y31OwHZMaj
         Ocp4s/S51HlHAutJ2+bPOThvyXpiunEZeKNfKq/abPB3iogxXOfjPtEO0p/Qp1ssU2Bt
         QRI8qLrDxlfS+aJkEr039/Hd+JkExVbD9L7GKu89Zv2jR9yaMfAIYPTL654EAU9x4c0f
         60ag==
X-Forwarded-Encrypted: i=1; AKwUvBx2n+yUxIXLiIWfdVBZvJm9nbnZkOC2dGCv23UiIFhyVT1TTfR+kzMvl4eUxxeXxxnTTzjFRvqhAFdr@vger.kernel.org
X-Gm-Message-State: AFq9FYIhJgTt5jA3zo6D3xrl5SnGwhv27sqWYIqjSrtLrAAE1aKRksOd
	5nvLwdcGI4c7yXmkUe6s3QjCeGd8F6mkFhg/ESM3pPEZXq2M74mGTL/vaEox50SinmY=
X-Gm-Gg: AYBFou0TwgiqkI658ZD05mMJ+f2u5Ucv7Y81DJSgtQw/cfT36mDwpyJeRom/cMKcd9j
	45j4nG/EAO0B+6jB5ffeaW2QDy/GqFRGA829V2GJbWxo35zVLzjycUuAalFv0jPPVbh+UkMYZ67
	qYVzJtDZqJPFxc1gZunufHNl2vqe081wVhgctjBqkX6TquExhe3zd5NfMOssn32EvYmwu4gDUyG
	Fp1TPe5QW197N/rmNMv+EMcL1LS0uRJ9ywFBIclwR152qsTJYlNhhfBDB20WIOA17d9ROlN10Ej
	p90zCEfLjuto4lyigmnM3ddpDnvXWnuESbpHQ3H35FfxJXsY3BqmawfJ4LGecrVo5o54fu5dAy0
	aXpUYNTzNu9fq4Vjc+x9oS9gDU6ZDI7qXbiOEOhs/oJaVgXs5Ette+fdJ9FxVVrDqmhXgsWIEpV
	f7J99c4+E8ywdJEJSP9F+ltjnAfV3FXFpC1TmWXL2EKUwIYqcmU0jqw2gwnee6nRWKyuGT2GFJ5
	hvEDdP1mdiOoLt9R53AtGBL7FkFy+5p6dmeiqxG+cKsuvUtFJXPcR2vJkYB0RExeqdgJo3fV5ZL
	Jr9mkSM0hbT6Ul1qACM47W0nDcMB7Lfcq2xRHQ70iw==
X-Received: by 2002:a05:6402:234a:b0:6b4:7b28:8588 with SMTP id 4fb4d7f45d1cf-6b49cb5a33dmr2836967a12.2.1793237116591;
        Wed, 28 Oct 2026 18:25:16 -0700 (PDT)
Received: from localhost ([2a03:2880:32ff:7d::])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6b49644bcd7sm2122970a12.33.2026.10.28.18.25.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Oct 2026 18:25:15 -0700 (PDT)
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
Subject: Re: [PATCH 16/46] mm/khugepaged: fix PMD table lock leak in
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
In-Reply-To: <20261027-fixes_core-v1-16-6f74bec9a5bb@kernel.org>
References: <20261027-fixes_core-v1-0-6f74bec9a5bb@kernel.org>
 <20261027-fixes_core-v1-16-6f74bec9a5bb@kernel.org>
Date: Wed, 28 Oct 2026 18:25:13 -0700
Message-Id: <179323711320.453251.11778195785979033843.b4-reply@b4>
X-Mailer: b4 0.17-dev

On 2026-10-27 00:17 +0100, David Hildenbrand (Arm) wrote:
> From: Josef Bacik <josef@toxicpanda.com>
> 
> For a private mapping with userfaultfd, try_collapse_pte_mapped_thp()
> takes the PMD table lock before it maps the page table for the second time.
> If that (pte_offset_map_rw_nolock) fails, because the page table vanished
> in the meantime due to concurrent page table reclaim, it leaves through
> the abort label, where the PMD table lock is unlocked if it differs from
> PTE table lock.
> 
> In case the PMD table lock and the PTE table lock match, which is the
> case without CONFIG_SPLIT_PTE_PTLOCKS after pte_offset_map_rw_nolock()
> failed, we miss to unlock the PMD table.
> 
> To fix it, forget the PTE table lock when we unmap+unlock the PTE table.
> 
> Fix generated by an LLM and sent by Josef Bacik in private.
> 
> Fixes: 6375e95f381e ("mm: pgtable: reclaim empty PTE page in madvise(MADV_DONTNEED)")
> Cc: stable@vger.kernel.org
> Signed-off-by: Josef Bacik <josef@toxicpanda.com>
> [ david: move the ptl = NULL handling; rewrite description, drop wrong comments ]
> Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>

Reviewed-by: Gregory Price (Meta) <gourry@gourry.net>
Tested-by: Gregory Price (Meta) <gourry@gourry.net>

-- 
Gregory Price (Meta) <gourry@gourry.net>
