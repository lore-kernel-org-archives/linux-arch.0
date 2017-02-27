Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-qk0-f176.google.com ([209.85.220.176]:34199 "EHLO
        mail-qk0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751341AbdB0W0n (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 27 Feb 2017 17:26:43 -0500
Received: by mail-qk0-f176.google.com with SMTP id s186so120867439qkb.1
        for <linux-arch@vger.kernel.org>; Mon, 27 Feb 2017 14:25:02 -0800 (PST)
Subject: Re: [PATCH 13/20] PCI: iproc-platform: update PCI config space remap
 function
References: <20170227151436.18698-1-lorenzo.pieralisi@arm.com>
 <20170227151436.18698-14-lorenzo.pieralisi@arm.com>
From: Ray Jui <ray.jui@broadcom.com>
Message-ID: <84a0b24b-3c88-b750-dd9e-1607bc67a0a8@broadcom.com>
Date: Mon, 27 Feb 2017 13:21:39 -0800
MIME-Version: 1.0
In-Reply-To: <20170227151436.18698-14-lorenzo.pieralisi@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>, Ray Jui <rjui@broadcom.com>, Jon Mason <jonmason@broadcom.com>
Message-ID: <20170227212139.EDkfOCKohYxEd9LYk-fvR549l4hS3u2NuxeN1wfVTfo@z>

Hi Lorenzo,

On 2/27/2017 7:14 AM, Lorenzo Pieralisi wrote:
> PCI configuration space should be mapped with a memory region type that
> generates on the CPU host bus non-posted write transations. Update the
> driver to use the devm_pci_remap_cfg* interface to make sure the correct
> memory mappings for PCI configuration space are used.
> 
> Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
> Cc: Bjorn Helgaas <bhelgaas@google.com>
> Cc: Ray Jui <rjui@broadcom.com>
> Cc: Jon Mason <jonmason@broadcom.com>
> ---
>  drivers/pci/host/pcie-iproc-platform.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/pci/host/pcie-iproc-platform.c b/drivers/pci/host/pcie-iproc-platform.c
> index f4909bb..b48d0db 100644
> --- a/drivers/pci/host/pcie-iproc-platform.c
> +++ b/drivers/pci/host/pcie-iproc-platform.c
> @@ -67,7 +67,8 @@ static int iproc_pcie_pltfm_probe(struct platform_device *pdev)
>  		return ret;
>  	}
>  
> -	pcie->base = devm_ioremap(dev, reg.start, resource_size(&reg));
> +	pcie->base = devm_pci_remap_cfgspace(dev, reg.start,
> +					     resource_size(&reg));

Note these are NOT config space registers; instead, they are host
controller registers. iProc PCIe controller access config space
registers indirectly through two of the controller registers instead of
directly mapped.

Thanks,

Ray

>  	if (!pcie->base) {
>  		dev_err(dev, "unable to map controller registers\n");
>  		return -ENOMEM;
> 
