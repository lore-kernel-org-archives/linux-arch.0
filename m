From: Russell King - ARM Linux <linux@armlinux.org.uk>
Subject: Re: [PATCH v3 00/32] PCI: fix config and I/O Address space memory
 mappings
Date: Wed, 12 Apr 2017 15:16:55 +0100
Message-ID: <20170412141654.GA17774@n2100.armlinux.org.uk>
References: <20170411122923.6285-1-lorenzo.pieralisi@arm.com>
 <1491917906.7236.7.camel@kernel.crashing.org>
 <20170411140857.GA6821@red-moon>
 <1491952371.7236.22.camel@kernel.crashing.org>
 <20170412113124.GZ17774@n2100.armlinux.org.uk>
 <1492005119.7236.62.camel@kernel.crashing.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <1492005119.7236.62.camel@kernel.crashing.org>
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

On Wed, Apr 12, 2017 at 11:51:59PM +1000, Benjamin Herrenschmidt wrote:
> On Wed, 2017-04-12 at 12:31 +0100, Russell King - ARM Linux wrote:
> > default implementation should fail if it's not supportable on all
> > architectures.=A0 However, when we have existing drivers using an
> > interface that doesn't provide the semantics they already require,
> > then it makes no sense to effectively break these drivers on a range
> > of existing architectures.
> > =

> > The question really is - what's the best way to solve the problem
> > with
> > existing drivers without breaking them.=A0 I suspect that, sadly, the
> > only realistic way forward here is via the litter-drivers-with-ifdefs
> > approach since you don't like providing a default implementation that
> > is compatible with what these drivers are already doing.
> =

> Then make ioremap_nopost return NULL when the arch doesn't have =

> the right semantic.
> =

> The driver than can *chose* to either silently fallback to ioremap,
> which has served us well for a long time despite being theorically in
> violation of the spec, or do funny things like read back some register
> after every config write to ensure ordering etc...
> =

> I much prefer that approach than having some generic ioremap function
> that exposes a semantic that silently provides a weaker one on some
> architecture.
> =

> At least we make the failure explicit, and the driver can take
> alternate (possibly sub-optimal) action if it chooses to do so.

The same points apply to things like pgprot_writecombine(),
pgprot_noncached(), pgprot_device().  Then there's also pgprot_nonposted()
that this series also introduces.

If ioremap_nopost() is not possible on an architecture, then
pgprot_nonposted() won't be possible either - but you've made no
mention of that so far.

Just like the proposed ioremap_nopost(), pgprot_nonposted() is given a
default implementation that uses pgprot_noncached().  Maybe we should
also make pci_remap_iospace() fail if pgprot_nonposted() is not defined
by the architecture?

-- =

RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
