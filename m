Received: from va-1-115.ptr.blmpb.com (va-1-115.ptr.blmpb.com [209.127.230.115])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 042D34229C4
	for <linux-arch@vger.kernel.org>; Mon,  6 Jul 2026 11:53:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.127.230.115
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783338823; cv=none; b=isGm/hrjfA/VI9rrTQ3guFhZn+jfM86k8rv3AOk1cj1WRpiaZHoWZ+ijXTAZfBu0O2uiEO+pv2S2RC0evIpkrsnar/K6PBWJRpk94nPK5zJMToFJNrpA0k65I7qkY6bWNC4v6TOE0gEauKM7PAUmxq73DW4UFZIBsM9+xWk/OK4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783338823; c=relaxed/simple;
	bh=E0BqE6g+Z42BlWO6l+i5LsQkn2KE/b6uKrUeyGd2SzA=;
	h=References:Content-Type:Cc:Date:Message-Id:Subject:Mime-Version:
	 In-Reply-To:From:To; b=RGNZcUh8c1OefASqDo/nSLpDdYxC8gnQE7BwIZL7qYB8eAmYfZdvHCFmm48PhY2osFbFfHMRTVMsBprr1yuosLeE2kxNFQpoIvvpMA8a8Qkgv1RyESYBchlSxGTsOJBd217FKfnXZKcjcJxRfTkfX9hgqwZIECvr0hWyWduSqQE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=C5ggkEwQ; arc=none smtp.client-ip=209.127.230.115
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="C5ggkEwQ"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=2212171451; d=bytedance.com; t=1783338817; h=from:subject:
 mime-version:from:date:message-id:subject:to:cc:reply-to:content-type:
 mime-version:in-reply-to:message-id;
 bh=H75gp8WVKuHVfCLEZVTtpIHpv638HXTLtw28T7Z0uiw=;
 b=C5ggkEwQLrUkTJ8W8Q8mUoo8pOWeVGFWMd9vma1eQcw78rYf+xULBso5o5K36BeE1LwACc
 JNqxpmawSbMnR7rpDnpaFiwcXj9E0OhQBVnCR9B/kyrw9q6l2IUIC5+j2ebe5AbQl2o3Qq
 wLLjPegiffJ+hE2OtzbC1x1E6ZGffEBXc9aF7O3QXNijmdkMXmXwvRaHeE9XWjOaejlKNb
 LBDmAFXuEqgkasO3SatMlRYFZXkk06ITyMj5exBUe8C2QnWnWHDxtynWlgVEsmWCT/K3cw
 8wEoU/gy+csXJF8L5wNIAYlD+Mx4utf5OsCvFPrke/9c3J9rr2/+SnZocoMs8A==
References: <c02d8cd6-a3e8-470f-a7ea-a2f2f666b10c@kernel.org>
X-Original-From: Li Zhe <lizhe.67@bytedance.com>
Content-Type: text/plain; charset=UTF-8
Cc: <akpm@linux-foundation.org>, <apopple@nvidia.com>, <arnd@arndb.de>, 
	<bp@alien8.de>, <dave.hansen@linux.intel.com>, <kees@kernel.org>, 
	<linux-arch@vger.kernel.org>, <linux-hardening@vger.kernel.org>, 
	<linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>, 
	<lizhe.67@bytedance.com>, <mingo@redhat.com>, <rppt@kernel.org>, 
	<tglx@kernel.org>, <x86@kernel.org>
Date: Mon,  6 Jul 2026 19:53:13 +0800
Message-Id: <20260706115313.50524-1-lizhe.67@bytedance.com>
X-Mailer: git-send-email 2.45.2
Subject: Re: [PATCH v5 6/8] string: introduce memcpy_nt() helpers
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
In-Reply-To: <c02d8cd6-a3e8-470f-a7ea-a2f2f666b10c@kernel.org>
From: "Li Zhe" <lizhe.67@bytedance.com>
X-Lms-Return-Path: <lba+26a4b973f+2aaa50+vger.kernel.org+lizhe.67@bytedance.com>
To: <david@kernel.org>
Content-Transfer-Encoding: 7bit

On Mon, Jul 6, 2026 at 11:18:48AM +0200, david@kernel.org wrote:

> > +
> > +#define __HAVE_ARCH_MEMCPY_NT 1
> > +/*
> > + * Reuse the existing x86 flushcache backend as the nt copy primitive.
> > + * Callers pair it with memcpy_nt_drain() when later stores must be
> > + * ordered after the copy.
> > + */
> > +static __always_inline void memcpy_nt(void *dst, const void *src, size_t cnt)
> > +{
> > +	memcpy_flushcache(dst, src, cnt);
> > +}
> 
> In particular if you end up with a single function (that jsut requires a write
> memory barrier afterwards), please make this
> 
> #define memcpy_nt memcpy_nt
> 
> instead.

Thanks for the review.

Just to make sure I understood this correctly: do you mean that, rather
than using a separate __HAVE_ARCH_MEMCPY_NT feature macro, you would
prefer the usual self-macro override pattern, with

    #define memcpy_nt memcpy_nt

in arch/x86/include/asm/string_64.h and the generic fallback kept under
#ifndef memcpy_nt in include/linux/string.h?

If so, I can rework it that way in v6. I would likely use the same
pattern for memcpy_nt_drain() as well, unless you would prefer
otherwise.

Thanks,
Zhe
