Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.44
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793958977;
	b=4ObTB7r+BLvUnS8zGd9xc1SNXvLJVybR5+QrbL41JZVc7Oc4rWC6zjSt3hdC3Wj5F4HH
	 JBjHkzUFnOYx5NlMF/2NE3hILuSEeH7p8R1cED9Mox8xr+kLo5Gi/BBkg6aIiYgXkw+2D
	 G9AUK6vc+p6jmjOOB+vsGqXtUqYygVRk7M9RmLT4J3OGpTZgAONJQCvIG5VER0gHv6UDj
	 DmYXa/pgpeNO9ocRVmv5BdnlEwFJQDrozqFPMEB6rI6WorGudQxuUoGE90x9RUrhXyPU3
	 4eMfuLWaNu1PUQmTEHAz46oTnYPQzmvWOCQ2xhPtdh5sQLFfsqtxemqxJxcogSlXw9Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793958977;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:References:
	 Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=PVNqNcKixHGsvQRk+aF9Z3pXurarEsFSJxJzB1XGyf0=;
	b=PiDqNp+s7tx3gFqHXxpdxgmd69mcl7Nyw0fBYmjylk3oKQrAdpfoK8wrnXG58/gBioAh
	 vVI/1gJXDCLL1LqVS7pFXB7N4VSKFKAkNhBQekMCSD5jeMapUx0FO1H37nfA6evWsEPKt
	 /fGqcbYjLVK2XqRJNA/otJU071CCAF9QYliNabJ/P3CnfqtKOERXvd7rpxw6NHBwabHrI
	 sA8eX18Qx+JtKQ9218WHDPgdEXtsVHnaHc0fxyrVzEnm8mQvtpOGG2XAqdQagCtmaivIe
	 gbRjjbWPo6yZgfCiW7Ih8rV+AePg+UdlspmdHqHbMTb2Juj3d8eoks8v1qL7eEU5dfw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=H1Xmkiwr;
	arc=none smtp.remote-ip=209.85.221.44
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69F75606A32D
	for <linux-arch@vger.kernel.org>; Fri,  6 Nov 2026 09:56:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 69F75606A32D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=H1Xmkiwr
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-48fd2e38825so290497f8f.2
        for <linux-arch@vger.kernel.org>; Fri, 06 Nov 2026 01:56:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793958976; x=1794563776; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=PVNqNcKixHGsvQRk+aF9Z3pXurarEsFSJxJzB1XGyf0=;
        b=H1XmkiwrX3YLzUoz8v63tW0K3f8HeQQMrYHC6NguBq0Yc1lHgV5BxOaPiQVM/nx5Kr
         Nv4Nkr/P+0smDYStmA0vxUWIevexJO6W3YeVFzXWxjpUb82YtyB7exO1WkMPRlrqshbw
         7gdELKEwKXzXZnlrkpHr1yD7exsMl5g9kqsHjwkVOrYoszaDhxn1MLxcOJF4sb/6L3MY
         sIdWD7L/keA+kAzxJc8rrEhKaeUKb4K3OJKzQ0cL4yoRHek+Sk1AtTQV2X8+u59Vj8dP
         k4wPQ0+F+f6g4v8Op0nmFGDXNrToQHYaCL+7LHoyjFE/RK0fmcwPf6Waptypct15sbUF
         jOcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793958976; x=1794563776;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=PVNqNcKixHGsvQRk+aF9Z3pXurarEsFSJxJzB1XGyf0=;
        b=PH/x1u4/kPX8l8PFblxoeyJy2ksVgvSQfz4ipnnRayyZIHPRS52FvGFlGdh8EBX6cJ
         Avi3HoZCSUweFyojEV31iSmYWgfoFS755AfV+XTmvxMsb7Ie8tCG35BmXEk4mBHeFyhv
         JXCxkmrrI08ucs6Am/SLNLmMEJYafZDd76PGpPXVM4Oex11L19idthbMKrgtYOQlZEX0
         73BlGNlLJK6C5m8MHIHKpptXpi1J5VFt43X67XQlJZBcuQjnH6aczHofcnyBpV8n6QWx
         bmuUTIPRLmgtZUi1xmiadDg6ULbw5N3rEucBof9m0eNW/VRsYioAi7VeSh+QLBNChNJ7
         lzgw==
