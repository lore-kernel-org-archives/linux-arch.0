Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from verein.lst.de ([213.95.11.211]:33716 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726115AbeJNPUc (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Sun, 14 Oct 2018 11:20:32 -0400
Date: Sun, 14 Oct 2018 09:40:24 +0200
From: Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH 5/8] pcmcia: allow PCMCIA support independent of the
 architecture
Message-ID: <20181014074024.GA17216@lst.de>
References: <20181013151016.31674-1-hch@lst.de> <20181013151016.31674-6-hch@lst.de> <20181014054252.GA24103@light.dominikbrodowski.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181014054252.GA24103@light.dominikbrodowski.net>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Dominik Brodowski <linux@dominikbrodowski.net>
Cc: Christoph Hellwig <hch@lst.de>, Masahiro Yamada <yamada.masahiro@socionext.com>, Matt Porter <mporter@kernel.crashing.org>, Alexandre Bounine <alex.bou9@gmail.com>, linux-kbuild@vger.kernel.org, linux-pci@vger.kernel.org, linux-scsi@vger.kernel.org, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Message-ID: <20181014074024.gnplRewuJ9FARZj21axtPwrW3FDyuT3dweQDwoKgxuI@z>

On Sun, Oct 14, 2018 at 07:42:52AM +0200, Dominik Brodowski wrote:
> On Sat, Oct 13, 2018 at 05:10:13PM +0200, Christoph Hellwig wrote:
> > There is nothing architecture specific in the PCMCIA core, so allow
> > building it everywhere.  The actual host controllers will depend on ISA,
> > PCI or a specific SOC.
> > 
> > Signed-off-by: Christoph Hellwig <hch@lst.de>
> 
> Looks good to me, though I'm interested on any subtle (build) breakage when
> this gets exposure in -next. Will you push this patch upstream directly, or
> should it go in via the pcmcia tree? If it is the former, feel free to add

The patches in the series depend on each other (just in terms of
context).  I suspect the best would be to get it into the kbuild tree.

It has survived the build bot, which found some interesting issues in
the other patches (as well as the !UML dependency), but if more issues
show I can keep you in the loop.
