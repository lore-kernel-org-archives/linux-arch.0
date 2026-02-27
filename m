Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 099C336896F;
	Fri, 27 Feb 2026 10:09:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772186943; cv=none; b=Ctsute1NMv5d5jw3tQcwOeTVS2vTkM0T+Hhf0w0uLAc33X4lAXE257KeC6mjwUPlO6rhYj6d2a6HJTXdne9PZC4J9ZbvhlAh+1Lub+JUQYEPvTycMVrMysRyt8FzQsxQjZyl3oZYSyQ48Cvxmh7P1M91dnrqFJzK4Wb27V86pkw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772186943; c=relaxed/simple;
	bh=xFINqK9SmWf/rzC1HoDp+l6DTGSQscXf1afCHJLGF9Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DQ5Tk1zHEHFFw/fglSlj/a18um7lyd6Gv/1uZ0LhnFs+Mersrrt0tiXrr2cdEXuhmy0i6Ka62LXqtH8m43BnS/R91fAWX98ugsFV751jpzWnuP9J3CybmRkGUYJE58MeJznPrGIA7yFz0TiohXAj41ouWHlZjuDg6NBkJJC5x/Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fjAxocGS; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fjAxocGS"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DA942C2BC86;
	Fri, 27 Feb 2026 10:08:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772186942;
	bh=xFINqK9SmWf/rzC1HoDp+l6DTGSQscXf1afCHJLGF9Q=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=fjAxocGSfsizlTGEeRyT/9w8kG6RHUsTJbXrD7kwSbIzhl2K1uqX/AJKPl3bNt8XG
	 lkTg3/kWICjhheb1LBHx4Mk14VHehTTIaslqB3kLEp+ifo8I4hX/MWh73HentGsPq1
	 0FrIyNjPvj+VjWnRylpjPUHHLGppU7kn+igYm4c3dPh6mA6KVb/YBsZehC6nOglJKZ
	 xUVe5XIWL7TK4OAvaYBWWHfFC7w5IogNIrG7Z5C2fTCHro+s0kQHR3pov5cSzl+1N4
	 92mADU0sNt9PTp4ZuN2YaUnuMotOAlM4YpAAtBkct7qTXvVoFtsYxaYSGiioPUn4Fm
	 573MXFW+wFXDg==
Date: Fri, 27 Feb 2026 10:08:56 +0000
From: Conor Dooley <conor@kernel.org>
To: Rui Qi <qirui.001@bytedance.com>
Cc: paul.walmsley@sifive.com, palmer@dabbelt.com, aou@eecs.berkeley.edu,
	alex@ghiti.fr, cyrilbur@tenstorrent.com, tglx@kernel.org,
	peterz@infradead.org, debug@rivosinc.com, andybnac@gmail.com,
	charlie@rivosinc.com, geomatsi@gmail.com, thuth@redhat.com,
	bjorn@rivosinc.com, songshuaishuai@tinylab.org, martin@kaiser.cx,
	masahiroy@kernel.org, kees@kernel.org, linux-arch@vger.kernel.org,
	linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] riscv: add system error interrupt handler support
Message-ID: <20260227-scanner-trembling-5e41445f9e93@spud>
References: <20260226082735.56108-1-qirui.001@bytedance.com>
 <20260226-comprised-untold-1f2c0d2d48d6@spud>
 <2bc446a4-0082-4525-baab-0ac4c332cfa8@bytedance.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="+tjsKqlXNfeP48Lb"
Content-Disposition: inline
In-Reply-To: <2bc446a4-0082-4525-baab-0ac4c332cfa8@bytedance.com>


