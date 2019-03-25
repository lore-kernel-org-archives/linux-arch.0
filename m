Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from vmicros1.altlinux.org ([194.107.17.57]:51594 "EHLO
        vmicros1.altlinux.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726203AbfCYP10 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 25 Mar 2019 11:27:26 -0400
Date: Mon, 25 Mar 2019 18:27:23 +0300
From: "Dmitry V. Levin" <ldv@altlinux.org>
Subject: Re: [PATCH] csky: Update syscall_trace_enter/exit implementation
Message-ID: <20190325152722.GA23169@altlinux.org>
References: <1553515419-1797-1-git-send-email-guoren@kernel.org>
 <20190325121754.GB19244@altlinux.org>
 <20190325124154.GA2653@guoren-Inspiron-7460>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="+HP7ph2BbKc20aGI"
Content-Disposition: inline
In-Reply-To: <20190325124154.GA2653@guoren-Inspiron-7460>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Guo Ren <guoren@kernel.org>
Cc: linux-arch@vger.kernel.org, ren_guo@c-sky.com, strace-devel@lists.strace.io, arnd@arndb.de, linux-kernel@vger.kernel.org
Message-ID: <20190325152723.YaOFd_RF1DObr4ula0B102-l996f7RKLD9pPolrfPmI@z>


--+HP7ph2BbKc20aGI
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 25, 2019 at 08:41:54PM +0800, Guo Ren wrote:
> On Mon, Mar 25, 2019 at 03:17:54PM +0300, Dmitry V. Levin wrote:
> > On Mon, Mar 25, 2019 at 08:03:39PM +0800, guoren@kernel.org wrote:
> > [...]
> > > diff --git a/arch/csky/include/uapi/asm/ptrace.h b/arch/csky/include/=
uapi/asm/ptrace.h
> > > index a4eaa8d..9bf5b1a 100644
> > > --- a/arch/csky/include/uapi/asm/ptrace.h
> > > +++ b/arch/csky/include/uapi/asm/ptrace.h
> > > @@ -62,6 +62,11 @@ struct user_fp {
> > >  #define instruction_pointer(regs) ((regs)->pc)
> > >  #define profile_pc(regs) instruction_pointer(regs)
> > > =20
> > > +static inline unsigned long regs_return_value(struct pt_regs *regs)
> > > +{
> > > +	return regs->a0;
> > > +}
> > > +
> > >  #endif /* __KERNEL__ */
> > >  #endif /* __ASSEMBLY__ */
> > >  #endif /* _CSKY_PTRACE_H */
> >=20
> > I wonder why we have this #ifdef __KERNEL__ code in the uapi namespace,
> > it defeats the idea of uapi.  Doesn't it belong to non-uapi
> > include/asm/ptrace.h namespace?
>=20
> Yes, I should move __KERNEL__ codes into arch/csky/include/asm/ptrace.h.
> But it'll be another patch for the modification. Any other problems?

=46rom UAPI perspective?  No, I don't see any more UAPI issues with the pat=
ch.


--=20
ldv

--+HP7ph2BbKc20aGI
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIcBAEBCAAGBQJcmPNaAAoJEAVFT+BVnCUIcrAP+wRDIzrJTdAGamQ3viXl2Hoc
mU2kNmYBr8p/xgLGeQsDNgiajI+ar0cklCjrXVJHP6A/H68GpVKuNNbVzo3znin6
xmauwBBDIHqFBMooTP+nkA8201GDhWW+Br/VKbf9SkD+qgDypcf9aYBxBBI7X4G+
ZTtAq1y3kEqsX+sUNKad381P5fUphd4vHow4B8NM9TQElS6dy0ztWrv6DIFVYWrl
BPNPWNAalsSYBxg6U2FYqfzGsx/ZGHDAfo/8NaGosi+lIvQzSBS+ZwRbBFCOhdpR
aqN8cyrZOmCAc8w0Z7DnoKP07Ex7D9C3Up0SPlsYpdL4CkBvFn+kF9zyN4jlKKC4
m+ErATsKYDWOOU816ONLGm/H3Y+UXwsYlZxLJ8ob/bTTBFqbbtg5e/cZM+KwqkBp
VYOzYw69JBwZ3K0sLy8egVf9jqJaMoGTcRmflYabFafSunG8Pu4l/M+tsodrqMye
W1rwa6CPjRLKTMWTIXGzt7rrup2s7a3pPp91JT/kzbceNHVa1bUah0OzbYpr7JTh
MHOzHmuqNiPctqWPwXtBDMetffUCr6Waf0yktrkV8cHtUU4sRG0seOZF8Uae2x0T
m70gRi4ustN2EkOLUnjUFw1pqPB9iAb3FsVckLbUfgiIZWUoRHAySrmEjtt6/eQy
xby6WSO+AlnXr2R5wdVr
=Lg4C
-----END PGP SIGNATURE-----

--+HP7ph2BbKc20aGI--