X-Forwarded-Encrypted: i=1; AL+hErGWkSd7G0Ur3HQu4t8seqaUrKxv22VoIJGogW/+Trj1vuByh4gQ8TkAQXw9w7n+M/lQKzfmQhMoJFtQ@vger.kernel.org
X-Gm-Message-State: APuU4Z9ZvXZavBW9lPvdj0EmNIFXJR6g5vBLsmvfOgTlPkoLOegN9uvw
	Uzlux03u9AiNyEQ8U5gHduec7xHUZmM2YroVQ8ggM0JrM2DeguamLq1X
X-Gm-Gg: AYBFou1RMqyjN8C1aMlGMZEaO5gMxEtAXeraeLYOkNB2zUpPSn3ogzggkO7GBZmceMA
	Ghptmw6/GTnV4993DjBwvNqVPb5JNHcsonu1i0o5TUuAp/RcSNZAfFvPMxOyXVJ17JsgHppGwDl
	xwHy1Ak22aVPoEtFnaVTharln6MaswKeNoNVNpwsYBb8U1P+hbVS4VTTn7f9IlkymkqmXWI5gzE
	XiOKQm3+M+D35fLM356mJ3gXFjDYrIelp2d316rT+1KUK6IWM1l2c+/VjyXDMx0cvPCovqXAVvi
	IgjC9QdhFNYhmOlKKdRRsbjYBsaCrHeGrFOPPXAcUrWJ7wdCjz2qp8dI0yXU4/Vc3jIZ24xx0t3
	Bet2QuveLW6b4pgSF5BIukckgH/Go8nWufGKkl4CgGEh3j7rSgDUcnDSufAZxRfMOmROqZMZozB
	ccmgixNq2Gkb3YkybMjXNMJnsO3jfnBmMeS5036MOhtPBmJxmhpwYD6+pBOoufAaotwBxU6Ah4N
	mC+nFJQ8C/Ad1CadBEega5HSVn9ICGghqQVwklc4z74MEU7q/8ufhR9uMEvI2fog/ihvQRt+Qkb
	R7k3Ek4SCjWg0GdvvCFk/BQ=
X-Received: by 2002:a05:6000:26d3:b0:48e:6159:8274 with SMTP id ffacd0b85a97d-492765a3e9emr3874962f8f.27.1793958975594;
        Fri, 06 Nov 2026 01:56:15 -0800 (PST)
Received: from [192.168.1.22] ([83.231.69.9])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-492d7dbb0d4sm2752385f8f.50.2026.11.06.01.56.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 06 Nov 2026 01:56:15 -0800 (PST)
Message-ID: <e3e15340-d6c0-479b-867f-e5eeac1e0e2c@gmail.com>
Date: Fri, 6 Nov 2026 10:56:11 +0100
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
Subject: Re: [PATCH 3/5] mm/mmu_gather: flush pending references early before
 the folio limit
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
 <20261105-refcount_overflow_stable-v1-3-70b9c655da3e@kernel.org>
Content-Language: en-US
From: "Jose A. Perez de Azpillaga" <azpijr@gmail.com>
In-Reply-To: <20261105-refcount_overflow_stable-v1-3-70b9c655da3e@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/5/26 2:10 PM, David Hildenbrand (Arm) wrote:
> When a task zaps mappings (e.g., MADV_DONTNEED), it can drop the PT lock
> and defer dropping the folio references. In the meantime, page faults
> can refault pagecache folios, creating more references for the same
> folios.
> 
> Let's just request a flush after enqueueing a pagecache folio whose
> refcount reached a certain threshold. Start flushing well before new
> references are refused, regardless of the caller's privileges.
> 
> This is a temporary measure until we have something better.
> 
> Reported-by: Chris Mason <mason@kernel.org>
> Fixes: 10ebac4f95e7 ("mm/memory: optimize unmap/zap with PTE-mapped THP")
> Cc: stable@vger.kernel.org
> Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>

LGTM:

Reviewed-by: Jose A. Perez de Azpillaga <azpijr@gmail.com>

-- 
cheers,
jose a. p-a
