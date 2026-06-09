Received: from va-1-112.ptr.blmpb.com (va-1-112.ptr.blmpb.com [209.127.230.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E013740861A
	for <linux-arch@vger.kernel.org>; Tue,  9 Jun 2026 12:02:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.127.230.112
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781006529; cv=none; b=sBn+sGaOAbp8+0RV+s5zJBlDbJWnLAF9si2wD8da8Reo9hORPX7v9zjsFF+4lknQE2EnU9iNfTJKLDUgBW2iYqp7B/272wIbbm1Q0qEInXndbawqncYdeyvz43gPYZng+RTRzHl5WNyZW3tK4Zdz6821mHE7wVwIipFMWMuaHKc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781006529; c=relaxed/simple;
	bh=G7EVk2DIInWxvU8yG0p32IQGdK4y1Qo29hxVBO64A/s=;
	h=To:Subject:Date:Mime-Version:In-Reply-To:Content-Type:Cc:From:
	 Message-Id:References; b=uYh5a0hapRnuHhKBV0Sa7YWki+mc4FIyb2uX9HePhruCay7RTa/RPl+VC9Ie7weGQbAhjiv2meRQebXWAyQ/SWGZHZ8h4e3YNE4mVUbJiYZQznm2eEb2zd9UB7WfYP5/xYZyJVxJP2ByBk6XaGSW8RRsk7WcP7QOOMlKrpkG0a0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=Gt3J+Ts+; arc=none smtp.client-ip=209.127.230.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="Gt3J+Ts+"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=2212171451; d=bytedance.com; t=1781006516; h=from:subject:
 mime-version:from:date:message-id:subject:to:cc:reply-to:content-type:
 mime-version:in-reply-to:message-id;
 bh=VtIvpKTvFtvgcG9xuXHskUbv+ygenMEnXGmAq+TVMPs=;
 b=Gt3J+Ts+V6FIDn3wjdp0RMkSYeGrbVVwdytN1sfQ7Vd2PKmwiQ9NEmX3X0rsUOCNkQCR6u
 Z0VwmiLnLLphpkdEfLGHAkiBhXeEJmSy6Nm64tE5sG9LB/W7oHHaHdPvcOr4SLYHBgBSLV
 lEg3k5NTBNW0YAUcCTGUAoWZW3nAiRrZ9GtbKfpy8Dc4bunHiezQ++sVy9J+XyMU/iyPhM
 4wWSbyLrXLlT8oi1HcheIAYUHobBsnXb4ZtKzQvZXrslAHLmhfGlR2iiPe6JFhFkyAnAA4
 VMh5xWSqKpnqe4TYXtefZ3p1ZgMje8QHWLmvTR+mzXtq/lb3OIXPviNS9BRMsQ==
To: <bp@alien8.de>
X-Original-From: Li Zhe <lizhe.67@bytedance.com>
X-Mailer: git-send-email 2.45.2
Subject: Re: [PATCH v4 6/8] string: introduce memcpy_streaming() helpers
Date: Tue,  9 Jun 2026 20:01:32 +0800
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
In-Reply-To: <20260607190804.GAaiXBlGO2eRcfs1oB@fat_crate.local>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset=UTF-8
Cc: <akpm@linux-foundation.org>, <apopple@nvidia.com>, <arnd@arndb.de>, 
	<dave.hansen@linux.intel.com>, <david@kernel.org>, <kees@kernel.org>, 
	<linux-arch@vger.kernel.org>, <linux-hardening@vger.kernel.org>, 
	<linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>, 
	<lizhe.67@bytedance.com>, <mingo@redhat.com>, <rppt@kernel.org>, 
	<tglx@kernel.org>, <x86@kernel.org>
From: "Li Zhe" <lizhe.67@bytedance.com>
Message-Id: <20260609120132.84323-1-lizhe.67@bytedance.com>
References: <20260607190804.GAaiXBlGO2eRcfs1oB@fat_crate.local>
X-Lms-Return-Path: <lba+26a2800b2+03b1cc+vger.kernel.org+lizhe.67@bytedance.com>

On Sun, 7 Jun 2026 12:08:04 -0700, bp@alien8.de wrote:

> On Wed, Jun 03, 2026 at 04:01:50PM +0800, Li Zhe wrote:
> > Introduce a generic memcpy_streaming() interface for write-once copy
> > sites that can fall back to memcpy() when no architecture-specific
> > optimization is available, or when an architecture-specific backend
> > cannot safely handle a given transfer.
> >
> > Add memcpy_streaming_drain() alongside it so callers can separate the
> > copy primitive from any required ordering point. On x86, use
> > memcpy_flushcache() and sfence only for aligned transfers that can stay
> > entirely on the non-temporal store path; otherwise fall back to memcpy()
> 
> So you throwing "streaming", "non-temporal" and "flush-cache" wildly around
> here and this is adding unnecessary confusion where it shouldn't. I'd suggest
> you stick to "non-temporal" which you can abbreviate short'n'sweet to "nt" and
> that's it. Keep it simple.

Thanks for the review. Will switch to nt-based naming in next revision.

> > so the generic API does not expose flushcache semantics on cached
> > head/tail fragments.
> >
> > Callers are responsible for invoking memcpy_streaming_drain() before
> > later normal stores that must be ordered after the streaming copy.
> >
> > Signed-off-by: Li Zhe <lizhe.67@bytedance.com>
> > ---
> >  arch/x86/include/asm/string_64.h | 32 ++++++++++++++++++++++++++++++++
> >  include/linux/string.h           | 20 ++++++++++++++++++++
> >  2 files changed, 52 insertions(+)
> >
> > diff --git a/arch/x86/include/asm/string_64.h b/arch/x86/include/asm/string_64.h
> > index 4635616863f5..aee63108577f 100644
> > --- a/arch/x86/include/asm/string_64.h
> > +++ b/arch/x86/include/asm/string_64.h
> 
> There's arch/x86/include/asm/string.h. Why are those here, in the _64 variant?

The current placement was meant to reflect that the x86 implementation
here is really just a thin wrapper around the existing
memcpy_flushcache() backend, and that backend is x86_64-only today.

On x86, CONFIG_ARCH_HAS_UACCESS_FLUSHCACHE is selected only for X86_64,
so a 32-bit build would still need to fall back to the generic
memcpy()-based implementation anyway. Keeping it in string_64.h made
that backend dependency explicit.

That said, I see your layering point. If arch/x86/include/asm/string.h
is the preferred place for the arch-visible wrapper, I can move the
wrapper there in the next revision while keeping the x86_64-specific
implementation details in string_64.h.

> > @@ -4,6 +4,7 @@
> >
> >  #ifdef __KERNEL__
> >  #include <linux/jump_label.h>
> > +#include <linux/align.h>
> >
> >  /* Written 2002 by Andi Kleen */
> >
> > @@ -100,6 +101,37 @@ static __always_inline void memcpy_flushcache(void *dst, const void *src, size_t
> >  	}
> >  	__memcpy_flushcache(dst, src, cnt);
> >  }
> > +
> > +/*
> > + * Only map memcpy_streaming() to memcpy_flushcache() when the destination
> > + * is already 8-byte aligned and the size can be handled without cached
> > + * head/tail fragments in __memcpy_flushcache().
> > + */
> > +static __always_inline bool memcpy_flushcache_nt_safe(const void *dst,
> > +						      size_t cnt)
> 
> This is checking alignment. Then call it that.
> 
> > +{
> > +	unsigned long d = (unsigned long)dst;
> 
> Useless.
> 
> > +
> > +	return cnt && IS_ALIGNED(d, 8) && IS_ALIGNED(cnt, 4);
> > +}
> 
> AFAICT, this helper is used only once. Zap it completely.

Agreed. That helper is over-factored in its current form.

I'll fold the alignment test into the callsite and drop the temporary
variable in the next revision.

> > +
> > +#define __HAVE_ARCH_MEMCPY_STREAMING 1
> > +static __always_inline void memcpy_streaming(void *dst, const void *src,
> 
> memcpy_nt()
> 
> > +					     size_t cnt)
> > +{
> > +	if (!cnt)
> > +		return;
> > +
> > +	if (memcpy_flushcache_nt_safe(dst, cnt))
> 
> That branch can cost. Why is that alignment checking so necessary? Why can't
> you simply DTRT by handling the misaligned parts like __memcpy_flushcache().
> 
> What does this bring you? None of that is explained in the commit message so
> why do I want this patch at all?
> 
> The commit message is basically telling me what the patch does but I can kinda
> read that from the diff itself. What it is not telling me is *why* it exists.

The extra alignment gating was meant to keep this helper narrower than
__memcpy_flushcache(), so patch 8 would not inherit the mixed cached
head/tail handling from that implementation.

Thinking about it more, I agree that this is hard to justify for a
generic helper. For this series, what really matters is that the
struct page copies in patch 8 can use the existing x86
memcpy_flushcache() fastpaths where that is beneficial; I do not need
patch 6 to impose extra selection policy on unrelated callers.

I'll simplify and rework this part in the next revision, rewrite the
changelog to explain the actual motivation more clearly, and respin
patches 6-8 accordingly.

Thanks,
Zhe
