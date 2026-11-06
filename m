Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.49
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793958143;
	b=cgV8UcUEj20aUM2epQ+ZsLHllrh9UdMFtrO8p479+YvCpCmEjjILB2EfTGwJfuk5Iiin
	 mN+EgH+UbK/64+adUGAFeQYPpBDKGzn/6Vb/xrnB/PJ79JSy/v2OlvQ89IxkqbZDyWDp1
	 RH7tV3FTYMdbhA/EEw6IWlDS4YiA3tRIiPFrYZmpdV03BOdB5d0M3S8mZ/B28d0tmeYu4
	 Ysp7KZ2a30DXRSa88fY2W7j3A+jof+rq77bCTRzp+Y/s/GOWBy1BZ/JrQiPfTbDXC0XbO
	 9f20Pb6yA2BjhK8A6X+KuTYUrohO0pxntbAaH32R76Ed1UWBdicB4xffTmKkPnYWQOQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793958143;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:References:
	 Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=wxjoU6eh1AnEB74q9TNTzzgoHGIbkez0gtAfCeShC9g=;
	b=Q4gdOqmpNhc46zG60tZrv7vIRZ/w5o76CdaHp1fS+tAAgeg7JCH8gxmRFbPPmeVURj0r
	 W0nWzG4zIKQ+YKKvEz5DwyPeW85dHMLgMnEPyD5vGC3NcScVRWxSH1Wu6gB9eKsNihDHg
	 Xk8rcdyoDjMqYiCedb/An9UfKqJ4750JxJBlODqEWZT8YXv0DaA/kOeU1d4/K0g4LGziX
	 ah/Z4x0vonasnsG12NSjDXq6KaTmC6/l6iyUlZBYc4wumzjElb82vXC9Z9Yq1ZWBZZV4M
	 ypbNRvmA1wsiY61nR9re2eXX3pvWL7QajeaK5C24BZYDC/BL2Sc/2efQ3n5K01ziybA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=f5aviNlW;
	arc=none smtp.remote-ip=209.85.128.49
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8AB5606A903
	for <linux-arch@vger.kernel.org>; Fri,  6 Nov 2026 09:42:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B8AB5606A903
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=f5aviNlW
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-4a2000d5fb1so2062225e9.1
        for <linux-arch@vger.kernel.org>; Fri, 06 Nov 2026 01:42:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793958141; x=1794562941; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=wxjoU6eh1AnEB74q9TNTzzgoHGIbkez0gtAfCeShC9g=;
        b=f5aviNlWe44WrD8IRdQX6ADMuIeIzKR0W9+k5UrolgZdhp5s/PGxmiZR+YoERBoVJ/
         6icSuT1pJK1BhDf9IIxn5cOoFPu3PXRcOjMBVS/auhQmMFJtiS811F3SN0M+HYUhfQ3z
         zv/RNhWZeAqD7XzxOLY04ZCApDq0VHzqjeoX1GyvA8W4WDjDzzcBAxWierLV9QWXD/NZ
         UQ+7cbI6on3aS/XAL23R+H0tD54FGUBzA783tY3f96ogm/iz8k5ihmez/pJCMZMaPljs
         p05ksTgKwyP1b297hjQpu/uHw9xgDm+3JpKi0vgksCEUrs8AbsWwzuqXcRGIAUH0fsFK
         Fu/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793958141; x=1794562941;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=wxjoU6eh1AnEB74q9TNTzzgoHGIbkez0gtAfCeShC9g=;
        b=fvKXFFF3JY7vtL+TOE5MFlFsvYhoa77oT2Hkb7WjNLwxdZpDuMPiMbAS4c1VTiBkdC
         SmpegpE+H2N771IJNNc7aybGZDHNNk+M76W6WYma3T/0buLzW0RaNXBydJcX1pBVQT3K
         f1x6pPVecvGvPxOANLqOsoSrDNQ4XuQ/p5/Z9UxJxjFCOCV4m3/qKfAXYAVJsFS6LhKb
         T4B8HTdK7NaKU/TyVfbOMfGE2DoQRHfYrQYUFNTw9/HBgZRwJOPedztT3BRzl1w8jt0g
         Thz9b61VhuNFH0P5yc7WA5/bVTvyPshtm9kLZOmbrRygVH4eTE17hWizuxcvKnlWMEAR
         DGpw==
