Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84230423EAD;
	Mon,  3 Aug 2026 21:40:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785793216; cv=none; b=Gga6pwMCuW2uudKm3Lr1WHkHU0Md150gHUnoFM5Rj6qLDlF2PQGmhiqasUEedLRVVH/u8cQKNDTG4arPmeLiSHv5OIIGAff1RleCWAQzVQSqNQT8M9ZULuG4w8lqLfPBbAmTCeVoQ4ciCZVYs10k+tdmWa/YzBs5k5eBJg0GI1Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785793216; c=relaxed/simple;
	bh=RYf0Vk7HpgGzTEMnWibiUVTfVRPCd90w8eHopp9oViQ=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=SLSFXb0lCd0teZGLOxHSBJyzc+NFb+xfBhqmxXRrnv4S/Mprtx4nvWqSJLDMf9RK1Hohi8TasUmo36DS51nxm1hke3KoHGTLqoC98nq2v31C286hYHF+DsJp4tTRB0Nwu3yHkB7VAKuDDcDR4B6rxuGFdPFfusyZnpST3Ekr8cU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=b6VwgqfI; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="b6VwgqfI"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8F4171F000E9;
	Mon,  3 Aug 2026 21:40:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux-foundation.org; s=korg; t=1785793215;
	bh=+Bg2LdVq1/Og7fOxQWrSuRusd4/7PR3QXSV1Hts0A/w=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=b6VwgqfILcG8FeFaIWu+DpKiAAl03QgVszTQCrSWT8MAKoNwAbNTlkxRN3uWu50yP
	 NJZ50HtAspJQ2DQlmn8EcJUwz7pLZ2M9ff26SidVSUGVu/s+V1ZwZF8BIh+f8YCjzw
	 F54QgJLm49aXZwLS2fQZ3AegJIsn4oU9jZnbSqdo=
Date: Mon, 3 Aug 2026 14:40:14 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: "Li Zhe" <lizhe.67@bytedance.com>
Cc: <apopple@nvidia.com>, <arnd@arndb.de>, <balbirs@nvidia.com>,
 <bp@alien8.de>, <dave.hansen@linux.intel.com>, <david@kernel.org>,
 <kees@kernel.org>, <mingo@redhat.com>, <muchun.song@linux.dev>,
 <rppt@kernel.org>, <tglx@kernel.org>, <linux-arch@vger.kernel.org>,
 <linux-hardening@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <linux-mm@kvack.org>, <x86@kernel.org>
Subject: Re: [PATCH v9 0/8] mm: optimize zone-device memmap initialization
Message-Id: <20260803144014.e2d4ebb83e9471b695f6290d@linux-foundation.org>
In-Reply-To: <20260803070929.86075-1-lizhe.67@bytedance.com>
References: <20260803070929.86075-1-lizhe.67@bytedance.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon,  3 Aug 2026 15:09:21 +0800 "Li Zhe" <lizhe.67@bytedance.com> wrote:

> Test procedure:
> Rebind the nd_pmem and dax_pmem drivers 30 times and collect the memmap
> initialization time from the pr_debug() output of
> memmap_init_zone_device().
> 
> Base(v7.2-rc1):
>   Average of nd_pmem rebinds: 244.28 ms
>   Average of dax_pmem rebinds: 273.31 ms
> 
> With this series applied:
>   Average of nd_pmem rebinds: 96.79 ms
>   Average of dax_pmem rebinds: 119.04 ms
> 
> This reduces the average memmap initialization time measured during
> rebind by about 60.4% for nd_pmem and 56.4% for dax_pmem.

Well that's nice.

Review is partial and it's late in the cycle so I'd prefer to schedule
this for the next -rc cycle.

AI review might have found a couple of things, please check?
	https://sashiko.dev/#/patchset/20260803070929.86075-1-lizhe.67@bytedance.com
