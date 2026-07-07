Received: from va-1-113.ptr.blmpb.com (va-1-113.ptr.blmpb.com [209.127.230.113])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 441C33A1686
	for <linux-arch@vger.kernel.org>; Tue,  7 Jul 2026 06:33:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.127.230.113
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783406015; cv=none; b=Y9osjG8y7Rqy9cR4lT01f5d8CGvQaB6yOWlnsLQ3ZtA4Zu7Zo4wEkK8qHseA6eGNnZzJPPCMrdcTxcAn0TG3Y6wi+8V5mI2aeGb+jj9x/TMX+KJ5q/aImk2V7/0p5zeUls0cZ+oyX1an1kugwv5lyCCvFHRGwKNf2kbWWOYZ35I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783406015; c=relaxed/simple;
	bh=qdGq9cjccATif0JJIIBAfgQrxK/PwGkyMySGWSNRKnk=;
	h=References:From:Content-Type:To:Cc:Subject:Message-Id:
	 Mime-Version:Date:In-Reply-To; b=pHbfgrWvy9VuGAn0IKr4XuB1+oFl1YfDh6HJTu8Mrx6zzzyUtVcJcEWXN+AsL3blAMjup1Xkmvel4ee+IcUu2UOJy4if6nKNItqYKhS3DrayRPtHPTfQ85LjgBLl8+libcL36p8/WaZIgVjHEWkMW3o6NAyjLntZS7oMXPaBYMs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=ididrPHL; arc=none smtp.client-ip=209.127.230.113
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="ididrPHL"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=2212171451; d=bytedance.com; t=1783406008; h=from:subject:
 mime-version:from:date:message-id:subject:to:cc:reply-to:content-type:
 mime-version:in-reply-to:message-id;
 bh=VlXNw2eBmsyA44qk9Kj+8iT7ILOluejS36YD0QBD00c=;
 b=ididrPHLfWDNNw0dAG1lSDQtTTT8WN/9ysUqOLgeS+2bf5x865xRpy7O0mfvl1wvLSQLqg
 w1i6mbVlmQnTattfJiGcMxUMCKe+nzB6uBIdQKPEbA5srpcLyAEQtD6eFHUKFEbHeXZKUV
 7u3LmUdIM3ElD9mGDI1IbJyHgMEjaT9Z9zwIUGG4SVlX8mlvTO0YwXGO3KvHTOVkgWJS8S
 9Y0Y4Xmk6i4mWZ9/+1gGrGR+HMbSNEMOkltUXGbHjZK3T5nk8+ob5Pr6fMTrUb/aOxgMhK
 68YpUqjD4SVo8tCguJha3bFfHlzpzr/FsLmcJX9L+NE4hvZeJNje7hb+NWN0kA==
References: <akxpS3WOP7oUBNKF@nvdebian.thelocal>
X-Mailer: git-send-email 2.45.2
From: "Li Zhe" <lizhe.67@bytedance.com>
X-Lms-Return-Path: <lba+26a4c9db6+53c83b+vger.kernel.org+lizhe.67@bytedance.com>
Content-Transfer-Encoding: 7bit
X-Original-From: Li Zhe <lizhe.67@bytedance.com>
Content-Type: text/plain; charset=UTF-8
To: <apopple@nvidia.com>
Cc: <akpm@linux-foundation.org>, <arnd@arndb.de>, <bp@alien8.de>, 
	<dave.hansen@linux.intel.com>, <david@kernel.org>, <kees@kernel.org>, 
	<linux-arch@vger.kernel.org>, <linux-hardening@vger.kernel.org>, 
	<linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>, 
	<lizhe.67@bytedance.com>, <mingo@redhat.com>, <rppt@kernel.org>, 
	<tglx@kernel.org>, <x86@kernel.org>
Subject: Re: [PATCH v5 4/8] mm: add a template-based fast path for zone-device page init
Message-Id: <20260707063303.40128-1-lizhe.67@bytedance.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Date: Tue,  7 Jul 2026 14:33:03 +0800
In-Reply-To: <akxpS3WOP7oUBNKF@nvdebian.thelocal>

On Tue, 7 Jul 2026 13:02:52 +1000, apopple@nvidia.com wrote:
> > +static inline bool zone_device_page_init_optimization_enabled(void)
> > +{
> > +	/*
> > +	 * The template fast path copies a preinitialized struct page image.
> > +	 * Skip it when the page_ref_set tracepoint is enabled.
> > +	 */
> > +	return !page_ref_tracepoint_active(page_ref_set);
> > +}
> > +
> > +static inline void zone_device_template_page_init(struct page *template,
> > +						  struct page *src)
> > +{
> > +	memcpy(template, src, sizeof(*template));
> 
> I'd drop this function and just open-code the memcpy as I think that ends up
> being clearer and removes a naming confusion - I kept mixing up the purpose of
> `zone_device_template_page_init` and `zone_device_page_init_from_template`

Agreed. I will drop zone_device_template_page_init() and open-code
that memcpy() in v6.

> > -	for (pfn = start_pfn; pfn < end_pfn; pfn += pfns_per_compound) {
> > -		struct page *page = pfn_to_page(pfn);
> > +
> > +	if (!nr_pages)
> > +		return;
> > +
> > +	pfn = start_pfn;
> > +	/*
> > +	 * Seed the reusable head-page template from the first real struct
> > +	 * page, because the existing page-init and pageblock helpers expect
> > +	 * a real memmap entry rather than a stack object.
> > +	 */
> > +	if (use_template) {
> > +		struct page *page = pfn_to_page(start_pfn);
> >
> >  		zone_device_page_init_slow(page, pfn, zone_idx, nid, pgmap);
> > +		zone_device_template_page_init(&template, page);
> > +		if (pfns_per_compound != 1)
> > +			memmap_init_compound(page, pfn, zone_idx, nid, pgmap,
> > +				compound_nr_pages(start_pfn, altmap, pgmap));
> > +		pfn += pfns_per_compound;
> 
> I think it would be clearer and less error prone to not unroll the loop here.
> Instead just initialise the template page and leave the for loop starting at
> pfn = start_pfn and let it handle the rest of the steps. I can't imagine the
> extra call to zone_deivce_page_init_from_template() would cause a noticable
> perf impact.
> 
> It also avoids the obvious danger of someone updating the loop but missing the
> unrolled version above.

Thanks. I will keep the initial slow-path template seeding as a
separate step, still using the first real memmap entry for that, but
let the main loop start at start_pfn again so the first PFN goes
through the same loop body as the rest. That should make the code
clearer and avoid the duplicated first-iteration path drifting from
the main loop in later changes.

Thanks,
Zhe
