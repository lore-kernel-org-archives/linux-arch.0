From: Michal Marek <mmarek@suse.cz>
Subject: Re: [PATCH 3/4] kbuild: link of vmlinux moved to a script
Date: Thu, 10 May 2012 14:22:10 +0200
Message-ID: <20120510122210.GA17550@sepie.suse.cz>
References: <20120428205651.GA7426@merkur.ravnborg.org>
 <20120428205919.GC7442@merkur.ravnborg.org>
 <4FA460AB.6060309@suse.cz>
 <20120505082916.GA14006@merkur.ravnborg.org>
 <CA+8MBbKd9zAouJy5JvUnLwUHMJ65HsYgCTfBgv42nm32EnMPFA@mail.gmail.com>
 <20120508165118.GA11750@merkur.ravnborg.org>
 <CAP=VYLobO--uwxv_hiMYBnjD-AU_0fqyQJD6argQygnkHnm5Vg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kbuild-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAP=VYLobO--uwxv_hiMYBnjD-AU_0fqyQJD6argQygnkHnm5Vg@mail.gmail.com>
Sender: linux-kbuild-owner@vger.kernel.org
To: Paul Gortmaker <paul.gortmaker@windriver.com>
Cc: Sam Ravnborg <sam@ravnborg.org>, Tony Luck <tony.luck@gmail.com>, linux arch <linux-arch@vger.kernel.org>, lkml <linux-kernel@vger.kernel.org>, linux-kbuild <linux-kbuild@vger.kernel.org>, Richard Weinberger <richard@nod.at>, "David S. Miller" <davem@davemloft.net>, Arnaud Lacombe <lacombar@gmail.com>, Andi Kleen <andi@firstfloor.org>, ralf@linux-mips.org, linux-mips@linux-mips.org
List-Id: linux-arch.vger.kernel.org

On Wed, May 09, 2012 at 06:58:16PM -0400, Paul Gortmaker wrote:
> On Tue, May 8, 2012 at 12:51 PM, Sam Ravnborg <sam@ravnborg.org> wrot=
e:
> > diff --git a/scripts/link-vmlinux.sh b/scripts/link-vmlinux.sh
> > index 26c5b65..1f4c27b 100644
> > --- a/scripts/link-vmlinux.sh
> > +++ b/scripts/link-vmlinux.sh
> > @@ -78,8 +78,8 @@ kallsyms()
> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0kallsymopt=3D--all-symbols
> > =A0 =A0 =A0 =A0fi
> >
> > - =A0 =A0 =A0 local aflags=3D"${KBUILD_AFLAGS} ${NOSTDINC_FLAGS} =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 \
> > - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 ${LINUXINCLUDE} ${KBUILD_=
CPPFLAGS}"
> > + =A0 =A0 =A0 local aflags=3D"${KBUILD_AFLAGS} ${KBUILD_AFLAGS_KERN=
EL} =A0 =A0 =A0 =A0 =A0 =A0 =A0 \
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 ${NOSTDINC_FLAGS} ${LINUX=
INCLUDE} ${KBUILD_CPPFLAGS}"
>=20
> All the linux-next builds for mips are failing, which I tracked down =
to this.
> Applying the above update doesn't help.  What is happening is that MI=
PS
> gets KBUILD_CPPFLAGS double-quoted, and then you get:
>=20
> + mips-wrs-linux-gnu-nm -n .tmp_vmlinux1
> + scripts/kallsyms
> + mips-wrs-linux-gnu-gcc -D__ASSEMBLY__ <..snip..>  -D__KERNEL__
> '-D"VMLINUX_LOAD_ADDRESS=3D0xffffffff81100000"' '-D"DATAOFFSET=3D0"' =
-c -o
> .tmp_kallsyms1.o -x assembler-with-cpp -
> <command-line>:0: error: macro names must be identifiers
> <command-line>:0: error: macro names must be identifiers
> make[1]: *** [vmlinux] Error 1
>=20
> Note the  '-D"VMLINUX_LOAD_ADDRESS=3D0xffffffff81100000"' '-D"DATAOFF=
SET=3D0"'
> part -- that is what triggers the two above errors.

I think it should be as simple as the below patch. But I have no mips
machine to verify myself.

Michal

=46rom d801533d5e6e509d5e115d2fb47655267c4c5ed4 Mon Sep 17 00:00:00 200=
1
=46rom: Michal Marek <mmarek@suse.cz>
Date: Thu, 10 May 2012 14:15:49 +0200
Subject: [PATCH] mips: Fix KBUILD_CPPFLAGS definition

The KBUILD_CPPFLAGS variable is no longer passed to sh -c 'gcc ...',
but exported and used by the link-vmlinux.sh script. This means that th=
e
double-quotes will not be evaluated by the shell.

Reported-by: Paul Gortmaker <paul.gortmaker@windriver.com>
Signed-off-by: Michal Marek <mmarek@suse.cz>

diff --git a/arch/mips/Makefile b/arch/mips/Makefile
index 4fedf5a..722e04a 100644
--- a/arch/mips/Makefile
+++ b/arch/mips/Makefile
@@ -219,8 +219,8 @@ endif
=20
 KBUILD_AFLAGS	+=3D $(cflags-y)
 KBUILD_CFLAGS	+=3D $(cflags-y)
-KBUILD_CPPFLAGS +=3D -D"VMLINUX_LOAD_ADDRESS=3D$(load-y)"
-KBUILD_CPPFLAGS +=3D -D"DATAOFFSET=3D$(if $(dataoffset-y),$(dataoffset=
-y),0)"
+KBUILD_CPPFLAGS +=3D -DVMLINUX_LOAD_ADDRESS=3D$(load-y)
+KBUILD_CPPFLAGS +=3D -DDATAOFFSET=3D$(if $(dataoffset-y),$(dataoffset-=
y),0)
=20
 LDFLAGS			+=3D -m $(ld-emul)
=20
--
To unsubscribe from this list: send the line "unsubscribe linux-kbuild"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
