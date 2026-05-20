Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9C33373C04;
	Wed, 20 May 2026 06:20:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779258027; cv=none; b=PVTNPGqpn/g3vevnSLQ+pFuChnI17KFF3xdyoWyr4+18NB4zqQIFWe2qQrOb326LrKYR0m1Qlt48vUjr2cMhtAAzfqWa7t230bkf9I0Bg4OI/WdwstJr9kyGM2Yjq31JjeGEvqLqcrH3lofdbSbJCSfH5zYrIinuQCPCP7WQR0o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779258027; c=relaxed/simple;
	bh=630MKcwpvMpyDVvsjlWtFyPRieMDSPHkQcWvpKO8Zg4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ajw0uz1pkSiD5I6ogVm6TKFI7oK+zF8lMdq4M10/JCn9TNR003Cec2rlLgb7ofL608+ta+3oXOki+mNJkXvRwQya0QFbUb1AZyYrf1gQbGgtX7mc+Bx9XC9uI0PWCftCRFWeUXD/LpmWXPggmyF1RX3+4STOOYqDiSQIXomrmxQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bFfMKWVY; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bFfMKWVY"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 93E141F000E9;
	Wed, 20 May 2026 06:20:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779258026;
	bh=kRoosjzRf37h/pwGsiGi0q+5SXjtwTQyz/NQU3Yaxn4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=bFfMKWVYCxCew7k1X8OGwRXHpwzHd8yu2IBtA1oQScIcLNfE+UBK9SwpldZtYY1QS
	 3W+9hy78tfebrfNK3SYnvhYO/2tI3JIVMADL7C/TTZ3GzgcezuEO9ccB/84QgLTaOm
	 JiMIndWClR5mU5zUn5XCU/8JeaIEN272URXRyfkzZ7lXXa9YbzCUAFFjcLxumB0Deb
	 MTgR26XMxeah36rYSKpWI4MrOBu/DTKnQMjoaHOW10apJ5dJQK9X48PxrMGTyzAKfo
	 iubUT/jY23fs99cqvM1N+8rCUjrlgUMmG2Nyx6RABUswP5ZmulRNGZwNPA132qxkGN
	 tUuBSFa2Bv2+Q==
Date: Wed, 20 May 2026 09:20:18 +0300
From: Mike Rapoport <rppt@kernel.org>
To: Li Zhe <lizhe.67@bytedance.com>
Cc: akpm@linux-foundation.org, arnd@arndb.de, bp@alien8.de,
	dave.hansen@linux.intel.com, david@kernel.org,
	linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-mm@kvack.org, mingo@redhat.com, tglx@kernel.org,
	x86@kernel.org
Subject: Re: [PATCH 0/4] mm: speed up ZONE_DEVICE memmap initialization
Message-ID: <ag1Sog3zDcJuOaaE@kernel.org>
References: <agqwZaEtwXg4-O9z@kernel.org>
 <20260518085700.69849-1-lizhe.67@bytedance.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260518085700.69849-1-lizhe.67@bytedance.com>

On Mon, May 18, 2026 at 04:57:00PM +0800, Li Zhe wrote:
> On Mon, 18 May 2026 09:23:33 +0300, rppt@kernel.org wrote:
> > On Fri, May 15, 2026 at 04:20:41PM +0800, Li Zhe wrote:
> > > 
> > > Performance
> > > ===========
> > > nd_pmem rebind, 100 GB fsdax namespace, map=dev
> > >   Base(v7.1-rc3):
> > >     First binding: 1486 ms
> > >     Average of subsequent rebinds: 273.52 ms
> > >   Full series:
> > >     First binding: 1272 ms
> > >     Average of subsequent rebinds: 104.59 ms
> > > 
> > > dax_pmem rebind, 100 GB devdax namespace, align=2097152
> > >   Base(v7.1-rc3):
> > >     First binding: 1515 ms
> > >     Average of subsequent rebinds: 313.45 ms
> > >   Full series:
> > >     First binding: 1286 ms
> > >     Average of subsequent rebinds: 116.93 ms
> > 
> > This is really good improvement!
> > 
> > It would be also interesting to see how the template approach would improve
> > "normal" memory map initialization.
> 
> I also experimented with this approach earlier. Unfortunately, in the
> normal memory map initialization path, functions such as
> deferred_free_pages() are invoked shortly after struct page
> initialization, and this function performs both read and write accesses
> to members of the struct page.
> 
> Non-temporal stores via MOVNTI are primarily beneficial for streaming
> write operations, where the cache lines written are not expected to be
> reused by the CPU in the near future. In this case, however, data
> written using MOVNTI is immediately accessed again through regular load
> and store instructions. This results in an access pattern that resembles
> a write-then-reuse workload rather than a pure streaming store.
> 
> Consequently, non-temporal stores do not deliver the expected reduction
> in cache pollution, and using MOVNTI provides no measurable performance
> benefit for this particular workload.

We can split initialization and freeing into separate loops if there is
overall benefit, but this needs to be verified on other major architectures
as well.
 
> That said, a template-based approach can still accelerate initialization.
> Based on measurements from this patchset, it should improve performance
> on the generic path by roughly 10%. I would appreciate feedback on
> whether such an optimization is still considered useful.

Improving the memory map initialization by 10% is valuable.
 
> Thanks,
> Zhe

-- 
Sincerely yours,
Mike.
