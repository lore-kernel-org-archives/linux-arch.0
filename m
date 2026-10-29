Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.219.46
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793313455;
	b=189Iia8YVrqjxN9QzZuo3uBAkwjnt/1pS7+nx3BuLgo7utWT/HdeEAutNUNhmEZdGByj
	 AmtRf6D9ujrhTHeTuhSk7AEp4d9bHeSp1vStpRATwJqUwqQryyn4EuBuFbUdCnrLF/L8u
	 ORplwy65PmGvM0k+7jPQbhYbBxYOc9tAQ3ffX+kpVBbmbCbyHCvkGMe5m/sZKWoJAP+oB
	 G7E1B5oD5kfUyOttENvux6OnKZsHHSd5uqzcHW2uuuV5DDM7/HZu1Ac+Rh4u1F+uCYVkY
	 uiicgaKEtqeCVmlHBCtRbJdXiQ5J7EkDsroWlp0AS9p9PTtznhG7YkL+dVjzAdvG3Vw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793313455;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Subject:From:To:
	 Cc:In-Reply-To:References:Date:Message-Id:X-Mailer;
	bh=QsPG26s54J59UedVlJRCxJXndkzu8TR98XKtjA3+1AU=;
	b=RXcL9q/Mppx6IcThK45tnrYBHJiZrzPxaZaQE7quTR3owYrYiuKt92uzCIvwuBfn338T
	 9+6/JSshnIJMblHMCNDdNW/sAh9y35Ree8dm7B0Xj/xHWYoLgzKSzzjgXVjbYd3FlXr3m
	 snePEPV9eegPJF84ZYF229+tiE+4fWR+yds7xKZodQbaU8oGS97KFLRRfAAw3PGJmcsUh
	 IlIc0g5hu1xhUZ9YEyBzKhNNnjr+qcc+wTdPJnzuNPnjH6pTecGRYSzr33/ooY3XuaXfz
	 RM/6OVj/dK0czEH0EksiJlvag0pOlBlozg8hVmpjfacHMRYhnoz/ARCZ+Es6UhZ9sqw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=gourry.net;
	spf=pass smtp.mailfrom=gourry.net;
	dkim=pass header.d=gourry.net header.i=@gourry.net header.a=rsa-sha256 header.s=google header.b=Dj8dQusc;
	arc=none smtp.remote-ip=209.85.219.46
Received: from mail-qv1-f46.google.com (mail-qv1-f46.google.com [209.85.219.46])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C1F6606A31D
	for <linux-arch@vger.kernel.org>; Thu, 29 Oct 2026 22:37:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2C1F6606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gourry.net header.i=@gourry.net header.a=rsa-sha256 header.s=google header.b=Dj8dQusc
Received: by mail-qv1-f46.google.com with SMTP id 6a1803df08f44-91c7a706b1fso16914236d6.1
        for <linux-arch@vger.kernel.org>; Thu, 29 Oct 2026 15:37:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1793313453; x=1793918253; darn=vger.kernel.org;
        h=message-id:date:references:in-reply-to:cc:to:from:subject
         :content-transfer-encoding:content-type:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=QsPG26s54J59UedVlJRCxJXndkzu8TR98XKtjA3+1AU=;
        b=Dj8dQuscI3pp1qYG8b6KcXsqNxRwgQE+IOWiM0vtUQjEIGh8IwfaD3RVp2Sq+NkZSs
         qHMoSLCbstd/15wF5Qxa2sDK2cDninOwTqsTFByb6LIZeWLpAf55M+HCw+VO3z1ZiSFz
         Z6Y4/NbXOjcmI5YX9a9L3/cxo+EMOJApGFo2tjQ4Jll0Em88E0c83dh9v9h6SXqNx/On
         2wHea5ofylJY3o3NA05JXNgsRQace0begultrDe7a7ROFS6WKgW3x6gh7nqOxJ4i7bJv
         /LExpfmEtFE9vVmiUbQF1EWeWQYpAQErRDpp4Wwd5p72d7ZyNPjiJeWH54OxSiUGzSXi
         GcSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793313453; x=1793918253;
        h=message-id:date:references:in-reply-to:cc:to:from:subject
         :content-transfer-encoding:content-type:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=QsPG26s54J59UedVlJRCxJXndkzu8TR98XKtjA3+1AU=;
        b=UGZFFVwWzwikrA5QwT83cXUSYOEDpJsfbplOJQeJCusLybxvnWL2+HmQUycLTFyLHD
         HDfFs8cUgibn+JkDkHam9Ie/z8Jxp2o92WGDzPogJSgFMzIftgWRX17VTtKM8hIbl1iN
         6mh1OlhlkYjtlStYHVvg55SpLER7lzOjfN6L/yTA8clNX+MbFHTIZEVY+I4nVfyUImal
         Wm5h9TRzfudWevw/skvChW9xs0CfcRIBks7dhMALWNl8cAK1G0KtdktVzaVpxTnh3TAp
         oCjchii96ZVswRhMv3U74v1UBLdCLCNPV57Fk1Rst+/i27DcgVmrUiDFT4s9L1reNIcs
         36gA==
