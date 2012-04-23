From: Sam Ravnborg <sam@ravnborg.org>
Subject: Re: [RFC] move link of vmlinux to a script
Date: Mon, 23 Apr 2012 07:10:41 +0200
Message-ID: <20120423051041.GA6709@merkur.ravnborg.org>
References: <20120422212220.GA6537@merkur.ravnborg.org> <CACqU3MU7MS7MjpyiSx-tUJ6c3rSexUB5=vTGy6gPv_OJevuOqw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kbuild-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CACqU3MU7MS7MjpyiSx-tUJ6c3rSexUB5=vTGy6gPv_OJevuOqw@mail.gmail.com>
Sender: linux-kbuild-owner@vger.kernel.org
To: Arnaud Lacombe <lacombar@gmail.com>
Cc: linux arch <linux-arch@vger.kernel.org>, linux-kbuild <linux-kbuild@vger.kernel.org>, lkml <linux-kernel@vger.kernel.org>, Michal Marek <mmarek@suse.cz>
List-Id: linux-arch.vger.kernel.org

Hi Arnaud.

Thanks for the comments.

> > +# Link of vmlinux
> > +# $1 - optional extra .o files
> > +# $2 output file
> > +vmlinux_link()
> > +{
> > + =A0 =A0 =A0 local lds=3D${srctree}/arch/${SRCARCH}/kernel/vmlinux=
=2Elds
> > +echo srcarch=3D${SRCARCH} CF=3D${CFLAGS_vmlinux}
> debugging leftover ?
yes - will be deleted.

> > +
> > + =A0 =A0 =A0 local aflags=3D"${KBUILD_AFLAGS} ${AFLAGS_KERNEL} ${N=
OSTDINC_FLAGS} ${LINUXINCLUDE} ${KBUILD_CPPFLAGS} ${modkern_aflags}"
> might be worse splitting that line.

I may be able to drop several of the variables,
otherwise yes.

> > +mksysmap()
> > +{
> > + =A0 =A0 =A0 $NM -n $1 | \
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 grep -v '\( [aNUw] \)\|\(__crc_\)\|\(=
 \$[adt]\)' > $2
> > +}
> > +
> you don't seem to consistently use #{FOO} vs. $FOO.

=46or arguments I use $FOO for the rest ${FOO}
I will fix this up to be consistent.

> > +# Update version
> > +info GEN .version
> > +if [ ! -r .version ]; then
> why '-r' specifically ? '-e' might be just enough.

I was so before - this part is a copy from the kernel.
And there is already enough changes..

> > +# final build of init/
> > +${MAKE} -f ${srctree}/scripts/Makefile.build obj=3Dinit
> > +
> are spaces allowed in `srctree' ? if so, this will break here.
Good catch.
Sticking "" around should do the trick? I will try to do so.
I should also try if it works with spaces - I think not.


> > +kallsymso=3D""
> > +kallsyms_vmlinux=3D""
> > +
> > +if [ "${CONFIG_KALLSYMS}" !=3D "" ]; then
> > +
> [ -n "${CONFIG_KALLSYMS}" ] would work too, as well as the other
> places where you use the [ "${FOO}" !=3D "" ] syntax.

Much more readable - will change.

	Sam
--
To unsubscribe from this list: send the line "unsubscribe linux-kbuild"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
