Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from isilmar-4.linta.de ([136.243.71.142]:53640 "EHLO
        isilmar-4.linta.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726012AbeJNNmT (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sun, 14 Oct 2018 09:42:19 -0400
Date: Sun, 14 Oct 2018 07:42:52 +0200
From: Dominik Brodowski <linux@dominikbrodowski.net>
Subject: Re: [PATCH 5/8] pcmcia: allow PCMCIA support independent of the
 architecture
Message-ID: <20181014054252.GA24103@light.dominikbrodowski.net>
References: <20181013151016.31674-1-hch@lst.de>
 <20181013151016.31674-6-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181013151016.31674-6-hch@lst.de>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Masahiro Yamada <yamada.masahiro@socionext.com>, Matt Porter <mporter@kernel.crashing.org>, Alexandre Bounine <alex.bou9@gmail.com>, linux-kbuild@vger.kernel.org, linux-pci@vger.kernel.org, linux-scsi@vger.kernel.org, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Message-ID: <20181014054252.SsUJRRiK7KV98k1jwaZL4AKtfnb3n4ljYQOmG1TmJHI@z>

On Sat, Oct 13, 2018 at 05:10:13PM +0200, Christoph Hellwig wrote:
> There is nothing architecture specific in the PCMCIA core, so allow
> building it everywhere.  The actual host controllers will depend on ISA,
> PCI or a specific SOC.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Looks good to me, though I'm interested on any subtle (build) breakage when
this gets exposure in -next. Will you push this patch upstream directly, or
should it go in via the pcmcia tree? If it is the former, feel free to add

	Acked-by: Dominik Brodowski <linux@dominikbrodowski.net>


Thanks,
	Dominik
