From: James Hogan <james.hogan@imgtec.com>
Subject: Re: [RFC][CFT][PATCHSET v1] uaccess unification
Date: Fri, 31 Mar 2017 14:38:17 +0100
Message-ID: <20170331133817.GH31606@jhogan-linux.le.imgtec.org>
References: <20170329055706.GH29622@ZenIV.linux.org.uk>
 <CAGXu5j+R1gNpuUv1=795t7PGwyLznVCGrRovy5ZXb69SmA0NJA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="6S+CllbbV/7E5K18"
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mailapp01.imgtec.com ([195.59.15.196]:57498 "EHLO
        imgpgp01.kl.imgtec.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S933030AbdCaNiV (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 31 Mar 2017 09:38:21 -0400
Content-Disposition: inline
In-Reply-To: <CAGXu5j+R1gNpuUv1=795t7PGwyLznVCGrRovy5ZXb69SmA0NJA@mail.gmail.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Kees Cook <keescook@chromium.org>
Cc: Al Viro <viro@zeniv.linux.org.uk>, linux-arch <linux-arch@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, Linus Torvalds <torvalds@linux-foundation.org>, Richard Henderson <rth@twiddle.net>, Russell King <linux@armlinux.org.uk>, Will Deacon <will.deacon@arm.com>, Haavard Skinnemoen <hskinnemoen@gmail.com>, Vineet Gupta <vgupta@synopsys.com>, Steven Miao <realmz6@gmail.com>, Jesper Nilsson <jesper.nilsson@axis.com>, Mark Salter <msalter@redhat.com>, Yoshinori Sato <ysato@users.sourceforge.jp>, Richard Kuo <rkuo@codeaurora.org>, Tony Luck <tony.luck@intel.com>, Geert Uytterhoeven <geert@linux-m68k.org>, Michal Simek <monstr@monstr.eu>, David Howells <dhowells@redhat.com>, Ley Foon Tan <lftan@altera.com>, Jonas Bonn <jonas@southpo>

--6S+CllbbV/7E5K18
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 30, 2017 at 05:21:32PM -0700, Kees Cook wrote:
> On Tue, Mar 28, 2017 at 10:57 PM, Al Viro <viro@zeniv.linux.org.uk> wrote:
> > At the moment I have that conversion done for everything except ia64 and
> > metag.  Once everything is converted, I'll remove ARCH_HAS_RAW_COPY_USER
> > and make generic stuff unconditional; at the same point
> > HAVE_ARCH_HARDENED_USERCOPY will be gone (becoming unconditionally true=
).
>=20
> Yay! :)

In the mean time should ARCH_HAS_RAW_COPY_USER select
HAVE_ARCH_HARDENED_USERCOPY?

FWIW I already have patches for metag to enable RAW_COPY_USER that just
need some more testing (mainly due to prerequisite user copy fixes), but
I don't know about ia64

Cheers
James

--6S+CllbbV/7E5K18
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----

iQIcBAEBCAAGBQJY3lvDAAoJEGwLaZPeOHZ6lRwP/1B2sYYvFA7rkWucSeTOPllY
DMho8dzqTi85UgPLffReWhqMcYnCNgkL39u2cVYB5osVv4oPVEM2wEW6nIc0EY6s
npKtrzRK8UhvrqiafNPOiWaQm+QEpinFsO0MpawuDznpg5fy04C9wqyurO+fQfWv
1EUghSbCY0q3JvW25XbOTvUqQ4b6qOaYr7Z+HxKTf7DK/nmFfO7tOEfzaxC6iKUG
yMHLbFv+AqHO43QmYRP/MBIE80eGUfB+S+kJfk7prhpRDXPUCxB66nycEuR5O1k6
RZ/YWj8MUdl/yf59gh7T1+CJGIhsrAaGcQg8jWjdKeJvXTlWGzs1C7jBK/G1TsTS
wKbLDgu1g0jlNdp7px4vByNFjdKkLXjQJIQmcaeuZybjpqXX0+3BmAmg3BqZxsHS
Fsw3DVlQZSGRQrzpAP9lRnGm9GtYkQHf2lVdVi97chC6pB0qOoFES24Dk9KUYrp4
fuELEDIcWhSo/u4Pn4kvK/PW8WKTdSdQyPN8vwnwOkCs5CvHhZVI1QmdL2Jdp0nj
BEWXkI/pNpC4Qz5SmDYEo+Nfx1M0rYD10FHG2b7SS/ybsa04EkaktSFh1UmnN/3p
rGbXbKBhMOUnUQNVPDBVYnJEk7I3WW73abpqXWSYDT5iIIG6BlGbzopM7OnQ8B4d
ApJyoJ2G/S7pHTOgzJKp
=f3v1
-----END PGP SIGNATURE-----

--6S+CllbbV/7E5K18--
