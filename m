From: Aleksa Sarai <cyphar@cyphar.com>
Subject: Re: [PATCH v4 2/3] fs: openat2: Extend open_how to allow
 userspace-selected fds
Date: Mon, 20 Apr 2020 12:06:42 +1000
Message-ID: <20200420020642.xzkqikia6kmslkjh@yavin.dot.cyphar.com>
References: <cover.1586830316.git.josh@joshtriplett.org>
 <f969e7d45a8e83efc1ca13d675efd8775f13f376.1586830316.git.josh@joshtriplett.org>
 <20200419104404.j4e5gxdn2duvmu6s@yavin.dot.cyphar.com>
 <b7dae79b-4c5f-65f6-0960-617070357201@kernel.dk>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="nl3aoloccd36jfpc"
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mout-p-201.mailbox.org ([80.241.56.171]:46500 "EHLO
        mout-p-201.mailbox.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725953AbgDTCHA (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sun, 19 Apr 2020 22:07:00 -0400
Content-Disposition: inline
In-Reply-To: <b7dae79b-4c5f-65f6-0960-617070357201@kernel.dk>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Jens Axboe <axboe@kernel.dk>
Cc: Josh Triplett <josh@joshtriplett.org>, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, io-uring@vger.kernel.org, linux-arch@vger.kernel.org, Alexander Viro <viro@zeniv.linux.org.uk>, Arnd Bergmann <arnd@arndb.de>


--nl3aoloccd36jfpc
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2020-04-19, Jens Axboe <axboe@kernel.dk> wrote:
> On 4/19/20 4:44 AM, Aleksa Sarai wrote:
> > On 2020-04-13, Josh Triplett <josh@joshtriplett.org> wrote:
> >> Inspired by the X protocol's handling of XIDs, allow userspace to sele=
ct
> >> the file descriptor opened by openat2, so that it can use the resulting
> >> file descriptor in subsequent system calls without waiting for the
> >> response to openat2.
> >>
> >> In io_uring, this allows sequences like openat2/read/close without
> >> waiting for the openat2 to complete. Multiple such sequences can
> >> overlap, as long as each uses a distinct file descriptor.
> >=20
> > I'm not sure I understand this explanation -- how can you trigger a
> > syscall with an fd that hasn't yet been registered (unless you're just
> > hoping the race goes in your favour)?
>=20
> io_uring can do chains of requests, where each link in the chain isn't
> started until the previous one has completed. Hence if you know what fd
> that openat2 will return, you can submit a chain ala:
>=20
> <open file X, give me fd Y><read from fd Y><close fd Y>
>=20
> as a single submission. This isn't possible to do currently, as the read
> will depend on the output of the open, and we have no good way of
> knowing what that fd will be.

Ah! I was aware of io_uring's chaining feature but thought it had access
to the return of the previous stage -- now this makes much more sense.
Thanks.

--=20
Aleksa Sarai
Senior Software Engineer (Containers)
SUSE Linux GmbH
<https://www.cyphar.com/>

--nl3aoloccd36jfpc
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQSxZm6dtfE8gxLLfYqdlLljIbnQEgUCXp0DrwAKCRCdlLljIbnQ
EmOYAP4lkf0v9STwr5KoDYWT6PbyBkxhHUVVy9D52d30Gd/h6gD/eZQuaYg8dEjF
EJpgo1J1EPiK6PIgD34KjQNKv8C7fQ0=
=hBJk
-----END PGP SIGNATURE-----

--nl3aoloccd36jfpc--
