From: Aleksa Sarai <cyphar@cyphar.com>
Subject: Re: [LTP] [fs] ce436509a8: ltp.openat203.fail
Date: Tue, 28 Apr 2020 10:51:26 +1000
Message-ID: <20200428005126.6wncibudt6ohghvc@yavin.dot.cyphar.com>
References: <f969e7d45a8e83efc1ca13d675efd8775f13f376.1586830316.git.josh@joshtriplett.org>
 <20200427135210.GB5770@shao2-debian>
 <20200427142733.GD7661@rei>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="tk4luxag2mt2b3sb"
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mout-p-103.mailbox.org ([80.241.56.161]:41566 "EHLO
        mout-p-103.mailbox.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726264AbgD1Avp (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 27 Apr 2020 20:51:45 -0400
Content-Disposition: inline
In-Reply-To: <20200427142733.GD7661@rei>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Cyril Hrubis <chrubis@suse.cz>
Cc: kernel test robot <rong.a.chen@intel.com>, Josh Triplett <josh@joshtriplett.org>, linux-arch@vger.kernel.org, Jens Axboe <axboe@kernel.dk>, Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org, lkp@lists.01.org, Alexander Viro <viro@zeniv.linux.org.uk>, linux-fsdevel@vger.kernel.org, io-uring@vger.kernel.org, ltp@lists.linux.it


--tk4luxag2mt2b3sb
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2020-04-27, Cyril Hrubis <chrubis@suse.cz> wrote:
> Hi!
> > commit: ce436509a8e109330c56bb4d8ec87d258788f5f4 ("[PATCH v4 2/3] fs: o=
penat2: Extend open_how to allow userspace-selected fds")
> > url: https://github.com/0day-ci/linux/commits/Josh-Triplett/Support-use=
rspace-selected-fds/20200414-102939
> > base: https://git.kernel.org/cgit/linux/kernel/git/shuah/linux-kselftes=
t.git next
>=20
> This commit adds fd parameter to the how structure where LTP test was
> previously passing garbage, which obviously causes the difference in
> errno.
>=20
> This could be safely ignored for now, if the patch gets merged the test
> needs to be updated.

It wouldn't be a bad idea to switch the test to figure out the ksize of
the struct, so that you only add bad padding after that. But then again,
this would be a bit ugly -- having CHECK_FIELDS would make this simpler.

--=20
Aleksa Sarai
Senior Software Engineer (Containers)
SUSE Linux GmbH
<https://www.cyphar.com/>

--tk4luxag2mt2b3sb
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQSxZm6dtfE8gxLLfYqdlLljIbnQEgUCXqd+CwAKCRCdlLljIbnQ
EgeUAP9m6EkEl0AGN+/eOT+i/EalQ0VpBQZ8UYtvJP5HbYDC8gEA3HtLFj8eHbce
Y9pj4AZCRJVLhR1qVwrou+X6rZVJ0Ao=
=p2HM
-----END PGP SIGNATURE-----

--tk4luxag2mt2b3sb--
