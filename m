From: James Hogan <james.hogan@imgtec.com>
Subject: Re: [PATCH v2 2/2] kbuild: Remove stale asm-generic wrappers
Date: Thu, 21 Jan 2016 10:19:21 +0000
Message-ID: <20160121101921.GC24198@jhogan-linux.le.imgtec.org>
References: <1453210670-12596-1-git-send-email-james.hogan@imgtec.com>
 <1453210670-12596-3-git-send-email-james.hogan@imgtec.com>
 <20160121000342.GA7538@NP-P-BURTON>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="bAmEntskrkuBymla"
Return-path: <linux-kbuild-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20160121000342.GA7538@NP-P-BURTON>
Sender: linux-kbuild-owner@vger.kernel.org
To: Paul Burton <paul.burton@imgtec.com>
Cc: Michal Marek <mmarek@suse.com>, linux-kernel@vger.kernel.org, Heinrich Schuchardt <xypron.glpk@gmx.de>, Arnd Bergmann <arnd@arndb.de>, Ralf Baechle <ralf@linux-mips.org>, Florian Fainelli <f.fainelli@gmail.com>, linux-kbuild@vger.kernel.org, linux-arch@vger.kernel.org, linux-mips@linux-mips.org
List-Id: linux-arch.vger.kernel.org

