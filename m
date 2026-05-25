Received: from va-1-114.ptr.blmpb.com (va-1-114.ptr.blmpb.com [209.127.230.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F37B35B21A
	for <linux-arch@vger.kernel.org>; Mon, 25 May 2026 04:02:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.127.230.114
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779681761; cv=none; b=iPJtOd2uvhNWqMh338EUy4ilw5wg/qVGxghvTLOYWddG0vGJlIex+S0SlpHq5O4fl+ntsbS2oYu6pE7tbybXJRHdO0YfkIt5DzgLMfasd/3G8EDZX8cDKL6dyFHua1KVtPTxWS47Ta+Rfto4n5xmB3B2oVHILMaoHALe2tEuCjY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779681761; c=relaxed/simple;
	bh=c2jodT9SGzn13wdz37eKaE0OenWvwNYICdTOtnxkppE=;
	h=Subject:Cc:Message-Id:Content-Type:Date:In-Reply-To:From:
	 Mime-Version:References:To; b=RN/gvHzqkGVHav2EH0QgoL0zM2p74mIXNHARA/2uQemX1XZJlwYNdyixGPnXHAgU0F5AUFUjcqP/yZkfgER3uOfV84TfYL/wdO3/6oesiWMMydo6NwjjV2ePyBmloGU81ca8FjAVaj/tmCtQtA7gxOoX+giDhRkn9Ys5HpeybV4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=AWYPrHGQ; arc=none smtp.client-ip=209.127.230.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="AWYPrHGQ"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=2212171451; d=bytedance.com; t=1779681749; h=from:subject:
 mime-version:from:date:message-id:subject:to:cc:reply-to:content-type:
 mime-version:in-reply-to:message-id;
 bh=ef4XEinfeY7PdsQMAtEr1Lcv0NaIMIY9uuCtzsvnryU=;
 b=AWYPrHGQ1oQubyOFZc4H/KZBIioSGJcqh/XPhcUlkmtuwfvll4Op+i23L4SaajcZbCqZyL
 5/HtYQWMbznwFNneZP5qFKliuLxerHYCbZzroZ0zdEfDidvHvwbep67XAiuno6wWRXMp9Q
 7HD33VdEAmmoi1rzIAhW9HcdwBR6IrreWytA8sW3yhCe9xtdaUI6gBm7HFToTbhxCpyHBZ
 p5xoHgObFeFngrmgrprbaznrpsFhmgwrB4ublLm3azFBz1jk4UzecPV2ZosPUP1V8guji8
 gLZeYuQg54kn7coM7zO0K1XekkLK2jg5J+i3yYxQUcl78JaYStZZJJ4jvsyV9g==
Subject: Re: [PATCH v2 3/7] mm: add a template-based fast path for zone-device page init
Cc: <akpm@linux-foundation.org>, <apopple@nvidia.com>, <arnd@arndb.de>, 
	<bp@alien8.de>, <dave.hansen@linux.intel.com>, <david@kernel.org>, 
	<kees@kernel.org>, <linux-arch@vger.kernel.org>, 
	<linux-hardening@vger.kernel.org>, <linux-kernel@vger.kernel.org>, 
	<linux-mm@kvack.org>, <lizhe.67@bytedance.com>, <mingo@redhat.com>, 
	<tglx@kernel.org>, <x86@kernel.org>
Message-Id: <20260525040206.96739-1-lizhe.67@bytedance.com>
X-Lms-Return-Path: <lba+26a13c9d3+e43670+vger.kernel.org+lizhe.67@bytedance.com>
Content-Type: text/plain; charset=UTF-8
Date: Mon, 25 May 2026 12:02:06 +0800
X-Mailer: git-send-email 2.45.2
In-Reply-To: <177953825218.3959652.8194606082469375738.b4-review@b4>
From: "Li Zhe" <lizhe.67@bytedance.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
References: <177953825218.3959652.8194606082469375738.b4-review@b4>
X-Original-From: Li Zhe <lizhe.67@bytedance.com>
To: <rppt@kernel.org>

On Sat, 23 May 2026 15:10:52 +0300, rppt@kernel.org wrote:

> On Thu, 21 May 2026 12:01:20 +0800, Li Zhe <lizhe.67@bytedance.com> wrote:
> > diff --git a/mm/mm_init.c b/mm/mm_init.c
> > index 4ba506df93bc..2992711351a0 100644
> > --- a/mm/mm_init.c
> > +++ b/mm/mm_init.c
> > @@ -1066,6 +1066,63 @@ static void __ref zone_device_page_init_slow(struct page *page,
> > [ ... skip 33 lines ... ]
> > + * The copied template already provides the PFN-invariant portion of a
> > + * ZONE_DEVICE struct page. Fix up the fields that still depend on @pfn
> > + * after the copy, namely the section bits and page->virtual when present.
> > + */
> > +static inline void zone_device_page_init_finish(struct page *page,
> > +							unsigned long pfn)
> 
> Please align the indentation for the second parameters line like int
> zone_device_template_page_init() or use two tabs for indentation
> everywhere.

Thanks for the review. I will adjust the indentation to use two tabs
for the second parameter line in the next revision.

Thanks,
Zhe
