From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 11/20] sound, skylake: switch from ioremap_cache to
 memremap
Date: Mon, 19 Oct 2015 17:08:42 +0100
Message-ID: <20151019160842.GF32054@sirena.org.uk>
References: <20151009221537.32203.5867.stgit@dwillia2-desk3.jf.intel.com>
 <20151009221635.32203.30755.stgit@dwillia2-desk3.jf.intel.com>
 <20151019152641.GC32054@sirena.org.uk>
 <s5hk2qi3m93.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="tmoQ0UElFV5VgXgH"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <s5hk2qi3m93.wl-tiwai@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Takashi Iwai <tiwai@suse.de>
Cc: Dan Williams <dan.j.williams@intel.com>, Liam Girdwood <lgirdwood@gmail.com>, Jeeja KP <jeeja.kp@intel.com>, linux-arm-kernel@lists.infradead.org, Jaroslav Kysela <perex@perex.cz>, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-arch.vger.kernel.org


--tmoQ0UElFV5VgXgH
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Oct 19, 2015 at 05:34:48PM +0200, Takashi Iwai wrote:
> Mark Brown wrote:

> > On Fri, Oct 09, 2015 at 06:16:36PM -0400, Dan Williams wrote:
> > > In preparation for deprecating ioremap_cache() convert its usage in
> > > skl-nhlt to memremap.

> > > -void __iomem *skl_nhlt_init(struct device *dev)
> > > +void *skl_nhlt_init(struct device *dev)

> > Why are we loosing the annotation here?

> It's the exact purpose of this patchset, as far as I understand.
> memremap() allows the driver accessing the mapped memory just like a
> normal memory unlike ioremap().

There's no mention of what the purpose of the conversion is in either
the patch or the cover letter so it's a bit unclear, some confirmation
would be good :(

--tmoQ0UElFV5VgXgH
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJWJRWJAAoJECTWi3JdVIfQDnkH/21yDAfjjam01THCt1nwF38r
dtojzNsMzERp8iWqE6hXTB0w2bunlH1JRvXgpQjoSe+ZugH/82OoL+rF0AlQbsWf
uO0JUsWEUgicgr+y1bnRy97h0gbIY402nr1c/VvyoVK+ITV9FLrgrfKrkFWXJH8n
jvOLz+vOYtWQWq1jKK0b0E4gdJ5TrQwYxDyFVZL9MMvQMl3c5eeoduGB5ssjxTdj
15j0ku8/Q0TqQTYPRul37wrSaOD62iRCbKxzkEGH6hzlTcJRPEPLBj35fEuRIbLA
SkXmQcaotdEcwMj5u0OMq+/gPKVe9Vqx8VQ62uF6rKLOJCkML5fzytb+GGRlpJ4=
=WgRq
-----END PGP SIGNATURE-----

--tmoQ0UElFV5VgXgH--
