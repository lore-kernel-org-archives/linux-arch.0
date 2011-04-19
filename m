From: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: [PATCH 6/6] pci/of: Consolidate pci_bus_to_OF_node()
Date: Mon, 18 Apr 2011 23:24:08 -0600
Message-ID: <BANLkTinAzvK=SN6cRNtVxJ1u3Odha9n4QQ@mail.gmail.com>
References: <1302495170-973-1-git-send-email-benh@kernel.crashing.org> <1302495170-973-7-git-send-email-benh@kernel.crashing.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-iy0-f174.google.com ([209.85.210.174]:33778 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752422Ab1DSFYa convert rfc822-to-8bit (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Tue, 19 Apr 2011 01:24:30 -0400
In-Reply-To: <1302495170-973-7-git-send-email-benh@kernel.crashing.org>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: linux-pci@vger.kernel.org, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, davem@davemloft.net, bheglaas@google.com, monstr@monstr.eu, tglx@linutronix.de, bigeasy@linutronix.de

On Sun, Apr 10, 2011 at 10:12 PM, Benjamin Herrenschmidt
<benh@kernel.crashing.org> wrote:
> The generic code always get the device-node in the right place now
> so a single implementation will work for all archs
>
> Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>

Patches 2-6 all look good to me.

Acked-by: Grant Likely <grant.likely@secretlab.ca>

> ---
> =A0arch/microblaze/include/asm/pci-bridge.h | =A0 =A05 -----
> =A0arch/powerpc/include/asm/pci-bridge.h =A0 =A0| =A0 =A05 -----
> =A0arch/x86/include/asm/prom.h =A0 =A0 =A0 =A0 =A0 =A0 =A0| =A0 =A06 =
------
> =A0include/linux/pci.h =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0| =A0=
 =A05 +++++
> =A04 files changed, 5 insertions(+), 16 deletions(-)
>
> diff --git a/arch/microblaze/include/asm/pci-bridge.h b/arch/microbla=
ze/include/asm/pci-bridge.h
> index 0d74d03..242be57 100644
> --- a/arch/microblaze/include/asm/pci-bridge.h
> +++ b/arch/microblaze/include/asm/pci-bridge.h
> @@ -102,11 +102,6 @@ struct pci_controller {
> =A0};
>
> =A0#ifdef CONFIG_PCI
> -static inline struct device_node *pci_bus_to_OF_node(struct pci_bus =
*bus)
> -{
> - =A0 =A0 =A0 return bus->dev.of_node;
> -}
> -
> =A0static inline struct pci_controller *pci_bus_to_host(const struct =
pci_bus *bus)
> =A0{
> =A0 =A0 =A0 =A0return bus->sysdata;
> diff --git a/arch/powerpc/include/asm/pci-bridge.h b/arch/powerpc/inc=
lude/asm/pci-bridge.h
> index 578060e..90bd3ed 100644
> --- a/arch/powerpc/include/asm/pci-bridge.h
> +++ b/arch/powerpc/include/asm/pci-bridge.h
> @@ -169,11 +169,6 @@ static inline struct pci_controller *pci_bus_to_=
host(const struct pci_bus *bus)
> =A0 =A0 =A0 =A0return bus->sysdata;
> =A0}
>
> -static inline struct device_node *pci_bus_to_OF_node(struct pci_bus =
*bus)
> -{
> - =A0 =A0 =A0 return bus->dev.of_node;
> -}
> -
> =A0#ifndef CONFIG_PPC64
>
> =A0extern int pci_device_from_OF_node(struct device_node *node,
> diff --git a/arch/x86/include/asm/prom.h b/arch/x86/include/asm/prom.=
h
> index dd6066a..df12870 100644
> --- a/arch/x86/include/asm/prom.h
> +++ b/arch/x86/include/asm/prom.h
> @@ -30,12 +30,6 @@ extern void add_dtb(u64 data);
> =A0extern void x86_add_irq_domains(void);
> =A0void __cpuinit x86_of_pci_init(void);
> =A0void x86_dtb_init(void);
> -
> -static inline struct device_node *pci_bus_to_OF_node(struct pci_bus =
*bus)
> -{
> - =A0 =A0 =A0 return pci_device_to_OF_node(bus->self);
> -}
> -
> =A0#else
> =A0static inline void add_dtb(u64 data) { }
> =A0static inline void x86_add_irq_domains(void) { }
> diff --git a/include/linux/pci.h b/include/linux/pci.h
> index 73dab8a..532c4e8 100644
> --- a/include/linux/pci.h
> +++ b/include/linux/pci.h
> @@ -1559,6 +1559,11 @@ static inline struct device_node *pci_device_t=
o_OF_node(struct pci_dev *pdev)
> =A0 =A0 =A0 =A0return pdev ? pdev->dev.of_node : NULL;
> =A0}
>
> +static inline struct device_node *pci_bus_to_OF_node(struct pci_bus =
*bus)
> +{
> + =A0 =A0 =A0 return bus ? bus->dev.of_node : NULL;
> +}
> +
> =A0#else /* CONFIG_OF */
> =A0static inline void pci_set_of_node(struct pci_dev *dev) { }
> =A0static inline void pci_release_of_node(struct pci_dev *dev) { }
> --
> 1.7.1
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-kerne=
l" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at =A0http://www.tux.org/lkml/
>



--=20
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
