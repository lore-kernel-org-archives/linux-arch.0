From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH] PCI: remove pcibios_scan_all_fns()
Date: Mon, 22 Jun 2009 18:53:47 +0200
Message-ID: <200906221853.48029.arnd@arndb.de>
References: <20090622140807.25509.54448.stgit@bob.kio>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.17.10]:54224 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750886AbZFVQys (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Mon, 22 Jun 2009 12:54:48 -0400
In-Reply-To: <20090622140807.25509.54448.stgit@bob.kio>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Alex Chiang <achiang@hp.com>
Cc: jbarnes@virtuousgeek.org, linux-arch@vger.kernel.org, Kyle McMartin <kyle@mcmartin.ca>, Tony Luck <tony.luck@intel.com>, Russell King <linux@arm.linux.org.uk>, Yoshinori Sato <ysato@users.sourceforge.jp>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Jeff Dike <jdike@addtoit.com>, linux-kernel@vger.kernel.org, Ralf Baechle <ralf@linux-mips.org>, David Howells <dhowells@redhat.com>, Paul Mundt <lethal@linux-sh.org>, Ivan Kokshaysky <ink@jurassic.park.msu.ru>, Ingo Molnar <mingo@redhat.com>, "David S. Miller" <davem@davemloft.net>

On Monday 22 June 2009, Alex Chiang wrote:
> --- a/include/asm-generic/pci.h
> +++ b/include/asm-generic/pci.h
> @@ -30,8 +30,6 @@ pcibios_bus_to_resource(struct pci_dev *dev, struct resource *res,
>         res->end = region->end;
>  }
>  
> -#define pcibios_scan_all_fns(a, b)     0
> -
>  #ifndef HAVE_ARCH_PCI_GET_LEGACY_IDE_IRQ
>  static inline int pci_get_legacy_ide_irq(struct pci_dev *dev, int channel)
>  {
> 

Acked-by: Arnd Bergmann <arnd@arndb.de>
