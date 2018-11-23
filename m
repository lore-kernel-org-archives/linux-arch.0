From: Masahiro Yamada <yamada.masahiro@socionext.com>
Subject: Re: [PATCH 3/9] MIPS: remove the HT_PCI config option
Date: Fri, 23 Nov 2018 11:37:32 +0900
Message-ID: <CAK7LNAQ5DHbe7RwixEi6vf6y+LzB5so0=xyFMMpv+xmEnVA3Mw@mail.gmail.com>
References: <20181115190538.17016-1-hch@lst.de> <20181115190538.17016-4-hch@lst.de>
 <20181119210141.nissqr6zaldt23xg@pburton-laptop> <20181119210538.p6xhyxf3s2diyv2v@pburton-laptop>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181119210538.p6xhyxf3s2diyv2v@pburton-laptop>
Sender: linux-kernel-owner@vger.kernel.org
To: Paul Burton <paul.burton@mips.com>
Cc: Christoph Hellwig <hch@lst.de>, mporter@kernel.crashing.org, Alex Bounine <alex.bou9@gmail.com>, Dominik Brodowski <linux@dominikbrodowski.net>, Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, linux-pci@vger.kernel.org, linux-arch <linux-arch@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linuxppc-dev <linuxppc-dev@lists.ozlabs.org>, linux-alpha@vger.kernel.org, Linux-MIPS <linux-mips@linux-mips.org>
List-Id: linux-arch.vger.kernel.org

On Tue, Nov 20, 2018 at 6:07 AM Paul Burton <paul.burton@mips.com> wrote:
>
> On Mon, Nov 19, 2018 at 01:01:41PM -0800, Paul Burton wrote:
> > On Thu, Nov 15, 2018 at 08:05:31PM +0100, Christoph Hellwig wrote:
> > > This option is always selected from LOONGSON_MACH3X.  Switch to just
> > > seleting PCI from that option and definining LOONGSON_PCIIO_BASE based
> > > on CONFIG_LOONGSON_MACH3X.
> > >
> > > Signed-off-by: Christoph Hellwig <hch@lst.de>
> > > ---
> > >  arch/mips/Kconfig                                | 11 -----------
> > >  arch/mips/include/asm/mach-loongson64/loongson.h |  2 +-
> > >  arch/mips/loongson64/Kconfig                     |  2 +-
> > >  3 files changed, 2 insertions(+), 13 deletions(-)
> > >
> > > diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
> > > index 8272ea4c7264..7d28c9dd75d0 100644
> > > --- a/arch/mips/Kconfig
> > > +++ b/arch/mips/Kconfig
> > > @@ -3040,17 +3040,6 @@ config PCI
> > >       your box. Other bus systems are ISA, EISA, or VESA. If you have PCI,
> > >       say Y, otherwise N.
> > >
> > > -config HT_PCI
> > > -   bool "Support for HT-linked PCI"
> > > -   default y
> > > -   depends on CPU_LOONGSON3
> > > -   select PCI
> > > -   select PCI_DOMAINS
> > > -   help
> > > -     Loongson family machines use Hyper-Transport bus for inter-core
> > > -     connection and device connection. The PCI bus is a subordinate
> > > -     linked at HT. Choose Y for Loongson-3 based machines.
> > > -
> > >  config PCI_DOMAINS
> > >     bool
> > >
> > > diff --git a/arch/mips/loongson64/Kconfig b/arch/mips/loongson64/Kconfig
> > > index c865b4b9b775..781a5156ab21 100644
> > > --- a/arch/mips/loongson64/Kconfig
> > > +++ b/arch/mips/loongson64/Kconfig
> > > @@ -76,7 +76,7 @@ config LOONGSON_MACH3X
> > >     select CPU_HAS_WB
> > >     select HW_HAS_PCI
> > >     select ISA
> > > -   select HT_PCI
> > > +   select PCI
> > >     select I8259
> > >     select IRQ_MIPS_CPU
> > >     select NR_CPUS_DEFAULT_4
> >
> > Should this also select PCI_DOMAINS to preserve the existing behavior?
> >
> > If not, could you explain why in the commit message?
>
> Ah, I see - PCI already selects PCI_DOMAINS. I think it would have been
> worth mentioning

OK, I added "PCI already selects PCI_DOMAINS"
in the commit description.



> but I don't mind if you don't think it a big enough
> deal to respin the patch, so:
>
>     Acked-by: Paul Burton <paul.burton@mips.com>
>
> Thanks,
>     Paul



-- 
Best Regards
Masahiro Yamada
