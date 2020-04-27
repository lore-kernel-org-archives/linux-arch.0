From: Jiaxun Yang <jiaxun.yang@flygoat.com>
Subject: Re: [PATCH 3/4] lib: logic_pio: Introduce MMIO_LOWER_RESERVED
Date: Mon, 27 Apr 2020 20:21:29 +0800
Message-ID: <20200427202129.34f8807e@flygoat-x1e>
References: <20200426114806.1176629-1-jiaxun.yang@flygoat.com>
        <20200426114806.1176629-4-jiaxun.yang@flygoat.com>
        <e84f4146-b44f-b009-0dc4-876aa551f44f@huawei.com>
        <42432F7C-D859-48B4-9547-A61BD22EFEEF@flygoat.com>
        <e6e3331f-283d-03e8-b23e-41870b547e34@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-mips-owner@vger.kernel.org>
In-Reply-To: <e6e3331f-283d-03e8-b23e-41870b547e34@huawei.com>
Sender: linux-mips-owner@vger.kernel.org
To: John Garry <john.garry@huawei.com>
Cc: Arnd Bergmann <arnd@arndb.de>, Bjorn Helgaas <bhelgaas@google.com>, linux-mips@vger.kernel.org, Thomas Bogendoerfer <tsbogend@alpha.franken.de>, Huacai Chen <chenhc@lemote.com>, Paul Burton <paulburton@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Stephen Kitt <steve@sk2.org>, Nick Desaulniers <ndesaulniers@google.com>, Serge Semin <fancer.lancer@gmail.com>, Anshuman Khandual <anshuman.khandual@arm.com>, Geert Uytterhoeven <geert@linux-m68k.org>, Andrew Morton <akpm@linux-foundation.org>, Daniel Silsby <dansilsby@gmail.com>, Mike Rapoport <rppt@linux.ibm.com>, Paul Cercueil <paul@crapouillou.net>, Mark Tomlinson <mark.tomlinson@alliedtelesis.co.nz>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Allison Randal <allison@lohutok.net>
List-Id: linux-arch.vger.kernel.org

On Mon, 27 Apr 2020 12:54:06 +0100
John Garry <john.garry@huawei.com> wrote:

> On 27/04/2020 12:03, Jiaxun Yang wrote:
> >=20
> >=20
> > =E4=BA=8E 2020=E5=B9=B44=E6=9C=8827=E6=97=A5 GMT+08:00 =E4=B8=8B=E5=8D=
=886:43:09, John Garry
> > <john.garry@huawei.com> =E5=86=99=E5=88=B0: =20
> >> On 26/04/2020 12:47, Jiaxun Yang wrote: =20
> >>> That would allow platforms reserve some lower address in PIO MMIO
> >>> range to deal with legacy drivers with hardcoded I/O ports that
> >>> can't be managed by logic_pio. =20
> >>
> >> Hi,
> >>
> >> Is there some reason why the logic_pio code cannot be improved to
> >> handle these devices at these "fixed" addresses? Or do you have a
> >> plan to improve it? We already support fixed bus address devices
> >> in the INDIRECT IO region. =20
> >=20
> > Hi,
> >=20
> > The issue about "Fixed Address" is we can't control the ioport
> > That driver used to operate devices.
> > So any attempt to resolve it in logic_pio seems impossible.
> >=20
> > Currently we have i8259, i8042, piix4_smbus, mc146818 rely on this
> > assumption. =20
>=20
> Right, and from glancing at a couple of drivers you mentioned, if we=20
> were to register a logic pio region for that legacy region, there
> does not seem to be an easy place to fixup to use logic pio addresses
> (for those devices). They use hardcoded values. However if all those
> drivers were mips specific, you could fixup those drivers to use
> logic_pio addresses today through some macro. But not sure on that.
>=20

Well, most of these drivers are shared with x86 so....
I guess the conversion needs two or more release cycles.

>=20
> So, going back to your change, I have a dilemma wondering whether you=20
> should still register a logic pio region for the legacy region
> instead of the carveout reservation, but ensure it is the first
> region registered, such that logic pio address base is 0 and no
> translation is required. At least then you have a region registered
> and it shows in /proc/ioports, but then this whole thing becomes a
> bit fragile.

Thanks for your solution. So I must register this range as early as
possible. As IRQ is the first subsystem using ISA, I'll do it before
IRQ init, just at the place I setup iormap for reserved region now.

Should be early enough to avoid any collision, as the only logic_pio
user on our system is PCI controller.

Thanks.
>=20
--
Jiaxun Yang
