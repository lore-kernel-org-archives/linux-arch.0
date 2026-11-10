Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.46
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794312022;
	b=VK3i7i9vlSoLUbyfgEszRwrHbsnR/qLy9bwG1KplpE5Rez4PbPJmdPBbJlTdQ1LxQy8g
	 sQWG3Bh2Bo9M9HQDEGgwLc4gvfBoojnruHVqJRPxROv1VwpvbxU6z3KQseapd0yVZIe6v
	 +RBi3CuYSLqcZzgY/cMyMpWjP1/d2B9QIVOqRM9WUuaNPAPA232OQbo+pbQ4VMuhyJXv6
	 zUb9hLo+OTP+X/Ke4WN+65ovNJCZSgBBItq8zfpsRL3LgovOVOuyhCkXiOnX9pnJDO5tE
	 vYw5DGqxVo/6Cuv9OlwyPtstAQyl5ZESfTnWve4BKqMGtw4yK2kHfadkjirznDfG3vg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794312022;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:References:
	 Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=5X3zb3VH4w0Ie2RKn7QlDBjKtcvMvn58SYuQeOEmpyc=;
	b=Dfk8XlA05mKmoSHZwiezoYF9uLk5eG/GKhsH+vIgcbeR6rK+Y4j8SIL2Hl13g3Qro4DE
	 hFNLIFIFWPJ/W+nzJ5hnz7sS+2VSktJPStnPuNyH31tfnTd9z/6a1U5xgvPEzaIKcp5dT
	 VJnQbxraULPaFtQW8F1wR8+FvX6v2p8Mynl2gUOnb5rXNznNqCruSmvcftNUNuSOK8c4I
	 sx0ddcI7vXd95ylxE1ay5K35bPF8LN874FOfp2jdgW7Vr+VND+AZrA8GrT9hXYQ1u3Wvt
	 RfrwH5S0ccKUyzVzfEQshDbiovoK3P/97j6e8ONASyH977TTdwYb3ai1ijdas+FHdPw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=RygyfnWn;
	arc=none smtp.remote-ip=209.85.128.46
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32BC2606A331
	for <linux-arch@vger.kernel.org>; Tue, 10 Nov 2026 12:00:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 32BC2606A331
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=RygyfnWn
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-4a208d93758so20114335e9.3
        for <linux-arch@vger.kernel.org>; Tue, 10 Nov 2026 04:00:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794312020; x=1794916820; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=5X3zb3VH4w0Ie2RKn7QlDBjKtcvMvn58SYuQeOEmpyc=;
        b=RygyfnWnL4Yk98O5t8EfRhHJ09wgqoKDc50vcLztTT6VXIdGWIzxp8gp/oS32JisXO
         kLYRYeznXrsblttCwXF35i/TiPDW3jopVuEIWql4OVWvjiutcXKU/UhCKEYZ4UR66O+e
         kULSXyMPCUX82fsckuZ3E8/kna98lIel4VII+ANkE31SFugl57e0klPU61lHfgCvDtTP
         MtFuBcaDmc0Sm6fZGoIl3GD+SdzoAAyrnDFRUROyQH/KkkH9EDfZSB4dt1fPJiCh/NsV
         ut2IqQIh8tubjGervp8DrB5/N+bX1ezKOwAYOMPw+my8dmAF1D4nC3K5R5n4n3eGr4qG
         fgaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794312020; x=1794916820;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=5X3zb3VH4w0Ie2RKn7QlDBjKtcvMvn58SYuQeOEmpyc=;
        b=aKrBX6/JXy1HimH/z+1+JtzbaxDw56nqHufq07lI5poLUJ+4l217563iZGrdwyIwiA
         /Wd4W4J8X6Oa3msjBeuHakrfwXHID25vKnJ46lSa1ofEa8LUDtXgKCaIlcHpL5y1shH3
         Cmwa8ph2aPaxYt5vFcWT28sASuRsnCBzNcn4P1PwdLT7we0rAqWA2D8r80OsPaPnJy9p
         oBFLFsj7fkluaaKPpTayx0f/k0kIRx/Lk2tSPYyZ5sELCmpGbIyBRzYklzfNvACYJ3Lb
         BsVMzdQMgKT5pZsCYPejrY8Py4F7TXh0gRZVqy5TdXUkqS/jH+Kv6L8LV1g62uxmGF69
         yc2g==
