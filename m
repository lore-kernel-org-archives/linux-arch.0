Received: from va-1-113.ptr.blmpb.com (va-1-113.ptr.blmpb.com [209.127.230.113])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 601CB4218AE
	for <linux-arch@vger.kernel.org>; Mon,  6 Jul 2026 11:51:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.127.230.113
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783338688; cv=none; b=Gl6VgfSFa1Pg+DBckQaJwaXnjANZ7XMyTmO0PEJ1SEYTYSpG9hHKmhB5u1bDXjIdoDCvrlSnC0o9DVsPe1DyFw9KBoYdWGpMPxhfbNAfV9RVbrTCkTnawGBH2YqSffIfCmY3uP938SAG9osHxzz2uSXqNQWejC+/DQ0plVba+9Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783338688; c=relaxed/simple;
	bh=fThLz2Zppuo/oG86sO8UHYPk8V8CTeqAvOAvi136srw=;
	h=Mime-Version:To:From:References:Cc:In-Reply-To:Message-Id:
	 Content-Type:Subject:Date; b=OLMvtP8Z3A24IS/dlIRCET/+Oyha68/hVCSBZGrtYqWSy4JOid8FzapPefZzlaHWYj2KBwQh/jOTXCM+Y8I2hxGsgDHSliDmLOAOO/pORyjTp/xX6h4DhsH09zWTaicc5MMwxQfuz471rjlFoUlq2cZskQYKBgsJO8yoAQuvHoU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=kpbD9rWW; arc=none smtp.client-ip=209.127.230.113
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="kpbD9rWW"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=2212171451; d=bytedance.com; t=1783338679; h=from:subject:
 mime-version:from:date:message-id:subject:to:cc:reply-to:content-type:
 mime-version:in-reply-to:message-id;
 bh=6OBy2qV7OhxuEEHQ84IFkBzFni9vtbgA+AFFdLduRZk=;
 b=kpbD9rWWzHm2q6czx3/0OGbHfXN0YGr1WOkyFcfpK2lJv6PDcxUOGj0P9t28rRPSlvlYqo
 9WWeNVlmAA+Mz941xj7ukjYfdJzlRk4oadYU81l5CWZxBtIx9NpT3qPmguXrdpG/+XniLb
 zcuXvMiSjsT1mLnfmTbVHVlCGRig94nBrDByMXRdoyZN8Hj80hhIgr4BpcjmoAYN1CEZVs
 Be2ZHE0IX4L2+04gduQFtCSM/4YRWjqTHvngREsQAbK9eDJaTGVkmpvobf0e5h9Bx3JjS4
 Qqp6t1NPiCRzRu5OYA57wXwkY8spZ8rXQhB0QolYWDtmLsGjMQzu9E+PKlBrfA==
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Lms-Return-Path: <lba+26a4b96b6+98f3f5+vger.kernel.org+lizhe.67@bytedance.com>
To: <david@kernel.org>
From: "Li Zhe" <lizhe.67@bytedance.com>
References: <38919e81-4c35-4e8b-ba2a-8af8be60b0b6@kernel.org>
X-Mailer: git-send-email 2.45.2
Cc: <akpm@linux-foundation.org>, <apopple@nvidia.com>, <arnd@arndb.de>, 
	<bp@alien8.de>, <dave.hansen@linux.intel.com>, <kees@kernel.org>, 
	<linux-arch@vger.kernel.org>, <linux-hardening@vger.kernel.org>, 
	<linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>, 
	<lizhe.67@bytedance.com>, <mingo@redhat.com>, <rppt@kernel.org>, 
	<tglx@kernel.org>, <x86@kernel.org>
In-Reply-To: <38919e81-4c35-4e8b-ba2a-8af8be60b0b6@kernel.org>
X-Original-From: Li Zhe <lizhe.67@bytedance.com>
Message-Id: <20260706115035.49813-1-lizhe.67@bytedance.com>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset=UTF-8
Subject: Re: [PATCH v5 2/8] mm: factor zone-device page init helpers out of __init_zone_device_page
Date: Mon,  6 Jul 2026 19:50:35 +0800

On Mon, Jul 6, 2026 at 11:13:45AM +0200, david@kernel.org wrote:

> > +static inline bool pagemap_resets_refcount(const struct dev_pagemap *pgmap)
> > +{
> > +	/*
> > +	 * MEMORY_DEVICE_GENERIC pages regain a refcount of 1 in the free
> > +	 * path. The remaining ZONE_DEVICE types start from 0 here and raise
> > +	 * the count again when the allocator or driver hands the page out.
> > +	 */
> > +	switch (pgmap->type) {
> > +	case MEMORY_DEVICE_FS_DAX:
> > +	case MEMORY_DEVICE_PRIVATE:
> > +	case MEMORY_DEVICE_COHERENT:
> > +	case MEMORY_DEVICE_PCI_P2PDMA:
> > +		return false;
> > +	case MEMORY_DEVICE_GENERIC:
> > +		return true;
> > +	default:
> > +		WARN_ONCE(1, "Unknown memory type!");
> > +		return true;
> 
> Wouldn't the compiler warn if we would define a new type but forgot to update it
> here? We're using an enum, and I thought the compiler would bail out in that case.
> 
> Or are we scared of some other garbage ending up in there?
> 
> Apart from that LGTM.

Thanks.

I will drop the default case in v6 so a newly added enum memory_type
value is easier to catch during build review.

I will move the WARN_ONCE() after the switch so we still keep a
runtime guard in case some invalid value ever shows up there.

Thanks,
Zhe
