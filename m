Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.50
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794214668;
	b=3pMSctYyTwBvGuXecfKg75FbSRDbtlLWN1jcTyHY4lYRpehBY1ClDvT4w7uuve6+cmLP
	 hzlJZz7mVSMusOjOHnsDRxIiT9aGSUhd4Yooj+N6lbuOEJLcUEC6Ia7t0dgsf0+uhEYtP
	 TibPCmF3zBwphW5A/3Rs5FXr6ip4Gn6L6o4p6x65taBY0m6hOioMfsXD5JFS+QoWyXZGJ
	 80CSaqkdX6YeFEV+Q/I9XZeiSK/CKxBcvta0Pjz/xnzHrLBkJ2yAm68h9veTW72CKSHNy
	 pLOVenkeQli9/c/iwVQ0+b8AnN+lDfDcqDPLzcj5f5sKzobUWyWb9CJ12HTpQV6Yg4g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794214668;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:References:
	 Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=6gPNbhKnS4UiPYe9GkhcEdm+Vle3xI8UXMcC7kdMJ/8=;
	b=PrqVvW09DtrsDKhNF0zruDm/+ESLrQk31kV27k/6pXiuazgQ9+q/go18regjNAGpPIOv
	 XMsPGE5JgHh/d71csaAjvXabokp6Xq20tpI+ng/Qx1n0zJCuJMK7dh+PqpTzsFwC7l/2f
	 Q0FMKCUGmtVOKZ1WriIIfaKkEFUo6A4vip3/rVyyke74IrO/2DyGPNxCh15ShOqKLpeoo
	 /ATdVj78GqhLU4RmJqpTZtvfem3xCNc2kcFVs/0R0lI2D3DMYd7fnaRvdOhkCKfcVsQkr
	 7jGdzr0o7BnDtDrz4Uv7is/rbiZoK0fHr+BVnPtWjUaGo8j2eJqWp1XEgN7AENyGb7g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=WX99d5g8;
	arc=none smtp.remote-ip=209.85.128.50
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B1EF606A326
	for <linux-arch@vger.kernel.org>; Mon,  9 Nov 2026 08:57:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8B1EF606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=WX99d5g8
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-4b4571ff080so7243005e9.1
        for <linux-arch@vger.kernel.org>; Mon, 09 Nov 2026 00:57:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794214667; x=1794819467; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=6gPNbhKnS4UiPYe9GkhcEdm+Vle3xI8UXMcC7kdMJ/8=;
        b=WX99d5g8HsNJ2Xc3dJWqBEteZ1Yzefr2XigtdxHvKUPJpgca1CoZqq4dp9NTaNP6YU
         bfxXvVbrXNq1MdQzDcVoMJst5p/JdASrGhqAQ35GgrQgGpWZpMZlArfgaA1khdBAvC3f
         UCgBrQaf6/SWaIrIz1cfg3VI8DlRIOxG1IFQ8rIXoFZQPGYzqcNzDEqWjIR9CgfeTAw8
         NE+Bm718A9eCD1tFyyGwavlgkgZz4MK9/UkYHD7WODjq9NCi/wfmLAsHbxT2jEtokNMQ
         8Q5NxTbvsYh5rJzdZ+Fl9IzESFScMGEZ1Re6QX6Qo6SLBiZakqLIE2CVv/0RDj39F8Jv
         /HqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794214667; x=1794819467;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=6gPNbhKnS4UiPYe9GkhcEdm+Vle3xI8UXMcC7kdMJ/8=;
        b=F5K1k10MHyy12S5FmUYV+uNr3B8+mJDdjijPVLNLqLkyRCbiAAQ+jDGqHC+2TB3xHA
         gYSUOoTrP5nSCpJ//WnEUM6IwqXfXxOOvs4zrntnjp5G1jQnvVXPppC7GSzmY4B8dd4H
         Nm/P05O3G/lgi4Bovwn1eLGgdvdt8XixuImNvwnTK6JSwjBg9TpGwDF9WaR1nUNvxL1P
         YDDquO1WI1cldzZAb/bvNI5L4O5pRAf0nhbLdL66+VgtNQSn7v9YZCVgrJ32WQn+gfF0
         cm3r7fhVb9h8QRJ7q0z964Gxn1K611bsKkCqPaqGzU7qXzB+gD84E2L+BGIzOxP06hv1
         NCTw==