X-Forwarded-Encrypted: i=1; AKwUvBy3uyaR+r16RytWmPEWUZfHklIq8RnFQKn7yZj5+zj8X/Z+kTHgGB9Bma/OS2YWymJa5zezIDcT6hq/@vger.kernel.org
X-Gm-Message-State: APuU4Z8Ktr6UElGwPqB9aoJTviNRtJAa894idIhQxO/6T7B5QwhU1ktM
	NqSmJD7QWUOA+vJbCTJwH1Y1RCN28QUWrC+8nOtm3hRUmzjeNkxOCwft
X-Gm-Gg: AYBFou0z5knrjsipCrxOLDbofFr0QhocyhaJiDfVIrbrT6dD+bkBbBfIPpE+OTMDUaQ
	xt7OW/HMbOFruzrHQszVwKD0Q40QK2ARj9U7bcgTpSUIqNKCzIwVnUBqAZ6bkDjJ1mGmMZLZfnT
	I8tmV13w1ezyeqVTdCCCQKuocfM30orwc+K+2x29vtnoNHJWGrBjp5jHQ32Hk7DAUFB4Ye5930W
	kwMJAJ1x9nLLje5Xdb0VLkI7DSg6sRwYUh3dACyHmD0d6rOXBhktNWlMchsXKZRvXv2j1PvCeai
	0uJcLt0xMEGtW+H0ZW4nJbDr4p4aWbxCRT3eh5Nxgtr/l/D2e9APdIxnR7ZSux4Neh71jOb8Cy1
	tTMDeVsx3BCexUaaKJRAgpA8JUwooDPs6fPr9zGniaVhmemhv7qCV6c+Qr0itSOPwiNcsbpRxf1
	rhAgBGnxdJ2sicUmtAfsRFTEdNBmFpDu+wo0hf7GTc29IpT8xeVFO1FCoT/pjS5ykxk3uR8belr
	PN3a5pODA6FCgPMSNzHJZcE6m4vnC2J2qzcTD4ODO5xYxq6X+sbpSCAgBtFCdbIIVqzgJXCkZKg
	0jyZ5SYefrCb4+F2F97sM4o=
X-Received: by 2002:a05:600c:c168:b0:4a0:1c0e:b057 with SMTP id 5b1f17b1804b1-4b6db2ba2demr25269125e9.4.1793958140866;
        Fri, 06 Nov 2026 01:42:20 -0800 (PST)
