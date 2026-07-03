Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F086E266EE9;
	Fri,  3 Jul 2026 19:56:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783108612; cv=none; b=X+TWhjfrQXja42E43TdEwyXgBLtWlwoaLd0CtoeX8A6JP/1zjWj8XdG/mF4Hfc8xi/5r4Fcdn2PJeAZxcgU0oVc5QK4BNSG12677XKkxN3fQVm4TRzanFHNiRYPDvFRRu4MJWNG3hUbGc1WtSbeV/HiDXlu+i8EqK8xKqJ3UY2E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783108612; c=relaxed/simple;
	bh=SM0OW7dWu+p2+grJqjD29tf+g1990+0LujxNw7uV7KI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IavaDUMnaG1LhYIGLqem33kY4mbzhjRJZbEevLwpkuzJ0YT02HewpYh7Uat+A8GYtoHF0IuDqAoJ195i5cqMzXbfygpX17C6bw8hWJnSGFuODhwukbllb7LvRMXayEdW/gyjsZITP2pTGfTxOP5+FuvbFIMBcbjin61YlHHE1wA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=fbhDnA/g; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="fbhDnA/g"
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id E8A7640E01DB;
	Fri,  3 Jul 2026 19:56:47 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id 591k-6jQHESx; Fri,  3 Jul 2026 19:56:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1783108598; bh=Ec4ooeB81VdLBBWoolmCjIrqAa/mMFqe7GUMG3eUFx0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=fbhDnA/gtOESnV9bPd2jExK58X/KJ+kXFtj7TALiu2D/pTjDmFF+sq2Q5S4GTDoZs
	 Rfn5fhAbaqjrt66z5m65Gp/yldPN4Ssmi5cPYyGdlTe7ZNjpcZ3Dqz/kW7Nv8iqp3b
	 QkedMrE1/YPFjPknxed4vUpV0fnVmvTJzrJP4xMkdqJ6SJh4znVRjFxk5eg7GcQxJi
	 cVXNsLkRf/3Z7BxcWNoQzn6i9aR8qN/ZGM7COx03LYky89jAHnso74jYMsfasa5dxU
	 ykabhvjrBh3QhJuoQb+/YvMbUeieDfz142B32N5wS7fFKGWBbYMj0D9HCGeoDCqUox
	 f4GDW8ngLep9gNMJO4JlDs7OfiBRnPIzjAScLuSOwZzLBwtwddJv9MRPUreHp6/aeA
	 kCGiRqVO7WuBnhYBqfdL4Wjxwp2m9JnFoqK+Ido2qLgLsQAzOwd3tyXTWCusWmy2RC
	 2Ks7tRaZj99L2v+VbpEXaKCbyZQMflIkx+YZ8cB1mJ2mXZ6HnKGSvAE56tLI6yRZi8
	 jLl9CP+mLFDS4mTQyW//oyD1Q9w4HDNZXnRCA6FNS1XukmTlJufSbpNlAL2KemskFr
	 OITG3TLxt6kcMu9wf16o/ao7qLJAcQ37ePi9aOi+X7Y4bVRkuGoYdm1DN4hN/VGOtk
	 tCVkVB1slPHiLCfzotXwxa1k=
Received: from stx.tnic (unknown [IPv6:2600:1700:38ca:c00::e])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 5108940E01CE;
	Fri,  3 Jul 2026 19:56:22 +0000 (UTC)
Date: Fri, 3 Jul 2026 12:56:19 -0700
From: Borislav Petkov <bp@alien8.de>
To: Li Zhe <lizhe.67@bytedance.com>
Cc: akpm@linux-foundation.org, apopple@nvidia.com, arnd@arndb.de,
	dave.hansen@linux.intel.com, david@kernel.org, kees@kernel.org,
	linux-arch@vger.kernel.org, linux-hardening@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, mingo@redhat.com,
	rppt@kernel.org, tglx@kernel.org, x86@kernel.org
Subject: Re: [PATCH v5 7/8] x86/string: extend memcpy_flushcache() fixed-size
 fastpaths
Message-ID: <20260703195619.GGakgT44P7lpcoMVlY@fat_crate.local>
References: <20260702022342.GFakXLrl7ryd-g7gTu@fat_crate.local>
 <20260702073750.73840-1-lizhe.67@bytedance.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260702073750.73840-1-lizhe.67@bytedance.com>

On Thu, Jul 02, 2026 at 03:37:50PM +0800, Li Zhe wrote:
> The relevant target sizes here are the x86_64 sizeof(struct page)
> values which patch 8 can hit: 64, 80, and 96 bytes.
> 
> On x86_64, CONFIG_HAVE_ALIGNED_STRUCT_PAGE keeps struct page 16-byte
> aligned. That gives 64 bytes in the common case, 80 bytes when
> WANT_PAGE_VIRTUAL or CONFIG_KMSAN adds extra fields, and 96 bytes when
> both are present. I stopped there deliberately because this series does
> not have a current caller which needs larger constant sizes.
> 
> The 32-byte and 48-byte cases were added only as intermediate fixed-size
> combinations used to build those larger struct page-sized copies while
> keeping them on the inline movnti path.

This needs to be in a comment over that code so that it is clear why that
distinction has been made.

> Yes. The separate helper is there exactly because the added
> 32/48/64/80/96-byte cases carry an extra 8-byte destination-alignment
> check, while I left the existing 4/8/16-byte inline cases unchanged.
> 
> The intent was to keep the larger fixed-size cases on the inline
> movnti path only when they already match the alignment assumptions
> used by __memcpy_flushcache(); otherwise they fall back to that
> out-of-line helper, which already handles the misaligned head/tail
> fragments before entering its movnti loops.

Why can't the larger MOVNTI sizes deal with misaligned cases too and thus make
the code even simpler and more straight-forward this way?

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
