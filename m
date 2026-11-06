Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.222.171
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793997978;
	b=e5mZljeUCrCWbip3igzRvsYcILTtRLd8Mlx80cqH6IoDsPHDWhD1Otb8MO/QGcTcLMln
	 F4cSLl2HSBcFGklrVwMJ0rjJK3qUrNPApzRAniRNJoIfyJ7sT4/hESJSg2mOE7z4/nJOj
	 GsbdD5W24gkD2zD88MQmizl+LW+p072ZXUbw/9h06HvFf01+Rjn5CARF3XBCpP/6o/kfo
	 jBFq/ZpbPqoxlUxlB1t3HFVUPVATv3OK1dnxiumpIeVgVk/MBgszHRH0WXeu5tGrM7trq
	 R4YpmmooJCtRI32od8qXfs85Wz3X47i6LVZTmewRodOXoJPpWYl+OUQzMtbCutY1pTw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793997978;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Received:Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=ZEes90VLavY8K6YFysNzmt6SItRkZVxy3F/LlAcJTS4=;
	b=gR7DAgQSWGp8C2suOQv9rcenslBTcxJJ/TY4TRC6edN/1LOk8zGwZ2EJ391ZCIzkvWpn
	 v5dIY2pBg65M8/yb8cjoiNRVd3WIPQ/1rg/XXSQRtKPlY1ydBhHfKFL+eWanIN6orMTCN
	 bSLlolG+Piq7PDGsbfVwSbmuHQj5sm0Klkb8sQ5rXjRIqbs8nsinV+icSKAd5l2Yj9fL9
	 Mq/ThEM8gVtk07KYCPsQ5niTesLm3r2uIHGE7p/mx63rJ7OsunvGHkuveeaztGXzkQ3hE
	 zniGFnxYOFsVocOov2GphUjWAB68s58ZyNvStlmj6BGn+IxQAgtyVwM1WfMOOJmJeVw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=ziepe.ca;
	spf=pass smtp.mailfrom=ziepe.ca;
	dkim=pass header.d=ziepe.ca header.i=@ziepe.ca header.a=rsa-sha256 header.s=google header.b=ia03zhgk;
	arc=none smtp.remote-ip=209.85.222.171
Received: from mail-qk1-f171.google.com (mail-qk1-f171.google.com [209.85.222.171])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57467606A32C
	for <linux-arch@vger.kernel.org>; Fri,  6 Nov 2026 20:46:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 57467606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=ziepe.ca header.i=@ziepe.ca header.a=rsa-sha256 header.s=google header.b=ia03zhgk
Received: by mail-qk1-f171.google.com with SMTP id af79cd13be357-93f1cf92c9eso100696085a.0
        for <linux-arch@vger.kernel.org>; Fri, 06 Nov 2026 12:46:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1793997977; x=1794602777; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=ZEes90VLavY8K6YFysNzmt6SItRkZVxy3F/LlAcJTS4=;
        b=ia03zhgkg8F62JJYs7M675TbPFObrCOv0u4oHOTJtFvqnTcmUDcbBVFNeSxJ9PD1Vd
         X3++rXu7ynGxcD6HJjYul9kMp2mTDpSN23R4UUoU0ZwdqEDcmhgNvxGOesSBXgouN8oh
         WDELPOC7iRZZXkBkQkIwq6qlSeuTE1ejJR5M5F/LnPE30IX4g/Ud6Zh3xUNRGf4pAPVX
         dMOu9Z+AvpbbS4FXZzZIAHlPF/xPfKu2d/QsjpRhkxiFFOUWUxlXnYq3llP5eRSIsIwj
         Judl3kx/z9/513cMlbrx7zq3FMlrSz13MdWcwld46RFB6UfDXOczNFtCUB4PVH9CamY8
         GLXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793997977; x=1794602777;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ZEes90VLavY8K6YFysNzmt6SItRkZVxy3F/LlAcJTS4=;
        b=ikXixwHgKG6Fp+Y9Wfnp66eOORsPYG8jqo+tYQNmlRZ58uvsKwG64eyWprGAnt1qTa
         xIKIdU4PNJ/7m9tDOTtmI9CxL8iwyGaZ7kghTGWA+A3lGlSRy1w/rdKsvVOjEXEsSPFu
         8ONi/xW0xmDjkigErvjFcIeugGakl4nRiGOEhjh1jppNmxV7clEb1/xobwwA7Jh1KuPk
         O6tcJrUmkOMVG2TL3iMilU5FvZh6zuyU/SXhNzpcmbEyxRYMHn0aif4Hd3ip3k6PEgFx
         YxC9RiTLdNckh6UTSJxNQOgX0TMRzuq4+utov5UQ15pk/ElAVP7vHz0Il1X5T6TizV7Y
         UQ3w==
