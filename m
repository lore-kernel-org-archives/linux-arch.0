Received: from va-1-114.ptr.blmpb.com (va-1-114.ptr.blmpb.com [209.127.230.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80D023AE1BB
	for <linux-arch@vger.kernel.org>; Thu,  2 Jul 2026 07:41:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.127.230.114
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782978099; cv=none; b=C7Sd8elHdaCOzl04Jn0ng3FesGUeZsu0kLmXf2ZggL8arL3xCXlvaBhgTAeGHAJA3dbVfTBa3fR/41hVDQSXbDeBLS1g5KTWs/mGUadBwKNI8zknzxRDN2AzAXN7YyvrpS2WGKH0zX2d744iROpWCX5PCsNkSx8YYTNtHQ4Qpf4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782978099; c=relaxed/simple;
	bh=ZQxIpkuEHvh0dCjK0QCC5RnnLql+W3wPr8GoWGCq4Xc=;
	h=From:Date:Message-Id:To:In-Reply-To:References:Mime-Version:
	 Content-Type:Subject:Cc; b=G3i7sJqlux0REU7U4Lr6O1Egl+ibPMqftIDwX6El7Xpx+1u8VyBdawTueqA0+CeLnHOsLQiUeTEO1kuHP7/hV92bOEQB7igHAEJ8T0Y4ecdElu0QL+fk0KnRwfIt9IYN0CPp1RJOfp8bv9tzbXwtXKLYMlTU0WHokIo/Gz4nzWc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=ZqtbmojB; arc=none smtp.client-ip=209.127.230.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="ZqtbmojB"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=2212171451; d=bytedance.com; t=1782978090; h=from:subject:
 mime-version:from:date:message-id:subject:to:cc:reply-to:content-type:
 mime-version:in-reply-to:message-id;
 bh=/dj7RTovRhDXEmfG0BztNGy5VfoucgAi636TM9fh3k4=;
 b=ZqtbmojB89fzg2gwWK/oEOIFh9S0Mbm2E7wFGyaz1ng6Z/6oXDq9ZllNbrubI6wHa20rlI
 EOODCAZmpk6XtgSRxMwE0b/2aWJdxs1TGKUIlHlY5LMZebR3Qhhh7HMX7/AzDIm/0NclgU
 rklet7NG/1YPQ5xKkFST53ZI07inkaloxJoT+u/UY163krDQt9sFBbs08IAvYF02LWPbrZ
 yAFY3z2gG1cbK/KGn/z0cOLA3klFYGXE3KJ2y1Tn0/VKX48kTv1smPLuj7ayg0Xvq6fTHP
 yidhIVQ77cJyYrjCzzIZZZKWkj/kXwDhulMi7GKJ1LNNgyYLhYmwqaaBvC3uJA==
From: "Li Zhe" <lizhe.67@bytedance.com>
Date: Thu,  2 Jul 2026 15:39:54 +0800
Message-Id: <20260702073954.73937-1-lizhe.67@bytedance.com>
To: <akpm@linux-foundation.org>
In-Reply-To: <20260701162808.f6701ef751f874b9ff1c1c85@linux-foundation.org>
References: <20260701162808.f6701ef751f874b9ff1c1c85@linux-foundation.org>
X-Lms-Return-Path: <lba+26a461628+23e982+vger.kernel.org+lizhe.67@bytedance.com>
X-Original-From: Li Zhe <lizhe.67@bytedance.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Subject: Re: [PATCH v5 0/8] mm: optimize zone-device memmap initialization
Content-Transfer-Encoding: 7bit
X-Mailer: git-send-email 2.45.2
Cc: <apopple@nvidia.com>, <arnd@arndb.de>, <balbirs@nvidia.com>, 
	<bp@alien8.de>, <dave.hansen@linux.intel.com>, <david@kernel.org>, 
	<kees@kernel.org>, <linux-arch@vger.kernel.org>, 
	<linux-hardening@vger.kernel.org>, <linux-kernel@vger.kernel.org>, 
	<linux-mm@kvack.org>, <lizhe.67@bytedance.com>, <mingo@redhat.com>, 
	<rppt@kernel.org>, <tglx@kernel.org>, <x86@kernel.org>

On Wed, 1 Jul 2026 16:28:08 -0700, akpm@linux-foundation.org wrote:

> On Wed,  1 Jul 2026 17:05:45 +0800 "Li Zhe" <lizhe.67@bytedance.com> wrote:
> 
> > memmap_init_zone_device() can take a noticeable amount of time when large
> > pmem namespaces are bound or rebound, because it initializes nearly
> > identical struct page descriptors one PFN at a time. This series reduces
> > that ZONE_DEVICE memmap initialization overhead by reusing prepared
> > struct page templates and, on x86, using memcpy_nt() for the template
> > copy path.
> >
> > The main target is large fsdax/devdax pmem configurations, where the
> > cost of initializing the memmap shows up directly in nd_pmem/dax_pmem
> > bind and rebind latency.
> >
> > Patches 1-3 are preparatory cleanups and helper extraction. Patches 4-5
> > add the template-copy fast path for head pages and compound tails.
> > Patches 6-8 introduce memcpy_nt()/memcpy_nt_drain(), extend the x86
> > fixed-size memcpy_flushcache() inline cases used by that helper, and
> > switch the template-copy path over to memcpy_nt().
> >
> > The fast path remains disabled when the page_ref_set tracepoint is
> > active, and sanitized builds stay on the slow path so their instrumented
> > stores are preserved. Architectures without a specialized memcpy_nt()
> > backend continue to fall back to memcpy().
> >
> > Tested in a VM with a 100 GB fsdax namespace device configured with
> > map=dev and a 100 GB devdax namespace (align=2097152) on Intel Ice Lake
> > server.
> 
> Thanks for persisting with this.
> 
> Review is still thin :( I see that Mike, Boris and Alistair have
> commented on previous versions.  As did Balbir, who wasn't cc'ed on
> this (fixed).
> 
> I'll add it to mm.git for testing exposure (because I'm still a sucker
> for speedups), but more review is needed, please.

Thanks, Andrew. I appreciate your help here. I'll address the latest
review comments in the next version.

Thanks,
Zhe
