Received: from va-1-113.ptr.blmpb.com (va-1-113.ptr.blmpb.com [209.127.230.113])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFAAF7E0E8
	for <linux-arch@vger.kernel.org>; Mon, 25 May 2026 04:59:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.127.230.113
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779685202; cv=none; b=kUQxQloiyJ8U4K5s7p8faB2gR0rZ78P+H4Y+r8uFx+0CP3KwEJ7C8lIqrxpPupiLOwc6eu67U39yJqVVROfUx/Fi6TBWK5HsTssBTPWTZUereJTYbmAhi26BNK4nQlD1pmxFri94AppmTVfqi6efjhbLIOmVa74URH3BYqI+2tE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779685202; c=relaxed/simple;
	bh=Y/KRuWmr52QZra+zuzKwy1pl8FQJn4MBJDAFpv31GDU=;
	h=From:Date:Message-Id:Subject:In-Reply-To:Content-Type:To:Cc:
	 Mime-Version:References; b=AJYsYFVwvivMT4sROS06YdByev86esmFsRIwH2KYVt6S6d8IcAoacprGkL8fTOufXSftxwXLQr1Ufryazp9dFhLNiV5L8kixhz5zBgfZW/m7wCVWR/tHsk6aCMwwRA74YzQ9wDVyfZnO8bDxaGSL/A5uhw+hoSqdEH324OZMCug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=qsQl+1KM; arc=none smtp.client-ip=209.127.230.113
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="qsQl+1KM"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=2212171451; d=bytedance.com; t=1779685195; h=from:subject:
 mime-version:from:date:message-id:subject:to:cc:reply-to:content-type:
 mime-version:in-reply-to:message-id;
 bh=hf73DpoVazSmVVzicHvdltR9UMe1NtyFFuAe3Bn9cLc=;
 b=qsQl+1KMJoCKvoHgULNd0FPNSyCPVLALfCroyoEjf3bovCC0wKiZSeRmk/992w91QKHQRV
 B4VjUA7V9qzwwQsziDbF+IUxmXCTAXSyEKSfe87g4YeXQ3qOrzQLYKMZ9TWsuLU/6tXhmx
 LPZlvAlSbv3V1C3h5ZWsMBfn40fYUgZP/Bg8vQ0tLal+t3MSBvMGQwoeKH2cm47qhuzUr3
 glf36gzQoswA5E/WcNOb3QuKRYdhT9jpSMVZsyp6ND3DaxXAG0qemgCyqF5U7jed9daE/y
 oP3KhC2ffg7lb6g7PrpvBbNSAEjzMGTkqiwVQt1mMlqMXmHX8V6pHnvhVmjL1w==
From: "Li Zhe" <lizhe.67@bytedance.com>
Date: Mon, 25 May 2026 12:59:31 +0800
Message-Id: <20260525045931.2136-1-lizhe.67@bytedance.com>
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v2 7/7] mm: use memcpy_streaming() in zone-device template copies
In-Reply-To: <177953825222.3959652.3741865801916579097.b4-review@b4>
X-Mailer: git-send-email 2.45.2
X-Original-From: Li Zhe <lizhe.67@bytedance.com>
Content-Type: text/plain; charset=UTF-8
To: <rppt@kernel.org>
Cc: <akpm@linux-foundation.org>, <apopple@nvidia.com>, <arnd@arndb.de>, 
	<bp@alien8.de>, <dave.hansen@linux.intel.com>, <david@kernel.org>, 
	<kees@kernel.org>, <linux-arch@vger.kernel.org>, 
	<linux-hardening@vger.kernel.org>, <linux-kernel@vger.kernel.org>, 
	<linux-mm@kvack.org>, <lizhe.67@bytedance.com>, <mingo@redhat.com>, 
	<tglx@kernel.org>, <x86@kernel.org>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <177953825222.3959652.3741865801916579097.b4-review@b4>
X-Lms-Return-Path: <lba+26a13d749+bafd18+vger.kernel.org+lizhe.67@bytedance.com>

On Sat, 23 May 2026 15:10:52 +0300, rppt@kernel.org wrote:

> On Thu, 21 May 2026 12:01:24 +0800, Li Zhe <lizhe.67@bytedance.com> wrote:
> > diff --git a/mm/mm_init.c b/mm/mm_init.c
> > index 17a84d4cda01..08feb24795b8 100644
> > --- a/mm/mm_init.c
> > +++ b/mm/mm_init.c
> > @@ -1075,13 +1075,15 @@ static void __ref zone_device_page_init_slow(struct page *page,
> > [ ... skip 12 lines ... ]
> >  	 */
> > -	return !page_ref_tracepoint_active(page_ref_set) &&
> > -		IS_ALIGNED(sizeof(struct page), sizeof(u64));
> > +	return !IS_ENABLED(CONFIG_KASAN) && !IS_ENABLED(CONFIG_KMSAN) &&
> > +	       !page_ref_tracepoint_active(page_ref_set) &&
> > +	       IS_ALIGNED(sizeof(struct page), sizeof(u64));
> 
> Oh, can we rewrite it as a sequence of
> 
> 	if (cond)
> 		return false;
> 	...
> 
> 	return true;
> 
> I believe the compilers would generate the same code.

Thanks for the review. I will fix this in the next revision.

> > @@ -1104,30 +1106,42 @@ static inline void zone_device_template_tail_page_init(struct page *template,
> > [ ... skip 10 lines ... ]
> > + * copying it into @page.
> >   */
> > -static inline void zone_device_page_init_finish(struct page *page,
> > -							unsigned long pfn)
> > +static inline void zone_device_page_update_template(struct page *template,
> > +						    unsigned long pfn)
> 
> Two tabs for indentation here from the first patch this function
> appears please.

Thanks for the review. I will fix this in the next revision.

> Why do we need the intermediate step of _init_finish() if we later
> change it to _update_template()?

Instead of introducing an intermediate _init_finish() and renaming it
later, I will simply use zone_device_page_update_template() directly
from the beginning in the patch series.

> > [ ... skip 30 lines ... ]
> > +		memcpy(page, template, sizeof(*page));
> > +	else
> > +		memcpy_streaming(page, template, sizeof(*page));
> >
> > -	for (i = 0; i < sizeof(struct page) / sizeof(u64); i++)
> > -		dst[i] = src[i];
> 
> If you replace this with memcpy, what's the point for doing the loop in
> intermediate patches?

Thanks for the review. I will fix this in the next revision.

Thanks,
Zhe
