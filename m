Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.208.45
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793228056;
	b=aRrcFoNhoCtsYwg1YCvH8+9tQdUjvYa8aeK2tpWCoW6C8GIL+8bFjyyqPQ+Rg7MZpaU8
	 I5r/uOTv2AdWX8B1v/sEj1x387zmairhVr4CcoRpBJ1wRtp7f/k6k+2BMr1Zay7mO1hRH
	 6ezchNgcQ35PdWxyMhiVKmOzVgDkSf3ozFS5E/+5HNP1+uvV9luKCpbpyF9o7v8gjEGa8
	 fYKc3n7D0tjSXlSbEkiKnaNnphC96+c6XSapHwPLJUSrLe79oi2+VBQdt5/ZZXe1QnPDI
	 8PJmE+5eJjUKyhepZ0pW81VsTLGkgPzKoM+G7aptFiQDjhM4Pnbl7WdiieyA8VFq3Qw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793228056;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Subject:From:To:
	 Cc:In-Reply-To:References:Date:Message-Id:X-Mailer;
	bh=1nzL/A4OIGWxPEaAp0V3O0CBZ7XOASlD1R5vK61L67g=;
	b=RlD5HI4nBMD+u2U1tA1N/loaFRlPjA3m0/97TckJn8phHRZPVW5T67jQlgAJ/P34HIs4
	 mroHHiCxfKqMf6AKs932u1xeIeQBHWaRTxND31MhPgoBSh3zPqkzNhv6ab47Mw4oCc/cV
	 ryHYZ4F+BGQ73t5Xn2FKYNE8kjiqhfBYbFXBIEwwEjzPX6kv2HwaDFBCQdHnRbjgOA925
	 ERgZDOE7yyA2QYcdDAzEM5Jmnpj0ef5L9qDm6IybkH1zH8ajoM9pepVhhocLlT596dcJF
	 NSY7DS1qRjXhci+fZVnXz5G+ibQeRkmix1GkvV1YAr+sVkTmJENXNSzuUX4SQl47gZQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=gourry.net;
	spf=pass smtp.mailfrom=gourry.net;
	dkim=pass header.d=gourry.net header.i=@gourry.net header.a=rsa-sha256 header.s=google header.b=Jd09Eqyr;
	arc=none smtp.remote-ip=209.85.208.45
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 270C1606A32E
	for <linux-arch@vger.kernel.org>; Wed, 28 Oct 2026 22:54:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 270C1606A32E
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gourry.net header.i=@gourry.net header.a=rsa-sha256 header.s=google header.b=Jd09Eqyr
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-6b1ec41d8e9so1855511a12.0
        for <linux-arch@vger.kernel.org>; Wed, 28 Oct 2026 15:54:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1793228053; x=1793832853; darn=vger.kernel.org;
        h=message-id:date:references:in-reply-to:cc:to:from:subject
         :content-transfer-encoding:content-type:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=1nzL/A4OIGWxPEaAp0V3O0CBZ7XOASlD1R5vK61L67g=;
        b=Jd09EqyrE5Ah8cRBCETOBxDbT9b0oGnFriZ7N/vtIFnR4atxKwoVXBEkw9jWiyscaL
         9cBv//XvhVx0QHadjkJLBobkr5XoWyssGxmav1gWZI3g+BwjlhfZWo65PjCsgnm9H3K3
         xu5Gt8LjlHXosZzQxl27itMRU6XM03eBrNEUzaUgmLacP/vWk9QUrBawj9QiMopYPRXA
         tFTTkouWxIpyyRzhMiRtstmfu3ZGpQ3UoEM6m+ucddIsmxmD56hyTjhxLKo4VCQBrV7A
         s99qsxF/HxZexb7mRhlnvehngAX2PDIIfWSoapPGufqyJfpOj/CE/u6FaQ8yHPJb3EEt
         tvmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793228053; x=1793832853;
        h=message-id:date:references:in-reply-to:cc:to:from:subject
         :content-transfer-encoding:content-type:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=1nzL/A4OIGWxPEaAp0V3O0CBZ7XOASlD1R5vK61L67g=;
        b=TDaO7OK4v+7KEqfB5fOu56GMFMtbvl72NyQUtKjEo+2MnrgrgzAFVBuFwaMN3weWW+
         9pq2S0guzkz0eSdmDqmHsfsZhLrXbc2RMIvXJUir6IAFyCss6N96j5P9Qt3H2Y73/rt7
         yApnxN/wKXcFUq5sZLE4Cvt+boucT34nDR4/F7MKSHgNbpvZ5OluR+POFtDmLjkuBvzJ
         6J9NAx+jRR49y0bPF6QSI1Hdd2Z1eYy4+YNeKbo9ZdvwJZSfkR6gT2uuzkQIRqhrFWDa
         oocE+IpUISXkDA3CqdcNpR72pKva4i0o6t/1FaSdxlXnZu0jvSRI+MoqYve9sRrOQnI+
         v/Vw==
