Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 543FD3B7779;
	Mon,  6 Jul 2026 17:19:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783358376; cv=none; b=GDOU7pJTlDKUA3fC7wSy5SE60km3lr6J8KHSluEgHj/cO8q98SbJl2rZ7FrKvljUNsE9427TEHD6iz2ZeH7kaScrpjBwtvWZVkv9nIbN1TtDyOTmyMExTdTSBsZLfpBIVFmg450oPOQtB7hdh39Mocs+YqLoatAczpU2kwzKa2c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783358376; c=relaxed/simple;
	bh=L0L0FF9JzdvaxhZgwZNkOjyWh3L8/Q+Sd6PJuQ5Xyec=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RQh4/f6QUdu6t28q3Xf/Bnge7uLVF6Z5oC3Tw4W+iVxmqpKsV3lS4i8vhu64NkhBlXJzxv6euj8rHdkRNgb6N2bfgNWKAqE5ETujbMaQPwL0i7fAxilo1rtCITLztIcmnvzk+zQx0yp28rS9PgcCpGOiIe5kolJOpv7sRjBMobs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=bpaFdjdu; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="bpaFdjdu"
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 218C640E00C0;
	Mon,  6 Jul 2026 17:19:31 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id XZjjGk29IVBx; Mon,  6 Jul 2026 17:19:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1783358361; bh=DM6ZBlt0zfO3Oxu5g1xHzady00ujWkiGTPHBW0POuGI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=bpaFdjdu7MeLFpwxJSUxbUN2zFVzHvpjeEX3yENf0gapDgpb38KuOEddMkkTXgf70
	 cAj1hYFfp60+FBEfB5QeUs5VzgHkUzDJsrRW8joss+DYyzGCkn+b4FMhTOj2Y0Mr1T
	 r89df/BS4pK6QPE0w+EpspS1EbTTvetdE7yZIsU//NDMqTNPjeUFrmXvy/E6LDXKVc
	 1/9GgGFZ8wx5g2OjcepRtDSMLK7tucXC+moW5Z8+PpRGMO0r4gO04rmtUi6ZhTC9/P
	 cQ9HrtVv7dGJt1aKdQRVkLPcu3e++nk5LZELNGuse4WvsCtIjtzGPt9btDmBUEeUA/
	 A0wTRpBQYIRKviTCwHHkK53tjSPK0cR6ZdSk29JBmET8hQhUtOe1Cfzf2s8Gsq6XrH
	 mJXQpN44UKQAF1SfZxdiQrV1IFLXBzgqM6AiM1s2X0iFBM1JRw9Eqj5qr3cgIoWo1J
	 kJJMK9UNBs7jGIiqEY5KGNINByS0yHLhZ7d7bTMy0MJbWDcCyzKrQOfVnTta9A+kCv
	 316Zx1nxDKYFZhcDEqCR2xq2UVwSr8ae8A2lecRPap07vDNDKU1cE2LBaEqMDBAwrg
	 axWuu6/TE2eI7hoDEKQuOlIByonIR+JnhhcvGra6UrfiODroSgRg6g0IVQISQ2qptm
	 xyobEQ+SWKLbhNsbJqxa0V4o=
Received: from stx.tnic (unknown [IPv6:2600:1700:38ca:c00::42])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 826F640E00DC;
	Mon,  6 Jul 2026 17:19:05 +0000 (UTC)
Date: Mon, 6 Jul 2026 10:19:02 -0700
From: Borislav Petkov <bp@alien8.de>
To: Li Zhe <lizhe.67@bytedance.com>
Cc: akpm@linux-foundation.org, apopple@nvidia.com, arnd@arndb.de,
	dave.hansen@linux.intel.com, david@kernel.org, kees@kernel.org,
	linux-arch@vger.kernel.org, linux-hardening@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, mingo@redhat.com,
	rppt@kernel.org, tglx@kernel.org, x86@kernel.org
Subject: Re: [PATCH v5 7/8] x86/string: extend memcpy_flushcache() fixed-size
 fastpaths
Message-ID: <20260706171902.GCakvjhl5U89iJdaNP@fat_crate.local>
References: <20260703195619.GGakgT44P7lpcoMVlY@fat_crate.local>
 <20260706074346.23928-1-lizhe.67@bytedance.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260706074346.23928-1-lizhe.67@bytedance.com>

On Mon, Jul 06, 2026 at 03:43:46PM +0800, Li Zhe wrote:
> The extra IS_ALIGNED() check is meant as a conservative performance
> choice, not because MOVNTI itself would be invalid on a misaligned
> destination.

Dude, you can't just wait for me to pull every unobvious decision in the code
out of you - you need to write it down in your commit messages! I'm not a mind
reader, you know.

> As the Intel optimization reference manual notes, higher-throughput
> data movement usually comes with alignment considerations, and can
> be more efficient when the destination is naturally aligned.

This can't get any more vague.

> So for these larger fixed-size cases, I kept the inline path limited
> to the aligned case. For misaligned destinations, falling back to
> __memcpy_flushcache() is expected to be the better choice, since it
> already handles the unaligned head first and only then enters its
> MOVNTI loops.
> 
> I will make that rationale explicit in the code comment and commit
> message in v6.

No, you need to show whether the alignment brigns anything and then add it or
remove it. We don't do things based on hearsay in the kernel - only on hard
performance numbers.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
