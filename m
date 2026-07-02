Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A64362853FD;
	Thu,  2 Jul 2026 02:16:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782958612; cv=none; b=ZImHDuWMoHlSdJvQm4TbOpZ7ywHfuZ7TKQ4mx2vbjeiPL3iQZczaFtn1OjWNeEG2U4mBDrWXPhjLmoQcMqF5de+0dZxlBO42en+Cu08xoHDaW+35iY7FMM0w2R9fuP+nX6RIinCPK6tvdmh0YgigOSbzYDJJLEZDMEU7JdY8cxQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782958612; c=relaxed/simple;
	bh=UXCBA2Bre4/bWySg1KvkyjGhklbsFGFnfXY9gyzqmJU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QIK3oSP7V4kEkpMxVGVzbRdrAD4FDlEWLITeKL7l2CJ2dQyIpI7hhVpIS7UbR0rjntfKKKwkcfodaEdCGFz9YbHjr/wgQhIA+vnYUNQBnwScWYFl2zoK9ymRG8UQEpeb7Wn3Fk7i8efmK583xaJo48PrgswjYmT9VkCLQ/rQl4k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=DJ20JY7s; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="DJ20JY7s"
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 6210A40E01B4;
	Thu,  2 Jul 2026 02:16:48 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id 8qrYl36SsMot; Thu,  2 Jul 2026 02:16:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1782958598; bh=U0ibtjdKS8/Jb1mPEb064Gd1FFp8S8EP9vMedmZd3dQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=DJ20JY7sQSmCBewgz8N5PqPWR9+U09bSWpydcI5HXfTet4cQvMhbJKW5VSw4i6xjB
	 9VI5tpedP/BwFLtOUVOcMweQNuXMfdFSjdAXn6eJ0PCrU2XqjVQ1ClhyXYm91QqezB
	 BWBxBhgCntE+LllJ9eI3gXQNdcBzT6kCX6jCDe0fRwyS5jwA6QLvgvSgHExdm4+ANc
	 EqWYH3ZDqfk8AYG+qNGddTsqrJQ0IkyPE2hjqMZGDrLtDUy4ECrSrwyMSTKOhgVwRs
	 LUUbQJDDRVx2dfqaba062lxJoKv4Wn9IKM1NBgcRXlg3o8lxWwjVusTeLEqJ7W+MC7
	 iOawLnpudAR3YuqT4/jIRUZd32Ucbul4mqqSMLsK+CIBFis+8dR4iAYJYEFAdpqZFs
	 dW+7xWlp8DBymok8tGte46Hsf+NiVujhE/VMj5uIxA9eT5ZR/jPDkWCHr3WwX4nUB8
	 EE85y77vQx77LWcizkjJ8JHZS4WTVUA2S1ZPpPT3bFJl5Tlb2Piynk6bZHdKlr0Y64
	 V6HDpIzSaZ6ayfPpNgI1huWSmN27DSyOsq7UEML5mkgEoJbaqpLmaQw+2qfCOadcso
	 Z0NrLTAP9BZi6REpw492LID8XOdObMxtgdyE2igruVR/oWldCk/EoUnX8RtvJdmlUw
	 VZSVQ4w4nHV9TF6a8e30Smfw=
Received: from stx.tnic (unknown [IPv6:2600:1700:38ca:c00::1a])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id BAB9540E016E;
	Thu,  2 Jul 2026 02:16:22 +0000 (UTC)
Date: Wed, 1 Jul 2026 19:16:19 -0700
From: Borislav Petkov <bp@alien8.de>
To: Li Zhe <lizhe.67@bytedance.com>
Cc: akpm@linux-foundation.org, apopple@nvidia.com, arnd@arndb.de,
	dave.hansen@linux.intel.com, david@kernel.org, kees@kernel.org,
	mingo@redhat.com, rppt@kernel.org, tglx@kernel.org,
	linux-arch@vger.kernel.org, linux-hardening@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, x86@kernel.org
Subject: Re: [PATCH v5 6/8] string: introduce memcpy_nt() helpers
Message-ID: <20260702021619.GEakXJ89-0rZcYGIq8@fat_crate.local>
References: <20260701090553.62691-1-lizhe.67@bytedance.com>
 <20260701090553.62691-7-lizhe.67@bytedance.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260701090553.62691-7-lizhe.67@bytedance.com>

On Wed, Jul 01, 2026 at 05:05:51PM +0800, Li Zhe wrote:
> +static __always_inline void memcpy_nt_drain(void)
> +{
> +	asm volatile("sfence" : : : "memory");

Doing a simple grep around the tree will give you the hint to use wmb() and
not reinvent the wheel here. Not to mention that this is bypassing KCSAN
instrumentation.

And then you don't need to go define this drain thing but simply use wmb()
because, oh, look, other architectures already define a write memory barrier
too.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
