From: Christoph Hellwig <hch@lst.de>
Subject: Re: Bug 205201 - Booting halts if Dawicontrol DC-2976 UW SCSI
 board installed, unless RAM size limited to 3500M
Date: Thu, 21 Nov 2019 08:29:43 +0100
Message-ID: <20191121072943.GA24024@lst.de>
References: <F1EBB706-73DF-430E-9020-C214EC8ED5DA@xenosoft.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <F1EBB706-73DF-430E-9020-C214EC8ED5DA@xenosoft.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Christian Zigotzky <chzigotzky@xenosoft.de>
Cc: Christoph Hellwig <hch@lst.de>, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, linux-mm@kvack.org, iommu@lists.linux-foundation.org, Benjamin Herrenschmidt <benh@kernel.crashing.org>, paulus@samba.org, darren@stevens-zone.net, "contact@a-eon.com" <contact@a-eon.com>, rtd2@xtra.co.nz, mad skateman <madskateman@gmail.com>, Rob Herring <robh+dt@kernel.org>, linuxppc-dev <linuxppc-dev@lists.ozlabs.org>, nsaenzjulienne@suse.de
List-Id: linux-arch.vger.kernel.org

On Sat, Nov 16, 2019 at 08:06:05AM +0100, Christian Zigotzky wrote:
> /*
>  *  DMA addressing mode.
>  *
>  *  0 : 32 bit addressing for all chips.
>  *  1 : 40 bit addressing when supported by chip.
>  *  2 : 64 bit addressing when supported by chip,
>  *      limited to 16 segments of 4 GB -> 64 GB max.
>  */
> #define   SYM_CONF_DMA_ADDRESSING_MODE CONFIG_SCSI_SYM53C8XX_DMA_ADDRESSING_MODE
> 
> Cyrus config:
> 
> CONFIG_SCSI_SYM53C8XX_DMA_ADDRESSING_MODE=1
> 
> I will configure “0 : 32 bit addressing for all chips” for the RC8. Maybe this is the solution.

0 means you are going to do bounce buffering a lot, which seems
generally like a bad idea.

But why are we talking about the sym53c8xx driver now?  The last issue
you reported was about video4linux allocations.
