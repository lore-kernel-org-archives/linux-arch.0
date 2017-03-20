Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:44584 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1756617AbdCTSSv (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Mon, 20 Mar 2017 14:18:51 -0400
Date: Mon, 20 Mar 2017 13:17:58 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
Subject: Re: [PATCH v1 0/3] ioremap() tidy-up
Message-ID: <20170320181757.GB29057@bhelgaas-glaptop.roam.corp.google.com>
References: <20170317172752.6308.91062.stgit@bhelgaas-glaptop.roam.corp.google.com>
 <CAK8P3a04OP+0gXBzDdC3=BJ99SL5Hw_rRLESsLJ7_PG9OHFt6w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAK8P3a04OP+0gXBzDdC3=BJ99SL5Hw_rRLESsLJ7_PG9OHFt6w@mail.gmail.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Arnd Bergmann <arnd@arndb.de>
Cc: Bjorn Helgaas <bhelgaas@google.com>, linux-arch <linux-arch@vger.kernel.org>, "Luis R. Rodriguez" <mcgrof@kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Message-ID: <20170320181758.5wUmAnQQ2e5O69uzcQek2j0J0vtVVh7R2KeWe0o_I_A@z>

On Fri, Mar 17, 2017 at 11:00:03PM +0100, Arnd Bergmann wrote:
> On Fri, Mar 17, 2017 at 6:46 PM, Bjorn Helgaas <bhelgaas@google.com> wrote:
> > 1) Fix some comments that say "IOMMU" when they mean "MMU".
> >
> > 2) Remove the generic __ioremap() definition, which I think is unused and
> > confusing.
> >
> > 3) Simplify the comments about ioremap() implementation.  I split this out
> > in case I went too far and made this controversial.
> 
> All look good
> 
> Reviewed-by: Arnd Bergmann <arnd@arndb.de>
> 
> Do you want to take them through your PCI tree?

Sure, I can.  I should have copied linux-pci; this was all motivated by
reviewing Lorenzo's patches, will probably go via my tree and should be
coordinated with these.

Bjorn
