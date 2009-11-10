From: Stephen Rothwell <sfr@canb.auug.org.au>
Subject: linux-next: new tree: sysctl
Date: Tue, 10 Nov 2009 15:33:09 +1100
Message-ID: <20091110153309.57efaac2.sfr@canb.auug.org.au>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
 micalg="PGP-SHA1";
 boundary="Signature=_Tue__10_Nov_2009_15_33_09_+1100_EE6V8VN_SK6QXUAp"
Return-path: <linux-next-owner@vger.kernel.org>
Sender: linux-next-owner@vger.kernel.org
To: linux-next@vger.kernel.org
Cc: LKML <linux-kernel@vger.kernel.org>, "Eric W. Biederman" <ebiederm@xmission.com>, linux-arch@vger.kernel.org, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Paul Mackerras <paulus@samba.org>, Tony Luck <tony.luck@intel.com>, Fenghua Yu <fenghua.yu@intel.com>, Ralf Baechle <ralf@linux-mips.org>, Kyle McMartin <kyle@mcmartin.ca>, Thibaut Varene <T-Bone@parisc-linux.org>, Carsten Otte <cotte@de.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>, "David S. Miller" <davem@davemloft.net>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>
List-Id: linux-arch.vger.kernel.org

--Signature=_Tue__10_Nov_2009_15_33_09_+1100_EE6V8VN_SK6QXUAp
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi all,

Eric has requested that the tree at
git://git.kernel.org/pub/scm/linux/kernel/git/ebiederm/sysctl-2.6.git#master
be added to linux-next and I will add it from today.

Before anyone else jumps to the wrong conclusion (as I did :-)) this tree
currently only contains the set of patches posted in the thread "generic
compat_sys_sysctl".
--=20
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/

--Signature=_Tue__10_Nov_2009_15_33_09_+1100_EE6V8VN_SK6QXUAp
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iEYEARECAAYFAkr47QUACgkQjjKRsyhoI8xp0QCfX3w2z7aeGKARtLucNQf4PgH2
EWMAnRkCT8GeQg4weyuxCZJxmCOIdGQ0
=qkkC
-----END PGP SIGNATURE-----

--Signature=_Tue__10_Nov_2009_15_33_09_+1100_EE6V8VN_SK6QXUAp--