X-Forwarded-Encrypted: i=1; AKwUvBydQhzIz7kegRhbPGLEQJgNKF68E8zyLTv/z4fgqzxXg019nsP2/7IxJ+S6ZK5dNhRFuLp8ulYLazs3@vger.kernel.org
X-Gm-Message-State: AFq9FYIePERMhFeKVLh5fs0a3p4Vyn2Cvp8PtthFPTFBPtVe32uVdBX1
	olZ2MlOOM6wj6WjrViTnFk9u/m5O3hBm/Ag5NTaEltoVqPovg+oNZ0J8oiDOhmU40cQ=
X-Gm-Gg: AYBFou2x6hcYNO2PM1j8g0iLlF4prKmVtZ+wvK/CXxr/Vh0isdEtGt26m9TkEoM82Tg
	MFrNBiRpPUWN/btWmD7Wm1i+MOiS5dqnpDQgvgwKMS+kZEOYZ+u+nzepuDlNEL5b2xjXnq4vVLM
	UU/mthDhmaK/gsgcbDiqKDZ2w3FVmHIgm/LHzARZIN/ykvs4vipKx0UXhWlF+VeBO/OeQJtgvsJ
	YZ2xEYMNPMvZFle5D9AdIm5QOUtr4u//LpBtDVHXkAWuSd8HgQuPuWbx+/cdSZJ448YdY3LwkYM
	uZiBqGMLeqBGK8OzkO/F4AGGQlGqXFfVfIuUFjmmelscKXdUbs3CPDfEFyGKZWItbGFPjDtsJKj
	2n8Md8pgJnnWjunU2+Bdkkmv6YXyaj7wUdrrQGm8SPQPWwmk2bJkEDajdhbqKEr0UQMsQnD5Irp
	89DXHdmugJcBHBI3J5xQM4azKrCetPeeDenchxj0HV6tcaC1Q2XKhrQdQ8PMoACud43dyGTnLkO
	SZnxFlksIRpIxV+xPNuojlJfVOBKiXvKNTUqQT5wp+5yn8KCKPEFxXABU7Zk2hdpm6FJlljippe
	JHiOq6jFsnImFnlXXI45HQGWjfMZQsGn6nYR9Mi50j8zzhrzqv/442YbQehV1/K3h6gQkiiKKt9
	/uYLd2T8RZwFLc56kPPIilg==
X-Received: by 2002:a05:6214:401e:b0:917:c073:1b98 with SMTP id 6a1803df08f44-91c90686fc8mr65881526d6.15.1793313453118;
        Thu, 29 Oct 2026 15:37:33 -0700 (PDT)
Received: from [192.168.86.58] (pool-173-79-60-52.washdc.fios.verizon.net. [173.79.60.52])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-91ca6855ea1sm646896d6.8.2026.10.29.15.37.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Oct 2026 15:37:32 -0700 (PDT)
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
Subject: Re: [PATCH v2 13/47] mm/huge_memory: fix truncate racing with PMD
 zapping
From: "Gregory Price (Meta)" <gourry@gourry.net>
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
In-Reply-To: <20261029-fixes_core-v2-13-a64ce7f83abb@kernel.org>
References: <20261029-fixes_core-v2-0-a64ce7f83abb@kernel.org>
 <20261029-fixes_core-v2-13-a64ce7f83abb@kernel.org>
Date: Thu, 29 Oct 2026 18:37:31 -0400
Message-Id: <179331345102.2127828.8211829708894165734.b4-reply@b4>
X-Mailer: b4 0.17-dev

On 2026-10-29 21:33 +0100, David Hildenbrand (Arm) wrote:
> From: Chris Mason <mason@kernel.org>
> 
> zap_huge_pmd_folio() removes the rmap before calling folio_mark_dirty().
> If this was the last mapping, truncation can skip unmapping the folio
> and proceed without waiting for the PMD lock, racing with dirtying.
> 
> ifs_set_range_dirty() can oops if MADV_DONTNEED races with
> ftruncate() on XFS, when we get the folio set dirty after it was found
> to not be mapped anymore.
> 
> Move folio_mark_dirty() and folio_mark_accessed() before rmap removal,
> matching the PTE zap path. This keeps the folio mapped while updating
> its state, so truncation must wait for the page table lock.
> 
> Fix generated by an LLM and sent by Chris Mason in private.
> 
> Fixes: fe6cf984939d ("mm/huge_memory: transfer the pmd dirty bit to the folio on zap")
> Cc: stable@vger.kernel.org
> Signed-off-by: Chris Mason <mason@kernel.org>
> [ david: simplify comment and description ]
> Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>

didn't have time to run tests, but this looks trivially correct.

Might be some backport ordering issues between this and commit 14.
Hard to say, didn't look into the history too deeply.

Reviewed-by: Gregory Price (Meta) <gourry@gourry.net>

-- 
~Gregory