X-Forwarded-Encrypted: i=1; AL+hErFr8rrYsWYVfkSzFkeqL+8XboV3r6zWZ/1bLnD/zujFVLCl02PDIGavj/p0ueJJ7IY+X85FVFOachrk@vger.kernel.org
X-Gm-Message-State: APuU4Z/btgUkamlDk1jB4dvDY20huYFDqScrb6+xj5R3NqRDhJxkD/by
	B5Ucn7tpFw2rhHtOiPh+jG+HIDJsVGLuhzbz/+hlcrkENPjsKMaCoAsq
X-Gm-Gg: AYBFou1uyve/936cuqY4E6acfco451m59b+x1Fokw38K8xh2KWO8GDH8BetgEITpHjg
	FjnJTPD1nz0Hr3D23h05ZXokZC9v2UJhTf6Hl9zoDOgVr/rtQ8dMPG1cJDKlUFTGBxcQLptoVG4
	DJmaASiIjRjmxXJiPKrjK0edKcCwV8lBPFnua14R7krzBoDp+ZNg/AR5G5+vETRdAYXRpBDksgE
	RaLnE/BVYbTptsQegYUPhlvuJWXyIXj4ZYuB+fNaJ0O0ApF63jlHqXWQn7Ib9ODGTwJJeilju9l
	EmyEOrAgaPHBTVD2PQ/wvkzUJoLpjIYLRJ5tDt4ubkR0NGSzjXrqRZKtxN8iy0m7CHxEO0O01mI
	88qsaHssoVLUqqrKsWvzoH/Oyd7LJDkY19Y6+qSCJDun9LYwVmvSbcElYtWTDDLbf9UNy+M8m/o
	MpaJo8kklYj8Xfm22JkIcXkcT2Y511UZzkYWyv6T5tlP9RCsKhaiMyKkiOoX3P0UYz1/Al83kkD
	Ns2GsB4Km4m4BKHPn4VJq288igOpDREXTcu3FnW++ZLFoTx4tVGN6JNr7S7Tw/4UaGBihd8NSaL
	yL0fpT/XS7kTzDBsVv5GfGs=
X-Received: by 2002:a05:600c:4f86:b0:4a1:fa21:fd90 with SMTP id 5b1f17b1804b1-4b960d9b17dmr61969495e9.9.1794214666809;
        Mon, 09 Nov 2026 00:57:46 -0800 (PST)
Received: from [192.168.1.22] ([83.231.69.9])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4b79501502asm149200295e9.2.2026.11.09.00.57.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 09 Nov 2026 00:57:46 -0800 (PST)
Message-ID: <a9fb2d3c-d518-49d3-9479-a25fa2cfc5b3@gmail.com>
Date: Mon, 9 Nov 2026 09:57:43 +0100
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
 <jhubbard@nvidia.com>, Josef Bacik <josef@toxicpanda.com>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, fuse-devel@lists.linux.dev,
 linux-arch@vger.kernel.org, iommu@lists.linux.dev, stable@vger.kernel.org
References: <20261107-refcount_overflow_stable-v2-0-c38f6809b106@kernel.org>
 <20261107-refcount_overflow_stable-v2-2-c38f6809b106@kernel.org>
