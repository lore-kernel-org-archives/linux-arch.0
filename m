Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:52850 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726091AbeJPEpz (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Tue, 16 Oct 2018 00:45:55 -0400
Date: Mon, 15 Oct 2018 15:58:58 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
Subject: Re: [PATCH 4/8] pci: consolidate PCI config entry in drivers/pci
Message-ID: <20181015205857.GE5906@bhelgaas-glaptop.roam.corp.google.com>
References: <20181013151016.31674-1-hch@lst.de>
 <20181013151016.31674-5-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181013151016.31674-5-hch@lst.de>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Masahiro Yamada <yamada.masahiro@socionext.com>, Matt Porter <mporter@kernel.crashing.org>, Alexandre Bounine <alex.bou9@gmail.com>, Dominik Brodowski <linux@dominikbrodowski.net>, linux-kbuild@vger.kernel.org, linux-pci@vger.kernel.org, linux-scsi@vger.kernel.org, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Message-ID: <20181015205858.LLT25FBblVvmpnHUOPAauzcOJJIOg18eRD9mFdyVEN0@z>

s/^pci: /PCI: / in subject

On Sat, Oct 13, 2018 at 05:10:12PM +0200, Christoph Hellwig wrote:
> There is no good reason to duplicate the PCI menu in every architecture.
> Instead provide a selectable HAS_PCI symbol that indicates availability
> of PCI support and the handle the rest in drivers/pci.
> 
> Note that for powerpc we now select HAS_PCI globally instead of the
> convoluted mess of conditional or or non-conditional support per board,
> similar to what we do e.g. on x86.  For alpha PCI is selected for the
> non-jensen configs as it was the default before, and a lot of code does
> not compile without PCI enabled.  On other architectures with limited
> PCI support that wasn't as complicated I've left the selection as-is.

Thanks for doing this.  It's a great cleanup.  I know you have a few
things you're cleaning up, but add my:

Acked-by: Bjorn Helgaas <bhelgaas@google.com>

when you do that.
