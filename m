Received: from va-2-111.ptr.blmpb.com (va-2-111.ptr.blmpb.com [209.127.231.111])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1B5B223DE9
	for <linux-arch@vger.kernel.org>; Tue,  7 Jul 2026 03:26:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.127.231.111
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783394767; cv=none; b=jc/BWFj5CszrvGuLNe9RGpbmCqb/lVQBtSkqzZKWpf4YE0hwsUt1xxny29aW80ASd6ZEX0vW0GDkYofbhl6mJKAzpct57ve+5kAcLeL6UWecWSDVYvJVqnU0bbHK7IlqJxyrrRHo/vD8WQQAx3jsZ/qgQzIls6S1c6R6LzOEdm0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783394767; c=relaxed/simple;
	bh=aZNNvM8SfGa8O6MPJG6nTNys5p/ltac8MYRFY3rlICw=;
	h=Message-Id:To:From:Subject:Date:Content-Type:Cc:Mime-Version:
	 In-Reply-To:References; b=B08PaM7f0NnAKjuy2sO7X2q5dy4YtQavejp2lJMIqJIgI5NRl9lUFewLHu6/qU5CIw2Jo9A/cYHFcIM30mGTUdyNIWlVq/b5uV3nmr07X1DTKEr0DLmIVk8iBZaeGiqHsPCKXSajFCblmL/ZHNlxlxb9cHO8Ta+3WGCBCub9mao=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=fiScCpEk; arc=none smtp.client-ip=209.127.231.111
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="fiScCpEk"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=2212171451; d=bytedance.com; t=1783394755; h=from:subject:
 mime-version:from:date:message-id:subject:to:cc:reply-to:content-type:
 mime-version:in-reply-to:message-id;
 bh=Bs4YEwGhuau8az/B0StDJAa2em7HRJjmNMnR+mFCouI=;
 b=fiScCpEkj3wfzVD1WWuF2+Syv8ox4WfI8HaqdFVpOVelvwqM0RD4CEfvN+dnooIneFZVrz
 cW7QsEq2tQ185IdgwCYpLlpeDGq6mjllrJ0NlVjl/dXqNYGmAte939SISC+Kp10sUbvCpg
 n4/pCxYk4My0MeenYwN1JIEK1ucMBADepQHr58r/ATd8mvOF+4zHyNDQHSwhHJXARe8gUn
 rY6HOc1UqUk6x87aePQ5UKFl0FumrCrTZBgBgpDxgAyjcd+1+PSymhLI1v1EVOliZr0aMd
 2hTxsapo4i08tTmxl+98xEk6X/qnDufuJ8Nrj5CtpCOkVAK54Is1VYAN3yQmyg==
Message-Id: <20260707032530.22444-1-lizhe.67@bytedance.com>
X-Lms-Return-Path: <lba+26a4c71c1+5fd8c2+vger.kernel.org+lizhe.67@bytedance.com>
Content-Transfer-Encoding: 7bit
To: <david@kernel.org>
From: "Li Zhe" <lizhe.67@bytedance.com>
Subject: Re: [PATCH v5 2/8] mm: factor zone-device page init helpers out of __init_zone_device_page
Date: Tue,  7 Jul 2026 11:25:30 +0800
Content-Type: text/plain; charset=UTF-8
Cc: <akpm@linux-foundation.org>, <apopple@nvidia.com>, <arnd@arndb.de>, 
	<bp@alien8.de>, <dave.hansen@linux.intel.com>, <kees@kernel.org>, 
	<linux-arch@vger.kernel.org>, <linux-hardening@vger.kernel.org>, 
	<linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>, 
	<lizhe.67@bytedance.com>, <mingo@redhat.com>, <rppt@kernel.org>, 
	<tglx@kernel.org>, <x86@kernel.org>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.45.2
In-Reply-To: <374a0a2a-444c-412b-8ab8-414dff6a2ca9@kernel.org>
References: <374a0a2a-444c-412b-8ab8-414dff6a2ca9@kernel.org>
X-Original-From: Li Zhe <lizhe.67@bytedance.com>

On Mon, 6 Jul 2026 15:47:43 +0200, david@kernel.org wrote:

> On 7/6/26 13:50, Li Zhe wrote:
> > On Mon, Jul 6, 2026 at 11:13:45AM +0200, david@kernel.org wrote:
> >
> >>> +static inline bool pagemap_resets_refcount(const struct dev_pagemap *pgmap)
> >>> +{
> >>> +	/*
> >>> +	 * MEMORY_DEVICE_GENERIC pages regain a refcount of 1 in the free
> >>> +	 * path. The remaining ZONE_DEVICE types start from 0 here and raise
> >>> +	 * the count again when the allocator or driver hands the page out.
> >>> +	 */
> >>> +	switch (pgmap->type) {
> >>> +	case MEMORY_DEVICE_FS_DAX:
> >>> +	case MEMORY_DEVICE_PRIVATE:
> >>> +	case MEMORY_DEVICE_COHERENT:
> >>> +	case MEMORY_DEVICE_PCI_P2PDMA:
> >>> +		return false;
> >>> +	case MEMORY_DEVICE_GENERIC:
> >>> +		return true;
> >>> +	default:
> >>> +		WARN_ONCE(1, "Unknown memory type!");
> >>> +		return true;
> >>
> >> Wouldn't the compiler warn if we would define a new type but forgot to update it
> >> here? We're using an enum, and I thought the compiler would bail out in that case.
> >>
> >> Or are we scared of some other garbage ending up in there?
> >>
> >> Apart from that LGTM.
> >
> > Thanks.
> >
> > I will drop the default case in v6 so a newly added enum memory_type
> > value is easier to catch during build review.
> >
> > I will move the WARN_ONCE() after the switch so we still keep a
> > runtime guard in case some invalid value ever shows up there.
> 
> If the compiler complains, we won't need the WARN_ONCE().

Thanks. I will drop the WARN_ONCE() as well in v6.

Thanks,
Zhe
