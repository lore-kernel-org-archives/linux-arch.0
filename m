Received: from va-1-114.ptr.blmpb.com (va-1-114.ptr.blmpb.com [209.127.230.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEE3A2727F3
	for <linux-arch@vger.kernel.org>; Thu,  3 Sep 2026 02:58:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.127.230.114
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788404325; cv=none; b=ZNxrYXNtree+aaaDdvH9G1L8C5IFdFC+mIQNup5g2xduUkYPrE2JfgwuxvlmFUTuqVsaAlYIjkhCm45JhEXLOdyerCINQlTmpbDB/k5dSiJWESeXmLdFpn/FXGpeA2jw27riJV+lzNumaiEhrT5gA54gEm8QLRAIFiYtDFD7CwM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788404325; c=relaxed/simple;
	bh=9X84J6Ue1h5bFLffaiUIrYJVatUia20jqN+GHbInAjE=;
	h=To:References:Content-Type:Cc:Message-Id:Mime-Version:In-Reply-To:
	 From:Subject:Date; b=AGNGSNmPElHWY23Fy75fQc513xaeUPD7OFWU9jiVITKNGfqTFPPlqLVyfbd6GECx98yV9U3D8Hggfr5kPMXjWyS6aOupAxztkWM6FEJhtFNBQt2KF2E6W3NkWeoeUzowo0rDOLVxovsM4z3d6A6TMAbnjByhin1Xnl1lE2CsQ2Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=IFFgYTGw; arc=none smtp.client-ip=209.127.230.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="IFFgYTGw"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=2212171451; d=bytedance.com; t=1788404312; h=from:subject:
 mime-version:from:date:message-id:subject:to:cc:reply-to:content-type:
 mime-version:in-reply-to:message-id;
 bh=3XGVvSOTCEh6IL41/waks8FQqdiqvKYj9ft+LeKmDH0=;
 b=IFFgYTGw5DYv/kcaykFZ8cfkcZ3MA4nRQi+7W2wfmS3xIX1EPmMTc+van106O0uN7AL60Z
 6Og310N6vMdxR9Ik/euR5Xvph6qSJjBKA513TgW8S3ks/zBlBNFQZ9OI9fPyIlNiU8hb5J
 2TeqD5bDIogY8uK2RvSpYxYZj/2WfQuSc1XZQwZHuOheg4dI6QjFJ1vfs4Ad8HMvJm91ad
 tnm+2iFX5JWA2tj/2h27NZjBurCiwDUltq9Q6sWmEdFyQBY2ReczeTkjdFYJsE5S1DTH0t
 rQdAz8ETV2qd9z6TEPS8mrV6/gM88OPFjqqI9R+XMczmKJcg5VvlQeLex3HQCg==
To: <rppt@kernel.org>, <akpm@linux-foundation.org>
X-Original-From: Li Zhe <lizhe.67@bytedance.com>
References: <apejDEdW95T-tekb@kernel.org>
Content-Type: text/plain; charset=UTF-8
Cc: <apopple@nvidia.com>, <arnd@arndb.de>, <balbirs@nvidia.com>, 
	<bp@alien8.de>, <dave.hansen@linux.intel.com>, <david@kernel.org>, 
	<kees@kernel.org>, <linux-arch@vger.kernel.org>, 
	<linux-hardening@vger.kernel.org>, <linux-kernel@vger.kernel.org>, 
	<linux-mm@kvack.org>, <lizhe.67@bytedance.com>, <mingo@redhat.com>, 
	<muchun.song@linux.dev>, <tglx@kernel.org>, <x86@kernel.org>
X-Mailer: git-send-email 2.45.2
X-Lms-Return-Path: <lba+26a98e256+e995c3+vger.kernel.org+lizhe.67@bytedance.com>
Message-Id: <20260903025806.70825-1-lizhe.67@bytedance.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
In-Reply-To: <apejDEdW95T-tekb@kernel.org>
From: "Li Zhe" <lizhe.67@bytedance.com>
Subject: Re: [PATCH v11 3/7] mm: add a template-based fast path for zone-device page init
Date: Thu,  3 Sep 2026 10:58:06 +0800

On Wed, 2 Sep 2026 07:16:12 +0300, <rppt@kernel.org> wrote:

> > +	/* Initialize the remaining head pages from template. */
> > +	for (; pfn < end_pfn; pfn += pfns_per_compound) {
> > +		page = pfn_to_page(pfn);
> > +
> > +		zone_device_page_init_from_template(page, pfn,
> > +						    &template);
> 
> Nit: this seems to fit into 80-chars line without wrapping.

Hi Mike,

Thanks for the review. Yes, this fits on one line.

Hi Andrew, could you please squash the following fixup into patch 3?

---
diff --git a/mm/mm_init.c b/mm/mm_init.c
index ba4148de2b28..84fe53633e44 100644
--- a/mm/mm_init.c
+++ b/mm/mm_init.c
@@ -1127,8 +1127,7 @@ void __ref memmap_init_zone_device(struct zone *zone,
 	for (; pfn < end_pfn; pfn += pfns_per_compound) {
 		page = pfn_to_page(pfn);
 
-		zone_device_page_init_from_template(page, pfn,
-						    &template);
+		zone_device_page_init_from_template(page, pfn, &template);
 
 		if (IS_ALIGNED(pfn, PAGES_PER_SECTION))
 			cond_resched();
---

Thanks,
Zhe
