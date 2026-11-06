Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.51
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793958640;
	b=AimVir2EzLUoZ2pwVE7g8vR2Bm2oVHwYRI2CqfKvTzkeYfLWWEtos06LIRxFkQhZ4KAg
	 VHw3b69mAQQoUJOd0xEJ4ply30xJLtQwo6RmXrzllufdMaBlmYa9cyEpOQuQGBIh4yHSa
	 x4V4lzePtHH+/Hq1fREr6ECjft66mWdTXA6mSk7PArrmMCGL7mLGIZiDTEQOQuJcMscNd
	 fvvRhWX6eYN/9DgUe9c+JAj995Q8w4Xml5e9DoWEtdHRWhBlrusX3IfhEHZ+514u765my
	 n+XdnlH579unc1yAMVWBUpj1b75W9+pX8JnmnZApPvuHYS/aVt5t6yHbcYOQNp0guwQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793958640;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:References:
	 Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=RupwrtSRCRknDTCP4U8+mHVorluG3D1aDqrqCuXGL/o=;
	b=pzLyquhHl7RtCOsxwK9G9jPV1f6nHXANDBqq+r5hHFs19HRJtfQ+qCOiTnR7uxLJgR1C
	 0fuwrmmTPEJm7lnQ6n1UUmJ+E1Ig+jLnkJMIFR/z/eFjhZrbe/iXfWOnk7HYiD6MdKdaZ
	 Cx48GyGJ9LkI5gvvxfls7xJxPaE619/UTd8hhjouTrT0+sIWHkPRuanhFxvEJ9vqWEDrc
	 m2WF+g3LJ/3tjGfQbjycHPOU8zejb28grRGBnX1Vaf6iSUYNpPsFf0yokv/UhKBPCXjZI
	 h6wqJ+PoQh4z09iyWl6F+R+mwxzV8ZOnL0PmvY77BGA0309/rnoSOoVE3QNTUNmrqng==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=t1D9H5iu;
	arc=none smtp.remote-ip=209.85.221.51
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E071D606EEB9
	for <linux-arch@vger.kernel.org>; Fri,  6 Nov 2026 09:50:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E071D606EEB9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=t1D9H5iu
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-48dfc0421d9so447398f8f.1
        for <linux-arch@vger.kernel.org>; Fri, 06 Nov 2026 01:50:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793958638; x=1794563438; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=RupwrtSRCRknDTCP4U8+mHVorluG3D1aDqrqCuXGL/o=;
        b=t1D9H5iuTUmjdPhOVJmZIub2cA7iiSUr41ZQ3yS+raxwi2K9JW5USUNO1Ej8W7ktyy
         jDlpr6IYaICDt5N3782Vm+vT8R7N+VD6e282WCZUIr3qHs3ymqVae8nOek4p5Qr6O/oS
         dqZpOzvc4Swchkzri6wDXvUOBTWJM5lyg5UOT7Y/iAiO/bDMWNay73N2vmeXoqlrNWa3
         CWfy2PPZ8DtSbf0uhLB61kRz/tBH8yhEbP0mgAap9N/KETVXb+EF1zhC7HOG5tW8CGpR
         ZOvm0YUZZDiDTRNjJd5C/6nVAnSAYqMrPeB1m3dSCFZzIl8NAmnARF5bgl9O49QSbyKD
         /grw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793958638; x=1794563438;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=RupwrtSRCRknDTCP4U8+mHVorluG3D1aDqrqCuXGL/o=;
        b=C3ndCBhd/yR4dTwPIBe0Kw4yrVOpkXl3hfOku0nanhV/I0qSzdDEfx8X51K8AaY7MZ
         Sb++UovtT0ZXAEIEoEzpy21/byhMjaDUZoHlt5U0qFVpeois04D/8MAtPceDLl2RSWYG
         TQ0iMaxAxfFRlA83M/yt0nd2jhwG7CbMhAgtLqJWBu9WA2MSdUxv3vAVMiahLtbKqHuG
         dQnxFsdkZO3GutJRBFAdgy4Us3TMe4nX1+t+VtN3KI0Z7kRALiUUWUOYyda0E0+HwwFE
         xG0VF8xA8JZUCE9Zgt2TzBFbFcsMp0yvk80PGAXXf1AwxUb62bwVXFqX3o7LywJ0pL+G
         JiIw==