X-Forwarded-Encrypted: i=1; AL+hErHZe7tdNoMc4AUe7sLIRV7+mtu0npiNTZS+MbMFN4OW4vE0825tQT/MrWabGcWPWNF62/AJXccoC7Xs@vger.kernel.org
X-Gm-Message-State: APuU4Z/heiIoMeHu4d7IfChin6WXaNrfOq29GXxCrAO1xBk4dUvrG+Un
	jUTK33fg3HpfrmwShzkEXQkUyyZlKqxBXto4SYZ1yrKdNB2YqJhdrN1h
X-Gm-Gg: AYBFou1PReH0XOCvmKgl8lsyUJ0qBl44MYE5Ldg870y8JYKZnuq5TlhQg5I6yfwDUoa
	h+h8jMzQsF3cP72U3/ebVghgaigTWVj4zqbRUnAM6sQEch0EFrTwDVTbDchycmSNf+yAk2uIVb0
	IHCmXyiX1uo2XKT7ExSqguQOXpuOZmkZbjRUxA2MPR7q2lhULtAVuz67moC5sqNRJ0Gy3KrR4D2
	r/G3Dl9ZyToe8htMZfnq4+Yr1jIyl84BC4nVR+R69PE+21A+kxi+453FtrvOQXjbsb60yMwlSq9
	hkC+Svg42UAjLo9zY0J28ERt7IrDFg+8zEK6caqaM6jWwzhXb9140xVdzd5739OxanwIWHGNURp
	jIWwNo4hsCCj9Vd4snBZJtOtPFp+u7T24Sr9lWGnKfL7Ze4oO5stUEzHz7zYibIKZ7P7g3cfE1K
	bcJsyJwrbKGIqULXk4WOpzMXLVEaRKZdclHE00UXdYqFrJQFaz5abISgV46d0q0dyp2RJ7vKRc9
	YTGQS4S8BZymmsq71FE6iSfncWA287lWig9wfaIE5gyhAj9EpWffFdrv66ffeMh800s0HWOdCTr
	9Gwh5bb66FNh7wNe9Ctxm39K
X-Received: by 2002:a05:600c:3e07:b0:4a1:e69d:90e8 with SMTP id 5b1f17b1804b1-4ba0234a8f3mr43245435e9.22.1794312020086;
        Tue, 10 Nov 2026 04:00:20 -0800 (PST)
Received: from [192.168.1.22] ([83.231.69.9])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4ba01fea9eesm97526925e9.11.2026.11.10.04.00.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 10 Nov 2026 04:00:19 -0800 (PST)
Message-ID: <d4bb71af-cd1f-4d42-b724-916064f4cf0f@gmail.com>
Date: Tue, 10 Nov 2026 13:00:16 +0100
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
Subject: Re: [PATCH v2 2/5] mm: limit pagecache folio refcount when splicing
 into pipes
To: "David Hildenbrand (Arm)" <david@kernel.org>,
 Lorenzo Stoakes <ljs@kernel.org>, "Liam R. Howlett" <liam@infradead.org>,
 Vlastimil Babka <vbabka@kernel.org>, Mike Rapoport <rppt@kernel.org>,
 Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>,
 "Matthew Wilcox (Oracle)" <willy@infradead.org>, Jan Kara <jack@suse.cz>,
 Andrew Morton <akpm@linux-foundation.org>, Zi Yan <ziy@nvidia.com>,
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
 Miklos Szeredi <miklos@szeredi.hu>, Alexander Viro
 <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>,
 Hugh Dickins <hughd@google.com>, Will Deacon <will@kernel.org>,
 "Aneesh Kumar K.V" <aneesh.kumar@kernel.org>, Nick Piggin
 <npiggin@gmail.com>, Peter Zijlstra <peterz@infradead.org>,
 Arnd Bergmann <arnd@arndb.de>, Jason Gunthorpe <jgg@ziepe.ca>,
 Kevin Tian <kevin.tian@intel.com>, "Joerg Roedel (AMD)" <joro@8bytes.org>,
 Robin Murphy <robin.murphy@arm.com>,
 Steve Sistare <steven.sistare@oracle.com>, John Hubbard
 <jhubbard@nvidia.com>, Josef Bacik <josef@toxicpanda.com>,
 Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, fuse-devel@lists.linux.dev,
 linux-arch@vger.kernel.org, iommu@lists.linux.dev, stable@vger.kernel.org
