Received: from outpost1.zedat.fu-berlin.de (outpost1.zedat.fu-berlin.de [130.133.4.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 857B239937C;
	Wed, 16 Sep 2026 19:16:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=130.133.4.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789586202; cv=none; b=UD+jrpZgTkHKPfHQ2yThPnwZfweP559bOniFZTVkGraufBHm3Lw9Sh+vC2bdcxEhukpv0Tlj0eAHZvHy+0UKrnyi6NBMaXPAEegOQJaVmZkWTL3zzijX0pf7Tcsr/8zVa1z03OTdZajsU+O2ZLBDwMXRbWfHrOsE6LaKz/sLZjI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789586202; c=relaxed/simple;
	bh=E+JtZUunUzEXcsAlzz+BmkdgXeDp3NCtoRLng5ShS/k=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=lO6y6Yf0KD0CWoEzNNZSdD6m3RoAwm1rd38CXEA0GDgA3tJ2clYY8nCcwWUmwNjZQ+h7j+CPnnie17k0RrIpp6w+ZEAXDdZN4tl2SK479/tqZVk8Z3GycOghmR1QJicIVNNNmj5mUdYI+KcTPEHEOgrTFMfE5oYtFbZj9dcQ9gM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=physik.fu-berlin.de; spf=pass smtp.mailfrom=zedat.fu-berlin.de; dkim=pass (2048-bit key) header.d=fu-berlin.de header.i=@fu-berlin.de header.b=PNJKfhKp; arc=none smtp.client-ip=130.133.4.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=physik.fu-berlin.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zedat.fu-berlin.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fu-berlin.de header.i=@fu-berlin.de header.b="PNJKfhKp"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=fu-berlin.de; s=fub01; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:From:
	Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:In-Reply-To:
	References; bh=KjWLBXziSfbMmjc+Wud8zKSR3wwT3IM7uisQyzdCm2k=; t=1789586186;
	x=1790190986; b=PNJKfhKpI5Hq7H0DkkAk9s4vGjBgmV1hzu2WU1Bke7v0lKQxcCfyg3QXAdxx6
	D9ZH3leM1djwTUfx3J4O/5vzrx/kplTye11Ix/QTbd6tBNcEIJcTmc+liM4KviQLPmFnospKRBTBW
	3wDInXHbmvcwJRMhLNnjx+AhzMiZQDHam80/0LxUuxK0L4UqZ0mASnbCgFjymW8j3NUGRyum3vprL
	9Lxl20/fAGkr86WSRJf3ChlDt5sAtR6OdA1GPlUJ3XoI+ULyd5dq8+cANJQcHYfbX5b8bYphvI1ay
	bZ4RKaAVO5M13XWXJycCrJWAJhy/YalfQQgolN8GZvY1MnDUyQ==;
Received: from inpost2.zedat.fu-berlin.de ([130.133.4.69])
          by outpost.zedat.fu-berlin.de (Exim 4.99)
          with esmtps (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@zedat.fu-berlin.de>)
          id 1x6v7B-00000001CYG-2LFT; Wed, 16 Sep 2026 21:16:17 +0200
Received: from p5dc55206.dip0.t-ipconnect.de ([93.197.82.6] helo=suse-laptop.fritz.box)
          by inpost2.zedat.fu-berlin.de (Exim 4.99)
          with esmtpsa (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@physik.fu-berlin.de>)
          id 1x6v7B-000000034Qk-19k9; Wed, 16 Sep 2026 21:16:17 +0200
Message-ID: <1835e3f1b7e936479964f5e40583133484510d25.camel@physik.fu-berlin.de>
Subject: Re: [PATCH 5/6] sh: Emulate two-byte cmpxchg
From: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
To: Bradley Morgan <brads@mainlining.org>, "Paul E. McKenney"
	 <paulmck@kernel.org>
Cc: frederic@kernel.org, neeraj.upadhyay@kernel.org, boqun@kernel.org, 
	joelagnelf@nvidia.com, rcu@vger.kernel.org, Andrew Morton	
 <akpm@linux-foundation.org>, Arnd Bergmann <arnd@arndb.de>, 
	linux-arch@vger.kernel.org, Vineet Gupta <vgupta@kernel.org>, 
	linux-snps-arc@lists.infradead.org, Russell King <linux@armlinux.org.uk>, 
	linux-arm-kernel@lists.infradead.org, Guo Ren <guoren@kernel.org>, 
	linux-csky@vger.kernel.org, Yoshinori Sato <ysato@users.sourceforge.jp>,
 Rich Felker <dalias@libc.org>, linux-sh@vger.kernel.org, Chris Zankel
 <chris@zankel.net>, Max Filippov	 <jcmvbkbc@gmail.com>,
 linux-kernel@vger.kernel.org
Date: Wed, 16 Sep 2026 21:16:16 +0200
In-Reply-To: <20260911192540.20983-6-brads@mainlining.org>
References: <20260911192540.20983-1-brads@mainlining.org>
	 <20260911192540.20983-6-brads@mainlining.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.60.2 
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Original-Sender: glaubitz@physik.fu-berlin.de
X-ZEDAT-Hint: PO

Hi Bradley,

On Fri, 2026-09-11 at 19:25 +0000, Bradley Morgan wrote:
> SH has no byte or halfword atomic memory operations, so the
> __cmpxchg() switch routes case 1 through cmpxchg_emu_u8() and
> lets case 2 fall through to __cmpxchg_called_with_bad_pointer(),
> which is declared but never defined, so a two-byte cmpxchg()
> fails at link time. Route case 2 through the new cmpxchg_emu_u16().
>=20
> Signed-off-by: Bradley Morgan <brads@mainlining.org>
> ---
>  arch/sh/include/asm/cmpxchg.h | 2 ++
>  1 file changed, 2 insertions(+)
>=20
> diff --git a/arch/sh/include/asm/cmpxchg.h b/arch/sh/include/asm/cmpxchg.=
h
> index 1e5dc5ccf7bf..477d3025a441 100644
> --- a/arch/sh/include/asm/cmpxchg.h
> +++ b/arch/sh/include/asm/cmpxchg.h
> @@ -59,6 +59,8 @@ static inline unsigned long __cmpxchg(volatile void * p=
tr, unsigned long old,
>  	switch (size) {
>  	case 1:
>  		return cmpxchg_emu_u8(ptr, old, new);
> +	case 2:
> +		return cmpxchg_emu_u16(ptr, old, new);
>  	case 4:
>  		return __cmpxchg_u32(ptr, old, new);
>  	}

Odd, I thought this series was merged long time ago. Was there anything hol=
ding it back?

Either way:

Acked-by: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>

Adrian

--=20
 .''`.  John Paul Adrian Glaubitz
: :' :  Debian Developer
`. `'   Physicist
  `-    GPG: 62FF 8A75 84E0 2956 9546  0006 7426 3B37 F5B5 F913
