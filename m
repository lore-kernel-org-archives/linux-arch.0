Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from smtp-out.google.com ([216.239.44.51]:8482 "EHLO
	smtp-out.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754583Ab1DDPZq (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Mon, 4 Apr 2011 11:25:46 -0400
Received: from wpaz5.hot.corp.google.com (wpaz5.hot.corp.google.com [172.24.198.69])
	by smtp-out.google.com with ESMTP id p34FPfrH005406
	for <linux-arch@vger.kernel.org>; Mon, 4 Apr 2011 08:25:41 -0700
Received: from vxi40 (vxi40.prod.google.com [10.241.35.40])
	by wpaz5.hot.corp.google.com with ESMTP id p34FPesY018670
	(version=TLSv1/SSLv3 cipher=RC4-SHA bits=128 verify=NOT)
	for <linux-arch@vger.kernel.org>; Mon, 4 Apr 2011 08:25:40 -0700
Received: by vxi40 with SMTP id 40so4615557vxi.38
        for <linux-arch@vger.kernel.org>; Mon, 04 Apr 2011 08:25:40 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1301902664.2549.76.camel@pasglop>
References: <1301882694.2549.53.camel@pasglop> <1301887630.2549.71.camel@pasglop>
 <1301902664.2549.76.camel@pasglop>
From: Bjorn Helgaas <bhelgaas@google.com>
Date: Mon, 4 Apr 2011 09:25:20 -0600
Message-ID: <BANLkTimBD=NfFKGpy0ZTnT9Dcu=dkTHxZg@mail.gmail.com>
Subject: Re: [RFC/PATCH] of: Match PCI devices to OF nodes generically
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: linux-arch@vger.kernel.org, linuxppc-dev <linuxppc-dev@lists.ozlabs.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, David Miller <davem@davemloft.net>, "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Message-ID: <20110404152520.3Q3gPSBqHSHQlTdKYnnEa1IdLplmtNNDCSkGHM4zji0@z>

On Mon, Apr 4, 2011 at 1:37 AM, Benjamin Herrenschmidt
<benh@kernel.crashing.org> wrote:

> powerpc has two different ways of matching PCI devices to their
> corresponding OF node (if any) for historical reasons. The ppc64 one
> does a scan looking for matching bus/dev/fn, while the ppc32 one does a
> scan looking only for matching dev/fn on each level in order to be
> agnostic to busses being renumbered (which Linux does on some
> platforms).
>
> This removes both and instead moves the matching code to the PCI core
> itself. It's the most logical place to do it: when a pci_dev is created,
> we know the parent and thus can do a single level scan for the matching
> device_node (if any).

Some of this is reminiscent of the ACPI/PCI binding we do on x86/ia64,
e.g., acpi_get_pci_dev() and the stuff in drivers/acpi/glue.c.  Have
you looked at that to see if there's any hope of covering both OF and
ACPI with something more generic?

Bjorn
