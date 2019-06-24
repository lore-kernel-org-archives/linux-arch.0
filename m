Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from bombadil.infradead.org ([198.137.202.133]:60750 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727732AbfFXLCH (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 24 Jun 2019 07:02:07 -0400
Date: Mon, 24 Jun 2019 04:02:06 -0700
From: Christoph Hellwig <hch@infradead.org>
Subject: Re: Archs using generic PCI controller drivers vs. resource policy
Message-ID: <20190624110206.GA6541@infradead.org>
References: <5f3dcc3a8dafad188e3adb8ee9cf347bebdee7f6.camel@kernel.crashing.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5f3dcc3a8dafad188e3adb8ee9cf347bebdee7f6.camel@kernel.crashing.org>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Bjorn Helgaas <helgaas@kernel.org>, linux-pci@vger.kernel.org, linux-arch@vger.kernel.org

On Sun, Jun 23, 2019 at 10:30:42AM +1000, Benjamin Herrenschmidt wrote:
> This is wrong. I want to move it to the architecture (initially,
> eventually it should be platform driven, but the default will start
> with architecture specific to avoid changing the existing behaviours
> while consolidating the code).

Doing this per arch sounds fundamentally wrong.  At best per firmware
type, but hopefully firmware messing with PCIe setup is slowly going
away, at least outside of x86.

> To do that right, I want to understand which archs can potentially use
> the code in drivers/pci/controller today so I can change those archs to
> explicitely set the default to "reassign everything" (and take the
> policy out of the drivers themselves).
> 
> So far I've counted arm, arm64 (DT, not ACPI) and nios2. Any other ?

riscv at least and probably anything that can be synthesized to common
FPGAs with PCIe support.
