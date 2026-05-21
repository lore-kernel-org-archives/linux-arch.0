Received: from va-1-114.ptr.blmpb.com (va-1-114.ptr.blmpb.com [209.127.230.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 240D3383318
	for <linux-arch@vger.kernel.org>; Thu, 21 May 2026 03:00:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.127.230.114
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779332460; cv=none; b=Q2mtHRIVw8PeGwT/xS5rpkosgT5Y5uGXxfWLLOU0XBxktXS34Xy19gzdkyeF44ZUOQw9WtM6VqYKuJA6iX5CN+f3IM7AB3OWBNM3RQK0irctlyW6mkQCTbdFCjkX1YV+XJjXf76E6rlV1WqegalgC1wDu5WNYHXYjCq9f+LJPRA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779332460; c=relaxed/simple;
	bh=kMrsuaIXs1XZK4EyqhsO91Xn/ho9H6IEPv+jBTnlpR8=;
	h=To:Cc:From:Date:References:Content-Type:In-Reply-To:Subject:
	 Message-Id:Mime-Version; b=qGdLOxpeyYwbfWbdE33vmuxRt3S34nVUuFzfpIXCdMgTggDU/xqI/0aohF6y7gU/u+ms82Snnf2tLunqxqTAT88rUXh+PacK2Zgnhx5N7VapqEk97BO7mpBGxHsks/XzR0aO+lbxC1nNfFXOeurbZClU4Rs1N+/m3+oBZaLLg2M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=mksmSm+w; arc=none smtp.client-ip=209.127.230.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="mksmSm+w"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=2212171451; d=bytedance.com; t=1779332453; h=from:subject:
 mime-version:from:date:message-id:subject:to:cc:reply-to:content-type:
 mime-version:in-reply-to:message-id;
 bh=vSWt6uzZfaEEioJZG86xnGAHhJIk7a5MEe/eyJLSA6I=;
 b=mksmSm+wRafg4kRpDtcKs3rj2kLdm85I/aH5YyIwrSfk+hA/kPIxf+FBL5TL2RNsQ38IVK
 7A6NIoduMz7xJEwAG+3zr0gN4p8QQtGDQaAp8ltVn1Y1IpHmB+fSOA7getP9qJq3LaeSth
 aj3lV6w3OgYIXVn7kbc50TBTeD9cZDF39vv4vntxCrEAm6U67+oLHzwraB/8ilY/rbQPJU
 F2Y1Z+TKcdjQM3ksqQojDe1gaNMj+krh1pLtBwfOFzl5n1GifcKdKeYGOqX8X2U7tF0bn8
 YUIqXjdqbfXEYXY5UCIh1b3EyMzL6EWlxWVVmAApkxsigkbUXXA5u2RW/25pkA==
To: <apopple@nvidia.com>
Cc: <akpm@linux-foundation.org>, <arnd@arndb.de>, <bp@alien8.de>, 
	<dave.hansen@linux.intel.com>, <david@kernel.org>, 
	<linux-arch@vger.kernel.org>, <linux-kernel@vger.kernel.org>, 
	<linux-mm@kvack.org>, <lizhe.67@bytedance.com>, <mingo@redhat.com>, 
	<rppt@kernel.org>, <tglx@kernel.org>, <x86@kernel.org>
From: "Li Zhe" <lizhe.67@bytedance.com>
Date: Thu, 21 May 2026 11:00:30 +0800
References: <ag41kVX1wky9hNXc@nvdebian.thelocal>
X-Original-From: Li Zhe <lizhe.67@bytedance.com>
X-Lms-Return-Path: <lba+26a0e7563+fb9b62+vger.kernel.org+lizhe.67@bytedance.com>
Content-Type: text/plain; charset=UTF-8
In-Reply-To: <ag41kVX1wky9hNXc@nvdebian.thelocal>
X-Mailer: git-send-email 2.45.2
Subject: Re: [PATCH 0/4] mm: speed up ZONE_DEVICE memmap initialization
Message-Id: <20260521030030.3566-1-lizhe.67@bytedance.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit

On Thu, 21 May 2026 08:36:08 +1000, apopple@nvidia.com wrote:

> On 2026-05-20 at 21:57 +1000, Li Zhe <lizhe.67@bytedance.com> wrote...
> > On Wed, 20 May 2026 09:20:18 +0300, rppt@kernel.org wrote:
> >
> > > On Mon, May 18, 2026 at 04:57:00PM +0800, Li Zhe wrote:
> > > > On Mon, 18 May 2026 09:23:33 +0300, rppt@kernel.org wrote:
> > > > > On Fri, May 15, 2026 at 04:20:41PM +0800, Li Zhe wrote:
> > > > > >
> > > > > > Performance
> > > > > > ===========
> > > > > > nd_pmem rebind, 100 GB fsdax namespace, map=dev
> > > > > >   Base(v7.1-rc3):
> > > > > >     First binding: 1486 ms
> > > > > >     Average of subsequent rebinds: 273.52 ms
> > > > > >   Full series:
> > > > > >     First binding: 1272 ms
> > > > > >     Average of subsequent rebinds: 104.59 ms
> > > > > >
> > > > > > dax_pmem rebind, 100 GB devdax namespace, align=2097152
> > > > > >   Base(v7.1-rc3):
> > > > > >     First binding: 1515 ms
> > > > > >     Average of subsequent rebinds: 313.45 ms
> > > > > >   Full series:
> > > > > >     First binding: 1286 ms
> > > > > >     Average of subsequent rebinds: 116.93 ms
> > > > >
> > > > > This is really good improvement!
> > > > >
> > > > > It would be also interesting to see how the template approach would improve
> > > > > "normal" memory map initialization.
> > > >
> > > > I also experimented with this approach earlier. Unfortunately, in the
> > > > normal memory map initialization path, functions such as
> > > > deferred_free_pages() are invoked shortly after struct page
> > > > initialization, and this function performs both read and write accesses
> > > > to members of the struct page.
> > > >
> > > > Non-temporal stores via MOVNTI are primarily beneficial for streaming
> > > > write operations, where the cache lines written are not expected to be
> > > > reused by the CPU in the near future. In this case, however, data
> > > > written using MOVNTI is immediately accessed again through regular load
> > > > and store instructions. This results in an access pattern that resembles
> > > > a write-then-reuse workload rather than a pure streaming store.
> > > >
> > > > Consequently, non-temporal stores do not deliver the expected reduction
> > > > in cache pollution, and using MOVNTI provides no measurable performance
> > > > benefit for this particular workload.
> > >
> > > We can split initialization and freeing into separate loops if there is
> > > overall benefit, but this needs to be verified on other major architectures
> > > as well.
> >
> > I agree with your point.
> >
> > > > That said, a template-based approach can still accelerate initialization.
> > > > Based on measurements from this patchset, it should improve performance
> > > > on the generic path by roughly 10%. I would appreciate feedback on
> > > > whether such an optimization is still considered useful.
> > >
> > > Improving the memory map initialization by 10% is valuable.
> 
> Agree with that - GPUs have to hotplug 100's GB of ZONE_DEVICE memory so any
> improvement here is valuable. Thanks for looking at it.

Thank you for your feedback. I will try the optimization after finishing
the current patchset.

Thanks,
Zhe
