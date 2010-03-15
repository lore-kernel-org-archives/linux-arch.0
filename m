From: Ulrich Drepper <drepper@redhat.com>
Subject: Re: 64-syscall args on 32-bit vs syscall()
Date: Mon, 15 Mar 2010 09:00:55 -0700
Message-ID: <4B9E59B7.6060405@redhat.com>
References: <1268628493.2355.2.camel@pasglop> <20100314.220646.190065794.davem@davemloft.net> <1268630313.2335.2.camel@pasglop> <20100315134449.GB1653@linux-mips.org> <4B9E4EB1.9010800@zytor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:56608 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S965216Ab0COQBW (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Mon, 15 Mar 2010 12:01:22 -0400
In-Reply-To: <4B9E4EB1.9010800@zytor.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: Ralf Baechle <ralf@linux-mips.org>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, David Miller <davem@davemloft.net>, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, kernel@teksavvy.com, torvalds@linux-foundation.org, munroesj@linux.vnet.ibm.com

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On 03/15/2010 08:13 AM, H. Peter Anvin wrote:
> One option would be to do a libkernel.so,

No need.  Put it in the vdso.  And name it something other than syscall=
=2E
 The syscall() API is fixed, you cannot change it.

All this only if it makes sense for ALL archs.  If it cannot work for
just one arch then it's not worth it at all.

- --=20
=E2=9E=A7 Ulrich Drepper =E2=9E=A7 Red Hat, Inc. =E2=9E=A7 444 Castro S=
t =E2=9E=A7 Mountain View, CA =E2=9D=96
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)
Comment: Using GnuPG with Fedora - http://enigmail.mozdev.org/

iEYEARECAAYFAkueWbcACgkQ2ijCOnn/RHRtBQCeP88S/0xei7CAt65AGboqsrC8
N7wAoK7Qbi+OZuQrgHTCgTA27TgY+gQU
=3D4tJ6
-----END PGP SIGNATURE-----