Received: from [192.168.1.22] ([83.231.69.9])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4b741cdd8d7sm22361285e9.1.2026.11.06.01.42.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 06 Nov 2026 01:42:20 -0800 (PST)
Message-ID: <528e3a0e-04fb-427f-88c7-63a7f4bbc505@gmail.com>
Date: Fri, 6 Nov 2026 10:42:17 +0100
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Post: <mailto:linux-arch@vger.kernel.org>
List-Help: <mailto:linux-arch+help@vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-arch+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/5] mm: limit pagecache folio refcount when mapping pages
To: "David Hildenbrand (Arm)" <david@kernel.org>,
 Andrew Morton <akpm@linux-foundation.org>, Lorenzo Stoakes <ljs@kernel.org>,
 "Liam R. Howlett" <liam@infradead.org>, Vlastimil Babka <vbabka@kernel.org>,
 Mike Rapoport <rppt@kernel.org>, Suren Baghdasaryan <surenb@google.com>,
 Michal Hocko <mhocko@suse.com>, "Matthew Wilcox (Oracle)"
 <willy@infradead.org>, Jan Kara <jack@suse.cz>, Zi Yan <ziy@nvidia.com>,
 Baolin Wang <baolin.wang@linux.alibaba.com>,
 Nico Pache <nico.pache@linux.dev>, Ryan Roberts <ryan.roberts@arm.com>,
 Dev Jain <dev.jain@arm.com>, Barry Song <baohua@kernel.org>,
 Lance Yang <lance.yang@linux.dev>, Usama Arif <usama.arif@linux.dev>,
 Kiryl Shutsemau <kas@kernel.org>, Matthew Brost <matthew.brost@intel.com>,
 Joshua Hahn <joshua.hahnjy@gmail.com>, Byungchul Park <byungchul@sk.com>,
 Gregory Price <gourry@gourry.net>, Ying Huang
 <ying.huang@linux.alibaba.com>, Alistair Popple <apopple@nvidia.com>,
 Peter Xu <peterx@redhat.com>, Johannes Weiner <hannes@cmpxchg.org>,
 Song Liu <songliubraving@fb.com>, Rik van Riel <riel@surriel.com>,
 Hugh Dickins <hughd@google.com>, Will Deacon <will@kernel.org>,
 "Aneesh Kumar K.V" <aneesh.kumar@kernel.org>, Nick Piggin
 <npiggin@gmail.com>, Peter Zijlstra <peterz@infradead.org>,
 Jason Gunthorpe <jgg@ziepe.ca>, Kevin Tian <kevin.tian@intel.com>,
 "Joerg Roedel (AMD)" <joro@8bytes.org>, Robin Murphy <robin.murphy@arm.com>,
 Steve Sistare <steven.sistare@oracle.com>, John Hubbard <jhubbard@nvidia.com>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, linux-arch@vger.kernel.org,
 iommu@lists.linux.dev, Chris Mason <mason@kernel.org>, stable@vger.kernel.org
References: <20261105-refcount_overflow_stable-v1-0-70b9c655da3e@kernel.org>
 <20261105-refcount_overflow_stable-v1-1-70b9c655da3e@kernel.org>
Content-Language: en-US
From: "Jose A. Perez de Azpillaga" <azpijr@gmail.com>
In-Reply-To: <20261105-refcount_overflow_stable-v1-1-70b9c655da3e@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/5/26 2:10 PM, David Hildenbrand (Arm) wrote:
> With large file folios, overflowing the folio mapcount and refcount
> became possible. For anon folios it is currently not really an issue:
> each large anon folio can only be mapped once into a process.
> 
> That's not really big news, but it's about time that we do something
> about it because some modern technology might find ways to abuse it :)
> 
> One of the enablers for that was commit ddc58f27f9ee ("mm: drop tail page
> refcounting"), however, file thp support was added later.
> 
> File folios can be mapped multiple times into the same process, allowing
> for processes to hold many references to the same folio.
> 
> As a short-term solution, let's introduce two folio refcount limits:
> one for ordinary consumers and one for admins. Leave some headroom
> before the refcount goes negative, which we really don't want (having
> the mapcount go negative is also not expected).
> 
> Start reporting SIGBUS if we run into limits. When restoring mappings
> from migration entries, instead zap the pte/pmd entry. We allow for
> slightly exceeding the limit to keep things simpler.
> 
> This is far from ideal, but better than all easy alternatives we can
> backport comfortably. For now it fixes the big problem: letting
> the refcount (+mapcount) go negative and cause trouble.
> 
> This is only a temporary fix, we'll follow up with something better.
> 
> While the refcount checks are not required for order 0 folios, let's
> just add them for consistency: each folio_add_file_rmap*() and
> folio_dup_file_rmap*() needs a prior check.
in mm-new copy_huge_pmd() now does a folio_dup_file_rmap_pmd() at fork,
since Konstantin's "mm/huge_memory: copy file THPs at fork like
copy_present_ptes() does". doesn't that one need the check too?

the rest LGTM:

Reviewed-by: Jose A. Perez de Azpillaga <azpijr@gmail.com>

-- 
cheers,
jose a. p-a
