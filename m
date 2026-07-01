Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4744F35F182;
	Wed,  1 Jul 2026 23:28:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782948491; cv=none; b=VNGOmBkCplKeBqgRw2mJdEV7ivjaBq7uUnQXsvPPPebRJKQsewPmgkGFwtLtwYwH9+v8Q+2Pt2uULmsjR8FBHLGxX0ZpERC4VxMliielASWuoC1g17lAP+LBjH7DACezC2v5vfZ5/1/PF8bMpBGoF7/RPlQM53g/lPkCsvAroqE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782948491; c=relaxed/simple;
	bh=R1sXhs858dNRbgUkglUsMplDfYjOiBmWV+LuElFvITE=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=BifLi2vjAEaooLAshFs1GtdZsVDMV6xx3wAsYH7P+MQI5coNAi/MKIqgMw8wIgM7n/BybAFtR2+RhkCVfTcmf2Ml2CLll80MSwMtBneimAVbm5p773m4MGYzZjftwZCu1qBpn5mUx74Jt52qS8ag2OpqLmplO06z2lLgHAERa24=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=L2QalADw; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="L2QalADw"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4A35E1F000E9;
	Wed,  1 Jul 2026 23:28:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux-foundation.org; s=korg; t=1782948489;
	bh=1tDwCIfEqBRQ1kY6a/LyMZ0uL6F57NGOJfCL1V2mTmI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=L2QalADwm9bFMHLjZn1wLrJ5YlM8eN4fmlBcjUJyuZrTsH2NRaSVqdjeoPHTL8fce
	 KGwKk9BiP7Vo4GMPShjJ9aX6hdVbGKuYN5Tpov0be/hiewKZNUBEgzE7NZNrj7rnQl
	 ikMNO19Y8iSz+JpicuChYq4cEmcSHxF3q6JzeWVo=
Date: Wed, 1 Jul 2026 16:28:08 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: "Li Zhe" <lizhe.67@bytedance.com>
Cc: <apopple@nvidia.com>, <arnd@arndb.de>, <bp@alien8.de>,
 <dave.hansen@linux.intel.com>, <david@kernel.org>, <kees@kernel.org>,
 <mingo@redhat.com>, <rppt@kernel.org>, <tglx@kernel.org>,
 <linux-arch@vger.kernel.org>, <linux-hardening@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>, <x86@kernel.org>,
 Balbir Singh <balbirs@nvidia.com>
Subject: Re: [PATCH v5 0/8] mm: optimize zone-device memmap initialization
Message-Id: <20260701162808.f6701ef751f874b9ff1c1c85@linux-foundation.org>
In-Reply-To: <20260701090553.62691-1-lizhe.67@bytedance.com>
References: <20260701090553.62691-1-lizhe.67@bytedance.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed,  1 Jul 2026 17:05:45 +0800 "Li Zhe" <lizhe.67@bytedance.com> wrote:

> memmap_init_zone_device() can take a noticeable amount of time when large
> pmem namespaces are bound or rebound, because it initializes nearly
> identical struct page descriptors one PFN at a time. This series reduces
> that ZONE_DEVICE memmap initialization overhead by reusing prepared
> struct page templates and, on x86, using memcpy_nt() for the template
> copy path.
> 
> The main target is large fsdax/devdax pmem configurations, where the
> cost of initializing the memmap shows up directly in nd_pmem/dax_pmem
> bind and rebind latency.
> 
> Patches 1-3 are preparatory cleanups and helper extraction. Patches 4-5
> add the template-copy fast path for head pages and compound tails.
> Patches 6-8 introduce memcpy_nt()/memcpy_nt_drain(), extend the x86
> fixed-size memcpy_flushcache() inline cases used by that helper, and
> switch the template-copy path over to memcpy_nt().
> 
> The fast path remains disabled when the page_ref_set tracepoint is
> active, and sanitized builds stay on the slow path so their instrumented
> stores are preserved. Architectures without a specialized memcpy_nt()
> backend continue to fall back to memcpy().
> 
> Tested in a VM with a 100 GB fsdax namespace device configured with
> map=dev and a 100 GB devdax namespace (align=2097152) on Intel Ice Lake
> server.

Thanks for persisting with this.

Review is still thin :( I see that Mike, Boris and Alistair have
commented on previous versions.  As did Balbir, who wasn't cc'ed on
this (fixed).

I'll add it to mm.git for testing exposure (because I'm still a sucker
for speedups), but more review is needed, please.

