From: Stephen Rothwell <sfr-3FnU+UHB4dNDw9hX6IcOSA@public.gmane.org>
Subject: Re: down_spin() implementation
Date: Fri, 28 Mar 2008 15:51:07 +1100
Message-ID: <20080328155107.e9d8866c.sfr@canb.auug.org.au>
References: <1FE6DD409037234FAB833C420AA843ECE9DF60@orsmsx424.amr.corp.intel.com>
	<20080326123239.GG16721@parisc-linux.org>
	<1FE6DD409037234FAB833C420AA843ECE9EB1C@orsmsx424.amr.corp.intel.com>
	<20080327141508.GL16721@parisc-linux.org>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
 micalg="PGP-SHA1";
 boundary="Signature=_Fri__28_Mar_2008_15_51_07_+1100_dVUL9o9+k43d_Bn2"
Return-path: <linux-arch-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20080327141508.GL16721-6jwH94ZQLHl74goWV3ctuw@public.gmane.org>
Sender: linux-arch-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-arch.vger.kernel.org>
To: Matthew Wilcox <matthew-Ztpu424NOJ8@public.gmane.org>
Cc: "Luck, Tony" <tony.luck-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, linux-arch-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-mm-Bw31MaZKKs3YtjvyW6yDsg@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

--Signature=_Fri__28_Mar_2008_15_51_07_+1100_dVUL9o9+k43d_Bn2
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Willy,

On Thu, 27 Mar 2008 08:15:08 -0600 Matthew Wilcox <matthew-Ztpu424NOJ8@public.gmane.org> wrote:
>
> Stephen, I've updated the 'semaphore' tag to point ot the same place as
> semaphore-20080327, so please change your linux-next tree from pulling
> semaphore-20080314 to just pulling plain 'semaphore'.  I'll use this
> method of tagging from now on.

Thanks. I read this to late for today's tree, but I will fix it up for
the next one.

--=20
Cheers,
Stephen Rothwell                    sfr-3FnU+UHB4dNDw9hX6IcOSA@public.gmane.org
http://www.canb.auug.org.au/~sfr/

--Signature=_Fri__28_Mar_2008_15_51_07_+1100_dVUL9o9+k43d_Bn2
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQFH7Hk+TgG2atn1QN8RAl+9AJwO3qpUPqXmQXwE1clMcEZF9ZV8RgCfRSx6
uWXD5SK8cMNVZ8YwG2QNKr0=
=RLpt
-----END PGP SIGNATURE-----

--Signature=_Fri__28_Mar_2008_15_51_07_+1100_dVUL9o9+k43d_Bn2--
