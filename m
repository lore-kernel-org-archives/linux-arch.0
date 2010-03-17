From: Ulrich Drepper <drepper@redhat.com>
Subject: Re: 64-syscall args on 32-bit vs syscall()
Date: Tue, 16 Mar 2010 22:52:27 -0700
Message-ID: <4BA06E1B.2040706@redhat.com>
References: <20100315134449.GB1653@linux-mips.org>	 <4B9E4EB1.9010800@zytor.com>	<4B9E59B7.6060405@redhat.com>	 <20100315.120004.209998642.davem@davemloft.net>	 <4B9E8D67.8040209@zytor.com>  <1268685311.2335.38.camel@pasglop>	 <1268776570.19726.98.camel@spokane1.rchland.ibm.com> <1268785874.2335.137.camel@pasglop>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:12046 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752378Ab0CQFwx (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Wed, 17 Mar 2010 01:52:53 -0400
In-Reply-To: <1268785874.2335.137.camel@pasglop>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: munroesj@us.ibm.com, "H. Peter Anvin" <hpa@zytor.com>, David Miller <davem@davemloft.net>, ralf@linux-mips.org, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, kernel@teksavvy.com, torvalds@linux-foundation.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On 03/16/2010 05:31 PM, Benjamin Herrenschmidt wrote:
> My proposal is purely a change to the syscall()
> function, nothing else. No kernel change, no ABI change, no change to
> the way glibc normally calls syscalls internally, etc...

How can this be?  People are today actively working around the problem
of 64-bit arguments.  You have to break something since you cannot
recognize these situations.  And since it became meanwhile clear that
there is no way to "fix" all archs magically I really don't want to
introduce anything.  There are mechanisms in place to abstract out some
of the issues.  And for the rest, well, if you're using syscalls
directly you already have to encoded lowlevel knowledge.  One more bit
doesn't hurt.  It's not as if this happens every day.

- --=20
=E2=9E=A7 Ulrich Drepper =E2=9E=A7 Red Hat, Inc. =E2=9E=A7 444 Castro S=
t =E2=9E=A7 Mountain View, CA =E2=9D=96
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)
Comment: Using GnuPG with Fedora - http://enigmail.mozdev.org/

iEYEARECAAYFAkugbhsACgkQ2ijCOnn/RHQzlACeMp0UK2jZuZOgXhJjB8Z9p4kh
rCoAn0zaJqFYV9tQ0Ct49Mprfa0O5iKh
=3D71la
-----END PGP SIGNATURE-----
