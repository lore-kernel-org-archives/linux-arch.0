Return-Path: <arnd@arndb.de>
Received: from natsmtp00.rzone.de ([81.169.145.165]:43239 "EHLO
	natsmtp00.rzone.de") by vger.kernel.org with ESMTP id S263028AbUESMX2
	(ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Wed, 19 May 2004 08:23:28 -0400
From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH] fixing sendfile on 64bit architectures
Date: Wed, 19 May 2004 14:21:48 +0200
References: <20040519114940.6b92cf1a.ak@suse.de>
In-Reply-To: <20040519114940.6b92cf1a.ak@suse.de>
MIME-Version: 1.0
Content-Type: multipart/signed;
  protocol="application/pgp-signature";
  micalg=pgp-sha1;
  boundary="Boundary-02=_fF1qAGIJN+c9J4G";
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200405191421.51310.arnd@arndb.de>
To: Andi Kleen <ak@suse.de>
Cc: linux-arch@vger.kernel.org, akpm@osdl.org
List-ID: <linux-arch.vger.kernel.org>


--Boundary-02=_fF1qAGIJN+c9J4G
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

On Wednesday 19 May 2004 11:49, Andi Kleen wrote:

> I changed all 64bit architectures except for parisc64, which seemed to=20
> already have a sendfile64.

And it looks like you missed s390.

=3D=3D=3D=3D=3D arch/s390/kernel/syscalls.S 1.11 vs edited =3D=3D=3D=3D=3D
=2D-- 1.11/arch/s390/kernel/syscalls.S	Thu Apr 29 11:41:09 2004
+++ edited/arch/s390/kernel/syscalls.S	Wed May 19 14:15:36 2004
@@ -195,7 +195,7 @@
 SYSCALL(sys_capget,sys_capget,sys32_capget_wrapper)
 SYSCALL(sys_capset,sys_capset,sys32_capset_wrapper)		/* 185 */
 SYSCALL(sys_sigaltstack_glue,sys_sigaltstack_glue,sys32_sigaltstack_glue)
=2DSYSCALL(sys_sendfile,sys_sendfile,sys32_sendfile_wrapper)
+SYSCALL(sys_sendfile,sys_sendfile64,sys32_sendfile_wrapper)
 NI_SYSCALL							/* streams1 */
 NI_SYSCALL							/* streams2 */
 SYSCALL(sys_vfork_glue,sys_vfork_glue,sys_vfork_glue)		/* 190 */

--Boundary-02=_fF1qAGIJN+c9J4G
Content-Type: application/pgp-signature
Content-Description: signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQBAq1Ff5t5GS2LDRf4RAu0PAJ9DaMOunSjsI5nd4s/hu8KnREBlnQCcDdOe
jPFw7kzDaucozqc4x2852EU=
=rwis
-----END PGP SIGNATURE-----

--Boundary-02=_fF1qAGIJN+c9J4G--
