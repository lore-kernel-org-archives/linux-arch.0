Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from vmicros1.altlinux.org ([194.107.17.57]:41830 "EHLO
        vmicros1.altlinux.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727039AbfDDOCD (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 4 Apr 2019 10:02:03 -0400
Date: Thu, 4 Apr 2019 17:02:01 +0300
From: "Dmitry V. Levin" <ldv@altlinux.org>
Subject: Re: [PATCH 4/6 v3] csky: Fix syscall_get_arguments() and
 syscall_set_arguments()
Message-ID: <20190404140200.GB4962@altlinux.org>
References: <20190401134104.676620247@goodmis.org>
 <20190401134421.121919570@goodmis.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="dTy3Mrz/UPE2dbVg"
Content-Disposition: inline
In-Reply-To: <20190401134421.121919570@goodmis.org>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: linux-kernel@vger.kernel.org, Linus Torvalds <torvalds@linux-foundation.org>, Ingo Molnar <mingo@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, Andy Lutomirski <luto@amacapital.net>, Roland McGrath <roland@hack.frob.com>, Oleg Nesterov <oleg@redhat.com>, linux-arch@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>, Thomas Gleixner <tglx@linutronix.de>, "Gustavo A. R. Silva" <gustavo@embeddedor.com>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org, Dominik Brodowski <linux@dominikbrodowski.net>, Andy Lutomirski <luto@kernel.org>, Kees Cook <keescook@chromium.org>, "Eric W. Biederman" <ebiederm@xmission.com>, Palmer Dabbelt <palmer@sifive.com>, Will Drewry <wad@chromium.org>, Guo Ren <guoren@kernel.org>
Message-ID: <20190404140201.4FnSJrVlzuOPZYKM1adireV4hGnKCTl-cmtZ5myf0pY@z>


--dTy3Mrz/UPE2dbVg
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 01, 2019 at 09:41:08AM -0400, Steven Rostedt wrote:
> From: "Dmitry V. Levin" <ldv@altlinux.org>
>=20
> C-SKY syscall arguments are located in orig_a0,a1,a2,a3,regs[0],regs[1]
> fields of struct pt_regs.
>=20
> Due to an off-by-one bug and a bug in pointer arithmetic
> syscall_get_arguments() was reading orig_a0,regs[1..5] fields instead.
> Likewise, syscall_set_arguments() was writing orig_a0,regs[1..5] fields
> instead.
>=20
> Link: http://lkml.kernel.org/r/20190329171230.GB32456@altlinux.org
>=20
> Fixes: 4859bfca11c7d ("csky: System Call")
> Cc: Ingo Molnar <mingo@redhat.com>
> Cc: Kees Cook <keescook@chromium.org>
> Cc: Andy Lutomirski <luto@amacapital.net>
> Cc: Will Drewry <wad@chromium.org>
> Cc: Guo Ren <guoren@kernel.org>
> Cc: stable@vger.kernel.org # v4.20+
> Signed-off-by: Dmitry V. Levin <ldv@altlinux.org>
> Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>

According to
https://lore.kernel.org/lkml/20190330004949.GA15705@guoren-Inspiron-7460/
the following tags could be added to this patch:

Tested-by: Guo Ren <ren_guo@c-sky.com>
Acked-by: Guo Ren <ren_guo@c-sky.com>


--=20
ldv

--dTy3Mrz/UPE2dbVg
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIcBAEBCAAGBQJcpg5YAAoJEAVFT+BVnCUIdTgP/Rm77MXR6eHh3/59ZVPESJzg
BcQDjaBmQo9TloF3Ykj5Bl7a7aHzWyBVjecJp57u0itrGGRrxuFGKekr2GDFjS0d
BbNIuHQEjx01MTPVolFxeVTpkB+tVLjVpkVou1GQ+YuPVyflKxashigXr7XpkaDI
3vKh4Ufj1TVJu+76gTHIONX57iwz5NyU2miNJ+6N53/agWMipEFdO/ZjEN4dm6lk
W5bSWVXKwvONHzUHf/4zByVc9qWXsTG/uXQjhieHCk22Jxin6TZbP41a0OJF2A89
FjHFdVzNmrX84IEeoXOSzBwA0oKboa+2bY4mMLkmB09EPRURtmJ97tKiOR3PFt+Z
v4bUhvI3Ri1+4rvl6hdLubGTmiEF9ixWUDZoYkHaDvS3w8IYTUZeu5ageO1lAts0
lz4kCCNuxN5sC46A0/wmNSdxDuWdd2B4eDZs2T+JcGJdjG3xTRAxYb3eYFISuksb
v+1CA50fQfZJ77fTcNqgUYja64iNpA+L0jic98Npl9XqODL2kpz2roeVFJd7A/3j
AMAmcvblmx22nIBTPuHi8wRhLsPDlTn/3LyAcastQQhNctGxBhjxHQBY75WNGshG
1pitcDV8Q52/rjtm9ZsoxJuueU4Yvs4skaWXVrIbmL46XULuN10oheH0b9YXFvDi
6T6VXgiXy9CmYHrM8fLa
=556p
-----END PGP SIGNATURE-----

--dTy3Mrz/UPE2dbVg--
