Received: from va-1-114.ptr.blmpb.com (va-1-114.ptr.blmpb.com [209.127.230.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEEC9420883
	for <linux-arch@vger.kernel.org>; Tue,  7 Jul 2026 03:29:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.127.230.114
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783394958; cv=none; b=atMOAAam/ThFFisnIcH0NlZIfQsbMuOoXAZCvOlGtzsJWCXruG6UZ04KswmLbvb8dsyIzOjMDkFXm+rucgRtcLUiFk9EUznoeuOjpmg3QbIqrv5WgMq/aQMsIsn/yyJVDmPRsJ9dLii/555Y7EKW1O25M5kiTH78LKo6YlqlsNw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783394958; c=relaxed/simple;
	bh=473jjUc1+1uOykXfxMbXSKl5carXVh/hDi9ucX/15qY=;
	h=Mime-Version:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Content-Type:From:Date; b=S8KS50XT1JbgBYoVBzckZGSO7tzyOd1Gb8FARF+g5UF25IZBQ+topPvO0s3JCsE4/Md5sr0FLROXlhQJKrddS059y4pSORBZVtOpltNHed147cK/lz3p1b05ymiaIBms8h57UDFKrV+OQK+3wa0shBxeIrLUejQmDp9eM8b1lXI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=m8TA+QfD; arc=none smtp.client-ip=209.127.230.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="m8TA+QfD"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=2212171451; d=bytedance.com; t=1783394947; h=from:subject:
 mime-version:from:date:message-id:subject:to:cc:reply-to:content-type:
 mime-version:in-reply-to:message-id;
 bh=V1sc6krzRa7pzyUyfCUHJ+0030uOyisQV8XNxwRymBw=;
 b=m8TA+QfDVC+r9ToFTz/i+blLo5LisA+k5lA0+m/a9epKWGnsxs5r9uu43E1XnVRThXUEru
 qF7ZqKDvIabFtCUyWRbN0qNzsr87h14C5RMnzTYx0943gxc8LLovzzVftHVxnH/PyJ3MAg
 niJzHElcoVYuzUAqJ2RYmMUe8gO2sK0ntmtPQieCdpKGDct4r+yaTK4aGXeNHa7pfVin0y
 YQ/0XSsFAy+cVvaFIIBAPw+FCO00pvbBc8XQd6l3TfgCAzvbCzivt62FrPfEwErVoD2Icf
 0ThtCi7zCX89+n9js5VrvJariM18dXT3XEB5YIWeXQEmNM0PORy3T6WS0I+Pbg==
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Original-From: Li Zhe <lizhe.67@bytedance.com>
To: <david@kernel.org>
Cc: <akpm@linux-foundation.org>, <apopple@nvidia.com>, <arnd@arndb.de>, 
	<bp@alien8.de>, <dave.hansen@linux.intel.com>, <kees@kernel.org>, 
	<linux-arch@vger.kernel.org>, <linux-hardening@vger.kernel.org>, 
	<linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>, 
	<lizhe.67@bytedance.com>, <mingo@redhat.com>, <rppt@kernel.org>, 
	<tglx@kernel.org>, <x86@kernel.org>
Subject: Re: [PATCH v5 6/8] string: introduce memcpy_nt() helpers
Message-Id: <20260707032839.22683-1-lizhe.67@bytedance.com>
In-Reply-To: <d5a9c3b7-fa4c-47b7-9417-4c81b21760b8@kernel.org>
References: <d5a9c3b7-fa4c-47b7-9417-4c81b21760b8@kernel.org>
Content-Type: text/plain; charset=UTF-8
From: "Li Zhe" <lizhe.67@bytedance.com>
Date: Tue,  7 Jul 2026 11:28:39 +0800
Content-Transfer-Encoding: 7bit
X-Mailer: git-send-email 2.45.2
X-Lms-Return-Path: <lba+26a4c7281+88c363+vger.kernel.org+lizhe.67@bytedance.com>

On Mon, 6 Jul 2026 15:49:21 +0200, david@kernel.org wrote:

> >>> +
> >>> +#define __HAVE_ARCH_MEMCPY_NT 1
> >>> +/*
> >>> + * Reuse the existing x86 flushcache backend as the nt copy primitive.
> >>> + * Callers pair it with memcpy_nt_drain() when later stores must be
> >>> + * ordered after the copy.
> >>> + */
> >>> +static __always_inline void memcpy_nt(void *dst, const void *src, size_t cnt)
> >>> +{
> >>> +	memcpy_flushcache(dst, src, cnt);
> >>> +}
> >>
> >> In particular if you end up with a single function (that jsut requires a write
> >> memory barrier afterwards), please make this
> >>
> >> #define memcpy_nt memcpy_nt
> >>
> >> instead.
> >
> > Thanks for the review.
> >
> > Just to make sure I understood this correctly: do you mean that, rather
> > than using a separate __HAVE_ARCH_MEMCPY_NT feature macro, you would
> > prefer the usual self-macro override pattern, with
> >
> >     #define memcpy_nt memcpy_nt
> >
> > in arch/x86/include/asm/string_64.h and the generic fallback kept under
> > #ifndef memcpy_nt in include/linux/string.h?
> 
> Yes, that's what Linus suggested as the preferred way for single functions when
> it came up in different context recently.

Thanks for confirming. I will switch v6 to that self-macro override
pattern for memcpy_nt(), and I used the same style for
memcpy_nt_drain().

Thanks,
Zhe
