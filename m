From: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: [PATCH 1/4] of: Add support for linking device tree blobs into
 vmlinux
Date: Thu, 23 Dec 2010 14:44:06 -0700
Message-ID: <20101223214405.GG20384@angua.secretlab.ca>
References: <1293047849-26078-1-git-send-email-dirk.brandewie@gmail.com>
 <1293047849-26078-2-git-send-email-dirk.brandewie@gmail.com>
 <4D127D72.8050303@suse.cz>
 <AANLkTik-yqs2Dy+MBAcQ5Gpb9Vcvd80BS=C=fuDe7z-A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kbuild-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <AANLkTik-yqs2Dy+MBAcQ5Gpb9Vcvd80BS=C=fuDe7z-A@mail.gmail.com>
Sender: linux-kbuild-owner@vger.kernel.org
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Michal Marek <mmarek@suse.cz>, linux-arch@vger.kernel.org, linux-kbuild@vger.kernel.org, microblaze-uclinux@itee.uq.edu.au, devicetree-discuss@lists.ozlabs.org, linux-kernel@vger.kernel.org, dirk.brandewie@gmail.com, linuxppc-dev@lists.ozlabs.org
List-Id: linux-arch.vger.kernel.org

On Thu, Dec 23, 2010 at 07:14:20AM +0100, Geert Uytterhoeven wrote:
> 2010/12/22 Michal Marek <mmarek@suse.cz>:
> > On 22.12.2010 20:57, dirk.brandewie@gmail.com wrote:
> >>
> >> From: Dirk Brandewie<dirk.brandewie@gmail.com>
> >>
> >> This patch adds support for linking device tree blob(s) into
> >> vmlinux. Modifies asm-generic/vmlinux.lds.h to add linking
> >> .dtb sections into vmlinux. To maintain compatiblity with the of/f=
dt
> >> driver code platforms MUST copy the blob to a non-init memory loca=
tion
> >> before the kernel frees the .init.* sections in the image.
> >>
> >> Modifies scripts/Makefile.lib to add a kbuild command to
> >> compile DTS files to device tree blobs and a rule to create object=
s to
> >> wrap the blobs for linking.
> >>
> >> STRUCT_ALIGNMENT is defined in vmlinux.lds.h for use in the rule t=
o
> >> create wrapper objects for the dtb in Makefile.lib. =A0The
> >> STRUCT_ALIGN() macro in vmlinux.lds.h is modified to use the
> >> STRUCT_ALIGNMENT definition.
> >>
> >> The DTB's are placed on 32 byte boundries to allow parsing the blo=
b
> >> with driver/of/fdt.c during early boot without having to copy the =
blob
> >> to get the structure alignment GCC expects.
> >>
> >> A DTB is linked in by adding the DTB object to the list of objects=
 to
> >> be linked into vmlinux in the archtecture specific Makefile using
> >> =A0 =A0obj-y +=3D foo.dtb.o
> >>
> >> Signed-off-by: Dirk Brandewie<dirk.brandewie@gmail.com>
> >
> > Hi,
> >
> > you can add
> > Acked-by: Michal Marek <mmarek@suse.cz>
> > but I thing this series should go through the tip tree, as your pri=
mary
> > target seems to be x86 and patch 2/4 depends on the ce4100 code tha=
t is only
> > in tip.
>=20
> If the two lines
>=20
> +# device tree blob
> +obj-$(CONFIG_X86_INTEL_CE) +=3D ce4100.dtb.o
>=20
> are removed, patch 2/4 no longer depends on the ce4100 code.
> The summary and description for that patch don't mention anything
> about ce4100 anyway.

I'd like to take this through the dt tree.  I'll drop the ce4100 hunk
when I merge it.

g.

>=20
> Gr{oetje,eeting}s,
>=20
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 Geert
>=20
> --
> Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linu=
x-m68k.org
>=20
> In personal conversations with technical people, I call myself a hack=
er. But
> when I'm talking to journalists I just say "programmer" or something =
like that.
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=A0 =A0=A0 -- =
Linus Torvalds
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@lists.ozlabs.org
> https://lists.ozlabs.org/listinfo/linuxppc-dev
--
To unsubscribe from this list: send the line "unsubscribe linux-kbuild"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
