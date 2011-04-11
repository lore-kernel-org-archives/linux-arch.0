Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail.sf-mail.de ([62.27.20.61]:53325 "EHLO mail.sf-mail.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753925Ab1DKPMR (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Mon, 11 Apr 2011 11:12:17 -0400
Message-ID: <da7a8b1fa75c0968a4586a591713d5db.squirrel@webmail.sf-mail.de>
In-Reply-To: <1302495170-973-4-git-send-email-benh@kernel.crashing.org>
References: <1302495170-973-1-git-send-email-benh@kernel.crashing.org>
    <1302495170-973-4-git-send-email-benh@kernel.crashing.org>
Date: Mon, 11 Apr 2011 15:12:15 -0000
Subject: Re: [PATCH 3/6] microblaze/pci: Move the remains of pci_32.c to
 pci-common.c
From: "Rolf Eike Beer" <eike-kernel@sf-tec.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: linux-pci@vger.kernel.org, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, davem@davemloft.net, bheglaas@google.com, monstr@monstr.eu, tglx@linutronix.de, bigeasy@linutronix.de
Message-ID: <20110411151215.Z-N4l2x9JxfGbM-rnn_-d6DfUsoIJW59M8HH-mkDDVM@z>

> There's no point in keeping this separate. Even if microblaze grows
> a 64-bit variant, it will probably be able to re-use that code as-is

> diff --git a/arch/microblaze/pci/pci-common.c
> b/arch/microblaze/pci/pci-common.c
> index 5359906..041b1d8 100644
> --- a/arch/microblaze/pci/pci-common.c
> +++ b/arch/microblaze/pci/pci-common.c
> @@ -50,6 +50,11 @@ unsigned int pci_flags;
>
>  static struct dma_map_ops *pci_dma_ops = &dma_direct_ops;
>
> +unsigned long isa_io_base;
> +unsigned long pci_dram_offset;
> +static int pci_bus_count;
> +
> +

Extra newline.

Eike