X-Forwarded-Encrypted: i=1; AKwUvBz56QqXC1chnlqYAdZtfivPv39ZeMGPWYmHstYO1ltVk2vP3OsAJMdVeIEEoNdgDmzZOc00OziQjmFo@vger.kernel.org
X-Gm-Message-State: APuU4Z903k7R0IQiu2lLQtlfldiaTfPc0WQQTcImXb3X7+hQs9LFJdcw
	GAttN31Dna511a0OJz241fNAUE3V7sYcvXDqsCUJNygbLbNJQXZUizrFAZKFrDX01k4=
X-Gm-Gg: AYBFou2UG/bik+NeNDsBxCM8evnl1BPHBkhSg8z0Um+480LeOuE0AoU926Oj4D2d0Gh
	WOWt9s9BHkXgeTZbERDh5dkAGXtZuvevixsxXactKDsgtpgoCmltzMy1UYk7C7jmqMeFtfjzpwQ
	K3EKv4AcbTUvcuDiANXJzSUOAfeMSGVUObiVdMLpxknEY9ANCNqFhElL5xVOKQ9Mtz6ZzzYu5ZG
	9P34VZjLKJLFfLP3I7KAQb5BZuxgO4jLdAaxV+eiOYazpYpicwCOYvE+OR43lWAizV22qPk7VI8
	gpHHUOHs3GsGaD7/oWrXONsjbZnwUVBE3lT4mmUxwlU40Ouv4ne/6SNgbURIJDov2AtUGhI5AMQ
	q+NYnTNlbudvnZYBt0GAgry3q+G6XCx0Of6oEN3PdNbJC+fGygJGrrTWackIAn1AnpHi/GPerQ1
	hKYfxaO1Gr8x0dK15F8omKHJCGH1dRF1lflpVbrLrCQ9WvebJ/jqGo4pNTuyZxUJD/77a8d2s43
	EZzj/Ti7mFeUfQpqTDkOQdT+2aCdlhHTHcfrhND7WqVOSqFUqoI7fYft0DyCYsHEkXLdvw2QmRi
	DsBKRmjQkNokhM5PT4ptvhfT/BnOXA5A8TPLKcPVh43NC5K3gCx55ga021OUqe2jZsezjwUBNzJ
	BqxN/87a29g==
X-Received: by 2002:a05:620a:4507:b0:939:a003:7127 with SMTP id af79cd13be357-945f35a6235mr574216085a.52.1793997977262;
        Fri, 06 Nov 2026 12:46:17 -0800 (PST)
Received: from ziepe.ca (hlfxns010zw-159-2-239-150.pppoe-dynamic.high-speed.ns.bellaliant.net. [159.2.239.150])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-91ea6ac8d02sm28364526d6.42.2026.11.06.12.46.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Nov 2026 12:46:16 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1xPQpE-00000007fOt-0vRe;
	Fri, 06 Nov 2026 16:46:16 -0400
