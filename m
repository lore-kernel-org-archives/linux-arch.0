From: Pavel Machek <pavel@ucw.cz>
Subject: Re: rfc: remove early_printk from a few arches? (blackfin, m68k,
 mips)
Date: Sun, 28 Dec 2014 19:36:25 +0100
Message-ID: <20141228183625.GE3922@amd>
References: <1418849927.28384.1.camel@perches.com>
 <alpine.DEB.2.11.1412190031530.17382@nanos>
 <1418951658.28384.20.camel@perches.com>
 <yw1x388ch0su.fsf@unicorn.mansr.com>
 <1418954914.25129.1.camel@perches.com>
 <yw1xy4q4exo9.fsf@unicorn.mansr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-m68k-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <yw1xy4q4exo9.fsf@unicorn.mansr.com>
Sender: linux-m68k-owner@vger.kernel.org
To: =?iso-8859-1?Q?M=E5ns_Rullg=E5rd?= <mans@mansr.com>
Cc: Joe Perches <joe@perches.com>, Thomas Gleixner <tglx@linutronix.de>, linux-arch <linux-arch@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, Geert Uytterhoeven <geert@linux-m68k.org>, linux-m68k <linux-m68k@lists.linux-m68k.org>, Steven Miao <realmz6@gmail.com>, Ralf Baechle <ralf@linux-mips.org>, linux-mips <linux-mips@linux-mips.org>
List-Id: linux-arch.vger.kernel.org

On Fri 2014-12-19 10:33:42, M=E5ns Rullg=E5rd wrote:
> Joe Perches <joe@perches.com> writes:
>=20
> > On Fri, 2014-12-19 at 01:43 +0000, M=E5ns Rullg=E5rd wrote:
> >> What exactly are you proposing to remove?
> >
> > Optionally compile out
> > kernel/printk/printk.c:early_printk()
> > even if CONFIG_EARLY_PRINTK is enabled.
> >
> >> I see no unused code related
> >> to early printk (in any variant) under arch/mips.
> >
> > I think there could be yet another CONFIG option
> > to specifically enable the early_printk function
> > for the arches that use it.
>=20
> Why bother?  On MIPS it would save 132 bytes of compiled code.
>=20
> > The kernel/printk/early_printk() function seems
> > used only by arm/microblaze/tile/x86.
>=20
> Rather than introduce more config complexity, you could try to remove
> the 7 remaining uses of early_printk().
>=20
> - arch/arm/mach-socfpga
>   Single early_printk("Early printk initialized\n") call serving no
>   apparent purpose can probably be safely deleted.  Since there are n=
o
>   other early_printk() calls, this information seems rather useless.

=46eel free to do that, but please keep early_printk() available...

=2E..so that I can debug the socfpga early boot when needed.

								Pavel
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses=
/blog.html
