Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-pg1-f196.google.com ([209.85.215.196]:39754 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728621AbeJAMXg (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 1 Oct 2018 08:23:36 -0400
Received: by mail-pg1-f196.google.com with SMTP id r9-v6so4763122pgv.6
        for <linux-arch@vger.kernel.org>; Sun, 30 Sep 2018 22:47:34 -0700 (PDT)
Date: Mon, 1 Oct 2018 15:47:23 +1000
From: Aleksa Sarai <cyphar@cyphar.com>
Subject: Re: [PATCH 0/3] namei: implement various scoping AT_* flags
Message-ID: <20181001054723.lekp3nqgctdyly7m@ryuk>
References: <20180929103453.12025-1-cyphar@cyphar.com>
 <20181001040821.GP31060@dastard>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="tnspunvdzgqmlf36"
Content-Disposition: inline
In-Reply-To: <20181001040821.GP31060@dastard>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Dave Chinner <david@fromorbit.com>
Cc: Jeff Layton <jlayton@kernel.org>, "J. Bruce Fields" <bfields@fieldses.org>, Al Viro <viro@zeniv.linux.org.uk>, Arnd Bergmann <arnd@arndb.de>, Shuah Khan <shuah@kernel.org>, David Howells <dhowells@redhat.com>, Andy Lutomirski <luto@kernel.org>, Christian Brauner <christian@brauner.io>, Eric Biederman <ebiederm@xmission.com>, Tycho Andersen <tycho@tycho.ws>, linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-arch@vger.kernel.org, linux-kselftest@vger.kernel.org, dev@opencontainers.org, containers@lists.linux-foundation.org
Message-ID: <20181001054723.2rpwNIm-tP2Hzo3QSmDIV9C2JtRfAFATV6fVbnWm7fU@z>


--tnspunvdzgqmlf36
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2018-10-01, Dave Chinner <david@fromorbit.com> wrote:
> > I've added some selftests for this, but it's not clear to me whether
> > they should live here or in xfstests (as far as I can tell there are no
> > other VFS tests in selftests, while there are some tests that look like
> > generic VFS tests in xfstests). If you'd prefer them to be included in
> > xfstests, let me know.
>=20
> xfstests, please. That way the new functionality will get immediate
> coverage by all the main filesystem development and distro QA
> teams....

Sure, will do. Do you want me to submit them in parallel -- and what is
the correct ML to submit changes to xfstests? Sorry for the silly
questions. :P

--=20
Aleksa Sarai
Senior Software Engineer (Containers)
SUSE Linux GmbH
<https://www.cyphar.com/>

--tnspunvdzgqmlf36
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEXzbGxhtUYBJKdfWmnhiqJn3bjbQFAluxtOsACgkQnhiqJn3b
jbQqAg//WFcKNlV1tSPzHG9JTv//wyGl9FY6gqg86/RbsjUwLuAPhlMi+hSqSvgB
7WMN1zMF5fnW1wxMqsj8vkL6WkYpcWxDxrVp4OBIi7iN3g734edhe5UZEpGgHm5S
QJqOQEfPwaVTOSJZojNnxoU7mzJGT20BptjhgRSlPR0MpnvA5rYfnZClYgfY0+zr
kdo1DQ2KbRt9kes+PxbTMre+COcVfXQvtV37Ydsyx7+PR8x1sCBBIQgGrELIF87t
EOrWy84gOja/4YSMqdXfqcwBiTI+UxmP8ulpC3nNKSwuDvwPRXNUUnJy1RHYlfCt
Zb3c2WTRZU0RhHjttajJGyAzF/ZERRBOWpBxePFgtP5z2Q5djuQohDP6ugqV9XFu
SgSG1wOKM9ptJlm1/NdC4Y47JrUuBxuQ0BU8uIjVpJssuyPXj7NGW1DHbL4i0PNm
uD9KdpKzYGVEvNHcywFHKabG6AqNOriki8h/BUc5GR79xadeEjpr2SUXD+0NSw4O
YKl677M45mQcasqzNlJrz+ASGJO18xnXrGIeCO1NtvjOCDsYoCOdaygQ27J4rXxo
2UrvoUyiaAzC1FhQceqq+LaPl+kY1DBtfTvKxIc6pS/WHVS+ntUOJgRVrPpdqZ0B
//8nJAGOjETFHFRKkWz5jaOsXJL4gl2JhJId88X1FIW97C2fbf4=
=hNmN
-----END PGP SIGNATURE-----

--tnspunvdzgqmlf36--
