From: "Valdis Kl=?utf-8?Q?=c4=93?=tnieks" <valdis.kletnieks@vt.edu>
Subject: Re: [PATCH 1/1] errno.h: Provide EFSBADCRC for everybody
Date: Tue, 05 Nov 2019 15:57:13 -0500
Message-ID: <249994.1572987433@turing-police>
References: <20191105024618.194134-1-Valdis.Kletnieks@vt.edu>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_1572987433_14215P";
         micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20191105024618.194134-1-Valdis.Kletnieks@vt.edu>
Sender: linux-kernel-owner@vger.kernel.org
To: Theodore Ts'o <tytso@mit.edu>, Andreas Dilger <adilger.kernel@dilger.ca>, Jaegeuk Kim <jaegeuk@kernel.org>, Chao Yu <chao@kernel.org>, "Darrick J. Wong" <darrick.wong@oracle.com>, Rasmus Villemoes <rasmus.villemoes@prevas.dk>, linux-xfs@vger.kernel.org, Jan Kara <jack@suse.com>, Arnd Bergmann <arnd@arndb.de>, linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net, linux-arch@vger.kernel.org
List-Id: linux-arch.vger.kernel.org

--==_Exmh_1572987433_14215P
Content-Type: text/plain; charset=us-ascii

On Mon, 04 Nov 2019 21:46:14 -0500, Valdis Kletnieks said:
> Four filesystems have their own defines for this. Move it
> into errno.h so it's defined in just one place.
>
> Signed-off-by: Valdis Kletnieks <Valdis.Kletnieks@vt.edu>

Going to have to retract this. and the other patch for EFSCORRUPTED.

On Tue, 05 Nov 2019 10:17:52 +0000, Rasmus Villemoes <rasmus.villemoes@prevas.dk> said:

> Does that work? Six architectures (alpha ia64 mips parisc powerpc sparc)
> have their own asm/errno.h. ia64 and powerpc include asm-generic/errno.h
> from their asm/errno.h, but the remaining four will no longer have a
> definition of EFSBADCRC.

I knew some architectures had their own syscall values.  I admit it comes as
a surprise to me (and probably a number of others) that errno.h is that way too....

Thanks for spotting this, Rasmus...

--==_Exmh_1572987433_14215P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Comment: Exmh version 2.9.0 11/07/2018

iQIVAwUBXcHiKQdmEQWDXROgAQILDg/+IpFcal1QlvbuIHm2Skf6HofxtKqb0d6M
tK77zP5Q+nv9p4o41Nh3lYk5p3an6xlcd3157L9fmOjQFy8dZJbY8i07oVCO/gtS
oV8xesp6X7uYEgSARDK6lO/1/9bAuCt4ghd5lKcsyBKDv1MQ80x3+mWx++oV1SG4
EYqkIglqmnZ2ZrielunCbKqSqs0tUY50ayaogkISJzMDliTsYfTMpWF+MkrYiuEU
kSQ8ifkclZ6rRQgeQzYRe/7Q4x02sudSWPkWHCOw5Gtg4vd0H7O4OhCadSt44uHv
Za+sDJ3TZ5bUlROV5SKj3Jfrp2EuuW3jbFHEVEvjrP5rZbOC6sPKy4N81oDCYQ5X
SbNfryx8h3CwOtGM6hgtLj1U3BFNESqkc6TnAarC8015rEbOoZn9vivgrtZ1xB6n
K9XXs1guqWZ2xBPdFbOTmv6T3Heg8Y4c/GhV/PcRTV+XZzUs77SmAKtaH9qH9bkf
efM4xNwEyBJsFn3ycYeP1lAjxlhJPsyEQVKfGNcyzGq4jP4EHNpWclncbZ9Wf/mw
QzHYeoP5jtmf2Mppe6/nTGm5Mdra1IptAZKdBRehe4XJc78exI3mfAi/2LoqHuzy
6EiVhn2WrtzPJ+s4SzNud9tOQz5tRhvh2wjiY0pDWYXMX8xg2DvdWpj03bM5ojHA
ePHUo1dE0Xs=
=2I65
-----END PGP SIGNATURE-----

--==_Exmh_1572987433_14215P--
