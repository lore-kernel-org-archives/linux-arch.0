Received: from va-1-112.ptr.blmpb.com (va-1-112.ptr.blmpb.com [209.127.230.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0E7B42254D
	for <linux-arch@vger.kernel.org>; Mon,  6 Jul 2026 11:52:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.127.230.112
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783338766; cv=none; b=FbuxFe5XvsRXAZ72NNyWY65kNkTsHIwIxFkQFBm5ylgABa3KLaQkWfdKPtusQH6BwHd/ht2I8kSCxgn5J34FTbqw5REPCPMjzNbtJ28MbdG5BC0EfRlhu6KnKy1X4BgIcPLc2mQk/1HMh5/71ltg8MOLCKtxx1kuErms1kUr1c0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783338766; c=relaxed/simple;
	bh=wR/71sJu3xf2oJc2FOUe8D2dMIeBtbmm5rhwEwaWCjA=;
	h=Cc:From:Message-Id:Mime-Version:In-Reply-To:Subject:References:
	 Content-Type:To:Date; b=jbPwJVGLT9JJcctfzSfyvnRA09vWDuqjUleldNSaMMLHum65NBVF45gqDRgCxRK0lveEa2/fM+hiqbcNWVM4ei1Trla8aHs6WMBmunhsAWuBz/IExtaCGMU6JsRp/zEpuCxUJOxrgxNZfeNG1Vu5xNPhyPt2D6EOAL1KxgzaEHI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=YgiY7HQh; arc=none smtp.client-ip=209.127.230.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="YgiY7HQh"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=2212171451; d=bytedance.com; t=1783338756; h=from:subject:
 mime-version:from:date:message-id:subject:to:cc:reply-to:content-type:
 mime-version:in-reply-to:message-id;
 bh=Eb4EE4GhIYXgk8IjcNOVvoBYVaWKohpIJ2vUwL57vFo=;
 b=YgiY7HQhlS2dA1kXAEeGIlvzVmf8gYfodAtIORcvHREvjp9tLVT3e9Npt+BzgiCufjFgWU
 8tHCH907rtgXLJu7W+k10ZBelYU+Eq/Qsfq0QsESsRuUXoZ6kCY/BW7bx6WyzQYrpCjzdl
 3C1IraBfcvsPSSURnpfAcBhJ4zfZu0UQ9SSz9xOTdo/gLGuVMwhpzeUJWQKLPI/8UkkfEo
 xFnLhCk0rtCrWxZNqAuu5AySZqKQ5u5ZUfwP20qhU1OEDW8G7/YU8oY2bq/EJFNJ26BwY/
 KKEkMBX9wKyxv5uN/9qFiT2LGPyYCPzg5Q7HnPn3QP3ZZzV5WYn3X30zqFHFbw==
Cc: <akpm@linux-foundation.org>, <apopple@nvidia.com>, <arnd@arndb.de>, 
	<bp@alien8.de>, <dave.hansen@linux.intel.com>, <kees@kernel.org>, 
	<linux-arch@vger.kernel.org>, <linux-hardening@vger.kernel.org>, 
	<linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>, 
	<lizhe.67@bytedance.com>, <mingo@redhat.com>, <rppt@kernel.org>, 
	<tglx@kernel.org>, <x86@kernel.org>
From: "Li Zhe" <lizhe.67@bytedance.com>
Message-Id: <20260706115213.50375-1-lizhe.67@bytedance.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
In-Reply-To: <8a6f0bc0-5b6d-406d-9d2c-d3861b5c31b5@kernel.org>
Subject: Re: [PATCH v5 3/8] mm: add a set_page_section_from_pfn() helper
X-Original-From: Li Zhe <lizhe.67@bytedance.com>
X-Lms-Return-Path: <lba+26a4b9702+cca2df+vger.kernel.org+lizhe.67@bytedance.com>
X-Mailer: git-send-email 2.45.2
References: <8a6f0bc0-5b6d-406d-9d2c-d3861b5c31b5@kernel.org>
Content-Type: text/plain; charset=UTF-8
To: <david@kernel.org>
Date: Mon,  6 Jul 2026 19:52:13 +0800
Content-Transfer-Encoding: 7bit

On Mon, Jul 6, 2026 at 11:15:36AM +0200, david@kernel.org wrote:

> > diff --git a/include/linux/mm.h b/include/linux/mm.h
> > index 485df9c2dbdd..f78afa63dd3d 100644
> > --- a/include/linux/mm.h
> > +++ b/include/linux/mm.h
> > @@ -2541,11 +2541,26 @@ static inline void set_page_section(struct page *page, unsigned long section)
> >  	page->flags.f |= (section & SECTIONS_MASK) << SECTIONS_PGSHIFT;
> >  }
> >  
> > +static inline void set_page_section_from_pfn(struct page *page,
> > +					     unsigned long pfn)
> 
> Two tab indent.

Thanks, I will fix the indentation in v6.

> > +{
> > +	set_page_section(page, pfn_to_section_nr(pfn));
> > +}
> > +
> >  static inline unsigned long memdesc_section(memdesc_flags_t mdf)
> >  {
> >  	return (mdf.f >> SECTIONS_PGSHIFT) & SECTIONS_MASK;
> >  }
> >  #else /* !SECTION_IN_PAGE_FLAGS */
> > +static inline void set_page_section(struct page *page, unsigned long section)
> > +{
> > +}
> 
> Why do we need this?

The empty set_page_section() helper is not needed. I will drop it in
v6.

> > +
> > +static inline void set_page_section_from_pfn(struct page *page,
> > +					     unsigned long pfn)
> > +{
> > +}
> 
> Dito.

The no-op set_page_section_from_pfn() helper is still needed for
!SECTION_IN_PAGE_FLAGS so callers can use a single helper without
open-coding #ifdef SECTION_IN_PAGE_FLAGS at each callsite.

Thanks,
Zhe
