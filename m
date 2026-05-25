Received: from va-1-112.ptr.blmpb.com (va-1-112.ptr.blmpb.com [209.127.230.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71C562BCF4C
	for <linux-arch@vger.kernel.org>; Mon, 25 May 2026 03:52:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.127.230.112
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779681156; cv=none; b=AsU7GJmqRDdG8DSDlMCcuvStTaOD0t353GX9/+FiIiei7GK+1pclGo2ADVr0UrvHEd2ckHUZy3iUq71ErCdVfalFZkx2xP2kxC2kS7dQ/R/K/Ms/7qBj5VLl8DRrhvzlmPKSrDQb6B7wq6BXM+JXYIMNK+58GqJZZTAc09jJccQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779681156; c=relaxed/simple;
	bh=0L6cXt6KxqUB4aAto9wYdBc+y/ozISuH4IFCFXTqTgI=;
	h=In-Reply-To:Content-Type:Cc:From:Date:Mime-Version:References:To:
	 Subject:Message-Id; b=HvMh9ORy18V7aWQzTQlZVeZkeIGcSQgSKwCvroegVfWPV6KrjTGaTJynn+FcR6EKtZzcl78tli6dDL7ac21livls+fuYgjqojvmEwyWTCbi38S9DW/EeMJw+OhdbbkrWyFW6hhqzSE3cXpy2Za/x1TSnnLNeJTBvdqAstqbE3iU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=nspQdq1Y; arc=none smtp.client-ip=209.127.230.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="nspQdq1Y"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=2212171451; d=bytedance.com; t=1779681143; h=from:subject:
 mime-version:from:date:message-id:subject:to:cc:reply-to:content-type:
 mime-version:in-reply-to:message-id;
 bh=7aygqIY72kQ/p3Di74VnQFgR5TlEfhNpKIZCSQTE5Gk=;
 b=nspQdq1Yu7uGDRh0Yv5uwphZvaFKYQhj78LB5V776zUM6MPUlxNVWRKsjGnyifxwBrH420
 SwGHd8sC8Tsxom2cHuzhinwJcLO4jEpSLfDpoLsVt6BByN5J2Msv+HE1YF2hOwoh5SjESq
 ITqaQ3mqKIe3d5U2F+w0R7yHWrmj3k0pDo+oiueVMZ1o92PQCzNNA1uCT8WJz5bYwn5I5P
 +XBxM/+d1o6MhGU4uOWe9XT8ALif4V2R5HTwBEexuVDH9ivGuEgb3c+ShLkMedtZ4NVOxP
 GEvRTjj5S1Kb80ZAN2H2uBIaj0w7bJF5hek4i/DpL5rqUcJE/T+iIRLap+yCNg==
In-Reply-To: <177953825215.3959652.4404326127425239303.b4-review@b4>
Content-Type: text/plain; charset=UTF-8
Cc: <akpm@linux-foundation.org>, <apopple@nvidia.com>, <arnd@arndb.de>, 
	<bp@alien8.de>, <dave.hansen@linux.intel.com>, <david@kernel.org>, 
	<kees@kernel.org>, <linux-arch@vger.kernel.org>, 
	<linux-hardening@vger.kernel.org>, <linux-kernel@vger.kernel.org>, 
	<linux-mm@kvack.org>, <lizhe.67@bytedance.com>, <mingo@redhat.com>, 
	<tglx@kernel.org>, <x86@kernel.org>
From: "Li Zhe" <lizhe.67@bytedance.com>
Date: Mon, 25 May 2026 11:51:56 +0800
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.45.2
Content-Transfer-Encoding: 7bit
References: <177953825215.3959652.4404326127425239303.b4-review@b4>
X-Original-From: Li Zhe <lizhe.67@bytedance.com>
X-Lms-Return-Path: <lba+26a13c774+c7ebb9+vger.kernel.org+lizhe.67@bytedance.com>
To: <rppt@kernel.org>
Subject: Re: [PATCH v2 1/7] mm: factor zone-device page init helpers out of __init_zone_device_page
Message-Id: <20260525035156.94490-1-lizhe.67@bytedance.com>

On Sat, 23 May 2026 15:10:52 +0300, rppt@kernel.org wrote:

> On Thu, 21 May 2026 12:01:18 +0800, Li Zhe <lizhe.67@bytedance.com> wrote:
> > diff --git a/mm/mm_init.c b/mm/mm_init.c
> > index f9f8e1af921c..4ba506df93bc 100644
> > --- a/mm/mm_init.c
> > +++ b/mm/mm_init.c
> > @@ -987,11 +987,36 @@ static void __init memmap_init(void)
> >  }
> >
> >  #ifdef CONFIG_ZONE_DEVICE
> > -static void __ref __init_zone_device_page(struct page *page, unsigned long pfn,
> > +static inline int zone_device_page_init_refcount(
> > +		const struct dev_pagemap *pgmap)
> 
> The name zone_device_page_init_refcount() implies that this function
> actually intializes the refcount, but it's actually used as a predicate
> based on pagemap properties, so let's make it bool and name accordingly.
> How about
> 
> static inline bool pagemap_resets_refcount(const struct dev_pagemap *pagemap)
> 
> Other than that:
> 
> Reviewed-by: Mike Rapoport (Microsoft) <rppt@kernel.org>

Thanks, I will fix this in the next revision.

Thanks,
Zhe
