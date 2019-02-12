Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-yw1-f66.google.com ([209.85.161.66]:45222 "EHLO
        mail-yw1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727614AbfBLWlP (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 12 Feb 2019 17:41:15 -0500
Subject: Re: [PATCH 2/4] Expose O_PATHSTATIC to userspace
References: <20190212145450.2200-1-demiobenour@gmail.com>
 <20190212145450.2200-2-demiobenour@gmail.com>
 <EC2075E7-CB9B-4DC0-B041-1EA1100D6748@dilger.ca>
From: "Demi M. Obenour" <demiobenour@gmail.com>
Message-ID: <39662373-f333-a5e1-f734-1b003992a468@gmail.com>
Date: Tue, 12 Feb 2019 17:41:09 -0500
MIME-Version: 1.0
In-Reply-To: <EC2075E7-CB9B-4DC0-B041-1EA1100D6748@dilger.ca>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="JdhHrYvC79uJTKDrSt0jFVgT7zCVPlvsa"
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Andreas Dilger <adilger@dilger.ca>
Cc: Jeff Layton <jlayton@kernel.org>, "J. Bruce Fields" <bfields@fieldses.org>, Alexander Viro <viro@zeniv.linux.org.uk>, Arnd Bergmann <arnd@arndb.de>, linux-fsdevel <linux-fsdevel@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>, linux-arch@vger.kernel.org
Message-ID: <20190212224109.xALNPpKD6mXx9jL4jrv-s76juR1KMNFkCNTMybFbGuM@z>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--JdhHrYvC79uJTKDrSt0jFVgT7zCVPlvsa
Content-Type: multipart/mixed; boundary="U98QdikU4hBjqnfGgi2wkgmNBgqxGWAbA";
 protected-headers="v1"
From: "Demi M. Obenour" <demiobenour@gmail.com>
To: Andreas Dilger <adilger@dilger.ca>
Cc: Jeff Layton <jlayton@kernel.org>, "J. Bruce Fields"
 <bfields@fieldses.org>, Alexander Viro <viro@zeniv.linux.org.uk>,
 Arnd Bergmann <arnd@arndb.de>, linux-fsdevel
 <linux-fsdevel@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>,
 linux-arch@vger.kernel.org
Message-ID: <39662373-f333-a5e1-f734-1b003992a468@gmail.com>
Subject: Re: [PATCH 2/4] Expose O_PATHSTATIC to userspace
References: <20190212145450.2200-1-demiobenour@gmail.com>
 <20190212145450.2200-2-demiobenour@gmail.com>
 <EC2075E7-CB9B-4DC0-B041-1EA1100D6748@dilger.ca>
In-Reply-To: <EC2075E7-CB9B-4DC0-B041-1EA1100D6748@dilger.ca>

--U98QdikU4hBjqnfGgi2wkgmNBgqxGWAbA
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable



On 2/12/19 3:18 PM, Andreas Dilger wrote:
> On Feb 12, 2019, at 7:54 AM, demiobenour@gmail.com wrote:
>>
>> From: "Demi M. Obenour" <demiobenour@gmail.com>
>>
>> This adds the file open flag O_PATHSTATIC, which ensures that symbolic=

>> links are *never* followed, even in path components other than the las=
t.
>> This is distinct from O_NOFOLLOW, which only prevents symlinks in the
>> *last* component from being followed.
>>
>> This is useful for avoiding race conditions in userspace code that
>> should expose only a subset of the filesystem to clients.  This includ=
es
>> FTP and SFTP servers, QEMU, and others.
>>
>> Currently, O_NOFOLLOW must be set if O_PATHSTATIC is set.  Otherwise,
>> open() fails with -EINVAL.
>=20
> I don't want to bikeshed (discard suggestion if you disagree), but why =
not
> name the flag "O_NEVER_FOLLOW" so that users can see it is also related=
 to
> "O_NOFOLLOW"?  Otherwise it seems like they are two completely differen=
t
> things from looking at the names, when in fact they are closely related=
=2E
>=20
> Cheers, Andreas
>=20

Searching for O_PATHSTATIC gives two results:

* https://www.halfdog.net/Security/2010/FilesystemRecursionAndSymlinks
* https://lists.gnu.org/archive/html/qemu-devel/2017-01/msg06225.html

O_DIRECTORY_NOFOLLOW would also be a good choice, since that is what the
flag actually does.  Ideally, we would rename O_NOFOLLOW, but we can=92t.=



--U98QdikU4hBjqnfGgi2wkgmNBgqxGWAbA--

--JdhHrYvC79uJTKDrSt0jFVgT7zCVPlvsa
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdodNnxM2uiJZBxxxsoi1X/+cIsEFAlxjS4UACgkQsoi1X/+c
IsEEQw//eeuvOan9TmZ0gfFNNIc7ibAMoc9o8q0L/Sr0yqTpRithhFdLfr/APzcq
jlctL4m4Urhg9R2IgEvKJUIH5LXpNgF0px2usODACwXua7MXy9b8ziN5f/+1+GOo
CiUNtnaR9kMWzR5HhyOGIE3LAAIBZrLgRRAuznvYbKQhojFayhAC5MeIpVsI91so
T4osAwVw0HHF4hIEIYUWMT5a1CZJfdxDPLb//AbEAWf1fU21XcKQFPxgYHIFMilo
s+0kkC/AHk/ncewn4N84jSoqsxYMqcmjHVwglVs7/SzCFPKLJoAKOjlKAe9q1l71
r4zvFIu2xMQ/73qQHNLJN9yWo8U7nCvC1S4oQUWPJP37C0G/6To7qGWXo9rFYZfP
BEtlX7dWdIEeiL/yM8ZIKE6GoTMl5vrvELRdn5QH3V9qRLCJLewezVivLMG6GjVL
ilINB6cx9N4YaxShouvNPrJURmPj8SZVyJa/bD4zC8UtfMpaLbWoJg0BjUf51FAb
tpKhBQqe00ecg1NgGtP0/54lcBVb3QWCVf4zHNDs96DET+c+ttd/nLMZcziYEYZt
VGwwGEZvRzm0km5/yya6Q0PYtYwM+KW7UW4jAZ/ksDBrQKirNOshC3kyKkggszUq
N6KU9v4MjvqCcf0xB/2+3CdmOujMdOmjmt63MYSR48cWD+n3b9w=
=fVy/
-----END PGP SIGNATURE-----

--JdhHrYvC79uJTKDrSt0jFVgT7zCVPlvsa--