X-Forwarded-Encrypted: i=1; AL+hErHxE/xIg8J7+ihs60uQbWx3WMVghTWq8994PopL4BgcUanVErtAb5vtvbti5/flA2qi5HvDUQ8bQ11/@vger.kernel.org
X-Gm-Message-State: APuU4Z+TjYKPgfOdxHmiCmHbmR3rFXubpJVc6vuJ+WTtTWoziJYBrn48
	pV+89M5k51r3LtXKejNyoEO+tzezvQdD/tZEoS/oYmXsRmCYY7LYax/B
X-Gm-Gg: AYBFou0Q6zUBNYn5KkNvDg9FH4vBGUBfYHn+UW0D3L6KzElrZ/R5P+ZJgfxhk2JCyLQ
	9D1Vm0AIXzmYM6pEr6ZcUT7Ju1sCXh/ABkvKuTQTOrq32aAm0HlqPpWSCSao+DN0i5Z2Jv+w4bK
	H14xHvLhjBBOnIEwT0+UhI45hDzkaqkb3iEyHdiNGZ/boiZus0m66oYM0yHZl4Uh1QGNRTtf0wD
	kIukfDfcyJqPIweCNlXIDAyx1jz4WBQbaQ9KvZncwliFv9cLkLDwgrDvpD+UcSXaKPKbIYq8X5J
	UqnEnZfkmIJHbt1SzZRfmAqX/Zoh+NXHls2JeBx/9yATe7dlwwGqBMvTuB54tt3jxLc3OMR9lNO
	5a+TM876LRNb1Sc+SdGHImrvvVSuennoDBFSIc2/V1Tw/JHshHYNJk2XHvCh3k4YGiMcUKY95qy
	a80jcH2Wyn/58x89GEZhIzchldEc4FI4amFJHwWSM+eTcIYFoJ3qDua8vrUaM80Z69Eh00vrrL5
	arPYP7ujKtPz9bMwHaocBdVa182y1r5V4IQZSHdhgicTY4Y6LGOfnZ/JkTQmeSUjJW+7c/JFF6R
	pzXud6qg7lDOWJo4qnExyyY=
X-Received: by 2002:a5d:5d82:0:b0:491:83e7:32bd with SMTP id ffacd0b85a97d-49277f88313mr3982559f8f.50.1793958637679;
        Fri, 06 Nov 2026 01:50:37 -0800 (PST)
Received: from [192.168.1.22] ([83.231.69.9])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-492d3d60e78sm2755152f8f.1.2026.11.06.01.50.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 06 Nov 2026 01:50:37 -0800 (PST)
Message-ID: <6662ae76-c8dc-4bc5-9730-bf9f537ca9cb@gmail.com>
Date: Fri, 6 Nov 2026 10:50:34 +0100
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
Subject: Re: [PATCH 2/5] mm: limit pagecache folio refcount when splicing into
 pipes
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
 iommu@lists.linux.dev, stable@vger.kernel.org
References: <20261105-refcount_overflow_stable-v1-0-70b9c655da3e@kernel.org>
 <20261105-refcount_overflow_stable-v1-2-70b9c655da3e@kernel.org>
Content-Language: en-US
From: "Jose A. Perez de Azpillaga" <azpijr@gmail.com>
In-Reply-To: <20261105-refcount_overflow_stable-v1-2-70b9c655da3e@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/5/26 2:10 PM, David Hildenbrand (Arm) wrote:
> Similar to mapping pagecache folios into page tables, let's reject splicing
> folios into a pipe if the refcount is at it's limit, similar to how we
> handle it during GUP.
> 
> This will prevent more cases of possible folio refcount overflows with
> large pagecache folios.
> 
> Let's keep it simple and check in the two callers of
> splice_folio_into_pipe().
> 
> Also check in try_get_page() to cover pipe-buffer duplication by tee()
> and partial pipe-to-pipe splicing.
> 
> Fixes: 800d8c63b2e9 ("shmem: add huge pages support")
> Fixes: 99cb0dbd47a1 ("mm,thp: add read-only THP support for (non-shmem) FS")
> Fixes: 793917d997df ("mm/readahead: Add large folio readahead")
> Cc: stable@vger.kernel.org
> Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>

LGTM:

Reviewed-by: Jose A. Perez de Azpillaga <azpijr@gmail.com>

-- 
cheers,
jose a. p-a
