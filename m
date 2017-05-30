Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from 8bytes.org ([81.169.241.247]:58332 "EHLO theia.8bytes.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751028AbdE3JcR (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Tue, 30 May 2017 05:32:17 -0400
Date: Tue, 30 May 2017 11:32:13 +0200
From: Joerg Roedel <joro@8bytes.org>
Subject: Re: [PATCH v6 1/6] iommu: of: Fix check for returning EPROBE_DEFER
Message-ID: <20170530093212.GD2818@8bytes.org>
References: <1495892865-9506-1-git-send-email-sricharan@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1495892865-9506-1-git-send-email-sricharan@codeaurora.org>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Sricharan R <sricharan@codeaurora.org>
Cc: robin.murphy@arm.com, will.deacon@arm.com, lorenzo.pieralisi@arm.com, iommu@lists.linux-foundation.org, linux-arm-kernel@lists.infradead.org, linux-arm-msm@vger.kernel.org, m.szyprowski@samsung.com, bhelgaas@google.com, linux-pci@vger.kernel.org, linux-acpi@vger.kernel.org, tn@semihalf.com, hanjun.guo@linaro.org, okaya@codeaurora.org, robh+dt@kernel.org, frowand.list@gmail.com, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, sudeep.holla@arm.com, rjw@rjwysocki.net, lenb@kernel.org, catalin.marinas@arm.com, arnd@arndb.de, linux-arch@vger.kernel.org, laurent.pinchart@ideasonboard.com, j.neuschaefer@gmx.net, geert@linux-m68k.org, magnus.damm@gmail.com, nwatters@codeaurora.org, linux@armlinux.org.uk
Message-ID: <20170530093213.F2h3uIBGx8ROS4RfZWAa_MjmoeuU6S1l5blV9fl-3fY@z>

On Sat, May 27, 2017 at 07:17:40PM +0530, Sricharan R wrote:
> Now with IOMMU probe deferral, we return -EPROBE_DEFER
> for masters that are connected to an IOMMU which is not
> probed yet, but going to get probed, so that we can attach
> the correct dma_ops. So while trying to defer the probe of
> the master, check if the of_iommu node that it is connected
> to is marked in DT as 'status=disabled', then the IOMMU is never
> is going to get probed. So simply return NULL and let the master
> work without an IOMMU.
> 
> Fixes: 7b07cbefb68d ("iommu: of: Handle IOMMU lookup failure with deferred probing or error")
> Reported-by: Geert Uytterhoeven <geert@linux-m68k.org>
> Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
> Tested-by: Will Deacon <will.deacon@arm.com>
> Tested-by: Magnus Damn <magnus.damn@gmail.com>
> Acked-by: Will Deacon <will.deacon@arm.com>
> Signed-off-by: Sricharan R <sricharan@codeaurora.org>
> ---
>  drivers/iommu/of_iommu.c | 1 +
>  1 file changed, 1 insertion(+)

Sorry for the confusion, I meant to apply this version of the patch-set
instead of v5.
