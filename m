From: Russell King - ARM Linux <linux@armlinux.org.uk>
Subject: Re: [PATCH v3 04/32] asm-generic: add ioremap_nopost() remap interface
Date: Wed, 12 Apr 2017 12:20:22 +0100
Message-ID: <20170412112022.GY17774@n2100.armlinux.org.uk>
References: <20170411122923.6285-1-lorenzo.pieralisi@arm.com>
 <20170411122923.6285-5-lorenzo.pieralisi@arm.com>
 <1491917983.7236.9.camel@kernel.crashing.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <1491917983.7236.9.camel@kernel.crashing.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Jonas Bonn <jonas@southpole.se>, Rich Felker <dalias@libc.org>, linux-pci@vger.kernel.org, Will Deacon <will.deacon@arm.com>, David Howells <dhowells@redhat.com>, Max Filippov <jcmvbkbc@gmail.com>, Paul Mackerras <paulus@samba.org>, Huacai Chen <chenhc@lemote.com>, Guan Xuetao <gxt@mprc.pku.edu.cn>, Thomas Gleixner <tglx@linutronix.de>, Hans-Christian Egtvedt <egtvedt@samfundet.no>, linux-arch@vger.kernel.org, Jesper Nilsson <jesper.nilsson@axis.com>, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, Yoshinori Sato <ysato@users.sourceforge.jp>, Michael Ellerman <mpe@ellerman.id.au>, Helge Deller <deller@gmx.de>, "James E.J. Bottomley" <jejb@parisc-linux.org>, Ingo Molnar <mingo@redhat.com>, Geert Uytterhoeven <geert@linux-m68k.org>, Catalin Marinas <catalin.marinas@arm.com>, Matt Turner <mattst88@gmail.com>, Haavard Skinnemoen <hskinnemoen@gmail.com>, Fenghua Yu <fenghua.yu>
List-Id: linux-arch.vger.kernel.org

On Tue, Apr 11, 2017 at 11:39:43PM +1000, Benjamin Herrenschmidt wrote:
> On Tue, 2017-04-11 at 13:28 +0100, Lorenzo Pieralisi wrote:
> > +static inline void __iomem *ioremap_nopost(phys_addr_t offset,
> > size_t size)
> > +{
> > +=A0=A0=A0=A0=A0=A0=A0return ioremap_nocache(offset, size);
> > +}
> > +
> =

> No this is wrong as I explained.
> =

> This is a semantic that simply *cannot* be generically provided accross
> architectures as a mapping attribute.
> =

> The solution to your problem lies elsewhere.

I disagree.  Sure, it may not be supportable across all architectures,
but we're not introducing something brand new here.

What we're trying to do is to fix some _existing_ drivers that are
already using ioremap() to map the PCI IO and configuration spaces.
Maybe it would help if those drivers were part of this patch set,
rather than the patch set just introducing a whole new architecture
interface without really showing where the problem drivers are.

The issue here is that if we make this new ioremap_nopost() fail by
returning NULL if an architecture does not provide an implementation,
then these drivers are going to start failing on such architectures.

It is only safe to do that where we know for certain that the drivers
are not used - but I don't think that's the case here (it's difficult
to tell, because no drivers are updated in this series, so we don't
know which are going to be affected.)

So, the question is:

- is it better to provide a default implementation which provides the
  functionality that existing drivers are _already_ using, albiet not
  entirely correctly.

or:

- is it better to break drivers on architectures when they're converted
  to fix up this issue.

What, I suppose, we could do is not bother with a default implementation,
but instead litter drivers with:

+#ifdef ioremap_post
+	base =3D ioremap_post(...);
+#else
	base =3D ioremap(...);
+#endif

which gets around your objection - not providing a default that's weaker
than required, but also not breaking the drivers.  The problem is that
we end up littering drivers with ifdefs.

However, I'm willing to bet that the architectures that you're saying
will not be able to support the weaker semantic won't have any need to
use these drivers, or if they do, the drivers will need the method of
accessing stuff like PCI IO and configuration spaces radically altered.

So, maybe the best solution is to not provide any kind of default
implementation, add a HAVE_IOREMAP_POST Kconfig symbol, have architectures
select that when they do provide ioremap_post(), and make the drivers
depend on that (so we don't end up trying to build these drivers on
architectures where they can never work.)  Down side to that is reduced
build coverage.

-- =

RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