--bAmEntskrkuBymla
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 21, 2016 at 12:03:42AM +0000, Paul Burton wrote:
> On Tue, Jan 19, 2016 at 01:37:50PM +0000, James Hogan wrote:
> > When a header file is removed from generic-y (often accompanied by the
> > addition of an arch specific header), the generated wrapper file will
> > persist, and in some cases may still take precedence over the new arch
> > header.
> >=20
> > For example commit f1fe2d21f4e1 ("MIPS: Add definitions for extended
> > context") removed ucontext.h from generic-y in arch/mips/include/asm/,
> > and added an arch/mips/include/uapi/asm/ucontext.h. The continued use of
> > the wrapper when reusing a dirty build tree resulted in build failures
> > in arch/mips/kernel/signal.c:
> >=20
> > arch/mips/kernel/signal.c: In function =E2=80=98sc_to_extcontext=E2=80=
=99:
> > arch/mips/kernel/signal.c:142:12: error: =E2=80=98struct ucontext=E2=80=
=99 has no member named =E2=80=98uc_extcontext=E2=80=99
> >   return &uc->uc_extcontext;
> >             ^
> >=20
> > Fix by detecting and removing wrapper headers in generated header
> > directories that do not correspond to a filename in generic-y, genhdr-y,
> > or the newly introduced generated-y.
> >=20
> > Reported-by: Jacek Anaszewski <j.anaszewski@samsung.com>
> > Reported-by: Hauke Mehrtens <hauke@hauke-m.de>
> > Reported-by: Heinrich Schuchardt <xypron.glpk@gmx.de>
> > Signed-off-by: James Hogan <james.hogan@imgtec.com>
> > Cc: Michal Marek <mmarek@suse.com>
> > Cc: Arnd Bergmann <arnd@arndb.de>
> > Cc: Ralf Baechle <ralf@linux-mips.org>
> > Cc: Paul Burton <paul.burton@imgtec.com>
> > Cc: Florian Fainelli <f.fainelli@gmail.com>
> > Cc: linux-kbuild@vger.kernel.org
> > Cc: linux-arch@vger.kernel.org
> > Cc: linux-mips@linux-mips.org
> > ---
> > Changes in v2:
> > - Rewrite a bit, drawing inspiration from Makefile.headersinst.
> > - Exclude genhdr-y and generated-y (thanks to kbuild test robot).
> > ---
> >  scripts/Makefile.asm-generic | 17 ++++++++++++++++-
> >  1 file changed, 16 insertions(+), 1 deletion(-)
> >=20
> > diff --git a/scripts/Makefile.asm-generic b/scripts/Makefile.asm-generic
> > index 045e0098e962..24c29f16f029 100644
> > --- a/scripts/Makefile.asm-generic
> > +++ b/scripts/Makefile.asm-generic
> > @@ -13,11 +13,26 @@ include scripts/Kbuild.include
> >  # Create output directory if not already present
> >  _dummy :=3D $(shell [ -d $(obj) ] || mkdir -p $(obj))
> > =20
> > +# Stale wrappers when the corresponding files are removed from generic=
-y
> > +# need removing.
> > +generated-y   :=3D $(generic-y) $(genhdr-y) $(generated-y)
> > +all-files     :=3D $(patsubst %, $(obj)/%, $(generated-y))
> > +old-headers   :=3D $(wildcard $(obj)/*.h)
> > +unwanted      :=3D $(filter-out $(all-files),$(old-headers))
>=20
> Hi James,
>=20
> Thanks a bunch for fixing this!

FTR, I noticed yesterday it fixes a similar case when switching v4.3 to
v4.4 too:

arch/mips/kernel/../../../fs/binfmt_elf.c In function =E2=80=98create_elf_t=
ables=E2=80=99:
=2E/arch/mips/include/asm/elf.h +425 :14: error: =E2=80=98AT_SYSINFO_EHDR=
=E2=80=99 undeclared (first use in this function)
  NEW_AUX_ENT(AT_SYSINFO_EHDR,     \
              ^

Due to commit ebb5e78cc634 ("MIPS: Initial implementation of a VDSO")
adding uapi/asm/auxvec.h and changing generic-y to header-y. Should
ucontext.h be exported via header-y too?

With these patches, it removes the stale file:
  REMOVE  arch/mips/include/generated/uapi/asm/auxvec.h

>=20
> Though is it my sleepy self or are all-files & old-headers misnomers?
> That is, isn't all-files actually a list of headers to be kept, and
> old-headers actually the list of all (header) files?

I've followed the naming in Makefile.headersinst. I read all-files as
"all the files we care about" (i.e. its a combination of several sets of
generated files, hence "all") and old-headers as in "existing headers"
(since it won't include files which haven't been generated yet).

all-files could perhaps be renamed new-headers, but that could be
misleading too.

Cheers
James

>=20
> Thanks,
>     Paul
>=20
> > +
> >  quiet_cmd_wrap =3D WRAP    $@
> >  cmd_wrap =3D echo "\#include <asm-generic/$*.h>" >$@
> > =20
> > -all: $(patsubst %, $(obj)/%, $(generic-y))
> > +quiet_cmd_remove =3D REMOVE  $(unwanted)
> > +cmd_remove =3D rm -f $(unwanted)
> > +
> > +all: $(patsubst %, $(obj)/%, $(generic-y)) FORCE
> > +	$(if $(unwanted),$(call cmd,remove),)
> >  	@:
> > =20
> >  $(obj)/%.h:
> >  	$(call cmd,wrap)
> > +
> > +.PHONY: $(PHONY)
> > +PHONY +=3D FORCE
> > +FORCE: ;
> > --=20
> > 2.4.10
> >=20

--bAmEntskrkuBymla
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJWoLCpAAoJEGwLaZPeOHZ6TaYP/iZf6/2NywLVhS2CqOESHACj
QCJ192fD3M6pC8KZ0oMw0mqNGupk4G3y7Q1S5uLhm1mI5Ggu3kmvM4x062jFYAZ5
TQJmpqOqrRAhCWCcEr3MPY3YoPk/ReCs6Z3CtvZ2h+NzG/69GWGZ9gvYfvcVYs9G
FbzOfPvQq4vUTV3wYdZfkep4bVDFIgUJoCLJuPpTvzcIwDNXu+J8YNYwhphOkFJO
bsLFpfqd0s/fWhv/hrCf0q1ZM4M899D2wJjOumCeM2rTmzw/CQLbtxOEoyp4aZq9
lIl2hMgN/cGuBv86dRLwdlOI3hg5sDu74HNQQpXgm9dOFe+TMUoLekeekWs7CEqe
3lN4zy7HSn6tKjk/OjK5o4vkBUKFIrRh1rV7aSQ85CxuClvaPeSZ5aWS6pVrGXJg
VaTXeqMF49ref03vs28iQ3ZvwiyLlow5v9JM4z8hSJoXil5SIfU3YxCa57pcqlTB
92pNm5zipZK8pvMdGIPkkp3V1I07nnUH/ziUIWIPgnVNbJe5GjHDVUIYChVtJJoQ
0P7ScIJZ2D0ggdOL2+EBZ+bAYzIuP4y5x0K2G9SXp7pfy/VJhVH7Xtpzy/cSpDgS
Fe0+BuS6P8EUacScrN99EdoNCs0HaQIEXJKvPRcj5qFPWe8oCwWv40PpesdUxZ8c
N1/7yI/91ymf1KdLbHIs
=aDXE
-----END PGP SIGNATURE-----

--bAmEntskrkuBymla--
