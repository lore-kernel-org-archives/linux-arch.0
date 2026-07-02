Received: from va-1-112.ptr.blmpb.com (va-1-112.ptr.blmpb.com [209.127.230.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7888399002
	for <linux-arch@vger.kernel.org>; Thu,  2 Jul 2026 07:37:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.127.230.112
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782977844; cv=none; b=oSn66RQoa0rZ4yz5VQQG5szl8P6J7Lvb2p+uyX/m7DQ2hRB6S+38qjnQ+re2m6ZbY6ArqGpR5et+orn4QtNhAQT1ozfcJPnc7qQOLh2+EVBOkBYx8qEXX/sAThVNvs7JwWRD1LlojJPFJY9i+x5Bpe/QS/eKCdYZmoiGzKgFLms=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782977844; c=relaxed/simple;
	bh=OfNnvsf2XrZONiWi57Mfcr1y3T67T3ZBChd2EzfO+s4=;
	h=Cc:Date:Mime-Version:In-Reply-To:Content-Type:From:Subject:To:
	 Message-Id:References; b=pYwVloCywgjJF5Aa4kBd1aSFocFr66jUgs99VN4apHZoUIx67MTY3NagVYdgCHKvyvjOeKCZCmY+fsLhSl9DT/TDaJ1JHWrtK49haYvgGD8sLU02ruh6XiyiI0c7WTmX5h/W9aNJxcyIs4SOV9BgYsswHo1G2+XQqgaNSoOtJdM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=Edr8RkFw; arc=none smtp.client-ip=209.127.230.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="Edr8RkFw"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=2212171451; d=bytedance.com; t=1782977832; h=from:subject:
 mime-version:from:date:message-id:subject:to:cc:reply-to:content-type:
 mime-version:in-reply-to:message-id;
 bh=r3eiU6kjFkOegWqPID6sfX2AaUoDfb5SEdPGRJL4ozI=;
 b=Edr8RkFwQQcAfzZHZe3EeX/M2GJAqQVhCR1m9+/VpHZc0eR0SWrrnVBDioZtVMCvaeNiYU
 UFguhxyZtcp4q/6X1xtgHZRjbv4P75htoHi77gmH8EbZwT6BhvIwYT+EirwIFjHlm7Es+8
 LUe67fpu/rG8aYYMc1ynADgZCLvXr+FYcbW7YTuoKgloIJRosGpXlzE+se2yc0i7HfHRTE
 IfrZBvAMCYWbZS6eju8OtYkSLGIM7xPGHPICFnXwcwGxW0L6z11WbxKeCbHGodJSmc+9CQ
 VkY1Dq6xcDa74FjuCMDzH7JdVdjvTN/GASZV057NDzV0pTZJ+C5paXA70Hi2zA==
Cc: <akpm@linux-foundation.org>, <apopple@nvidia.com>, <arnd@arndb.de>, 
	<dave.hansen@linux.intel.com>, <david@kernel.org>, <kees@kernel.org>, 
	<linux-arch@vger.kernel.org>, <linux-hardening@vger.kernel.org>, 
	<linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>, 
	<lizhe.67@bytedance.com>, <mingo@redhat.com>, <rppt@kernel.org>, 
	<tglx@kernel.org>, <x86@kernel.org>
X-Original-From: Li Zhe <lizhe.67@bytedance.com>
Date: Thu,  2 Jul 2026 15:36:41 +0800
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
In-Reply-To: <20260702021619.GEakXJ89-0rZcYGIq8@fat_crate.local>
Content-Type: text/plain; charset=UTF-8
From: "Li Zhe" <lizhe.67@bytedance.com>
Subject: Re: [PATCH v5 6/8] string: introduce memcpy_nt() helpers
X-Lms-Return-Path: <lba+26a461526+d9e216+vger.kernel.org+lizhe.67@bytedance.com>
X-Mailer: git-send-email 2.45.2
To: <bp@alien8.de>
Message-Id: <20260702073641.73753-1-lizhe.67@bytedance.com>
References: <20260702021619.GEakXJ89-0rZcYGIq8@fat_crate.local>

On Wed, 1 Jul 2026 19:16:19 -0700, bp@alien8.de wrote:

> On Wed, Jul 01, 2026 at 05:05:51PM +0800, Li Zhe wrote:
> > +static __always_inline void memcpy_nt_drain(void)
> > +{
> > +	asm volatile("sfence" : : : "memory");
> 
> Doing a simple grep around the tree will give you the hint to use wmb() and
> not reinvent the wheel here. Not to mention that this is bypassing KCSAN
> instrumentation.
> 
> And then you don't need to go define this drain thing but simply use wmb()
> because, oh, look, other architectures already define a write memory barrier
> too.

Thanks for the review.

Yes, a separate memcpy_nt_drain() wrapper is unnecessary. I'll drop
memcpy_nt_drain() in v6 and use wmb() at the ordering points in patch
8 instead.

Thanks,
Zhe