--+tjsKqlXNfeP48Lb
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 27, 2026 at 03:54:39PM +0800, Rui Qi wrote:
> On 2/26/26 5:22 PM, Conor Dooley wrote:
> > On Thu, Feb 26, 2026 at 04:27:35PM +0800, Rui Qi wrote:
> >> Add a system error interrupt handler for RISC-V that panics
> >> the system when hardware errors are detected. The implementation inclu=
des:
> >>
> >> - Add IRQ_SYS_ERROR (23) interrupt definition to CSR header
> >> - Implement sys_error.c module with panic handler
> >> - Register per-CPU interrupt handler for system error interrupts
> >> - Add module to kernel build system
> >>
> >> When a system error interrupt occurs, the handler immediately panics
> >> the system with a descriptive message to ensure the error is properly
> >> captured and the system is halted safely.
> >>
> >> Signed-off-by: Rui Qi <qirui.001@bytedance.com>
> >> ---
> >>  arch/riscv/include/asm/csr.h  |  4 +-
> >>  arch/riscv/kernel/Makefile    |  1 +
> >>  arch/riscv/kernel/sys_error.c | 80 +++++++++++++++++++++++++++++++++++
> >>  include/linux/cpuhotplug.h    |  1 +
> >>  4 files changed, 85 insertions(+), 1 deletion(-)
> >>  create mode 100644 arch/riscv/kernel/sys_error.c
> >>
> >> diff --git a/arch/riscv/include/asm/csr.h b/arch/riscv/include/asm/csr=
=2Eh
> >> index 31b8988f4488..1f43c25b07ed 100644
> >> --- a/arch/riscv/include/asm/csr.h
> >> +++ b/arch/riscv/include/asm/csr.h
> >> @@ -99,7 +99,8 @@
> >>  #define IRQ_M_EXT		11
> >>  #define IRQ_S_GEXT		12
> >>  #define IRQ_PMU_OVF		13
> >> -#define IRQ_LOCAL_MAX		(IRQ_PMU_OVF + 1)
> >> +#define IRQ_SYS_ERROR		23
> >=20
> > Hmmm, two problems I think with this. 23 is one of the interrupts that
> > has been reserved for use with AIA. I don't think they use it right now,
> > but in the future it might see use there.
> >=20
> > The first problem is kind of moot though, because reserving 16-23 for
> > AIA is a retcon, and previously these interrupts were available custom
> > use on any platform (as you have done here), so while it might be a
> > system error on your platform, it could be something completely innocuo=
us
> > on mine!
> >=20
> > With that in mind, does having this in arch code make sense at all?
> > Can this just be a normal driver, that'll only probe on your specific
> > platform?
>=20
> Thanks for the comment.
>=20
> I checked the latest RISC-V Interrupt Spec (2025-03-12). In that
> version, interrupts 16=E2=80=9323 are defined as architectural local inte=
rrupts,
> and interrupt 23 is tentatively proposed for a =E2=80=9CBus or system err=
or=E2=80=9D

Right, tentative is kinda no use to either of us though. Do you have
hardware that does this?

> type condition. That suggests this interrupt number is no longer just a
> free, platform-defined slot =E2=80=94 it now carries architectural intent=
 and a
> potential standardized meaning.

Emphasis on "potential", of course ;) Still a platform defined slot for
anyone that doesn't implement AIA, I think...
I don't understand the interaction between extensions and the priv spec
here, since the priv spec still says that 16 and higher are platform
specific.

> Given this context, my current implementation treats interrupt 23 as a
> local condition that matches the spec=E2=80=99s intent for a system-level=
 error
> signal, rather than an arbitrary, custom platform interrupt. This seemed
> reasonable as long as it aligns with the architectural semantics for
> local interrupts.
>=20
> That said, I=E2=80=99m open to the concern about placing this handling in
> arch/riscv, and I=E2=80=99d like to understand your preference: do you th=
ink
> this should be entirely moved into platform-specific code, or would a
> conditional, spec-aware arch implementation (e.g., gated on the presence
> of the relevant AIA/local interrupt support) be acceptable? Please let

It can't be gated on AIA, because AIA isn't the extension that says that
this is what interrupt 23 does (it specifically says that new extensions
are expected to define the use of the three interrupts "proposes"), and
we don't permit extension related stuff that is not frozen. I couldn't
find an extension at any stage that set the behaviour in stone, are you
aware of one? If one exists, a spec-aware arch implementation would be
okay. If one does not, you'll have to make this specific to your
platform until that extension shows up.

> me know what approach you=E2=80=99d suggest.

--+tjsKqlXNfeP48Lb
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCaaFtOAAKCRB4tDGHoIJi
0v+8AQDBNb2Yu6k8hiU8nJccWxtlj0Ulo99efQToPff2nKAhTgEA1Kv4Fr3s7MZ4
rNnLEypHbKIwRoY7IOt64iirHC5yFQc=
=Wpzl
-----END PGP SIGNATURE-----

--+tjsKqlXNfeP48Lb--
