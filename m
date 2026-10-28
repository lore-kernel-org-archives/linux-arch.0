Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.222.177
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793224777;
	b=JdEsgq6yrFq5gOgH8N55CVfjhBWkApsO0vCfsoNC7hw/n865d4r93Hhfy70seNyuFQWz
	 0HoK4JLC7TjcZAkTbMZg16VKtiwd4b76lVpnSoaaFwkMSn+qlOSfzLasgxdzhwOx4Oaj8
	 QAs78Ef2BC4JO54U04OKPn09YsvtQEPq8YkoMnqlSKFjccssbotRpcKaqFc9Rul6QGlTG
	 axYMMV2xhQAdMT6Xw5RdtWP5nb32Od+NdPU4gv+YoJD0nLJ2l5n+fhyovvvir3ReEq0CY
	 NyMG8jukNZbqN971sISgugDQxPNGIdEledQo9qcN0y9cJWGTMTnb/N9uK9/ZmLEZRlQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793224777;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Subject:From:To:
	 Cc:In-Reply-To:References:Date:Message-Id:X-Mailer;
	bh=OhxlTVYV9TLcZ/UBe1xcuRZQWn43bPmhsFTY2WYTAiQ=;
	b=t2tR82gobw82S8gb3PV76cHN75uH9sw4Gli8Nw4ypxaF1gPmacX7+2WI96OlJpS0psEi
	 eC8Pjc0rJsulUDMA2LXFVtKIf+1FpMHj+EwfWqUWPsuC/jYgTAX27bIloNaSHLuz5K7Pv
	 DGvI1MIYoq+Neh33zW246Ym41Fan53fmugK7HB0NUoIWtW/lnf3OT2suYzekK9Q6fNo9T
	 xCfzJM7DsabUoIuMC5zK6pxl+MSRW3Swm53575GbhXZ+yjeRKK58XtUeolKCSNnjjk0P9
	 xjIgFLN8TYGnoTRSE4d2WtmWjX1BpXVFwoaeAwmfA/I8DEOMg7/40q34xlVCHIf22/A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=gourry.net;
	spf=pass smtp.mailfrom=gourry.net;
	dkim=pass header.d=gourry.net header.i=@gourry.net header.a=rsa-sha256 header.s=google header.b=JJljicIu;
	arc=none smtp.remote-ip=209.85.222.177
Received: from mail-qk1-f177.google.com (mail-qk1-f177.google.com [209.85.222.177])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23660606A31D
	for <linux-arch@vger.kernel.org>; Wed, 28 Oct 2026 21:59:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 23660606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gourry.net header.i=@gourry.net header.a=rsa-sha256 header.s=google header.b=JJljicIu
Received: by mail-qk1-f177.google.com with SMTP id af79cd13be357-93f560af6aeso158427985a.0
        for <linux-arch@vger.kernel.org>; Wed, 28 Oct 2026 14:59:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1793224775; x=1793829575; darn=vger.kernel.org;
        h=message-id:date:references:in-reply-to:cc:to:from:subject
         :content-transfer-encoding:content-type:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=OhxlTVYV9TLcZ/UBe1xcuRZQWn43bPmhsFTY2WYTAiQ=;
        b=JJljicIuNc8c1hKynJqXX/VZCOPYs7Y9HJoAynJywjHK2yeTMkC3bqqzE7PEcLPD6A
         4HUuY3A6DGxK7k1KKDC3MjMltOvH2hnz5xHVGlKqKRs2wvllOMfex65kCIfA/Ud5ZuJY
         5CfIY42O8zl11oDwhrhAEk7nqJzdWGVX+xLfyMp3qho/XLR80ZGzg/jLaxW+lirQ+1XX
         0ZSSG6g37QoKqss/2s/69JJbOxfL25oWhGjX4HpEVH8sq12RNIiNqdxzuwAkEH0g/dEW
         gRXP/wSgQ2RAH+S68n6oHVT5kviIDSSPQ6GOz7LUsIw2+RU3+WY/zX965JVoT66OLw+E
         mMJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793224775; x=1793829575;
        h=message-id:date:references:in-reply-to:cc:to:from:subject
         :content-transfer-encoding:content-type:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=OhxlTVYV9TLcZ/UBe1xcuRZQWn43bPmhsFTY2WYTAiQ=;
        b=MLs7LVj9Go4bPBuKE8S7forVJPNJFF+5EDKKaOel1KXIwAeMavxMul8bzXpUe8jriM
         OGB7ZrwnZ8UFnBFU2EIsBFg9fBidBG92cgR2dgqD9WeSloEuiaX3kFaExh7PXOiNCuBh
         T+iYvcMIRn2ax29KyBVQ5ZEHW6VOHRUlWfdblaIUqPMkZA+yaHokyJgZv9B+lwl5Ngpo
         /txSvwOUcFpiF3CM/NNyQuIOQcdvEo680flMNl/cKTw+P+0wtO615BfvA2m4ChF8mP0P
         xfMHJ1/HBNV5VfxiSgA55HCtugYUhXBdH8BolwSAcX7zCNJ/gnk//GQbSnHL2mMc4mK8
         RxvQ==
