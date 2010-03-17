From: Ulrich Drepper <drepper@redhat.com>
Subject: Re: 64-syscall args on 32-bit vs syscall()
Date: Wed, 17 Mar 2010 02:14:05 -0700
Message-ID: <4BA09D5D.5090602@redhat.com>
References: <20100315134449.GB1653@linux-mips.org>	 <4B9E4EB1.9010800@zytor.com>	<4B9E59B7.6060405@redhat.com>	 <20100315.120004.209998642.davem@davemloft.net>	 <4B9E8D67.8040209@zytor.com>  <1268685311.2335.38.camel@pasglop>	 <1268776570.19726.98.camel@spokane1.rchland.ibm.com>	 <1268785874.2335.137.camel@pasglop>  <4BA06E1B.2040706@redhat.com> <1268816179.2335.187.camel@pasglop>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:14283 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753539Ab0CQJOa (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Wed, 17 Mar 2010 05:14:30 -0400
In-Reply-To: <1268816179.2335.187.camel@pasglop>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: munroesj@us.ibm.com, "H. Peter Anvin" <hpa@zytor.com>, David Miller <davem@davemloft.net>, ralf@linux-mips.org, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, kernel@teksavvy.com, torvalds@linux-foundation.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On 03/17/2010 01:56 AM, Benjamin Herrenschmidt wrote:
>>  - You keep the existing syscall() exported by glibc for binary
>> compatibility
>=20
>>  - You add a new __syscall() (or whatever you want to name it) that =
adds
>> a dummy argument at the beginning, and whose implementation shifts
>> everything by 2 instead of 1 argument before calling into the kernel
>=20
>>  - You define in unistd.h or whatever is relevant, a macro that does=
:
>=20
>> #define syscall(__sysno, __args..) __syscall(0, _sysno, __args)
>=20
>> I believe that should cover it, at least for powerpc, possibly for o=
ther
>> archs too though as I said, I may have missed something there.

How can this possibly be the case?  This will screw people who currentl=
y
work around the ppc limitations of the existing syscall.

Just leave it alone.

- --=20
=E2=9E=A7 Ulrich Drepper =E2=9E=A7 Red Hat, Inc. =E2=9E=A7 444 Castro S=
t =E2=9E=A7 Mountain View, CA =E2=9D=96
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)
Comment: Using GnuPG with Fedora - http://enigmail.mozdev.org/

iEYEARECAAYFAkugnV0ACgkQ2ijCOnn/RHRL4gCeIY0SLDCgLqtVvuMw+pvCzkwE
3MIAoJQRK5Mc+WtC/Wz9tPFPy4X+EALe
=3Dlexw
-----END PGP SIGNATURE-----
