Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from ozlabs.org ([103.22.144.67]:52933 "EHLO ozlabs.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933019AbbENWdn (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Thu, 14 May 2015 18:33:43 -0400
Date: Fri, 15 May 2015 08:33:34 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
Subject: Re: [PATCH v2] Documentation/arch: Add kernel feature descriptions
 and arch support status under Documentation/features/
Message-ID: <20150515083334.535ad43e@canb.auug.org.au>
In-Reply-To: <20150514195925.GA27570@gmail.com>
References: <20150513092421.GB11030@gmail.com>
	<20150513094622.GC11030@gmail.com>
	<20150513094756.GD11030@gmail.com>
	<20150513131835.GJ1517@pd.tnic>
	<20150513134842.GA1657@gmail.com>
	<20150513162757.GA21894@x>
	<20150513150523.ddd65d7cd51f820b78f0c8e3@linux-foundation.org>
	<20150514101518.GA27550@gmail.com>
	<20150514103544.GA7027@gmail.com>
	<20150514123835.1bf436bc35d711f8dbf9bc0f@linux-foundation.org>
	<20150514195925.GA27570@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/QXvRtdH6eVM2W88vkav0Vi4"; protocol="application/pgp-signature"
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Ingo Molnar <mingo@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, Josh Triplett <josh@joshtriplett.org>, Borislav Petkov <bp@alien8.de>, Jonathan Corbet <corbet@lwn.net>, Peter Zijlstra <peterz@infradead.org>, Andy Lutomirski <luto@amacapital.net>, Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>, Thomas Gleixner <tglx@linutronix.de>, Linus Torvalds <torvalds@linux-foundation.org>, linux-api@vger.kernel.org, linux-kernel@vger.kernel.org, x86@kernel.org, linux-arch@vger.kernel.org, Yoshinori Sato <ysato@users.sourceforge.jp>
Message-ID: <20150514223334.v7apM1OYwgWa9Gq__UDboJtnhGBB5E3qUME7c5Y8nIw@z>

--Sig_/QXvRtdH6eVM2W88vkav0Vi4
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Ingo,

Thanks for this.  The concept is certainly good.

On Thu, 14 May 2015 21:59:25 +0200 Ingo Molnar <mingo@kernel.org> wrote:
>
> The patch that adds a new architecture to all these files would give=20
> us a good overview about how complete an initial port is.

If you want to test how hard that is (and what sort of patch it
produces), the h8300 architecture was added to linux-next recently.

--=20
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au

--Sig_/QXvRtdH6eVM2W88vkav0Vi4
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJVVSLEAAoJEMDTa8Ir7ZwVpFkP/1gzWYa0KgCaEwVVhSZdSCS5
5dl4I5IVZcINTXQ6z7s1xkoFP0TN/0+uC9tgTeemXbsow0PEZCa2WPba9VH0VihZ
g8kkhS1taOOmm8oPZ03WpAf+oSJYF7VdcdIJf+qd71f0QPnq4keyjQhWdqYiCefQ
R9MPyvXHPXpuTkJYnpHnmkMLq0NJMoSw7wAOGIN3g/TPT1VfTelrSd1JEbD4JmUT
rz6cT456nZcZymCsWh0guj1J2QVGoiy0lOODI3h2ZtcoH91XXcUc4P04zjr2mPn0
YR6J+Kr6+XZGxIh2Lr93KBCPJngrjE6FZlLd1X+G5CzdwPdtYlEVUUjm1vA5ijD0
jUp+LHkxMlhwvN+yriMT8i/gmoZo0zsa7p2wPl9WAsmyQ/zrI6vwpiYCXsLZEWbU
JUmXjfkSyARIj++5vfsxaBbbrUpcmp96xTpcV0VaDb7k3PmRQhb2ALoGYfoZHwWA
obfZj2WYj/C4zZHAhCJ7IKV+Q1ewKYUxKQIi5vCFbLqw0hs7ydzPuGzCccEIPFrh
xWy+53itTKKRGZAd/ztSHOVbioH7Kv6x8UkAjuhtdaHdRqmnGO2K6IQhzo37YBmT
sxn5XIcYFSITxIRPauUim1j4SC1+yrzyEJ2zPBjgIyn8zJVlrlAHBmHd/pUPeY7o
VuIVimZKQ9Q4xEAwA8cv
=e+Nx
-----END PGP SIGNATURE-----

--Sig_/QXvRtdH6eVM2W88vkav0Vi4--
