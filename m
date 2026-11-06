Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.51
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793959999;
	b=iKabMUzC2xoceDNjWyh9BE16CsBx7o0k8l2eLIg6RWXgzsTr+BLpE2edITKbL138Mncy
	 dFUJ44Oerpm5FmcGcRojAO5JxjWx/Z4RzPFKuvba2wh1zHOAAOvoJ+v+k8nDbaa/FamkB
	 XWuk63fS2c6t8+YNuzGPRZSDHGp7BZvBZL9FQ7vfMjKyJTyp2auPuJ3s83d8nyzUyHO3s
	 4PqQ7LmyIVY0J9nLp/atQRoctvT3p8Q1+pWpVkXkp3nPvtKtkOIwJfRP6s0EFNTgUgEqJ
	 VD8mPVOk8ODccUHjlMMf6ig35atbks7IYLccuWyscZQGWAa8V6s3HkbdrF7Vu5dEb8A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793959999;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:References:
	 Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=fLL3XmqFz5Pf3FaFIovTOe/0d0X3Y15DtdwfOU4Sa2o=;
	b=LvX164QW4D+4/vPYjkSq/JW1IyPvNlyFSccHL9bXFLBbZ/TOcAFKNLX27VPXtKNr/YaT
	 CoIzehuhvgUowVNJ0pMH9CF9xCcsA3wa1Ce0A3fGcI0mpftYRtZPGMOO67n1NmsXwdsEj
	 H2uJgnVybgKGcmk1OT5devgepkiEDE1FEed57vuEnKoyD1CdcANXXDihKfYMbhqhBtoss
	 A/E4XHil0njSy6hp6XNrQ+9cwv1rFsSTxr8dYwkm454LbZiRwk+w/j+XMykVXK3yeQtGq
	 4YR125Iifd5DjWSB8/pMjm2O57GRYnOlm80vJeB4+/1jfv3W+gSCVkxAkXLUK9aj+Sg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=lmi5Q0Fv;
	arc=none smtp.remote-ip=209.85.221.51
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42544606A330
	for <linux-arch@vger.kernel.org>; Fri,  6 Nov 2026 10:13:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 42544606A330
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=lmi5Q0Fv
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-48e46e449e8so298062f8f.3
        for <linux-arch@vger.kernel.org>; Fri, 06 Nov 2026 02:13:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793959997; x=1794564797; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=fLL3XmqFz5Pf3FaFIovTOe/0d0X3Y15DtdwfOU4Sa2o=;
        b=lmi5Q0Fv7T71Md66nuBX67PlvPoEFrAFoRKV1Sq9HgiIufOQpo6A5qA4voQ9XVsQnI
         Y5Hj/M5KiCFqmc99z/aMxLeWTTEEj7wwOi2WSlzSWmo/tAk3DTZOxVOHqmd3JGBbyX5p
         MjxD+nIIkXrtlDg79Rto+zQPgz6nVr2WPvpz2LPA0t+/5xqCmE79Ud+YVNwx95IDOpUY
         6gKHohlLzrUuTmWRolrPZjIckPQ9XVpyHmmteUBXc8zNdemlnEFZM9+mZVxPhBgRgSxd
         OK8xZxmBxgiJbDDXxSodZkJXJeAnpIIx2xVIJR2W/+gMaMI2CJhuiL6Zi46Q+a4Dwvd2
         pmHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793959997; x=1794564797;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=fLL3XmqFz5Pf3FaFIovTOe/0d0X3Y15DtdwfOU4Sa2o=;
        b=wKJ5CF471CL4Ntdb5zTKqulJNPC1ZCP2XMDTzaMZx01ytak/B6QCtSw2+mRVC/1Zh3
         Xy35Q5qYvot7OQIXrXuKUPqvRQ4uAZRho1+TnfBltiPX/w0HKqGU8RGl2sXFTs7AyU5x
         Q9+3NtizNmivaAUf09TbDvm9KotsTec1AkvSBTuwyNy9BrCKagaKUme/AXaLbNYi5pGl
         cpAWrm09ezVUSNyDRDuFn1T6Xbmt56vBY0YIGMm4YA7z7WAPyYMG8U8p7IMC2mg/L+R9
         2GtewEvCejGpFiW5gFQotljS3qhWIExQ+DwPLSvD4CSbmKhiWLtbwOtXnAkWT9Im5e3S
         5MQQ==
X-Forwarded-Encrypted: i=1; AKwUvByby9psnCjgyUbQSSrJfDlGlX8d/KAHC5MD/vHjV+z5nPQl6bYY+CH2SWZNcQCHIL+wU1Yqt0kismxW@vger.kernel.org
X-Gm-Message-State: APuU4Z+fsl/txRi9zOliqFX8Sa8KTGyjl5eco7TReBtUPkSBvuuwZ6Tp
	nq/rd4SgOWk5ImqFhu7w532dAOvGSwS9Uz5NVHyivjZCxyjpExliin0j