X-Forwarded-Encrypted: i=1; AKwUvBy+G23pqMxxzsFsOZVcHGDTqOzDOl8aN8wQRnJ5e6GJop7tLAUPkKT5AiB19vs+m/tEwOXBWA5cMHod@vger.kernel.org
X-Gm-Message-State: AFq9FYKSphesSRqgntSdMMiqVm0JHZ3Ae06EXV6926c6Nl5intxrzDxl
	3Z8I5Z3XcHpzOOBuVStK20uSrQHp1uMQ1rsnsRj0ByJhn0mDBLfxHrbatJWn2QsyAB8=
X-Gm-Gg: AYBFou1JVxyhIiSh7fda/zuQxJJP/YDGS7Y4n1HfOvSDMLJI9HwItZCPwsmHIhcUtM2
	qMtp/qaPryK/cveTBMruBq3fcYWvkt8CNKysggKkCghOu58HCEEk8mQatz6+ao0NKOlxF5zZQNc
	yesfHoc2ZI5ExR4Xe/RnkeXykU50rccrzV+1txd6lM6cNIjhbNnAtUPZgv844SyAdpFpPFblfkF
	Zk12cWuBvsbuY2HmaRQqznWH5waBkSVacl0DM5E1wGttk8y6sWq2uaGoWmTZlYmCmSGtsgHAKYN
	6isMJ0e9SRgE2dIHYu2+Yz7YJFH8bwLo//74lz8rSnoCthgtNwslYiBS0XXkyTztyaeiOU9/0Om
	HA/u9ATKcL73alZB4SkkpVTA0LBHmuT449xmmJtMR+RpwmDv0QXm+UpyLgXgWTQK1/Gz1XE8HZu
	Nw63HjqjSQ2F/LQpkop+8UIx0lDoGfOeKt/4VLGP59+EDGS9p9HjNuFGxJ4FDeW3S29iDsV2bJ3
	gvXT9AgHM11K6LbJWVWDpQjauYTiYkbQYhnJRXMT6ChWlMeeafrsiWCt/QGmX4KmTIEe3J7PaAq
	cHsLP0pLeiYxQMRR4xPstfgcOpE5U2S6K34uTS1wO0Q=
X-Received: by 2002:aa7:d0d3:0:b0:6b4:78c3:b8bf with SMTP id 4fb4d7f45d1cf-6b49cbfe65cmr2043596a12.26.1793228053385;
        Wed, 28 Oct 2026 15:54:13 -0700 (PDT)
Received: from localhost ([2a03:2880:32ff:49::])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6b4964601f2sm1991741a12.37.2026.10.28.15.54.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Oct 2026 15:54:12 -0700 (PDT)
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
Subject: Re: [PATCH 45/46] mm/memory-tiers: unregister empty tiers outside
 memory_tier_lock
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
 linux-cxl@vger.kernel.org, stable@vger.kernel.org, 
 Josef Bacik <josef@toxicpanda.com>
In-Reply-To: <20261027-fixes_core-v1-45-6f74bec9a5bb@kernel.org>
References: <20261027-fixes_core-v1-0-6f74bec9a5bb@kernel.org>
 <20261027-fixes_core-v1-45-6f74bec9a5bb@kernel.org>
Date: Wed, 28 Oct 2026 15:54:10 -0700
Message-Id: <179322805093.453251.8441529644965692562.b4-reply@b4>
X-Mailer: b4 0.17-dev

On 2026-10-27 00:18 +0100, David Hildenbrand (Arm) wrote:
> When offlining a node's last memory empties its tier,
> clear_node_memory_tier() calls device_unregister() while holding
> memory_tier_lock. A concurrent sysfs read can hold a kernfs active
> reference and block in nodelist_show() on that mutex. device_unregister()
> then waits in kernfs_drain() for the read to finish and release its active
> reference, while the reader waits for the offlining task to release the
> mutex.
> 
> Return the node's former tier from clear_node_memory_tier(), making the
> helper more similar to set_node_memory_tier(), which also returns a
> memory_tier pointer. Let the caller unlink an empty tier under
> memory_tier_lock before rebuilding demotion targets, then unregister its
> device after dropping the lock.
> 
> Fixes: 9832fb87834e ("mm/demotion: expose memory tier details via sysfs")
> Cc: stable@vger.kernel.org
> Reported-by: Josef Bacik <josef@toxicpanda.com>
> Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>

Reviewed-by: Gregory Price (Meta) <gourry@gourry.net>

-- 
Gregory Price (Meta) <gourry@gourry.net>