Date: Fri, 6 Nov 2026 16:46:16 -0400
From: Jason Gunthorpe <jgg@ziepe.ca>
To: "David Hildenbrand (Arm)" <david@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Lorenzo Stoakes <ljs@kernel.org>,
	"Liam R. Howlett" <liam@infradead.org>,
	Vlastimil Babka <vbabka@kernel.org>,
	Mike Rapoport <rppt@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Michal Hocko <mhocko@suse.com>,
	"Matthew Wilcox (Oracle)" <willy@infradead.org>,
	Jan Kara <jack@suse.cz>, Zi Yan <ziy@nvidia.com>,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	Nico Pache <nico.pache@linux.dev>,
	Ryan Roberts <ryan.roberts@arm.com>, Dev Jain <dev.jain@arm.com>,
	Barry Song <baohua@kernel.org>, Lance Yang <lance.yang@linux.dev>,
	Usama Arif <usama.arif@linux.dev>, Kiryl Shutsemau <kas@kernel.org>,
	Matthew Brost <matthew.brost@intel.com>,
	Joshua Hahn <joshua.hahnjy@gmail.com>,
	Byungchul Park <byungchul@sk.com>,
	Gregory Price <gourry@gourry.net>,
	Ying Huang <ying.huang@linux.alibaba.com>,
	Alistair Popple <apopple@nvidia.com>, Peter Xu <peterx@redhat.com>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Song Liu <songliubraving@fb.com>, Rik van Riel <riel@surriel.com>,
	Hugh Dickins <hughd@google.com>, Will Deacon <will@kernel.org>,
	"Aneesh Kumar K.V" <aneesh.kumar@kernel.org>,
	Nick Piggin <npiggin@gmail.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Kevin Tian <kevin.tian@intel.com>,
	"Joerg Roedel (AMD)" <joro@8bytes.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Steve Sistare <steven.sistare@oracle.com>,
	John Hubbard <jhubbard@nvidia.com>, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	linux-arch@vger.kernel.org, iommu@lists.linux.dev,
	stable@vger.kernel.org
Subject: Re: [PATCH 4/5] iommufd: fix cleanup when adding memfd folio pins
 fails
Message-ID: <20261106204616.GL663069@ziepe.ca>
References: <20261105-refcount_overflow_stable-v1-0-70b9c655da3e@kernel.org>
 <20261105-refcount_overflow_stable-v1-4-70b9c655da3e@kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Post: <mailto:linux-arch@vger.kernel.org>
List-Help: <mailto:linux-arch+help@vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-arch+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261105-refcount_overflow_stable-v1-4-70b9c655da3e@kernel.org>

On Thu, Nov 05, 2026 at 02:10:13PM +0100, David Hildenbrand (Arm) wrote:
> folio_add_pins() can fail after memfd_pin_folios() succeeded pinning a
> folio. Upcoming folio refcount limit checks will make this easier to
> trigger.
> 
> Let's fix three problems in the error handling:
> 
> 1. pfn_reader_release_pins() uses the allocated array size instead of the
>    number of folios returned by memfd_pin_folios(). With large folios,
>    cleanup can unpin uninitialized entries. Remember the number of returned
>    folios and use that during cleanup.
> 
> 2. pin_memfd_pages() returns on failure without releasing the pins acquired
>    by the current call. Release the per-page pins for folios already
>    expanded into the page array, and the single pins for the remaining
>    folios.
> 
> 3. pfn_reader_next() returns on failure before updating batch_end_index,
>    even if the batch already contains successfully expanded folios. Update
>    it before propagating the error so cleanup releases those pins as well.
> 
> Fixes: 92687c793644 ("iommufd: pfn_reader for file mappings")
> Cc: stable@vger.kernel.org
> Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>
> ---
>  drivers/iommu/iommufd/pages.c | 15 +++++++++++----
>  1 file changed, 11 insertions(+), 4 deletions(-)

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

Jason
