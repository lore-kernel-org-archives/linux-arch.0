Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2BD736C9C2;
	Wed, 10 Jun 2026 19:19:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781119193; cv=none; b=YZNsCubW6+/4uH0BbiDk7jMLN8oqQXaAJuO0BP6gPEJD8rXdKgd7Tybgy9XbY6GfvvEYWKa3kxkbDGnPsUY10nIggAyq0Oj+c0y7CVlRy7PUlnJrV8dcO5STGyoG+PKdPFAcx4hiqqV/Gh4KJahnMJDEKFzIGA9OhNmMyfDvShI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781119193; c=relaxed/simple;
	bh=5J0IeNThya3UT08dAWzEzDsB32UrFOWKtcPSoW1ZZkQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fi24o85fIV6ZlBc3AnGS01KIw2wzPlwE2cVW1IabFQfcxFp8B0VCxoqdJbhtYwDfi97lZuF2qFC0pl9pnWyeyQJaW9uw7OKRUUa5uEKNeKa0GPBN6FFoEXorUDBrKKZ3iE1QCjOdbv/L7X+ts4JP7StAiT+drH9fTDsNRuhqsLg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=JceC9ePc; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="JceC9ePc"
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 4EBA340E0177;
	Wed, 10 Jun 2026 19:19:49 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id 8nyn0l_YIkCi; Wed, 10 Jun 2026 19:19:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1781119179; bh=JysIXdHqb/AfYm9Wq38SegXh3xO5K+ZoKmjZT9fhfWE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=JceC9ePcoFi7qjCMH22o5S3xFxLlydWzyZvW2u2eZHiksbHKuXbdnlx1p7ujPkotk
	 C6U9Up8ZdzWzvfl5udJAHcg3aUuEpkPEqQfE/CGCSQffYtmKnBguQ6WTj5WY4FQprz
	 kV+FpnxtiSQ0ivUNwWCVSZrJM1Hy1HoYuBh5r9Cco8R3hbMChgQrInyAdK+XhUy9PF
	 /UEj+kTvgroGGKCaoG7SwdwvyR/7DzCwqSW9d+iCodMCRxW8+psphgPVDq8ixaGDUB
	 E7T1v4mLvFr95/m3DqW6qxBPbxQuEOdb1hY3zfA1sZqitymqRXE4UrpkZB64mDuekD
	 Raqrr+fQ7MKy/jG8tQouQ3bqfof37zTlEZaeFNO78nEdLhQi+NgaPIFK12z5+lVNvr
	 3Ir2xmbh9mVSmV6m6buYFSw7v/EEWbJ0FXuqxR7+OOluS37N8Elk9L3NTDm7ODGKCA
	 NM9tHMpX6PhuDnI7dgOlgYafrusn2O2UbFI6Ap/ZApb1UeyiMQoi9oocL+K23R+k0Y
	 pIU3bYEMMK0Nqewco6E5Rv7TDUn0Ks7hioOYxvBhnx6sghZga+WLbk9gz1uL4KIBfC
	 NRqlI903GpRy75JLK1l+nska7lWTSoonARyvpSViO6PgrALz9sGL0dRvmL03edO1sc
	 IkpYbKVJMDMp8u/PzvVKuJoE=
Received: from stx.tnic (unknown [IPv6:2600:1700:38ca:c00::1a])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 8F43D40E01B5;
	Wed, 10 Jun 2026 19:19:23 +0000 (UTC)
Date: Wed, 10 Jun 2026 12:19:20 -0700
From: Borislav Petkov <bp@alien8.de>
To: Li Zhe <lizhe.67@bytedance.com>
Cc: akpm@linux-foundation.org, apopple@nvidia.com, arnd@arndb.de,
	dave.hansen@linux.intel.com, david@kernel.org, kees@kernel.org,
	linux-arch@vger.kernel.org, linux-hardening@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, mingo@redhat.com,
	rppt@kernel.org, tglx@kernel.org, x86@kernel.org
Subject: Re: [PATCH v4 6/8] string: introduce memcpy_streaming() helpers
Message-ID: <20260610191920.GBaim4uMX3z6OqJwHr@fat_crate.local>
References: <20260607190804.GAaiXBlGO2eRcfs1oB@fat_crate.local>
 <20260609120132.84323-1-lizhe.67@bytedance.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260609120132.84323-1-lizhe.67@bytedance.com>

On Tue, Jun 09, 2026 at 08:01:32PM +0800, Li Zhe wrote:
> That said, I see your layering point. If arch/x86/include/asm/string.h
> is the preferred place for the arch-visible wrapper, I can move the
> wrapper there in the next revision while keeping the x86_64-specific
> implementation details in string_64.h.

No, 64-bit only's fine. We don't put any new features into 32-bit already
anyway but that wasn't clear from the commit message what your goal is.

> Thinking about it more, I agree that this is hard to justify for a
> generic helper. For this series, what really matters is that the
> struct page copies in patch 8 can use the existing x86
> memcpy_flushcache() fastpaths where that is beneficial; I do not need
> patch 6 to impose extra selection policy on unrelated callers.

What I am asking is, you need to show numbers why those helpers exist.

Your 0th message is talking about measuring this in VMs. If this workload is
not VM-specific, then those numbers don't matter. They're just handwaving.

So I'd need a good justification why we need the changes before we go any
further.

HTH.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
