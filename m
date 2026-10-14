Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0966C485511;
	Wed, 14 Oct 2026 09:00:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791968431; cv=none; b=fzfVxNrXN8Lyr0V1YNpzP3BCrCg0lCFnddhQB0ZDw6j6+/WTo663MOrN4dmNZ1T19GJ5buXYdIV4aayIy9PTUHYsaY5f1qroDv01dSfcnhijHC9EAIGVkqhP8Ro+dMhUtxZMLg+ZDEMUv2pXkWrn4dgmF70BEBmvxT9iQYTx3nA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791968431; c=relaxed/simple;
	bh=QHHb0DZxd6vJXZJdg7EynMfshzf8IQQprxwja0EOQwM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uHWKQwmPHEDgPLpb8M+a3dCTSW6qjJ7kwJ3KPxsAMOJfwG9cVYBgy1c7SX9xTpTkYu8tsMCM4ixAnzaUn9xRs0+v/TuPgPYnLLRnldQvBw+4irQ0SoMmEcdL0b+Fbx5FaGXur1uxRwg+yMIxbXEz5vxmQo2foTwurTkyWD47sJY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=jQIYGdPm; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="jQIYGdPm"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id F3F361596;
	Wed, 14 Oct 2026 02:00:24 -0700 (PDT)
Received: from arm.com (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 4A1513F7B4;
	Wed, 14 Oct 2026 02:00:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1791968428; bh=QHHb0DZxd6vJXZJdg7EynMfshzf8IQQprxwja0EOQwM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=jQIYGdPm3y0xRuJPv+eARHLw4283SpruBCAt7f+uNiNtj2bLUJLZJqiMiEptorMth
	 AHcohvXT/YR/v9xWV1xT5HGMk0lUPOhXuCoCas3fKXKz/oDeBsKz7dZ8C0EbaUTwuA
	 w7TvbAkKZuVD54ELwmQUaWMe7kRy40smDfYLxXLA=
Date: Wed, 14 Oct 2026 10:00:18 +0100
From: Catalin Marinas <catalin.marinas@arm.com>
To: "Christoph Lameter (Ampere)" <cl@gentwo.org>
Cc: Ankur Arora <ankur.a.arora@oracle.com>,
	Haris Okanovic <harisokn@amazon.com>, linux-kernel@vger.kernel.org,
	linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-pm@vger.kernel.org, bpf@vger.kernel.org, arnd@arndb.de,
	will@kernel.org, peterz@infradead.org, akpm@linux-foundation.org,
	mark.rutland@arm.com, ast@kernel.org, rafael@kernel.org,
	daniel.lezcano@linaro.org, memxor@gmail.com,
	zhenglifeng1@huawei.com, xueshuai@linux.alibaba.com,
	rdunlap@infradead.org, david.laight.linux@gmail.com,
	broonie@kernel.org, joao.m.martins@oracle.com,
	boris.ostrovsky@oracle.com, konrad.wilk@oracle.com,
	ashok.bhat@arm.com
Subject: Re: [PATCH v15 12/16] cpuidle/poll_state: Wait for need-resched via
 tif_need_resched_relaxed_wait()
Message-ID: <as9EospGcR2e1mpO@arm.com>
References: <20260831202251.305046-1-ankur.a.arora@oracle.com>
 <20260831202251.305046-13-ankur.a.arora@oracle.com>
 <178908146776.2725577.2613699832033292946.b4-review@b4>
 <878q58z2ej.fsf@oracle.com>
 <3e8bda45-0aa7-d0be-8aad-dab95902dcde@gentwo.org>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3e8bda45-0aa7-d0be-8aad-dab95902dcde@gentwo.org>

On Mon, Sep 21, 2026 at 10:47:13AM -0700, Christoph Lameter (Ampere) wrote:
> On Fri, 11 Sep 2026, Ankur Arora wrote:
> > Thanks for retesting.
> >
> > > The new unit tests all pass on both metal and virt variants of the same machines.
> > >
> > > I hope we can merge this soon.
> >
> > Yes indeed. I'll send out one more version which addresses a few minor
> > bot comments (and patch-1 needs a re-review because of changes.)
> >
> > But other than that this is as mergeable as it will ever be.
> 
> I dont see it anywhere. Is this patchset scheduled to be merged?

Not as far as I'm aware. There were some minor issues raised by Sashiko.
Ankur said he'll respin a v16 but I guess his spare time is fairly
limited.

If any interesting party wants to take it over, that would be great. It
would also be nice to get some acks from the atomic infrastructure
maintainers.

-- 
Catalin