X-Gm-Gg: AYBFou10aPGn0iXwaSvo9V7KH7Gp1hHG9YVmAe4kW9/WW2KfeNb9CjL86SBXgvzTM4B
	MnI2PPGL1GH0wV+6+3Q2MP7F2VoStfnpjQsO6g+8q4GiXMFJo482dZJBkIclNc2pkwqTOtv83A/
	XV3NQUI8/jQTNF5F0iXBCCGCH4wAbZcoMg8QKnBa9Qpu2ifyU3Xv+6XKH00340taFgqTbIQxr/6
	OnEWYcf9p6gfSMg7BkJPITIAGn0zXX/S7uRlCQJ7uP+fq4EHs1rS2yk4yFFZsOBdM0B10ZI7GjZ
	+JkVpmAUXF5WPBJGZQq0a3PxOgaR1Zxj2FLNmP+NsMFGdiWiHHXWVj5R1BUyvDSCuKu1L4Y5+9B
	xG2yN22f4YldnLuwLyUKcyDuT57Hi5NIidES4iOoLciN/yCBwZLzldjFkXWxvBwmeu81SnVdgk8
	5OEA1MN7y5QUJBUoVpYEtVfk1Oa2AztZ+uatmOPJVg9hTM+sX1SYaL0oRYJ4b0rOLoZ7BaGExXB
	pMDGEy/4EBSUK0bx6q/d2aqjGvftVcnIqXE7qE2lohltRgI1Z2pN3VqQ/0NZWnmKS9pSI6CP4BT
	++FDR/EV46/jeJ1tjfn7Ycw=
X-Received: by 2002:a05:600c:310f:b0:4b6:bb67:bb9 with SMTP id 5b1f17b1804b1-4b6ded4a3b0mr30188925e9.29.1793959996617;
        Fri, 06 Nov 2026 02:13:16 -0800 (PST)
Received: from [192.168.1.22] ([83.231.69.9])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4b572bba207sm121341505e9.10.2026.11.06.02.13.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 06 Nov 2026 02:13:16 -0800 (PST)
Message-ID: <4763a039-60f8-4263-8124-beb0f9ab3366@gmail.com>
Date: Fri, 6 Nov 2026 11:13:13 +0100
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
Subject: Re: [PATCH 5/5] mm/gup: limit pagecache folio refcount when grabbing
 references
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
 <20261105-refcount_overflow_stable-v1-5-70b9c655da3e@kernel.org>
Content-Language: en-US
From: "Jose A. Perez de Azpillaga" <azpijr@gmail.com>
In-Reply-To: <20261105-refcount_overflow_stable-v1-5-70b9c655da3e@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/5/26 2:10 PM, David Hildenbrand (Arm) wrote:
> Let's replace our existing safety check by the new
> folio_ref_count_over_limit() check in fast and slow GUP before acquiring
> additional references or pins.
> 
> Keep it simple and use the check for all folio types.
> 
> Drop the WARN_ON_ONCE(), because apparently these things can currently
> happen with large pagecache folios.
> 
> Keep the zero-refcount rejection if the refcount is 0.
> 
> Fixes: 800d8c63b2e9 ("shmem: add huge pages support")
> Fixes: 99cb0dbd47a1 ("mm,thp: add read-only THP support for (non-shmem) FS")
> Fixes: 793917d997df ("mm/readahead: Add large folio readahead")
> Cc: stable@vger.kernel.org
> Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>
> ---
>  mm/gup.c | 12 ++++++++----
>  1 file changed, 8 insertions(+), 4 deletions(-)
> 
> diff --git a/mm/gup.c b/mm/gup.c
> index 2ab42fc6834e5..db9db6b2a4662 100644
> --- a/mm/gup.c
> +++ b/mm/gup.c
> @@ -77,7 +77,7 @@ static inline struct folio *try_get_folio(struct page *page, int refs)
>  
>  retry:
>  	folio = page_folio(page);
> -	if (WARN_ON_ONCE(folio_ref_count(folio) < 0))
> +	if (unlikely(folio_ref_count_over_limit(folio)))
>  		return NULL;
>  	if (unlikely(!folio_ref_try_add(folio, refs)))
>  		return NULL;
> @@ -140,7 +140,11 @@ static void gup_put_folio(struct folio *folio, int refs, unsigned int flags)
>  int __must_check try_grab_folio(struct folio *folio, int refs,
>  				unsigned int flags)
>  {
> -	if (WARN_ON_ONCE(folio_ref_count(folio) <= 0))
> +	if ((flags & (FOLL_GET | FOLL_PIN)) &&
> +	    unlikely(folio_ref_count_over_limit(folio)))
> +		return -ENOMEM;
> +
> +	if (WARN_ON_ONCE(!folio_ref_count(folio)))
>  		return -ENOMEM;
>  
>  	if (unlikely(!(flags & FOLL_PCI_P2PDMA) && folio_is_pci_p2pdma(folio)))
> @@ -1482,8 +1486,8 @@ static long __get_user_pages(struct mm_struct *mm,
>  				struct folio *folio = page_folio(page);
>  
>  				/*
> -				 * Since we already hold refcount on the
> -				 * large folio, this should never fail.
> +				 * Grabbing more references can fail once we
> +				 * hit folio refcount limits.
>  				 */
>  				if (try_grab_folio(folio, page_increm - 1,
>  						   gup_flags)) {

this can fail now, so shouldn't the error path below return -ENOMEM like
the first page does, instead of -EFAULT?

-- 
cheers,
jose a. p-a