Content-Language: en-US
From: "Jose A. Perez de Azpillaga" <azpijr@gmail.com>
In-Reply-To: <20261107-refcount_overflow_stable-v2-2-c38f6809b106@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/7/26 11:23 PM, David Hildenbrand (Arm) wrote:
> Similar to mapping pagecache folios into page tables, let's reject
> additional references when splicing folios into a pipe if the refcount
> is at its limit, similar to how we handle it during GUP.
> 
> This will prevent more cases of possible folio refcount overflows with
> large pagecache folios.
> 
> Let's keep it simple and check in the two callers of
> splice_folio_into_pipe(). Return -EOVERFLOW if the limit prevents any
> progress, so do_splice_read() can fall back to copy_splice_read() when
> read_iter is available. This keeps sendfile() and other splice users
> working when ordinary reads would still succeed.
> 
> Also fall back to copying in FUSE when taking another reference through
> fuse_ref_folio() would exceed the limit.
> 
> Also check in try_get_page() to cover pipe-buffer duplication by tee()
> and partial pipe-to-pipe splicing.
> 
> Fixes: 800d8c63b2e9 ("shmem: add huge pages support")
> Fixes: 99cb0dbd47a1 ("mm,thp: add read-only THP support for (non-shmem) FS")
> Fixes: 793917d997df ("mm/readahead: Add large folio readahead")
> Cc: stable@vger.kernel.org
> Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>
> ---
>  fs/fuse/dev.c      |  5 +++--
>  fs/splice.c        |  8 +++++++-
>  include/linux/mm.h |  9 ++++++---
>  mm/filemap.c       | 11 ++++++++---
>  mm/shmem.c         |  4 ++++
>  5 files changed, 28 insertions(+), 9 deletions(-)
> 
> diff --git a/fs/fuse/dev.c b/fs/fuse/dev.c
> index 3641abb90d6bb..4f6b7b42bfd3e 100644
> --- a/fs/fuse/dev.c
> +++ b/fs/fuse/dev.c
> @@ -1265,9 +1265,10 @@ int fuse_copy_folio(struct fuse_copy_state *cs, struct folio **foliop,
>  		if (cs->write && cs->pipebufs && folio) {
>  			/*
>  			 * Can't control lifetime of pipe buffers, so always
> -			 * copy user pages.
> +			 * copy user pages. Also copy folios at their refcount limit.
>  			 */
> -			if (cs->req->args->user_pages) {
> +			if (cs->req->args->user_pages ||
> +			    unlikely(folio_ref_count_over_limit(folio))) {
>  				err = fuse_copy_fill(cs);
>  				if (err)
>  					return err;
> diff --git a/fs/splice.c b/fs/splice.c
> index e6d43329ed3f0..df73a4e65118b 100644
> --- a/fs/splice.c
> +++ b/fs/splice.c
> @@ -956,6 +956,7 @@ static ssize_t do_splice_read(struct file *in, loff_t *ppos,
>  			      unsigned int flags)
>  {
>  	unsigned int p_space;
> +	ssize_t ret;
>  
>  	if (unlikely(!(in->f_mode & FMODE_READ)))
>  		return -EBADF;
> @@ -977,7 +978,12 @@ static ssize_t do_splice_read(struct file *in, loff_t *ppos,
>  	 */
>  	if ((in->f_flags & O_DIRECT) || IS_DAX(in->f_mapping->host))
>  		return copy_splice_read(in, ppos, pipe, len, flags);
> -	return in->f_op->splice_read(in, ppos, pipe, len, flags);
> +	ret = in->f_op->splice_read(in, ppos, pipe, len, flags);
> +
> +	/* Fallback to copying when hitting folio refcount limits. */
> +	if (unlikely(ret == -EOVERFLOW) && in->f_op->read_iter)
> +		ret = copy_splice_read(in, ppos, pipe, len, flags);

here it can't tell where the -EOVERFLOW came from, if another file
returns -EOVERFLOW (i.e. tty_fops uses copy_splice_read, and
n_hdlc_tty_read() returns -EOVERFLOW after dropping the frame), it now
gets a second read. also, the first read already lost data. so the data
read returns different data, the dropped frame is never reported and
returns the next frame instead.


-- 
cheers,
jose a. p-a
