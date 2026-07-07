Received: from va-2-111.ptr.blmpb.com (va-2-111.ptr.blmpb.com [209.127.231.111])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0367D35292A
	for <linux-arch@vger.kernel.org>; Tue,  7 Jul 2026 03:26:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.127.231.111
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783394810; cv=none; b=FljwwT3ZVGvauhtcDd53cKXAnR7fd4xESaprep7ZQFFZYkEA9G8KnlqrnHF0McIjdi8jTKIMzcRHEZQGdsX4tAa+WL+8QbLA9ATN5ueWv7RXf50hf2JSR88/VpgFx5F2MxB2AQKdk0xhVFGk/2IULcMopxZ3bcnHMG86qFvwgkc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783394810; c=relaxed/simple;
	bh=rZcy/OjLivVNRwhgZh1B5yn7/oH+AoU4M2LXl7X/KoA=;
	h=To:Date:From:Subject:Message-Id:Mime-Version:In-Reply-To:Cc:
	 Content-Type:References; b=k9DoqlLfUwApLm8TOFeL0MGLJ/2qYLOoJscMR6sJcORgxO3CNPUSWwDnLaVwK0W3Bvg4iU6I9kXiujt9U6eDyGedclhWHlxBFO16zkuQ4Vg/MpsD9XqPban0CJhGPj0u5JSmXFxYx+W6sQc2ZUO1mn1MiQy+17afyMQLLjLqjBY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=ICbc6Yzf; arc=none smtp.client-ip=209.127.231.111
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="ICbc6Yzf"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=2212171451; d=bytedance.com; t=1783394803; h=from:subject:
 mime-version:from:date:message-id:subject:to:cc:reply-to:content-type:
 mime-version:in-reply-to:message-id;
 bh=SlatkrEAWoB+y6LZ393h4sLUiuJx4jpAjzGhZ6jaKUI=;
 b=ICbc6YzfZzXq36v7jd/D4NQthSnyK7c+sifrvuwWVOaHNe1Vb2UzuvUUvn1FjN0OnGWZJi
 yA0W9+RKMjh7CIvSLIjt+1UkQZhf8jDa5qbS98cfl1Cw1MI5N5qN/wKlXAOvQCiCU8w90H
 okYyMkXS1WF0435sxrIU090ExeNzKHaMr5r7uWC/SvKq0/Up+k5sgoSLRM2iHfFbo13Kz1
 r3ufno4vTEwtvwicVMQiHIOIoxx1Ppg5wbgY0HqA6YLrhZwKELOoIWhUpFdMsp3Mn9myg0
 4oi9v/y32UgzwAToqjRksPNYIJaONd+BZRarP0/hz0anCJkd4J6L8c7ABlo+KA==
To: <david@kernel.org>
Date: Tue,  7 Jul 2026 11:26:20 +0800
X-Lms-Return-Path: <lba+26a4c71f1+bbe082+vger.kernel.org+lizhe.67@bytedance.com>
From: "Li Zhe" <lizhe.67@bytedance.com>
Subject: Re: [PATCH v5 3/8] mm: add a set_page_section_from_pfn() helper
Message-Id: <20260707032620.22595-1-lizhe.67@bytedance.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
In-Reply-To: <efd55e0c-8caf-4633-b876-18e8e788493a@kernel.org>
Content-Transfer-Encoding: 7bit
Cc: <akpm@linux-foundation.org>, <apopple@nvidia.com>, <arnd@arndb.de>, 
	<bp@alien8.de>, <dave.hansen@linux.intel.com>, <kees@kernel.org>, 
	<linux-arch@vger.kernel.org>, <linux-hardening@vger.kernel.org>, 
	<linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>, 
	<lizhe.67@bytedance.com>, <mingo@redhat.com>, <rppt@kernel.org>, 
	<tglx@kernel.org>, <x86@kernel.org>
X-Mailer: git-send-email 2.45.2
Content-Type: text/plain; charset=UTF-8
X-Original-From: Li Zhe <lizhe.67@bytedance.com>
References: <efd55e0c-8caf-4633-b876-18e8e788493a@kernel.org>

On Mon, 6 Jul 2026 15:48:16 +0200, david@kernel.org wrote:

> >>> +static inline void set_page_section_from_pfn(struct page *page,
> >>> +					     unsigned long pfn)
> >>> +{
> >>> +}
> >>
> >> Dito.
> >
> > The no-op set_page_section_from_pfn() helper is still needed for
> > !SECTION_IN_PAGE_FLAGS so callers can use a single helper without
> > open-coding #ifdef SECTION_IN_PAGE_FLAGS at each callsite.
> 
> Sorry, I meant two-tab indent :) Why we need that was clear to me.

Thanks for clarifying. I will fix the indentation in v6.

Thanks,
Zhe
