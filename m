From: Aleksa Sarai <cyphar@cyphar.com>
Subject: Re: [PATCH 1/3] namei: implement O_BENEATH-style AT_* flags
Date: Sun, 30 Sep 2018 14:38:23 +1000
Message-ID: <20180930043823.2pgzrtgcziaou7ov@ryuk>
References: <20180929103453.12025-1-cyphar@cyphar.com>
 <20180929103453.12025-2-cyphar@cyphar.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="r6lzrlms3sezh4bg"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180929103453.12025-2-cyphar@cyphar.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Jeff Layton <jlayton@kernel.org>, "J. Bruce Fields" <bfields@fieldses.org>, Al Viro <viro@zeniv.linux.org.uk>, Arnd Bergmann <arnd@arndb.de>, Shuah Khan <shuah@kernel.org>
Cc: David Howells <dhowells@redhat.com>, Andy Lutomirski <luto@kernel.org>, Christian Brauner <christian@brauner.io>, Eric Biederman <ebiederm@xmission.com>, Aleksa Sarai <cyphar@cyphar.com>, Tycho Andersen <tycho@tycho.ws>, linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-arch@vger.kernel.org, linux-kselftest@vger.kernel.org, dev@opencontainers.org, containers@lists.linux-foundation.org
List-Id: linux-arch.vger.kernel.org


--r6lzrlms3sezh4bg
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2018-09-29, Aleksa Sarai <cyphar@cyphar.com> wrote:
> * AT_XDEV: Disallow mount-point crossing (both *down* into one, or *up*
>   from one). The primary "scoping" use is to blocking resolution that
>   crosses a bind-mount, which has a similar property to a symlink (in
>   the way that it allows for escape from the starting-point). Since it
>   is not possible to differentiate bind-mounts However since
>   bind-mounting requires privileges (in ways symlinks don't) this has
>   been split from LOOKUP_BENEATH. The naming is based on "find -xdev"
>   (though find(1) doesn't walk upwards, the semantics seem obvious).

I've just noticed that the mountpoint-crossing code for AT_XDEV doesn't
detect things like:

   % ln -s / /tmp/jumpup
   % vfs_helper -o open -F xdev -d /tmp jumpup
   /

I will fix that in v2.

--=20
Aleksa Sarai
Senior Software Engineer (Containers)
SUSE Linux GmbH
<https://www.cyphar.com/>

--r6lzrlms3sezh4bg
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEXzbGxhtUYBJKdfWmnhiqJn3bjbQFAluwUz4ACgkQnhiqJn3b
jbS7URAAsh090oENRqj3EHW+hMMyrQ8ZjdRvylkNYtvhnGchEihDVXj4/NTprb9L
q1HdUQUW+v0CE7ow1H05L2F9RtMexztYwQvohdDNjgsaXFA5TYPB9cmkC6gaZoyE
On907Yd6LD1AzK+UDaq9ZYxTOgVVFi12xc5lY84jp3EFgSLQ4NB6hD6K8g4eGKym
1lkClzi8seX4o6FziHQC/3al+e3hIRzYF0HTLUbh9+bfuzpKI1tE14Bk1ijLa0Ow
jJdAuXcUfvYhznSjFUL0zbgXsUKQps9d/RnqVTb8gAI5Xa1r+Ht2ZpTdi3yt6LO6
SqQWCy/aIjc6dOu58xc6UeBW45iAzUFiD4VsH0qZtpHkbrvpUQ+K0rJ6fnEzdLr9
tN4X/cAY/q4DvuRwz69VgqjYXftgiilNwBKPMJewGl31ruGlywzrqgsYimuQFRXt
qbhTQcKWht09S4IPKAXS2dBlhLG94/aUijjYg8HwXAtHUj+dOjExpvtaPkmAL3kU
bgmB2kXlgcmLBLUSi8es5ILTD4N6wqgtwbcugCDHoiXwitprT9VHyIl/Tmm8G9nI
SIXVe5P+AwvRVL+Bq/vWceyPYH8T9bCObdI3NvB9jdO4nU2xfEqLAFzICOKsdFow
obiD/n0Cl60vdnJS6miCV7kzEkcnT4aPe5ycdkPI5y4dYEgWzOQ=
=jwmS
-----END PGP SIGNATURE-----

--r6lzrlms3sezh4bg--
