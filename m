Received: from va-1-111.ptr.blmpb.com (va-1-111.ptr.blmpb.com [209.127.230.111])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CDB23A8724
	for <linux-arch@vger.kernel.org>; Tue,  7 Jul 2026 06:38:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.127.230.111
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783406328; cv=none; b=Mqc1LijcDSphQ/uMBjkWX2llmirtODFW/nGlvN5XnA66QoucG6v3ZcxXt9WCW8PzS7ojuCOUfqXWwRagfM2kPDeZG8wp80rzsnxltuaupUpUbQWW6TsH5aCx4t+t0bx7eqUGMSetefL56LTVQ+5DwYnFwRNUQVRKY0jTitvbmxA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783406328; c=relaxed/simple;
	bh=nV2AGITJZTU1NzNzryu2M0rvwVAs69WU7Il0XZUHCqU=;
	h=Subject:Date:Message-Id:To:Cc:From:Mime-Version:In-Reply-To:
	 References:Content-Type; b=gTO4/ypCGhoUdVJ2gal1RT7l4ojoFvHtgbCcS0mqORR8EhTAd/3Exd3uoVP7BZrdlHa7gzHoQBVXR+09Mq18H8RQPNlQ2LYVZg+PfLpoZIPaIBfzVqV6VWAvxZ9vGiTA0WtSsQq6sIAHAhOF8fyxZYXhMX4UfpCiiQcUgfvS+yI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=T9c9o/hg; arc=none smtp.client-ip=209.127.230.111
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="T9c9o/hg"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=2212171451; d=bytedance.com; t=1783406321; h=from:subject:
 mime-version:from:date:message-id:subject:to:cc:reply-to:content-type:
 mime-version:in-reply-to:message-id;
 bh=t1BFGaGU2xupQRN461NQlBdIPrGwg67ma5LofMnJBF8=;
 b=T9c9o/hgrsIen/ufvk8cRltvXc98r0f7EqRqol0h2xOlpYPaEds9LiOavYAnXnMqZK1QU/
 tJFTdwl9AqBP1WE4OfIcKhnLtFGofcXfP6cdLzrZa9UWblf4j+5XR9NDS71K863YqXjtmz
 xmFuMZJGfliqsMk18REwMAJICS4nCNTxK7f92WV5FRLJ1qBczS3RAUcmVt07IoUIIGfQl4
 48L5Bdg31dUmUISHQQ8enci+/1njK//6szFSdbL/RUP5w9Kwk7KoOBLidOuQ/lQtpWa08w
 3fD5BpDEMR8LcT0qm5q25TaViyAC5t1NFXHzMqiEzMGXMUwpqGu6Lm25artsnw==
Subject: Re: [PATCH v5 5/8] mm: extend the template fast path to zone-device compound tails
Date: Tue,  7 Jul 2026 14:38:14 +0800
Message-Id: <20260707063814.40421-1-lizhe.67@bytedance.com>
To: <apopple@nvidia.com>
Cc: <akpm@linux-foundation.org>, <arnd@arndb.de>, <bp@alien8.de>, 
	<dave.hansen@linux.intel.com>, <david@kernel.org>, <kees@kernel.org>, 
	<linux-arch@vger.kernel.org>, <linux-hardening@vger.kernel.org>, 
	<linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>, 
	<lizhe.67@bytedance.com>, <mingo@redhat.com>, <rppt@kernel.org>, 
	<tglx@kernel.org>, <x86@kernel.org>
From: "Li Zhe" <lizhe.67@bytedance.com>
X-Original-From: Li Zhe <lizhe.67@bytedance.com>
X-Lms-Return-Path: <lba+26a4c9eef+4b62c2+vger.kernel.org+lizhe.67@bytedance.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
In-Reply-To: <akxtWBdz5XjoAAzF@nvdebian.thelocal>
X-Mailer: git-send-email 2.45.2
References: <akxtWBdz5XjoAAzF@nvdebian.thelocal>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset=UTF-8

On Tue, 7 Jul 2026 13:09:01 +1000, apopple@nvidia.com wrote:

> > -	for (pfn = head_pfn + 1; pfn < end_pfn; pfn++) {
> > +
> > +	pfn = head_pfn + 1;
> > +	/*
> > +	 * All tails of the same compound page share the state established by
> > +	 * prep_compound_tail(). Reuse one tail template for the whole range and
> > +	 * refresh only the PFN-dependent fields in that template before each copy.
> > +	 */
> > +	if (use_template) {
> >  		struct page *page = pfn_to_page(pfn);
> >
> > -		zone_device_page_init_slow(page, pfn, zone_idx, nid, pgmap);
> > -		prep_compound_tail(page, head, order);
> > -		set_page_count(page, 0);
> > +		zone_device_tail_page_init(page, pfn, zone_idx, nid,
> > +					   pgmap, head, order);
> > +		zone_device_template_page_init(&template, page);
> > +		pfn++;
> 
> Similar comment as the previous patch - I think it's clearer to just init the
> template page here as a separate step and not unroll the loop.

Thanks. I will rework memmap_init_compound() the same way in v6.

Thanks,
Zhe