References: <20261107-refcount_overflow_stable-v2-0-c38f6809b106@kernel.org>
 <20261107-refcount_overflow_stable-v2-2-c38f6809b106@kernel.org>
 <c8dd3102-38f8-4972-ad2d-97545fd8c8d4@kernel.org>
Content-Language: en-US
From: "Jose A. Perez de Azpillaga" <azpijr@gmail.com>
In-Reply-To: <c8dd3102-38f8-4972-ad2d-97545fd8c8d4@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/10/26 11:38 AM, David Hildenbrand (Arm) wrote:
> On 11/7/26 23:23, David Hildenbrand (Arm) wrote:
>> Similar to mapping pagecache folios into page tables, let's reject
>> additional references when splicing folios into a pipe if the refcount
>> is at its limit, similar to how we handle it during GUP.
>>
>> This will prevent more cases of possible folio refcount overflows with
>> large pagecache folios.
>>
>> Let's keep it simple and check in the two callers of
>> splice_folio_into_pipe(). Return -EOVERFLOW if the limit prevents any
>> progress, so do_splice_read() can fall back to copy_splice_read() when
>> read_iter is available. This keeps sendfile() and other splice users
>> working when ordinary reads would still succeed.
>>
>> Also fall back to copying in FUSE when taking another reference through
>> fuse_ref_folio() would exceed the limit.
>>
>> Also check in try_get_page() to cover pipe-buffer duplication by tee()
>> and partial pipe-to-pipe splicing.
>>
>> Fixes: 800d8c63b2e9 ("shmem: add huge pages support")
>> Fixes: 99cb0dbd47a1 ("mm,thp: add read-only THP support for (non-shmem) FS")
>> Fixes: 793917d997df ("mm/readahead: Add large folio readahead")
>> Cc: stable@vger.kernel.org
>> Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>
>> ---
>>  fs/fuse/dev.c      |  5 +++--
>>  fs/splice.c        |  8 +++++++-
>>  include/linux/mm.h |  9 ++++++---
>>  mm/filemap.c       | 11 ++++++++---
>>  mm/shmem.c         |  4 ++++
>>  5 files changed, 28 insertions(+), 9 deletions(-)
>>
>> diff --git a/fs/fuse/dev.c b/fs/fuse/dev.c
>> index 3641abb90d6bb..4f6b7b42bfd3e 100644
>> --- a/fs/fuse/dev.c
>> +++ b/fs/fuse/dev.c
>> @@ -1265,9 +1265,10 @@ int fuse_copy_folio(struct fuse_copy_state *cs, struct folio **foliop,
>>  		if (cs->write && cs->pipebufs && folio) {
>>  			/*
>>  			 * Can't control lifetime of pipe buffers, so always
>> -			 * copy user pages.
>> +			 * copy user pages. Also copy folios at their refcount limit.
>>  			 */
>> -			if (cs->req->args->user_pages) {
>> +			if (cs->req->args->user_pages ||
>> +			    unlikely(folio_ref_count_over_limit(folio))) {
> 
> Linus points out off-list (thanks!), that fuse_ref_folio() should have
> really used try_get_page() right from the start.
> 
> And that we should just not fallback to a copy, in particular,
> if the refcount is invalid (<= 0).

now that is said out loud, makes sense.

> So the following is what I have for now. Once we remove the limit
> handling again, that code won't change, which is good.
> 
> I went back and forth with folio_get_checked() naming, but decided to
> not mix in the "try" as that just reminds of our speculative refcount
> handling. (folio_try_get_checked / folio_try_get_referenced)

agreed with that.

[snip]

> -			if (pipe_is_full(pipe))
> +			if (pipe_is_full(pipe) || *ppos < folio_next_pos(folio))
>  				goto out;

nice!

Reviewed-by: Jose A. Perez de Azpillaga <azpijr@gmail.com>

-- 
cheers,
jose a. p-a
