Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-pg1-f196.google.com ([209.85.215.196]:36846 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729991AbfBLUSR (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 12 Feb 2019 15:18:17 -0500
Received: by mail-pg1-f196.google.com with SMTP id r124so1772653pgr.3
        for <linux-arch@vger.kernel.org>; Tue, 12 Feb 2019 12:18:16 -0800 (PST)
From: Andreas Dilger <adilger@dilger.ca>
Message-ID: <EC2075E7-CB9B-4DC0-B041-1EA1100D6748@dilger.ca>
Content-Type: multipart/signed;
 boundary="Apple-Mail=_C2E7E05C-2B20-4EA4-8AA7-025ABEE10788";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
Subject: Re: [PATCH 2/4] Expose O_PATHSTATIC to userspace
Date: Tue, 12 Feb 2019 13:18:10 -0700
In-Reply-To: <20190212145450.2200-2-demiobenour@gmail.com>
References: <20190212145450.2200-1-demiobenour@gmail.com>
 <20190212145450.2200-2-demiobenour@gmail.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: demiobenour@gmail.com
Cc: Jeff Layton <jlayton@kernel.org>, "J. Bruce Fields" <bfields@fieldses.org>, Alexander Viro <viro@zeniv.linux.org.uk>, Arnd Bergmann <arnd@arndb.de>, linux-fsdevel <linux-fsdevel@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>, linux-arch@vger.kernel.org
Message-ID: <20190212201810.z7_AuRzLyesPX82IdxV0xFdwFHzpS18KpyuXV5DUPxQ@z>


--Apple-Mail=_C2E7E05C-2B20-4EA4-8AA7-025ABEE10788
Content-Transfer-Encoding: 7bit
Content-Type: text/plain;
	charset=us-ascii

On Feb 12, 2019, at 7:54 AM, demiobenour@gmail.com wrote:
> 
> From: "Demi M. Obenour" <demiobenour@gmail.com>
> 
> This adds the file open flag O_PATHSTATIC, which ensures that symbolic
> links are *never* followed, even in path components other than the last.
> This is distinct from O_NOFOLLOW, which only prevents symlinks in the
> *last* component from being followed.
> 
> This is useful for avoiding race conditions in userspace code that
> should expose only a subset of the filesystem to clients.  This includes
> FTP and SFTP servers, QEMU, and others.
> 
> Currently, O_NOFOLLOW must be set if O_PATHSTATIC is set.  Otherwise,
> open() fails with -EINVAL.

I don't want to bikeshed (discard suggestion if you disagree), but why not
name the flag "O_NEVER_FOLLOW" so that users can see it is also related to
"O_NOFOLLOW"?  Otherwise it seems like they are two completely different
things from looking at the names, when in fact they are closely related.

Cheers, Andreas






--Apple-Mail=_C2E7E05C-2B20-4EA4-8AA7-025ABEE10788
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=signature.asc
Content-Type: application/pgp-signature;
	name=signature.asc
Content-Description: Message signed with OpenPGP

-----BEGIN PGP SIGNATURE-----
Comment: GPGTools - http://gpgtools.org

iQIzBAEBCAAdFiEEDb73u6ZejP5ZMprvcqXauRfMH+AFAlxjKgMACgkQcqXauRfM
H+D8gQ//e+7SA0vBv61wtMK0lXxO3SfVSJHlv9UYGJ8XiaZh8Ui12qH9UsaiuZki
o0b2ChHlUVmgWRHB0wDxQ2L8Iabf/WZ+bzYiRU9DE+VDaDHsZusNmpQKRiafEmDw
lOMwc/gvwLColA4Fjl+4CfcSyXURrHCG+pINi+EA+cg8X+qSwMWSvJ/G+39rvJ/Y
jP19/zxoQ9hAvyKo0acpA2/a2LvMAJ9eFySYURD27IniButV/e4YwuzOMy55dp74
rlvElPktrVJtJ4Wg2smHM2978OLAO96RKxBi3UlfeppscQ8ABn/mPPgZjBP7N2yD
NWUxcNEkB6pRznKx/ItqH21B4DZ3ma2QLDu6Hfb59PWBoY0UK86Q4SILJJ7sioxf
eda/pQcmHbj9gefg4IMGjMZ4KK3iuAdDJt/PM/nWzOlu17CD9nEgO61GNUUp04Kd
NVFeXTGx3Sy/avISJf++N1mN5LEKzFpbHU1Bc7SeyI61ujuCE4S4FYJ3q2IvJzYL
66cvgaJFJbZ9v3mOq0jimwYTy7cDgJrgFSNEuxzGSx/HaRYBoBTU0DAaBwvmMQxu
2RDK4ulIYA9uuxRATGGtuowlh81SI/qoWhxssATbO6vUaBJuHxp/D0NoN9jwSpex
MpZUVppYkHQXh/Q9vpxSZtm9Hy19zICQ1Sg7pU0pv/88bv9/iEM=
=Qls+
-----END PGP SIGNATURE-----

--Apple-Mail=_C2E7E05C-2B20-4EA4-8AA7-025ABEE10788--
