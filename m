From: Ingo Molnar <mingo@elte.hu>
Subject: Re: kbuild - introduce support for subdir-ccflags-y
Date: Sun, 19 Apr 2009 10:59:14 +0200
Message-ID: <20090419085914.GA25898@elte.hu>
References: <20090418125159.GA23008@uranus.ravnborg.org> <20090418125839.GA3668@flint.arm.linux.org.uk> <20090418150750.GA24059@elte.hu> <20090418180953.GE7148@flint.arm.linux.org.uk> <f73f7ab80904182017n7f27f49ck48ba200deb99388a@mail.gmail.com> <20090419062841.GA17801@uranus.ravnborg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kbuild-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20090419062841.GA17801@uranus.ravnborg.org>
Sender: linux-kbuild-owner@vger.kernel.org
To: Sam Ravnborg <sam@ravnborg.org>, Andrew Morton <akpm@linux-foundation.org>
Cc: Kyle Moffett <kyle@moffetthome.net>, linux-kbuild <linux-kbuild@vger.kernel.org>, linux arch <linux-arch@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>, "David S. Miller" <davem@davemloft.net>, Russell King <rmk+lkml@arm.linux.org.uk>
List-Id: linux-arch.vger.kernel.org


* Sam Ravnborg <sam@ravnborg.org> wrote:

> On Sat, Apr 18, 2009 at 11:17:44PM -0400, Kyle Moffett wrote:
> > On Sat, Apr 18, 2009 at 2:09 PM, Russell King <rmk+lkml@arm.linux.o=
rg.uk> wrote:
> > > On Sat, Apr 18, 2009 at 05:07:50PM +0200, Ingo Molnar wrote:
> > >> * Russell King <rmk+lkml@arm.linux.org.uk> wrote:
> > >> > On Sat, Apr 18, 2009 at 02:51:59PM +0200, Sam Ravnborg wrote:
> > >> > > The typical use cases are an architecture or a subsystem tha=
t
> > >> > > decide to cover all files with -Werror.
> > >> > > Today alpha, mips and sparc uses -Werror in almost all their
> > >> > > Makefile - with subdir-ccflag-y it is now simpler to do so
> > >> > > as only the top-level directories needs to be covered.
> > >> >
> > >> > Hmm, this won't make sense for ARM. =A0We have things like #wa=
rning
> > >> > and deprecated functions in machine specific headers, and addi=
ng
> > >> > -Werror to the whole of arch/arm/ will result in these causing
> > >> > builds to fail.
> > >>
> > >> This is optional - if you dont want it, you dont set it.
> > >
> > > Please read _all_ of my mail, particularly the bit where it talks=
 about
> > > it being useful for a certain subset.
> >=20
> > It's my impression that on x86 it's a config option whether or not =
to
> > build with -Werror.  You could do the exact same thing with an
> > internal inverted-logic CONFIG_ARM_ALLOW_WARNINGS option and make a=
ll
> > the boards triggering warnings "select ARM_ALLOW_WARNINGS".  Then h=
ave
> > a user-visible config option "ARM_USER_ALLOW_WARNINGS" which also
> > selects the internal option.  That adds some additional kconfig-lev=
el
> > documentation on which subarch combos need some love.
>=20
> Correct - but Russell's original comment was that the subdir-*=20
> feature was of no use for arm. And this is correct with the=20
> current way the individual directories are specified.
>=20
> If you compare arch/x86/kernel/ and arch/arm/kernel/ you will see=20
> that x86 has 3 subdirectories where arm has none.
>=20
> Another measure: Arm has 12 Makefiles outside mach* and plat*=20
> where x86 has 24 Makefiles.
>=20
> Ao unless Russell decide to take the patch that refactor all the=20
> core-* stuff out in a Kbuild file arm has no use of=20
> subdir-ccflags-y and can use the already existing ccflags-y if=20
> they decide to cover most of arm with -Werror.

Yes. This is an optional facility entirely - if some arch does
not need or does not want it, it does not have to care.

Sparc is the example to follow here: it has had unconditional=20
-Werror builds (for its architecture files) for years. It has
done so without any explicit kbuild help beyond a single-line
ccflags-y :=3D -Werror rule. Sparc has 7 makefiles and it has a=20
well-tested compiler environment.

We cannot do the same on x86 straight away: it's being built
on a very wide variety of compiler versions, by a very wide
range of people: more than 95% of our Linux kernel testers are
on x86.

Some of those compiler versions emit bogus warnings that cannot
be worked around in the kernel in any sane way - and a forced
-Werror build would thus become a (needless) show-stopper there.
It will also take some time to flush out any remaining warnings.

All in one, we want arch/x86 to become a -Werror-clean architecture=20
and we want all the advantages of that, but we didnt want to do any=20
artificial 'break the world' flag day.

So we are doing a hybrid approach instead, we are adding a=20
default-off .config option, and we are doing it all smoothly and=20
gradually.

The reason we asked Sam whether he can think of any kbuild help=20
(again, which is strictly optional) was that we didnt want to=20
propagate a 5-6 lines hybrid Makefile rule into 24 makefiles.

We could have done this all via a special makefile rule entirely
in arch/x86/ that is included in every secondary makefile - but
we also wanted to give other architectures an optional, librarized
kbuild facility to do the same, if they so choose.

Thanks,

	Ingo
--
To unsubscribe from this list: send the line "unsubscribe linux-kbuild"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
