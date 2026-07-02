Received: from va-1-115.ptr.blmpb.com (va-1-115.ptr.blmpb.com [209.127.230.115])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 108453A8724
	for <linux-arch@vger.kernel.org>; Thu,  2 Jul 2026 07:39:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.127.230.115
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782977950; cv=none; b=fZ8Fqj5NPmTo0JiqCawmZ/G/k0+M4v3UZRKvc8DezCzZX74c1fGPHoqsb2m8gNAGHHvfmuNj7pJdV4n4XiiNHenObOjupQkExBwoxss6bqYG/vLXV/W/f6Qog/996XC9q6y05tRmgR0vLklAZfvibtvv8+g4rcbhc9EtrPBoqmw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782977950; c=relaxed/simple;
	bh=ghErQN1ohrlmKBzcnwYliYes4xesj5WiArPIQDAzgWs=;
	h=Subject:References:Content-Type:Mime-Version:In-Reply-To:From:
	 Date:Message-Id:To:Cc; b=F1cEnWvlG3l9uWeK9gVH+UNHqxla/vGPkYQYLYYgi6LJ5Nmo7BDu5L0Fs3M7n1uvGPDbrM1ngOjwOv9k0ShL70aM0DEddjq/AgFJ9pw6H/Gpw0lgnUxGMwN5WfwLIHarEcwALpwnMN6H0Bv9TQ0xQyj3jhwgeMAaEmnEuxGYAFY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=GfTVLNR9; arc=none smtp.client-ip=209.127.230.115
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="GfTVLNR9"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=2212171451; d=bytedance.com; t=1782977932; h=from:subject:
 mime-version:from:date:message-id:subject:to:cc:reply-to:content-type:
 mime-version:in-reply-to:message-id;
 bh=xmtA+r8qM/zVSb+LgLYGgZo13emjpI/4k5SRnvWn14s=;
 b=GfTVLNR9QqLMKZ7bCbiff2yOQ0U075jIAKU42nT9ijx+q07i2TGoHeu6MG0IpBaS9eO+eJ
 0Q2pWIwbcwtjYirtsmNsnC6HMIRiSJCv566mdThlxHDiEf8t2U+szS0DHS3AxhXkV1cduU
 OjBnVA4UQ7UAcFfbm1oAbSokPkIap6G6erj3ClO7s2n89QvjuTWnsVdyYfcx2AHQd4c3qz
 oI3+CnzwCUcuKWTLavIpsgNguwYum94E3p3vNEgYibmDZ06lqVcg3o6vttf2uO401knXDy
 ZI3UNZCtC7tF/XoEosxXaiYfn7jML/0fEOvwspV+u9Y+sruF2xVVwq7/w3cjDA==
Subject: Re: [PATCH v5 7/8] x86/string: extend memcpy_flushcache() fixed-size fastpaths
References: <20260702022342.GFakXLrl7ryd-g7gTu@fat_crate.local>
X-Original-From: Li Zhe <lizhe.67@bytedance.com>
Content-Type: text/plain; charset=UTF-8
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
In-Reply-To: <20260702022342.GFakXLrl7ryd-g7gTu@fat_crate.local>
Content-Transfer-Encoding: 7bit
From: "Li Zhe" <lizhe.67@bytedance.com>
Date: Thu,  2 Jul 2026 15:37:50 +0800
Message-Id: <20260702073750.73840-1-lizhe.67@bytedance.com>
X-Lms-Return-Path: <lba+26a461589+357c6e+vger.kernel.org+lizhe.67@bytedance.com>
To: <bp@alien8.de>
Cc: <akpm@linux-foundation.org>, <apopple@nvidia.com>, <arnd@arndb.de>, 
	<dave.hansen@linux.intel.com>, <david@kernel.org>, <kees@kernel.org>, 
	<linux-arch@vger.kernel.org>, <linux-hardening@vger.kernel.org>, 
	<linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>, 
	<lizhe.67@bytedance.com>, <mingo@redhat.com>, <rppt@kernel.org>, 
	<tglx@kernel.org>, <x86@kernel.org>
X-Mailer: git-send-email 2.45.2

On Wed, 1 Jul 2026 19:23:42 -0700, bp@alien8.de wrote:

> On Wed, Jul 01, 2026 at 05:05:52PM +0800, Li Zhe wrote:
> > The new x86 memcpy_nt() helper in this series maps to
> > memcpy_flushcache(), and the ZONE_DEVICE fast path uses that primitive
> > for constant-sized struct page template copies.
> >
> > memcpy_flushcache() currently inlines only the 4, 8, and 16-byte
> > cases. Larger constant-sized copies fall back to __memcpy_flushcache()
> > even when the destination is naturally aligned. Extend the inline
> > movnti coverage to 32, 48, 64, 80, and 96 bytes so the struct
> 
> Why exactly those sizes and not bigger?
> 
> Any numbers to back this up?

The relevant target sizes here are the x86_64 sizeof(struct page)
values which patch 8 can hit: 64, 80, and 96 bytes.

On x86_64, CONFIG_HAVE_ALIGNED_STRUCT_PAGE keeps struct page 16-byte
aligned. That gives 64 bytes in the common case, 80 bytes when
WANT_PAGE_VIRTUAL or CONFIG_KMSAN adds extra fields, and 96 bytes when
both are present. I stopped there deliberately because this series does
not have a current caller which needs larger constant sizes.

The 32-byte and 48-byte cases were added only as intermediate fixed-size
combinations used to build those larger struct page-sized copies while
keeping them on the inline movnti path.

