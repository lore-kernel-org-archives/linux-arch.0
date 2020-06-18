Return-Path: <SRS0=SYs/=77=kvack.org=owner-linux-mm@kernel.org>
Date: Thu, 18 Jun 2020 11:19:25 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
Subject: Re: [PATCH] mm: Move p?d_alloc_track to separate header file
Message-ID: <20200618111925.28100ec9@canb.auug.org.au>
In-Reply-To: <20200609120533.25867-1-joro@8bytes.org>
References: <20200609120533.25867-1-joro@8bytes.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/YCi/Nnb9cueQmER4WWU5i5W";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Sender: owner-linux-mm@kvack.org
To: Joerg Roedel <joro@8bytes.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, peterz@infradead.org, jroedel@suse.de, Andy Lutomirski <luto@kernel.org>, Abdul Haleem <abdhalee@linux.vnet.ibm.com>, Satheesh Rajendran <sathnaga@linux.vnet.ibm.com>, manvanth@linux.vnet.ibm.com, linux-next@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>, Mike Rapoport <rppt@linux.ibm.com>, Linus Torvalds <torvalds@linux-foundation.org>, linuxppc-dev@lists.ozlabs.org, hch@lst.de, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, linux-mm@kvack.org
List-ID: <linux-arch.vger.kernel.org>
Message-ID: <20200618011925.I6NLHWFbS_miuUBo8KIf3G6dekq8YoPbRllGW7ygNEU@z>

--Sig_/YCi/Nnb9cueQmER4WWU5i5W
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Joerg,

Sorry for the late reply.

On Tue,  9 Jun 2020 14:05:33 +0200 Joerg Roedel <joro@8bytes.org> wrote:
>
> diff --git a/include/linux/pgalloc-track.h b/include/linux/pgalloc-track.h
> new file mode 100644
> index 000000000000..1dcc865029a2
> --- /dev/null
> +++ b/include/linux/pgalloc-track.h
> @@ -0,0 +1,51 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +#ifndef _LINUX_PGALLLC_TRACK_H
> +#define _LINUX_PGALLLC_TRACK_H
> +

Maybe this could have a comment that it should always be included after
mm.h or we could add enough to make it standalone (even just an include
of mm.h would probably be enough).

--=20
Cheers,
Stephen Rothwell

--Sig_/YCi/Nnb9cueQmER4WWU5i5W
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAl7qwR0ACgkQAVBC80lX
0GysAwf/ZNngUfjr8j+WzPw9diANohv/lSl2wn69fUe4dvCuORBkF0ItPZodhAX1
8MaSeeYqtRt3Vh0xFgsA/rW4DxOxSQN87G1QBgSCA2BFkNs/sxDhMTs0CJmZR52y
LtRaXmfro+7Z9Th1DBKbJA5Waw0Cw90U5muGvb/FFmjvKKGOX52g7lb8RWyeoNe0
FcngH+KvpNBenHro9/87VSadAb5Ch7IoTx1x0eFF0oDtEBe8tOs/ZpLfTUKnql04
FqVy/p1HMv0vNZyc4hFukB1IcPeCSK/YXKHleZ0nIWQ/Qeo6lwlEzboK3ixEBt5B
4YrmmUYfdVq6Mk2Bhnp4uBIO8aYmMw==
=bxHw
-----END PGP SIGNATURE-----

--Sig_/YCi/Nnb9cueQmER4WWU5i5W--
