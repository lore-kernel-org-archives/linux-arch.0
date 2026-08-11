Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D735A396D1C;
	Tue, 11 Aug 2026 19:47:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786477634; cv=none; b=hUuZmUB0BDKaZ4EVWsEmNEN7WfaXnzJ5AUnMlObCkkcFpfw82gJ3/VxnWhlQnKBJqxHt5lRK4U9fRio+jKt+pXa0j6VXc6E9LyHnuFh/NuKfj+/0/x+JzWwWW/lhzQ1SPptporzeMd4HzTxtLOl5pIuTwgUz13CQs0dvzKVSI3o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786477634; c=relaxed/simple;
	bh=4rALHgNYPYNYyfuRdnoi21ZfIZSdZYk9GWsUFQCCJrg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Hl0q3DXwI6BIpn3G/ZQWSOe5BZ5a2GDLdpT/pRc6K2eB5YH8ra93xhArXw23Wt75vprbEfHVMpxvajFLvGNGlI9bn9xU1fMxfeqXBl76JmrX5qxONXBUeZIxTgY5H/97m4mCqlz4RDYHbt4PsgFTtDo3+iL6R2Xh3mncThYhgqk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=lEWLx2DJ; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="lEWLx2DJ"
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 06C9740E019C;
	Tue, 11 Aug 2026 19:47:07 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id faVIp7MZ5ZKS; Tue, 11 Aug 2026 19:46:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1786477615; bh=BlXSLUlIACbCo1CYAl6qQKtQGar/xLkA/Fwfj1CIbk0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=lEWLx2DJlfcAE+5czMjnyrf2q0Awz3QSjJak0ELLkESNmzfDXZeAL5PjYk+p9cWfH
	 oCfFz9JjsFiDrzBKGbjUkPpqSUZubOPIjb9nsLxUm8uVB/h+z/QHKjuSnNwz4jb0MM
	 tDmJNncyp8c1TZJgw569dgnGERXhq2gFFmX9fLMWhOQ9i4D2jxDmSWkiJIKMzu3OBc
	 /cttvTz4+FIAW/4d8x3b54YWoNE5Bn9asJE0JKcsP4bkkGfLAvjiN3mlXPv82DMVQo
	 aRQUMNM5sRjPbzvdICyXdYVqyUg9FhnRW4veaqXAxj+tiLrWZUQVVMxuiiKAVajPSQ
	 /2DLkSiqAfHNcJRbmYIm55GTg4phm/9H+XMvyxOYoLbpabte9F+gGqqqwuj0GpV/3Y
	 +8jW/BNyqci/op26P4gB6kiN48jXY0WkpLgvvX+E2lbFrbaIHkiMJ6/fCAu1yfpwaz
	 21uL+B563QVnJ0la3I5WiEVbB7C+zKx4nYu7fYxkB4SWtIm6eIWAsgyKfwjrzY+u7d
	 C8gkGKPDNI8btG3UVcWGNvlFPhDkY5ZjemmQFEWlXF/Py1lhDQfZVPvIvOi0WIFZdD
	 vNzuJtdOBfQZhW8fym4rlPJu90+aZIFHJFwSi/0BytlPM17V9lGLUQKQ0wiKSWL0DL
	 Dna5N1+0oKeXM8XRb0JhYfQc=
Received: from stx.tnic (unknown [IPv6:2600:1700:38ca:c00::1b])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 3CAB540E00E6;
	Tue, 11 Aug 2026 19:46:38 +0000 (UTC)
Date: Tue, 11 Aug 2026 12:46:34 -0700
From: Borislav Petkov <bp@alien8.de>
To: Li Zhe <lizhe.67@bytedance.com>
Cc: akpm@linux-foundation.org, apopple@nvidia.com, arnd@arndb.de,
	balbirs@nvidia.com, dave.hansen@linux.intel.com, david@kernel.org,
	kees@kernel.org, mingo@redhat.com, muchun.song@linux.dev,
	rppt@kernel.org, tglx@kernel.org, linux-arch@vger.kernel.org,
	linux-hardening@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-mm@kvack.org, x86@kernel.org
Subject: Re: [PATCH v10 8/8] x86/string: extend memcpy_flushcache()
 fixed-size fastpaths
Message-ID: <20260811194634.GBant8GqpdMeXP5GsO@fat_crate.local>
References: <20260810122057.30447-1-lizhe.67@bytedance.com>
 <20260810122057.30447-9-lizhe.67@bytedance.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260810122057.30447-9-lizhe.67@bytedance.com>

On Mon, Aug 10, 2026 at 08:20:57PM +0800, Li Zhe wrote:
> The x86 memcpy_nontemporal() helper maps to memcpy_flushcache(), and the
> ZONE_DEVICE template-copy path uses it to copy one struct page at a
> time.
> 
> The relevant copy size is sizeof(struct page). On x86_64, the base struct
> page layout is 64 bytes. Adding either the KMSAN metadata pointers or an
> out-of-flags last_cpupid field can make it 80 bytes after alignment, and
> enabling both can make it 96 bytes.
> 
> memcpy_flushcache() currently only has inline fixed-size cases for 4, 8,
> and 16 bytes. As a result, these constant-sized struct page copies fall
> through to __memcpy_flushcache() even though the compiler knows the copy
> size at the call site.
> 
> Add fixed-size MOVNTI cases up to 96 bytes so the ZONE_DEVICE
> template-copy path can keep these struct page copies in the inline
> memcpy_flushcache() path.
> 
> This matters for ZONE_DEVICE memmap initialization because the copy
> happens once per initialized struct page. For a 100 GB fsdax namespace
> with map=dev, this is about 25 million struct page copies during nd_pmem
> binding or rebinding.
> 
> Tested in a VM with a 100 GB fsdax namespace device configured with
> map=dev and a 100 GB devdax namespace (align=2097152) on Intel Ice Lake
> server.
> 
> Test procedure:
> Rebind the nd_pmem and dax_pmem drivers 30 times and collect the memmap
> initialization time from the pr_debug() output of
> memmap_init_zone_device().
> 
> With memcpy_nontemporal() used by the ZONE_DEVICE template-copy path:
>   Average of rebinds for nd_pmem driver: 150.83 ms
>   Average of rebinds for dax_pmem driver: 153.55 ms
> 
> With this x86 fixed-size fastpath patch applied:
>   Average of rebinds for nd_pmem driver: 96.79 ms
>   Average of rebinds for dax_pmem driver: 119.04 ms
> 
> This further reduces the average memmap initialization time measured
> during rebind by about 35.8% for nd_pmem and 22.5% for dax_pmem.
> 
> Suggested-by: Borislav Petkov <bp@alien8.de>
> Signed-off-by: Li Zhe <lizhe.67@bytedance.com>
> ---
>  arch/x86/include/asm/string_64.h | 71 +++++++++++++++++++++++++-------
>  1 file changed, 56 insertions(+), 15 deletions(-)

Acked-by: Borislav Petkov (AMD) <bp@alien8.de>

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