> > page-sized copies used by that path can stay on the inline
> > non-temporal store path instead of dropping into the out-of-line
> > helper.
> >
> > Factor the store sequences into 8/16/32/64-byte helpers, keep the
> > existing 4/8/16-byte cases handled directly in memcpy_flushcache(),
> > issue the stores in ascending address order, and leave all other sizes
> > on __memcpy_flushcache().
> >
> > Signed-off-by: Li Zhe <lizhe.67@bytedance.com>
> > ---
> >  arch/x86/include/asm/string_64.h | 80 +++++++++++++++++++++++++++++++-
> >  1 file changed, 79 insertions(+), 1 deletion(-)
> >
> > diff --git a/arch/x86/include/asm/string_64.h b/arch/x86/include/asm/string_64.h
> > index 6f36abedc56a..95ef2d481418 100644
> > --- a/arch/x86/include/asm/string_64.h
> > +++ b/arch/x86/include/asm/string_64.h
> > @@ -4,6 +4,7 @@
> >
> >  #ifdef __KERNEL__
> >  #include <linux/jump_label.h>
> > +#include <linux/align.h>
> >
> >  /* Written 2002 by Andi Kleen */
> >
> > @@ -82,8 +83,81 @@ int strcmp(const char *cs, const char *ct);
> >  #ifdef CONFIG_ARCH_HAS_UACCESS_FLUSHCACHE
> >  #define __HAVE_ARCH_MEMCPY_FLUSHCACHE 1
> >  void __memcpy_flushcache(void *dst, const void *src, size_t cnt);
> > -static __always_inline void memcpy_flushcache(void *dst, const void *src, size_t cnt)
> > +
> > +static __always_inline void memcpy_flushcache_8(void *dst, const void *src)
> 
> If this is calling MOVNTI, you might as well call it that way. Only leave the
> externally exposed wrapper called "flushcache".

Thanks for the review.

In the next version I will rename the internal leaf helpers to
movnti_*() names and keep memcpy_flushcache() as the externally exposed
wrapper.

> > +{
> > +	asm volatile("movntiq %1, %0"
> > +		     : "=m"(*(u64 *)dst)
> > +		     : "r"(*(const u64 *)src)
> > +		     : "memory");
> > +}
> > +
> > +static __always_inline void memcpy_flushcache_16(void *dst,
> > +						 const void *src)
> > +{
> > +	memcpy_flushcache_8(dst, src);
> > +	memcpy_flushcache_8(dst + 8, src + 8);
> > +}
> > +
> > +static __always_inline void memcpy_flushcache_32(void *dst,
> > +						 const void *src)
> > +{
> > +	memcpy_flushcache_16(dst, src);
> > +	memcpy_flushcache_16(dst + 16, src + 16);
> > +}
> > +
> > +static __always_inline void memcpy_flushcache_64(void *dst,
> > +						 const void *src)
> >  {
> > +	memcpy_flushcache_32(dst, src);
> > +	memcpy_flushcache_32(dst + 32, src + 32);
> > +}
> > +
> > +/*
> > + * Keep the additional aligned fixed-size cases on the inline movnti path.
> > + * Leave the existing 4/8/16-byte cases handled directly in
> > + * memcpy_flushcache() so their code generation stays unchanged.
> > + */
> > +static __always_inline int memcpy_flushcache_large(void *dst,
> > +						   const void *src,
> > +						   size_t cnt)
> > +{
> > +	char *dptr = dst;
> > +	const char *sptr = src;
> > +
> > +	if (!IS_ALIGNED((unsigned long)dst, 8))
> > +		return 0;
> > +
> > +	switch (cnt) {
> > +	case 32:
> > +		memcpy_flushcache_32(dptr, sptr);
> > +		return 1;
> > +	case 48:
> > +		memcpy_flushcache_32(dptr, sptr);
> > +		memcpy_flushcache_16(dptr + 32, sptr + 32);
> > +		return 1;
> > +	case 64:
> > +		memcpy_flushcache_64(dptr, sptr);
> > +		return 1;
> > +	case 80:
> > +		memcpy_flushcache_64(dptr, sptr);
> > +		memcpy_flushcache_16(dptr + 64, sptr + 64);
> > +		return 1;
> > +	case 96:
> > +		memcpy_flushcache_64(dptr, sptr);
> > +		memcpy_flushcache_32(dptr + 64, sptr + 64);
> > +		return 1;
> > +	}
> > +
> > +	return 0;
> > +}
> > +
> > +static __always_inline void memcpy_flushcache(void *dst, const void *src,
> > +					      size_t cnt)
> > +{
> > +	if (!cnt)
> > +		return;
> > +
> >  	if (__builtin_constant_p(cnt)) {
> >  		switch (cnt) {
> >  			case 4:
> > @@ -97,7 +171,11 @@ static __always_inline void memcpy_flushcache(void *dst, const void *src, size_t
> >  				asm ("movntiq %1, %0" : "=m"(*(u64 *)(dst + 8)) : "r"(*(u64 *)(src + 8)));
> >  				return;
> >  		}
> > +
> > +		if (memcpy_flushcache_large(dst, src, cnt))
> 
> Why is this a separate function and not extending the switch-case?
> 
> I betcha it has to do with the alignment check but nothing explains to me why.

Yes. The separate helper is there exactly because the added
32/48/64/80/96-byte cases carry an extra 8-byte destination-alignment
check, while I left the existing 4/8/16-byte inline cases unchanged.

The intent was to keep the larger fixed-size cases on the inline
movnti path only when they already match the alignment assumptions
used by __memcpy_flushcache(); otherwise they fall back to that
out-of-line helper, which already handles the misaligned head/tail
fragments before entering its movnti loops.

The current patch does not explain that clearly enough. In v6 I will
add an explicit comment to memcpy_flushcache_large() and spell the
same reasoning out in the changelog.

Thanks,
Zhe
