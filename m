Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from outbound.smtp.vt.edu ([198.82.183.121]:52002 "EHLO
        omr2.cc.vt.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1729687AbfKEU6s (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 5 Nov 2019 15:58:48 -0500
Received: from mr4.cc.vt.edu (mr4.cc.vt.edu [IPv6:2607:b400:92:8300:0:7b:e2b1:6a29])
        by omr2.cc.vt.edu (8.14.4/8.14.4) with ESMTP id xA5KwlCa028124
        for <linux-arch@vger.kernel.org>; Tue, 5 Nov 2019 15:58:47 -0500
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com [209.85.222.199])
        by mr4.cc.vt.edu (8.14.7/8.14.7) with ESMTP id xA5KwgdP020370
        for <linux-arch@vger.kernel.org>; Tue, 5 Nov 2019 15:58:47 -0500
Received: by mail-qk1-f199.google.com with SMTP id a16so11059289qka.10
        for <linux-arch@vger.kernel.org>; Tue, 05 Nov 2019 12:58:47 -0800 (PST)
From: "Valdis Kl=?utf-8?Q?=c4=93?=tnieks" <valdis.kletnieks@vt.edu>
Subject: Re: [PATCH 1/1] errno.h: Provide EFSBADCRC for everybody
In-Reply-To: <20191105151736.GB4153244@magnolia>
References: <20191105024618.194134-1-Valdis.Kletnieks@vt.edu>
 <20191105151736.GB4153244@magnolia>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_1572987519_14215P";
         micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Tue, 05 Nov 2019 15:58:39 -0500
Message-ID: <250143.1572987519@turing-police>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: "Darrick J. Wong" <darrick.wong@oracle.com>
Cc: Theodore Ts'o <tytso@mit.edu>, Andreas Dilger <adilger.kernel@dilger.ca>, Jaegeuk Kim <jaegeuk@kernel.org>, Chao Yu <chao@kernel.org>, linux-xfs@vger.kernel.org, Jan Kara <jack@suse.com>, Arnd Bergmann <arnd@arndb.de>, linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net, linux-arch@vger.kernel.org
Message-ID: <20191105205839.5nAZJv4XfMb2H5tu821h_1-_rkgXLK7YyDcUkbYoiP8@z>

--==_Exmh_1572987519_14215P
Content-Type: text/plain; charset=us-ascii

On Tue, 05 Nov 2019 07:17:36 -0800, "Darrick J. Wong" said:
> On Mon, Nov 04, 2019 at 09:46:14PM -0500, Valdis Kletnieks wrote:
> > Four filesystems have their own defines for this. Move it
> > into errno.h so it's defined in just one place.
> >
> > Signed-off-by: Valdis Kletnieks <Valdis.Kletnieks@vt.edu>
>
> Acked-by: Darrick J. Wong <darrick.wong@oracle.com>
>
> You can build all six filesystems with both this and the EFSCORRUPTED
> patch applied, correct?

I can.  But it was pointed out to me that it blows up on some architectures..



--==_Exmh_1572987519_14215P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Comment: Exmh version 2.9.0 11/07/2018

iQIVAwUBXcHifwdmEQWDXROgAQLj5RAApcBiDjlLyeNreRjX2DmNwO+Ua9G5e5Sp
eXKK/n2L2aQzyRQz7vGUMquNdBYorbtXuzT13bysejTkkkISSGz9lABhFZibT3n5
EUxZmFM8LKoRYx+sAkw3sHfwj4pmLhuz3O5GXA3IkEn57++QiOoi+QR01H7B6KIU
2W2NoauIR6t5hiO83EIpioJq07WOm1QP46diNozGGCskSwgEeJVXnWMNoIS23Xc7
OK1FlYHnJ0wxDtnuzCEb9rOoi7u1Fr3FXTwpLo5V2krxLdW+jYhIRSoK+UPM0yky
HIKCcTErRDckrbcT4+T6uszVrt+tXLdZE/mWgHLqbWnfB3g3Hh4C1ccX7TWqAG5S
63ok39pe6rDa5sTRwHhEhIfBKOWXhGA1XNay3cWCgBroEwPpz0Zhy8xBP397bwZA
7RubcSMY6Ct4tTUsS/8Ocmo/U0Kuo6k3El246di3UILbLQ1hvUXBeHtBbNKD0u4u
nHhCqndqK0JAluIzlkpqVkcFXSWBlzlxfpNNNpgrr3aIGkwFWjJnsgkhB9T0cT4L
8gK8W3Ly4V8A+oYoI4MgZ1LJ+jN/y7aDpDMHL3mjBECucfSmvaZLbRTOiAN7OHdz
J7lkyAPaFi9NCVNYzS4tKLPOQcgJIA+GMCfSGmEAWiW07o2qb62I1kJz2vSkiTQC
j0Tlv0TH9BI=
=1Y8S
-----END PGP SIGNATURE-----

--==_Exmh_1572987519_14215P--
