From: James Hogan <james.hogan@imgtec.com>
Subject: Re: [PATCH 8/9] RISC-V: User-facing API
Date: Tue, 4 Jul 2017 00:06:39 +0100
Message-ID: <20170703230639.GY6973@jhogan-linux.le.imgtec.org>
References: <20170628224237.GO6973@jhogan-linux.le.imgtec.org>
 <mhng-21eaeea1-4cd1-43b1-9b2b-b664cea12d43@palmer-si-x1c4>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="nPYEf/DvajCvrriP"
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mailapp01.imgtec.com ([195.59.15.196]:28582 "EHLO
        imgpgp01.kl.imgtec.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1750803AbdGCXGl (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 3 Jul 2017 19:06:41 -0400
Content-Disposition: inline
In-Reply-To: <mhng-21eaeea1-4cd1-43b1-9b2b-b664cea12d43@palmer-si-x1c4>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Palmer Dabbelt <palmer@dabbelt.com>
Cc: peterz@infradead.org, mingo@redhat.com, mcgrof@kernel.org, viro@zeniv.linux.org.uk, sfr@canb.auug.org.au, nicolas.dichtel@6wind.com, rmk+kernel@armlinux.org.uk, msalter@redhat.com, tklauser@distanz.ch, will.deacon@arm.com, paul.gortmaker@windriver.com, linux@roeck-us.net, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, albert@sifive.com

--nPYEf/DvajCvrriP
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 29, 2017 at 02:42:38PM -0700, Palmer Dabbelt wrote:
> On Wed, 28 Jun 2017 15:42:37 PDT (-0700), james.hogan@imgtec.com wrote:
> > On Wed, Jun 28, 2017 at 11:55:37AM -0700, Palmer Dabbelt wrote:
> >> diff --git a/arch/riscv/include/uapi/asm/ucontext.h b/arch/riscv/inclu=
de/uapi/asm/ucontext.h
> >> new file mode 100644
> >> index 000000000000..52eff9febcfd
> >> --- /dev/null
> >> +++ b/arch/riscv/include/uapi/asm/ucontext.h
> > ...
> >> +struct ucontext {
> >> +	unsigned long	  uc_flags;
> >> +	struct ucontext	 *uc_link;
> >> +	stack_t		  uc_stack;
> >> +	sigset_t	  uc_sigmask;
> >> +	/* glibc uses a 1024-bit sigset_t */
> >> +	__u8		  __unused[1024 / 8 - sizeof(sigset_t)];
> >> +	/* last for future expansion */
> >> +	struct sigcontext uc_mcontext;
> >> +};
> >
> > Any particular reason not to use the asm-generic ucontext?
>=20
> In the generic ucontext, 'uc_sigmask' is at the end of the structure so i=
t can
> be expanded.  Since we want our mcontext to be expandable as well, we
> pre-allocate some expandable space for sigmask and then put mcontext at t=
he
> end.
>=20
> We stole this idea from arm64.

Curious. __unused seems like overkill to be honest given that expanding
the number of signals up to 128 causes other issues (as discovered on
MIPS e.g. the waitpid() status, with stopsig not fitting below the exit
code (shift 8) and core dump flag (bit 7)), but perhaps it could be
carefully expanded by splitting the stopsig field.

Looks harmless here I suppose so I defer to others. If it is the
preferred approach does it make sense to make it the "default" for new
architectures at some point?

Cheers
James

--nPYEf/DvajCvrriP
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEd80NauSabkiESfLYbAtpk944dnoFAllaze4ACgkQbAtpk944
dnqR+Q//QLpQpfsJiSMoLW2CWqUhk0wD14+7EOMu5+gTajP4KVjnO99ixfIWfws/
k2SWkX6gO78NMrRhwG+7Dl5+BqIDS+qRG6l4KkgR4M6mDwFRw//hh9NmkeDNtRvv
x4oTZYdMH7UQuOon6V5PnNgwM5U1usv0D8JT1wt3rwvTlAzq+W29xPV4gGUqARr/
Vbu/LeRdT30OmXWl1bAuZS8I6CfdnQfv8aMO2tNFKX0pg9Y+EyFFj3NpkLygFLii
KfJ05DGt2MnrShu4vEi044p3evugToMksVFsDf6zcTDJ0pS0Rtf7MeazHVL7KKyb
kEzjw7RT2HbqbaLLF4pT6KcZZ0ChzlBJ3nGKnbyVhjs9X5cRtFwHtslwiQ+uosFt
x2SUTM4MTTP8+0szxgQGCgC3U25xsfy99hZBqLi0wlXp6d5CByhpJQWdxtDNeENP
EA3ecyD12mgV/49igPOHP1h37sTIA+cmQakrbtNQbDCuaP1ORpNXV6UqzMTa49pL
8me8RQASr77KjxJAzY8UXJId/OUZMuyw5YzfF49AFHNpXTM/kC5cmSbC1Kthh5Dp
a5/EONxF04FhFoa1HS+VJxwbCUaj+yWfTEu3KTpYrPzSSFHHJB3BruRUywsfVfqJ
bcjXFlao2ZYgJQnAzNrOaTrjEmePLzwJFvdVrz6R7h4MU1l9z8Y=
=YUP2
-----END PGP SIGNATURE-----

--nPYEf/DvajCvrriP--
