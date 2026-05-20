Received: from va-1-111.ptr.blmpb.com (va-1-111.ptr.blmpb.com [209.127.230.111])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69ED63D811E
	for <linux-arch@vger.kernel.org>; Wed, 20 May 2026 11:58:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.127.230.111
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779278285; cv=none; b=Kpp6g647mRtwClXi07u+rlkwj1zWWpfF18RRY6Hz6rp5acRhWC5mAsFGXMHOIYGUMfq8dZ26U224nHDsOizj4TXsvGJI9BYARWBaLBqZMrWm6iGJxCOI32JnI2JkyLG8/W7BrHIJNjyVI+6p98D5lBhw7nwNebSwUlLeAjH6Lps=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779278285; c=relaxed/simple;
	bh=KhvpS0fFnpxwiSEAVAUtutSUplbwx4tDXN2Rv95PEoY=;
	h=Mime-Version:In-Reply-To:Subject:Message-Id:Content-Type:Cc:From:
	 References:To:Date; b=IeqaSAb+MeA/ga5Pvc9RtVwX6nbM5WyOO4IWdsjajysSLY6CWt1mDb8IpOzEXnwG36hOEmATVoTa81ipXBMgpIxK2DB4TtSVjoRUb/jFJfN8MGdZeenTRuQvjozp9DxK62lLM2kHgzX5USr/J3ayTvuHQoHC2fZbBXL8+4uAhc8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=iG5yRu4b; arc=none smtp.client-ip=209.127.230.111
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="iG5yRu4b"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=2212171451; d=bytedance.com; t=1779278272; h=from:subject:
 mime-version:from:date:message-id:subject:to:cc:reply-to:content-type:
 mime-version:in-reply-to:message-id;
 bh=PzN7l1ThkVlwzYft29/2nDhN3g1VkN9d+lGAiRZSN48=;
 b=iG5yRu4b/wBG+/Qs9QxI8W+a6tlM6enK3/n8NlURP80woWzz8dpgie0b3WQagbpHlASh5I
 MQm+M+Q1cOssUGNHeC6TB4qRVnguy57tLxCjabxQuDKhZmqQhaoLISaLD1x751SaK2SX6O
 7e9npIp9f2VujT8+i076Or0PUgyBHO/LuO7Jg/1J/+WXbRhVc6KtfIt19Rfm0zcKjm+Qb1
 WCEYuJuzvwvzdQrsOW90Ij9vjIepgAGCascHLFRlelOWrd4y/ZxkFSe0tk5XFeWDoIj8H7
 jFycVntHGSD566lVM7AvtX4+3UpDMVlNEYvJZR+Opi5NZyEaYMFUzVR30xfwbg==
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
In-Reply-To: <ag1Sog3zDcJuOaaE@kernel.org>
Subject: Re: [PATCH 0/4] mm: speed up ZONE_DEVICE memmap initialization
Message-Id: <20260520115731.35059-1-lizhe.67@bytedance.com>
Content-Type: text/plain; charset=UTF-8
Cc: <akpm@linux-foundation.org>, <arnd@arndb.de>, <bp@alien8.de>, 
	<dave.hansen@linux.intel.com>, <david@kernel.org>, 
	<linux-arch@vger.kernel.org>, <linux-kernel@vger.kernel.org>, 
	<linux-mm@kvack.org>, <lizhe.67@bytedance.com>, <mingo@redhat.com>, 
	<tglx@kernel.org>, <x86@kernel.org>
From: "Li Zhe" <lizhe.67@bytedance.com>
Content-Transfer-Encoding: 7bit
References: <ag1Sog3zDcJuOaaE@kernel.org>
X-Original-From: Li Zhe <lizhe.67@bytedance.com>
To: <rppt@kernel.org>
Date: Wed, 20 May 2026 19:57:31 +0800
X-Mailer: git-send-email 2.45.2
X-Lms-Return-Path: <lba+26a0da1be+9ca7a9+vger.kernel.org+lizhe.67@bytedance.com>

On Wed, 20 May 2026 09:20:18 +0300, rppt@kernel.org wrote:

> On Mon, May 18, 2026 at 04:57:00PM +0800, Li Zhe wrote:
> > On Mon, 18 May 2026 09:23:33 +0300, rppt@kernel.org wrote:
> > > On Fri, May 15, 2026 at 04:20:41PM +0800, Li Zhe wrote:
> > > >
> > > > Performance
> > > > ===========
> > > > nd_pmem rebind, 100 GB fsdax namespace, map=dev
> > > >   Base(v7.1-rc3):
> > > >     First binding: 1486 ms
> > > >     Average of subsequent rebinds: 273.52 ms
> > > >   Full series:
> > > >     First binding: 1272 ms
> > > >     Average of subsequent rebinds: 104.59 ms
> > > >
> > > > dax_pmem rebind, 100 GB devdax namespace, align=2097152
> > > >   Base(v7.1-rc3):
> > > >     First binding: 1515 ms
> > > >     Average of subsequent rebinds: 313.45 ms
> > > >   Full series:
> > > >     First binding: 1286 ms
> > > >     Average of subsequent rebinds: 116.93 ms
> > >
> > > This is really good improvement!
> > >
> > > It would be also interesting to see how the template approach would improve
> > > "normal" memory map initialization.
> >
> > I also experimented with this approach earlier. Unfortunately, in the
> > normal memory map initialization path, functions such as
> > deferred_free_pages() are invoked shortly after struct page
> > initialization, and this function performs both read and write accesses
> > to members of the struct page.
> >
> > Non-temporal stores via MOVNTI are primarily beneficial for streaming
> > write operations, where the cache lines written are not expected to be
> > reused by the CPU in the near future. In this case, however, data
> > written using MOVNTI is immediately accessed again through regular load
> > and store instructions. This results in an access pattern that resembles
> > a write-then-reuse workload rather than a pure streaming store.
> >
> > Consequently, non-temporal stores do not deliver the expected reduction
> > in cache pollution, and using MOVNTI provides no measurable performance
> > benefit for this particular workload.
> 
> We can split initialization and freeing into separate loops if there is
> overall benefit, but this needs to be verified on other major architectures
> as well.

I agree with your point.

> > That said, a template-based approach can still accelerate initialization.
> > Based on measurements from this patchset, it should improve performance
> > on the generic path by roughly 10%. I would appreciate feedback on
> > whether such an optimization is still considered useful.
> 
> Improving the memory map initialization by 10% is valuable.

Thank you for your feedback. I will try the optimization after finishing
the current patchset.

Thanks,
Zhe
