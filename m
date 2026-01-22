Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 971F63101C2;
	Thu, 22 Jan 2026 10:03:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769076226; cv=none; b=LhljpbQ3DlV2vF/Snx5Nn8gwVEA742sQjzWVwebuP7UW526UeLIq7+7nUJWAufGGJertxnn8vpVdlgk82KLhe6uOkciM87XM2MyT2RvOCzYfARYbdseGJYQnCNJW4T7ImM6RsFpaETnU/CnYAB06EpEmMLz54vXEJCziq9yvlHg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769076226; c=relaxed/simple;
	bh=yL/NrddG1CawfKhoy4ZH1/4SsxmbBqbip9rUrRWJ+qM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YkGooIUBghGYSXWwU3nz+gSCgxr1vDk1uObdLHUQF5r2zbBhqitgYg7YOk90q0qgWcwRUJHDQ88GoERoT389y6wGrF4EvrINnHXay54owbE0A7RrClaUrsOJ9sJxZSP/M/bjRUP63ixR/v2Lmhc/4Tll8AKiyo31DMrM+ojc3ZM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BpS+5mmu; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BpS+5mmu"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1AFD1C116C6;
	Thu, 22 Jan 2026 10:03:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769076226;
	bh=yL/NrddG1CawfKhoy4ZH1/4SsxmbBqbip9rUrRWJ+qM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=BpS+5mmuQZCe173jMQU+eRlim0YQxsGfPb0rhy4QSByTDjeNk8vcjdoLnBsMQNvay
	 14sD4Tx+hYBzYuiyNWBJN+FO/l/8r5YhCtGPPaEHbFbNv/qJIlE1d3HZGTdnPdhmg5
	 j2I3/qxwfyTlw5rqZ5Zg2Ypq5sspCPJkG9zibheIhO0NyR4janbnDOFA89yShhAnmI
	 7kj42mLTLdODw95p3T+NQnWiX46ZgsffM1lsx39s3oj7TGKSGNlHg5SujnnMZUFKJe
	 mxtWDvaFp8RXaYicrJb/h09nkogt17BpUo6tISRX0nO2e9QjaZ7VlIVfXqE9SoNJQI
	 opFU4u9VTB2vg==
Date: Thu, 22 Jan 2026 12:03:35 +0200
From: Mike Rapoport <rppt@kernel.org>
To: Eugen Hristev <eugen.hristev@linaro.org>
Cc: david@redhat.com, linux-arm-msm@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-mm@kvack.org,
	tglx@linutronix.de, andersson@kernel.org, pmladek@suse.com,
	rdunlap@infradead.org, corbet@lwn.net, mhocko@suse.com,
	tudor.ambarus@linaro.org, mukesh.ojha@oss.qualcomm.com,
	linux-arm-kernel@lists.infradead.org,
	linux-hardening@vger.kernel.org, jonechou@google.com,
	rostedt@goodmis.org, linux-doc@vger.kernel.org,
	devicetree@vger.kernel.org, linux-remoteproc@vger.kernel.org,
	linux-arch@vger.kernel.org, tony.luck@intel.com, kees@kernel.org
Subject: Re: [PATCH 18/26] mm/memblock: Add MEMBLOCK_INSPECT flag
Message-ID: <aXH190NDVl7JAl7A@kernel.org>
References: <20251119154427.1033475-1-eugen.hristev@linaro.org>
 <20251119154427.1033475-19-eugen.hristev@linaro.org>
 <aVImIneFgOngYdSn@kernel.org>
 <4b8953ac-567b-4d68-9c25-72a69afdf1b3@linaro.org>
 <aVlsqdgXSBLIE9Xi@kernel.org>
 <ae85df64-b6b7-43d7-ba50-9c0525481299@linaro.org>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ae85df64-b6b7-43d7-ba50-9c0525481299@linaro.org>

On Tue, Jan 20, 2026 at 05:13:43PM +0200, Eugen Hristev wrote:
> 
> 
> On 1/3/26 21:23, Mike Rapoport wrote:
> > On Sat, Jan 03, 2026 at 08:36:40AM +0200, Eugen Hristev wrote:
> >>
> >>
> >> On 12/29/25 08:56, Mike Rapoport wrote:
> >>> Hi Eugen,
> >>>
> >>> On Wed, Nov 19, 2025 at 05:44:19PM +0200, Eugen Hristev wrote:
> >>>> This memblock flag indicates that a specific block is registered
> >>>> into an inspection table.
> >>>> The block can be marked for inspection using memblock_mark_inspect()
> >>>> and cleared with memblock_clear_inspect()
> >>>
> >>> Can you explain why memblock should treat memory registered for inspection
> >>> differently?
> >>
> >> It should not, at a first glance.
> >>
> >> The purpose of the flag is to let memblock be aware of it.
> >> The flag is there to have a "memblock way" of registering the memory,
> >> which inside memblock , it can translate to a meminspect way of
> >> registering the memory. It's just an extra layer on top of meminspect.
> >> With this, it would be avoided to call meminspect all over the places it
> >> would be required, but rather use the memblock API.
> > 
> > memblock APIs are not available after boot on many architectures, most
> > notable being x86.
> > 
> > But regardless, I can't say I understand why using memblock APIs for
> > meminspect is better than using meminspect directly.
> > I'd imagine that using meminspect register APIs would actually make it more
> > consistent and it would be easier to identify what memory is registered
> > with meminspect.
> > 
> > In the end, memblock_alloc*() returns dynamically allocated memory, just
> > like kmalloc(), the difference is that memblock is active very early at
> > boot and disappears after core MM initialization.
> 
> Hi Mike,
> 
> Thanks for sharing your opinion.
> 
> David, what do you think, does it make sense to have this flag or we can
> ditch it and use meminspect directly ?
> 
> Also, for some memory blocks, they do not disappear ever, e.g. the
> printk log buffer, it's allocated early and never freed, so it's
> required to have some memblocks marked for inspection.

The allocated memory does not disappear, the memblock metadata does.

> Eugen

-- 
Sincerely yours,
Mike.
