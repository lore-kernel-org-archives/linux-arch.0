From: Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: [PATCH 09/24] PCI, powerpc: Register busn_res for root buses
Date: Wed, 8 Feb 2012 07:58:21 -0800
Message-ID: <CAErSpo6BwznWf3rq4J2Ao+rrgR4yWqQ0mQGygkd2KmBuA1OD8g@mail.gmail.com>
References: <1328425088-6562-1-git-send-email-yinghai@kernel.org> <1328425088-6562-10-git-send-email-yinghai@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pci-owner@vger.kernel.org>
In-Reply-To: <1328425088-6562-10-git-send-email-yinghai@kernel.org>
Sender: linux-pci-owner@vger.kernel.org
To: Yinghai Lu <yinghai@kernel.org>
Cc: Jesse Barnes <jbarnes@virtuousgeek.org>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Tony Luck <tony.luck@intel.com>, Dominik Brodowski <linux@dominikbrodowski.net>, Andrew Morton <akpm@linux-foundation.org>, Linus Torvalds <torvalds@linux-foundation.org>, linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, Paul Mackerras <paulus@samba.org>, linuxppc-dev@lists.ozlabs.org
List-Id: linux-arch.vger.kernel.org

On Sat, Feb 4, 2012 at 10:57 PM, Yinghai Lu <yinghai@kernel.org> wrote:
> Signed-off-by: Yinghai Lu <yinghai@kernel.org>
> Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> Cc: Paul Mackerras <paulus@samba.org>
> Cc: linuxppc-dev@lists.ozlabs.org
> ---
> =A0arch/powerpc/kernel/pci-common.c | =A0 =A07 ++++++-
> =A01 files changed, 6 insertions(+), 1 deletions(-)
>
> diff --git a/arch/powerpc/kernel/pci-common.c b/arch/powerpc/kernel/p=
ci-common.c
> index cce98d7..501f29b 100644
> --- a/arch/powerpc/kernel/pci-common.c
> +++ b/arch/powerpc/kernel/pci-common.c
> @@ -1732,6 +1732,8 @@ void __devinit pcibios_scan_phb(struct pci_cont=
roller *hose)
> =A0 =A0 =A0 =A0bus->secondary =3D hose->first_busno;
> =A0 =A0 =A0 =A0hose->bus =3D bus;
>
> + =A0 =A0 =A0 pci_bus_insert_busn_res(bus, hose->first_busno, hose->l=
ast_busno);
> +
> =A0 =A0 =A0 =A0/* Get probe mode and perform scan */
> =A0 =A0 =A0 =A0mode =3D PCI_PROBE_NORMAL;
> =A0 =A0 =A0 =A0if (node && ppc_md.pci_probe_mode)
> @@ -1742,8 +1744,11 @@ void __devinit pcibios_scan_phb(struct pci_con=
troller *hose)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0of_scan_bus(node, bus);
> =A0 =A0 =A0 =A0}
>
> - =A0 =A0 =A0 if (mode =3D=3D PCI_PROBE_NORMAL)
> + =A0 =A0 =A0 if (mode =3D=3D PCI_PROBE_NORMAL) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 pci_bus_update_busn_res_end(bus, 255);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0hose->last_busno =3D bus->subordinate =
=3D pci_scan_child_bus(bus);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 pci_bus_update_busn_res_end(bus, bus->s=
ubordinate);
> + =A0 =A0 =A0 }

The only architecture-specific thing here is discovering the range of
bus numbers below a host bridge.  The architecture should not have to
mess around with pci_bus_update_busn_res_end() like this.  It should
be able to say "here's my bus number range" (and of course the PCI
core can default to 0-255 if the arch doesn't supply a range) and the
core should take care of the rest.

Bjorn
