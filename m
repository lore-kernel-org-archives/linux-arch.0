Received: from out-186.mta0.migadu.com (out-186.mta0.migadu.com [91.218.175.186])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00CA333A71B
	for <linux-arch@vger.kernel.org>; Mon,  3 Aug 2026 08:39:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.186
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785746397; cv=none; b=QR2RXonnodGf9LwXDDy92J8sXrZD3DJ4XN6SdJemxq47B0SAYnV3h9bjk+WomlRwfjUDFpWUhOMNyiBcRhUndgasBinkYVHXDT+oVKxmW8jFgvjNMS7VbIh8V0GmDJ9lMmkAhqsy8Lf3QJ0ogV5Yag9JHB91leMF7Hw5TT6Zj8s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785746397; c=relaxed/simple;
	bh=i84saUSnhw4dvsL73qjIQ2iV2KAmszYV6bPiQqIQTao=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=tEulU0SfTRBfG0wFECi9vkPaqwi4LHxnAJdEAS2BpSgb7fCw6hg6ObaumdPkqKB+vVLA/eHkusPNDjojOgkymBd72P8ut6lh/Ie0KqiAKmw/Al2RC/pxPMsl9R7DGnSANnrDxuYMUh/MCaS5vTW1xK9OOSXQ7yo3QIgjSzLosrU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=wdsCv7xa; arc=none smtp.client-ip=91.218.175.186
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="wdsCv7xa"
Content-Type: text/plain;
	charset=us-ascii
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1785746383;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wxNx4GDWUihrljy6qO1iXM0vV/PzaZT1gUMrOo4agVk=;
	b=wdsCv7xanZYH2lLaZyI3Sc9uLB26pn1JOIYwZ9hS4f3Niq4qYKa3hmPkDDPHMv9+KoyP+Y
	1uDDNrgwUZtRohVsWHI7XXn084qZG9U++C08ZGVFIM4PqRpGXoUfSixe5S5F3oTiX181l+
	AOf2bd5jSvafihaz7v81tiQb2XvwfhY=
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3864.600.51.1.1\))
Subject: Re: [PATCH v9 4/8] mm: add a template-based fast path for zone-device
 page init
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Muchun Song <muchun.song@linux.dev>
In-Reply-To: <20260803070929.86075-5-lizhe.67@bytedance.com>
Date: Mon, 3 Aug 2026 16:39:22 +0800
Cc: akpm@linux-foundation.org,
 apopple@nvidia.com,
 arnd@arndb.de,
 balbirs@nvidia.com,
 bp@alien8.de,
 dave.hansen@linux.intel.com,
 david@kernel.org,
 kees@kernel.org,
 mingo@redhat.com,
 rppt@kernel.org,
 tglx@kernel.org,
 linux-arch@vger.kernel.org,
 linux-hardening@vger.kernel.org,
 linux-kernel@vger.kernel.org,
 linux-mm@kvack.org,
 x86@kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <CB22DBB6-0B52-46C2-9A19-4A18A6F6DEC1@linux.dev>
References: <20260803070929.86075-1-lizhe.67@bytedance.com>
 <20260803070929.86075-5-lizhe.67@bytedance.com>
To: Li Zhe <lizhe.67@bytedance.com>
X-Migadu-Flow: FLOW_OUT



> On Aug 3, 2026, at 15:09, Li Zhe <lizhe.67@bytedance.com> wrote:
>=20
> memmap_init_zone_device() repeats nearly identical head-page
> initialization for each PFN. Prepare one reusable ZONE_DEVICE =
head-page
> template through the existing slow path, refresh the PFN-dependent
> fields in that template before each copy, and memcpy it into each
> destination page.
>=20
> Use the template path unconditionally, as suggested by Muchun. The
> page_ref_set tracepoint is primarily a debugging aid, while this code =
is
> still initializing struct pages before they are handed out. =46rom the
> perspective of users of those pages, the initialization-time refcount
> transitions are not part of the observable page lifetime.
>=20
> This means page_ref_set will no longer observe every =
initialization-time
> refcount assignment for copied ZONE_DEVICE head pages. The impact is
> controlled because the final initialized struct page state is =
unchanged,
> and keeping a separate non-template path only for this local =
tracepoint
> observability would add complexity to the common path.
>=20
> This patch accelerates head-page initialization. The pfns_per_compound
> =3D=3D 1 case gets the full benefit here, compound tails are handled =
in the
> next patch.
>=20
> Tested in a VM with a 100 GB fsdax namespace device configured with
> map=3Ddev on Intel Ice Lake server. This test exercises the nd_pmem =
rebind
> path (pfns_per_compound =3D=3D 1).
>=20
> Test procedure:
> Rebind the nd_pmem driver 30 times and collect the memmap =
initialization
> time from the pr_debug() output of memmap_init_zone_device().
>=20
> Base(v7.2-rc1):
>  Average of rebinds for nd_pmem driver: 244.28 ms
>=20
> With this patch and its prerequisites applied:
>  Average of rebinds for nd_pmem driver: 215.55 ms
>=20
> This reduces the average memmap initialization time measured during =
rebind
> from 244.28 ms to 215.55 ms, or about 11%.
>=20
> Suggested-by: Muchun Song <muchun.song@linux.dev>

I personally feel you might have used the wrong trailer here, because it
implies that the overall design is based on someone's suggestion. But =
for me,
I think what you actually meant is that in a previous version, I made a
suggestion about simplifying the code, rather than dictating the overall
direction of this entire patch series. So I feel I shouldn't be credited =
here.
This information is already enough just appearing in the change log.

Muchun,
Thanks.


