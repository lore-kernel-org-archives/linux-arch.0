Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 352703F789D;
	Tue, 28 Apr 2026 11:00:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777374058; cv=none; b=K4TWcx2EwCrVt3HGP03jaYKfAlXW+cn6mU1kkiIf4cp8F3vHhq27caqxoVu8QpLD5clotbKbmbzj3KOx3nLoyrcjvQbrrY5YCTBROQReR+x1/kd0gMBOCNieXluggTOdXw9mkBgMCPZRbS66fjcw2R7s7zCQQ7ZGtgI7rJxQTaU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777374058; c=relaxed/simple;
	bh=xZI5npuq98CfITnXHb4A8HrkYEta0yZ5XbDryC76lrQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DXo/lJMssRfgBcIac1KZFptmRuUaB80ucO3BJKqBzd6MD/Mjixv6YF3AewFMzPIGe3lNzbyUL3skCmc5V71SaXgU+GQ5AcHgck6W1atJ/0VyflH9po8BJkVX9AI7epgg8f7pmYQ0Qp4/Su4JPdy3nv8ShfXXp3HRg4QiT2VvWYY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=BnbLYkmM; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=7U9zG0CL; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="BnbLYkmM";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="7U9zG0CL"
Date: Tue, 28 Apr 2026 13:00:54 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1777374055;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=XBGhq8AsscvIj+mH9lal8kMT11cGW5WaUiLHhyEg9Cg=;
	b=BnbLYkmMWIJt5VYkLwCdmQ60Q0X9uQlTWDCP7HP8/5OWBPyO5FaIv+KhxHC7SWW/fUPdqz
	+5GmE0FU/6RP0jFGAMKRpIKED1ulUDEQ1XZDeRcEnmfbHok4Wipd0or7EVnUP6vmQRn4nu
	dRRcQJE5gQwyYdrl9BDmpiW5WBl0h4KL1iZapdKnMQMG3uDKGV1f+5CmxsrfEBYUHeq4nm
	op2tVAUkJuFE1MyXvndOhSg5IOKNtZgLJh3+bl15iKUfNBdgkqZL4cn0eq72ogjoWmHsLu
	IDVMuW64PEGt1cd1h76IwXMnmiB+3dGtamdqFAPwpQQTSwvAnYjBDRxpAZAA1Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1777374055;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=XBGhq8AsscvIj+mH9lal8kMT11cGW5WaUiLHhyEg9Cg=;
	b=7U9zG0CLn0w8edytSvhyGI+M4MTTmvpY2+kYhI/KmQsZDhYbNYFkRJC8CUSuEQOFCvFeoD
	Bcx9hNwDJNsf8/Cw==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: =?utf-8?B?QW5kcsOp?= Almeida <andrealmeid@igalia.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>, Thomas Gleixner <tglx@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Carlos O'Donell <carlos@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Florian Weimer <fweimer@redhat.com>,
	Rich Felker <dalias@aerifal.cx>,
	Torvald Riegel <triegel@redhat.com>,
	Darren Hart <dvhart@infradead.org>, Ingo Molnar <mingo@kernel.org>,
	Davidlohr Bueso <dave@stgolabs.net>, Arnd Bergmann <arnd@arndb.de>,
	"Liam R . Howlett" <Liam.Howlett@oracle.com>,
	Uros Bizjak <ubizjak@gmail.com>,
	Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <linux@weissschuh.net>,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-arch@vger.kernel.org, kernel-dev@igalia.com
Subject: Re: [PATCH RFC v2 0/2] arm64: vdso: Implement
 __vdso_futex_robust_try_unlock()
Message-ID: <20260428110054.oQNT-kMn@linutronix.de>
References: <20260424-tonyk-robust_arm-v2-0-db4e46f752cf@igalia.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20260424-tonyk-robust_arm-v2-0-db4e46f752cf@igalia.com>

On 2026-04-24 15:55:59 [-0300], Andr=C3=A9 Almeida wrote:
> Hi folks,
Hi,

> This is my take on implementing the new vDSO for unlocking a robust futex=
 in
> arm64. If you don't know what's that, Thomas wrote a good summary,
> including the motivation for this work and the x86 implementation:
>=20
>    https://lore.kernel.org/lkml/878qb89g7b.ffs@tglx/
>=20
> There are some loose ends in my patchset so I'm sending as a RFC to ask
> some questions:
>=20
>  - If the process is interrupted between the labels, we need to check the
>  conditional flags and clear the op_pending address from the register. Us=
ing
>  objdump I see that op_pending addr is being stored at x2, but I suspect =
that
>  this isn't stable, so I need to figure out how to make sure that the add=
ress
>  will always be stored in the same register.
>  - So far I have implemented only the LL/SC version to make review easier=
, but I
>  can do the LSE version as well.

I am a bit behind here. In the meantime, were you able to check it with
	https://lore.kernel.org/all/20260404093939.7XgeW_54@linutronix.de/
?

Sebastian
