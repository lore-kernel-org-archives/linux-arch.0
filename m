From: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Subject: Re: [PATCH v3 04/32] asm-generic: add ioremap_nopost() remap interface
Date: Tue, 11 Apr 2017 15:31:39 +0100
Message-ID: <20170411143138.GC6821@red-moon>
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
Cc: Jonas Bonn <jonas@southpole.se>, Rich Felker <dalias@libc.org>, linux-pci@vger.kernel.org, Will Deacon <will.deacon@arm.com>, "James E.J. Bottomley" <jejb@parisc-linux.org>, David Howells <dhowells@redhat.com>, Max Filippov <jcmvbkbc@gmail.com>, Paul Mackerras <paulus@samba.org>, Huacai Chen <chenhc@lemote.com>, Guan Xuetao <gxt@mprc.pku.edu.cn>, Thomas Gleixner <tglx@linutronix.de>, Hans-Christian Egtvedt <egtvedt@samfundet.no>, linux-arch@vger.kernel.org, Jesper Nilsson <jesper.nilsson@axis.com>, Yoshinori Sato <ysato@users.sourceforge.jp>, Michael Ellerman <mpe@ellerman.id.au>, Helge Deller <deller@gmx.de>, Russell King <linux@armlinux.org.uk>, Ingo Molnar <mingo@redhat.com>, Geert Uytterhoeven <geert@linux-m68k.org>, Catalin Marinas <catalin.marinas@arm.com>, Matt Turner <mattst88@gmail.com>, Haavard Skinnemoen <hskinnemoen@gmail.com>, Fenghua Yu <fenghua.yu@intel.co>
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

I agree that a default implementation does not make much sense. The
only solution to this, if we want the ioremap_nopost to be made available
to generic code (and drivers - ie DT PCI host bridge drivers on ARM/ARM64
are not arch code), is to make the ioremap_nopost() call return NULL
unless overriden by arch code that can provide its semantics.

Thanks,
Lorenzo