X-Forwarded-Encrypted: i=1; AKwUvBxn7v+9pjqgGBBvupNZfT4sZERiaowKc/X0u70dx3ySPADTN8gSo6FJks93xgDK8AQW0jw3ZMJh60z+@vger.kernel.org
X-Gm-Message-State: AFq9FYJzP7UiJ/A6VW7S0VWj7D+bCEYJE6fzGZUrsWyJjz1uh/y1SwFf
	N/pqWO5+vprJz8d7Q0nkOBxqVKmQI3M2zNzipUf3kxohrVVEjtym+U89Qt/kemdVixBKe+Y9rFW
	OVRs1UNI=
X-Gm-Gg: AYBFou1lvkmko0bsUR3Xcd+ChH8L7I2MmR65scBnCZ1kzPa/vvuO2EH5byl2HLVRw8G
	kTaeScdxO4FbWUPomCeoty3klCrT07/TM4/21JM9UswpU7Jax2jUgkvghVRswjPprZrhY/dw394
	aWreaQifeHnzkfmntziytK1I+iSXoWDV4/f59Sh0zBUYaHCHR8dChZzlfGRSY/dEHc6aZQm0Cha
	mFGK0ohh9JFG41jvKGLAiZQmueJ1IBcPYZCZ3NB3fQPP8Pc/bi8H52XLRxmycrR/gKe2i6Xqvw6
	z0glUILEeUQSRw6NHCX9S3uiBAC006JCLE6mkm5bTa31KNBTTurdtOwoW4ALy+4LMYKXkmrOd3H
	kjJKO/iTrJoWm9mvpXRCHqzxUsocfn/WNn3lGq9GIDkinZxJQp/TE5dGhpNxKHqLf/AcU+AkC9r
	/x7wI3DJOMaj/WgCriEJfjTqBmhpLorJAbhUUrGVoKNGDfXSb1sRaEMyzxqoFBP4p6cLg1pXx4C
	Z6AfauyUruQxa4bnfSMdNUyKXUtHpHClLS+reJzA9LGqtKi3eV/mILi6EDMKh2TbLHl2s1E5TTu
	vc3L+xX5ywGh71HOy8g4JiaDaA5KGxrZ7meBJV1lhYUov2+eKT8dlb3nBrYaRiQCKPJX+T7E6ja
	F
X-Received: by 2002:a05:620a:460f:b0:93e:ce12:aadd with SMTP id af79cd13be357-94408db358bmr587757585a.58.1793224775119;
        Wed, 28 Oct 2026 14:59:35 -0700 (PDT)
Received: from [192.168.86.58] (pool-173-79-60-52.washdc.fios.verizon.net. [173.79.60.52])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-940f078ba99sm1374978985a.32.2026.10.28.14.59.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Oct 2026 14:59:34 -0700 (PDT)
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
Subject: Re: [PATCH 32/46] mm/memory_hotplug: avoid races in
 pfn_to_online_page() with dying pgmap
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
 linux-cxl@vger.kernel.org, Josef Bacik <josef@toxicpanda.com>
In-Reply-To: <20261027-fixes_core-v1-32-6f74bec9a5bb@kernel.org>
References: <20261027-fixes_core-v1-0-6f74bec9a5bb@kernel.org>
 <20261027-fixes_core-v1-32-6f74bec9a5bb@kernel.org>
Date: Wed, 28 Oct 2026 17:59:33 -0400
Message-Id: <179322477323.1935969.10540673116963281867.b4-reply@b4>
X-Mailer: b4 0.17-dev

On 2026-10-27 00:17 +0100, David Hildenbrand (Arm) wrote:
> From: Josef Bacik <josef@toxicpanda.com>
> 
> If ZONE_DEVICE memory shares a memory section with ordinary memory, the
> section is online and the pfns of the device are valid.
> pfn_to_online_page() tells them apart by asking get_dev_pagemap() whether
> the pfn belongs to a dev_pagemap.
> 
> get_dev_pagemap() only returns a dev_pagemap whose reference is alive.
> memunmap_pages() kills the reference first, waits until all pages are
> idle, and then removes the memmap. During all that time the function
> finds nothing, and pfn_to_online_page() hands out the struct pages of the
> device as if they were online memory. A pfn walker reads them while they
> are poisoned and freed.
> 
> The entry in pgmap_array is only deleted after the pages have been
> removed. Look at that instead of trying to get a reference.
> 
> This is probably not worth CCing stable.
> 
> Fix generated by an LLM and sent by Josef Bacik in private.
> 
> Fixes: 1f90a3477df3 ("mm: teach pfn_to_online_page() about ZONE_DEVICE section collisions")
> Signed-off-by: Josef Bacik <josef@toxicpanda.com>
> Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>

More zone device pfn-walk brittleness :\

Reviewed-by: Gregory Price (Meta) <gourry@gourry.net>

-- 
~Gregory

