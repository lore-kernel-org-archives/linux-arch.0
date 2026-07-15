Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3C4F42CB14;
	Wed, 15 Jul 2026 11:06:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784113582; cv=none; b=Tn/CHWu4SFRGxJCtjWDxHqhHTS5pDXqnqp5w4Rk6foxU06oWDNyvYYjK6OMPK5271vwtHycbQUWG/guph7AvO3J8p3MMtPL1xhFqXK0AkO27+CVM9oew551PT7AdDvlTUr+fxdnjccNYa1ME6ob2MSM95Wx1dXcWZF5dVuUusZI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784113582; c=relaxed/simple;
	bh=YXhGJJQTqFNt/77iJA7WI2RXUNccPNHDOnaD2kOemiQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=i5mSKr/2SA9tyc06S8Q8xpo9MfcT0dF9kbPe6lgGObaM6bjff/H4SFZErKh5WujhjxgiP3ZcpopkqjNOMhrb+ZN4UiOzTxuiQi1tFbI1VzZkjfc5/rKbTl7+l5RgKTt9RYCtDOOThzIWFdaa0AbewK6amSj2ne/vVFbmZ9OlcVc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=1Q56+mb7; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=nOtaw3lp; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="1Q56+mb7";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="nOtaw3lp"
Date: Wed, 15 Jul 2026 13:06:13 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1784113578;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=abtaHT+iM35mYhuUa0tFLYJlMk0dWSVeeSAZanDwdRY=;
	b=1Q56+mb7FdmVtn2LseSeElkRG3+cBY0sq+4sHmMi4f8/OYZeRDvn1QWWrZVvm20Zwt/i4f
	KIAA0hrOKzDmyvz4S23yrhyGLvIZRCmqbK+lXs/vw4EjtvY9TwvhZrT4SFIwRbcXWM36Ht
	NmjV4QYTqhBT0YhtgNxnFx6ChnesB2qT9OWe/2+huuby5ySLYRSKFQRlSsc4USNKEHvEMi
	v4Tbe6bg1sDx1548467nYT8272WMWIWeM/13hn+CeQ/BZRsGYQYYl/Rco/ZQ76vm/D2z8M
	f33HH8nfd7NC54hsaeEvjSE4xgoRbcPGNpKluhrSbacyRWjKndBZcwb8z7d+wQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1784113578;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=abtaHT+iM35mYhuUa0tFLYJlMk0dWSVeeSAZanDwdRY=;
	b=nOtaw3lpuc2tTTbVyR+QigURKy+xRCGuJurFvmtVUN0XYRnH+u6fxhtm7hTWCKyZxAd+BQ
	tpHoDvSyj+3BCeCA==
From: Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
To: Arnd Bergmann <arnd@arndb.de>
Cc: Thomas Gleixner <tglx@kernel.org>, Andy Lutomirski <luto@kernel.org>, 
	Vincenzo Frascino <vincenzo.frascino@arm.com>, Nathan Chancellor <nathan@kernel.org>, 
	Nicolas Schier <nsc@kernel.org>, Thomas Bogendoerfer <tsbogend@alpha.franken.de>, 
	Daniel Lezcano <daniel.lezcano@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	Marc Zyngier <maz@kernel.org>, Paul Walmsley <pjw@kernel.org>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
	Alexandre Ghiti <alex@ghiti.fr>, Huacai Chen <chenhuacai@kernel.org>, 
	WANG Xuerui <kernel@xen0n.name>, Linux-Arch <linux-arch@vger.kernel.org>, 
	linux-kernel@vger.kernel.org, linux-kbuild@vger.kernel.org, linux-mips@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-riscv@lists.infradead.org, loongarch@lists.linux.dev
Subject: Re: [PATCH 3/7] MIPS: csrc-r4k: Replace CONFIG_GENERIC_GETTIMEOFDAY
 ifdeffery with IS_ENABLED()
Message-ID: <20260715125715-5f101707-9307-4e7a-a8eb-698c42aadb21@linutronix.de>
References: <20260709-vdso-arch-clockmodes-v1-0-3fd780bbf851@linutronix.de>
 <20260709-vdso-arch-clockmodes-v1-3-3fd780bbf851@linutronix.de>
 <87wluwoe1c.ffs@fw13>
 <20260715102751-d1ed7195-f541-484e-9843-73ee4237b7b5@linutronix.de>
 <ee62c755-a15a-41e8-b0bb-7595e9366977@app.fastmail.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ee62c755-a15a-41e8-b0bb-7595e9366977@app.fastmail.com>

On Wed, Jul 15, 2026 at 12:13:06PM +0200, Arnd Bergmann wrote:
> On Wed, Jul 15, 2026, at 10:43, Thomas Weißschuh wrote:
> > On Wed, Jul 15, 2026 at 10:25:19AM +0200, Thomas Gleixner wrote:
> 
> >> -#ifdef CONFIG_GENERIC_GETTIMEOFDAY
> >>  #include <asm/vdso/clocksource.h>
> >> -#endif /* CONFIG_GENERIC_GETTIMEOFDAY */
> >>  enum vdso_clock_mode {
> >>  	VDSO_CLOCKMODE_NONE,
> >> -#ifdef CONFIG_GENERIC_GETTIMEOFDAY
> >> +#ifdef VDSO_ARCH_CLOCKMODES
> >>  	VDSO_ARCH_CLOCKMODES,
> >>  #endif
> >>  	VDSO_CLOCKMODE_MAX,
> >> 
> >> and then you can just unconditionally set clocksource::vdso_clock_mode
> >> in all drivers.
> >> 
> >> No?
> >
> > It will weaken the sanity check in __clocksouce_register_scale() if
> > CONFIG_GENERIC_GETTIMEOFDAY=n. I am not sure what that sanity check
> > is supposed to protect against, so I left it as is.

See [0], where HAVE_GENERIC_VDSO is now VDSO_DATASTORE.
The naming "generic vDSO" does not make much sense anymore.
There are different pieces which are used in various combinations.

> Is there still a reason to even allow CONFIG_GENERIC_GETTIMEOFDAY=n
> when  generic VDSO is enabled? I see that loongarch32 and
> riscv32 are still missing the vdso time support, but that may
> be more a sign that nobody cares enough about performance
> on those targets.

> In particular, riscv64 doesn't even build the vdso32 code for
> compat tasks, which indicates that userspace doesn't actually
> need vdso.

It doesn't build the time bits. But it has the hwprobe bits,
which do need the datastore (which is effectively HAVE_GENERIC_VDSO).

> On loongarch32, the commit adding the vdso said
> GENERIC_GETTIMEOFDAY 'will be supported in future'.

I have no idea if this port is even functional right now.
So far I was unable to run it in QEMU.

> On everything else, GENERIC_GETTIMEOFDAY and HAVE_GENERIC_VDSO
> are already synonyms.

[0] https://lore.kernel.org/lkml/20260709-vdso-have_generic_vdso-v1-0-d2e1061f268b@linutronix.de/
