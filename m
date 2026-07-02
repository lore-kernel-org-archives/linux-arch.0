Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58C882EBDFA;
	Thu,  2 Jul 2026 02:25:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782959112; cv=none; b=XUPAVvz8DccGEvgopX4j9dq4v+uxLAn+JkYRvHJjy91H71afwOj767jUCXV6EZHLsy5w1rLOSMG3thrfBScg1Y2yCI7lPMCmcUry6D1w2Dqzu9D0RIbOqmUqpBcJVlc8PI+1qTEEpLdm86csKLWpzg0v0dkstR+93rY0si8eMmM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782959112; c=relaxed/simple;
	bh=D9KCWDqbEEidmOh/o4kKIt3LS2Y2X8MKR6LAfxljrME=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UwIv6Jx/NUEwxcJkG74HVIynmLQSp6NOzFDYTrO4qu15havnse1g/mBkcXzB8dfr15yeFsQMu95UyjZNBOMrIkfx/pCWXHjWEzVtoGhiIZgKP4GkBTO4PTjpHdfaJUnnb2kpsJ7I2ujOtaRva0OiYegXw1rBApx/h6F3Zkf5/Ig=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=fR+fzzIJ; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="fR+fzzIJ"
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 71E9B40E01B4;
	Thu,  2 Jul 2026 02:25:09 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id bWB6q0UW1WcZ; Thu,  2 Jul 2026 02:24:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1782959099; bh=gjv96nxdF7cSVwl1Zc5n3dulTwvFlJdKfLng4pKLP2Y=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=fR+fzzIJ9CalK/Mz2k16jL+nIWjWnO4YfRFDEIusbXVNNTFFg/pD9cIUNOAZg2BFz
	 pI/R7y31GGX8JIpz+6rNWIF9u+DQpX+n1Eeahkso5LLA+KWHLFPY+Go0YFzUY3lAGx
	 2dJLmuw7OsKKrODpYx2eYrzgYZMFWqo+lNt9jisaL14B3sQoNscqkiHU1DJsOZUh+b
	 o71+y3AhUWym+4qD6GxrvYXZHCoUBoTesnaZS8RlsULz78m3hClf4SHjraSNuz8OzU
	 9cEiYRLI1W+Tc7cDxDzwkWi7VciRHaBm5WWNtgqgCz+e49tIXbcEGU+MucxwqY1fZS
	 wUwF4rVSNbkjphaKGajNZLHLeNy0FP+YY5kuKxWCxiA+yvvxjUr3kYKbOyGrN+PYt2
	 KIDDVg0POSItRXbi3DO67zzjXAuYVozxJuu9RgFo/AuQ7C8LwN33MMCLRxIXdwhrOI
	 4WfcQ2cy2YvLu37iIJ/mQhvxGXNRJJaKjIgSEMxo53rZXiRa6c6yYNs2ebtlGaw9cN
	 679TvR0BoRjSBiBsYNIPDkGz4Gh0M8Toa9oruZXVStxq54x7FFdVGUTxglg4AzOAg6
	 wNWef2Dq8fDG0y4lBtnmAhUKF6k2h7imoSXnMhfm2oc16T9IYt9OECZ9S2IpkEmRwq
	 djNQgskWb6Y46+2RnaIICxgM=
Received: from stx.tnic (unknown [IPv6:2600:1700:38ca:c00::1a])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id BEB4D40E00C0;
	Thu,  2 Jul 2026 02:24:42 +0000 (UTC)
Date: Wed, 1 Jul 2026 19:24:39 -0700
From: Borislav Petkov <bp@alien8.de>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Li Zhe <lizhe.67@bytedance.com>, apopple@nvidia.com, arnd@arndb.de,
	dave.hansen@linux.intel.com, david@kernel.org, kees@kernel.org,
	mingo@redhat.com, rppt@kernel.org, tglx@kernel.org,
	linux-arch@vger.kernel.org, linux-hardening@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, x86@kernel.org,
	Balbir Singh <balbirs@nvidia.com>
Subject: Re: [PATCH v5 0/8] mm: optimize zone-device memmap initialization
Message-ID: <20260702022439.GGakXL5wfwQVSSzISL@fat_crate.local>
References: <20260701090553.62691-1-lizhe.67@bytedance.com>
 <20260701162808.f6701ef751f874b9ff1c1c85@linux-foundation.org>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260701162808.f6701ef751f874b9ff1c1c85@linux-foundation.org>

On Wed, Jul 01, 2026 at 04:28:08PM -0700, Andrew Morton wrote:
> I'll add it to mm.git for testing exposure (because I'm still a sucker
> for speedups), but more review is needed, please.

Yeah, it'll need more churn until it looks sensible.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
