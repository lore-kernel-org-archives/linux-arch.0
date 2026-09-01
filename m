Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A00A4A441E;
	Tue,  1 Sep 2026 23:07:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788304054; cv=none; b=cE6fzap5rECBCfoueYQ9CfbK6G2YG4UyX5qL/YnuKkZlACzQcLpCv9tn3d40DSFhjDsowhxaTDmf37Mj3pJUkz+GK49qEv9VqjqPEjp9Dz98V1qdEIddaXLkFJKF7RqMqdPkIMdw7lcO8w9nvLi5ye0UqZhLkjwCQ9EonGpQBeo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788304054; c=relaxed/simple;
	bh=JSCUYOd+oLTmiVORWjY6iYY3FH4mD1g53cDcO6D53UI=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=ZVSpTz7qYYFnAsr5wD5vvzW+jVxJ5s8mhHc/M/ZdPePDo+b8P6mj23V4HS0Sog9HHgsrHH667N2SWfmHTA04mywCJdCh9uKh4nuU8Lwuf+L73EnLFO12eI/i6j+TGDDVIlQW5DElZ1yabKLSKkD4Yg3tEJeiUk5+4wAnA6kOUE4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=kerGN5SB; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="kerGN5SB"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7B92E1F00A3A;
	Tue,  1 Sep 2026 23:07:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux-foundation.org; s=korg; t=1788304053;
	bh=7cQ19BHiyrucmJAw/pZFIQ4zM3ytepyEIFxxLDlatXE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=kerGN5SBq3yKVTcKS9bVEW3P3myLlKw6ZtqPBgY7pUSSc2o83gl5duhZsYi7rr+tj
	 LRBEWhA9KftnxV2h7SwVbVs+/D5ymVIUzWOU30LGP2lOSS8TzdQee7VrwCI3TtfO3R
	 W8xeOMF2zlRU+87Iw/b+zQmf1KRK+y2fH94NeP50=
Date: Tue, 1 Sep 2026 16:07:32 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: "Li Zhe" <lizhe.67@bytedance.com>
Cc: <apopple@nvidia.com>, <arnd@arndb.de>, <balbirs@nvidia.com>,
 <bp@alien8.de>, <dave.hansen@linux.intel.com>, <david@kernel.org>,
 <kees@kernel.org>, <mingo@redhat.com>, <muchun.song@linux.dev>,
 <rppt@kernel.org>, <tglx@kernel.org>, <linux-arch@vger.kernel.org>,
 <linux-hardening@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <linux-mm@kvack.org>, <x86@kernel.org>
Subject: Re: [PATCH v11 0/7] mm: optimize zone-device memmap initialization
Message-Id: <20260901160732.8098b853491008465ea81461@linux-foundation.org>
In-Reply-To: <f7099580-870f-4cdf-84cc-a82cc47a42b0@bytedance.com>
References: <20260831111638.76012-1-lizhe.67@bytedance.com>
	<20260831164531.be5a8fa210401830e85eb974@linux-foundation.org>
	<f7099580-870f-4cdf-84cc-a82cc47a42b0@bytedance.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 1 Sep 2026 10:58:09 +0800 "Li Zhe" <lizhe.67@bytedance.com> wrote:

> On 9/1/26 7:45 AM, Andrew Morton wrote:
> > On Mon, 31 Aug 2026 19:16:31 +0800 "Li Zhe" <lizhe.67@bytedance.com> wrote:
> >
> >> memmap_init_zone_device() can take a noticeable amount of time when large
> >> pmem namespaces are bound or rebound, because it initializes nearly
> >> identical struct page descriptors one PFN at a time. This series reduces
> >> that ZONE_DEVICE memmap initialization overhead by reusing prepared
> >> struct page templates and, on x86, using memcpy_nontemporal() for the
> >> template copy path.
> >>
> >> ...
> >>
> >> This reduces the average memmap initialization time measured during
> >> rebind by about 48.0% for nd_pmem and 41.6% for dax_pmem on that arm64
> >> VM setup. Since this arm64 setup does not use the x86 MOVNTI fast paths,
> >> the result also suggests that the generic template-copy optimization can
> >> benefit architectures without an architecture-specific
> >> memcpy_nontemporal() backend.
> > Well that's nice.
> >
> > Sashiko seems to have found some new things to complain about:
> > 	https://sashiko.dev/#/patchset/20260831111638.76012-1-lizhe.67@bytedance.com
> >
> Hi Andrew,
> 
> Thanks for taking a look.
> 
> For the comment on patch 5 about the cnt == 0 case, I agree that
> memcpy_flushcache() should preserve the usual zero-length memcpy
> semantics. This is a pre-existing issue in the x86
> memcpy_flushcache()/__memcpy_flushcache() implementation, not a bug
> introduced by this series. The new ZONE_DEVICE call site added by this
> series always copies sizeof(struct page), so it cannot hit the
> zero-length case.

OK, thanks.

> Since this is a pre-existing issue and is independent of this patchset,
> would you prefer me to send a separate standalone fix for the x86
> memcpy_flushcache() zero-length case, rather than folding it into this
> series?

A standalone thing please.  It sounds like a candidate for the x86
tree, as long as Sashiko is wrong in implying that your [5/7] could
trigger this bug.

> For the MOVNTI ordering concern in patch 6, this was discussed in the
> previous round. Based on that discussion, I believe the current code is
> correct, so I do not plan any additional code changes for these items.
> 
> Thanks,
> Zhe
