Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F241337BAB;
	Mon, 31 Aug 2026 23:45:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788219934; cv=none; b=TAxmA7j4JBdlhxiYxnO8nDFi0SZXqyO4DcIBNw8+FgSWckwPMdO4CNIcWojihSVmw1myEZP7PvqsdSFDitGvxqdo80CMuUSvjJn8+OiDsWQJu17hXBOq+ckW1+2Na7kphnZorfhGv8mPECmq1uMWcq97bhp0dZQd3TTaxUeYNIY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788219934; c=relaxed/simple;
	bh=KFg9Z+cYzf+wgTjB4jP0frPMbh2Dw+RY49DZZp2ECaA=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=bPaJkXa4Evdf7YAKvFNza53irfpJy+KukKbIl6a6gHeJEEaQKXmcuxYVs7fMdhe6JCjo2DLp2sMPKIy2GSN1KRJX/Yzufy/Zfr79nNAeXidH8/gSytACqp7JvWQIiUUWUCrSLyXxfaF7ejakuxcKndUhTrmXf1dNV/tgaUUcD/w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=Vhuqq3dh; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="Vhuqq3dh"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3B0781F000E9;
	Mon, 31 Aug 2026 23:45:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux-foundation.org; s=korg; t=1788219932;
	bh=wj4I/MKj2L9b4J+c08D7cj7b3uNtuGqLdKw3zvVsGww=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=Vhuqq3dhS0xj/pd9jp9IoVKDsg24dq5X2+kEEIBjB+a3vki3RCwS4uXdfJC4jqTXJ
	 thxERrpgvXlbZtgTioLwixWVxFgiZUzOmhCn0EbPB0XODc4QSl1IVOk2OzQ56ZULUD
	 D/eOxK4ZSBkWfhM21240hACSxmQV00dGRsxfsSsg=
Date: Mon, 31 Aug 2026 16:45:31 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: "Li Zhe" <lizhe.67@bytedance.com>
Cc: <apopple@nvidia.com>, <arnd@arndb.de>, <balbirs@nvidia.com>,
 <bp@alien8.de>, <dave.hansen@linux.intel.com>, <david@kernel.org>,
 <kees@kernel.org>, <mingo@redhat.com>, <muchun.song@linux.dev>,
 <rppt@kernel.org>, <tglx@kernel.org>, <linux-arch@vger.kernel.org>,
 <linux-hardening@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <linux-mm@kvack.org>, <x86@kernel.org>
Subject: Re: [PATCH v11 0/7] mm: optimize zone-device memmap initialization
Message-Id: <20260831164531.be5a8fa210401830e85eb974@linux-foundation.org>
In-Reply-To: <20260831111638.76012-1-lizhe.67@bytedance.com>
References: <20260831111638.76012-1-lizhe.67@bytedance.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 31 Aug 2026 19:16:31 +0800 "Li Zhe" <lizhe.67@bytedance.com> wrote:

> memmap_init_zone_device() can take a noticeable amount of time when large
> pmem namespaces are bound or rebound, because it initializes nearly
> identical struct page descriptors one PFN at a time. This series reduces
> that ZONE_DEVICE memmap initialization overhead by reusing prepared
> struct page templates and, on x86, using memcpy_nontemporal() for the
> template copy path.
> 
> ...
>
> This reduces the average memmap initialization time measured during
> rebind by about 48.0% for nd_pmem and 41.6% for dax_pmem on that arm64
> VM setup. Since this arm64 setup does not use the x86 MOVNTI fast paths,
> the result also suggests that the generic template-copy optimization can
> benefit architectures without an architecture-specific
> memcpy_nontemporal() backend.

Well that's nice.

Sashiko seems to have found some new things to complain about:
	https://sashiko.dev/#/patchset/20260831111638.76012-1-lizhe.67@bytedance.com


