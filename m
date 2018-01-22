Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from szxga07-in.huawei.com ([45.249.212.35]:37605 "EHLO huawei.com"
        rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
        id S1750886AbeAVL7l (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Mon, 22 Jan 2018 06:59:41 -0500
Subject: Re: [PATCH v11 2/9] PCI: Remove unused __weak attribute in
 pci_register_io_range()
References: <1516537647-50553-1-git-send-email-john.garry@huawei.com>
 <1516537647-50553-3-git-send-email-john.garry@huawei.com>
From: John Garry <john.garry@huawei.com>
Message-ID: <6816e715-df0f-ddff-d19d-de2d0f3101c7@huawei.com>
Date: Mon, 22 Jan 2018 11:59:20 +0000
MIME-Version: 1.0
In-Reply-To: <1516537647-50553-3-git-send-email-john.garry@huawei.com>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: bhelgaas@google.com
Cc: mika.westerberg@linux.intel.com, rafael@kernel.org, lorenzo.pieralisi@arm.com, rjw@rjwysocki.net, robh+dt@kernel.org, arnd@arndb.de, mark.rutland@arm.com, olof@lixom.net, hanjun.guo@linaro.org, dann.frazier@canonical.com, benh@kernel.crashing.org, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, linuxarm@huawei.com, linux-pci@vger.kernel.org, minyard@acm.org, devicetree@vger.kernel.org, linux-arch@vger.kernel.org
Message-ID: <20180122115920.bMO1Y_BvwjQDNzRvgl9EAf_o8GmMQY87tKJ7VgowRVI@z>

On 21/01/2018 12:27, John Garry wrote:
> From: Gabriele Paoloni <gabriele.paoloni@huawei.com>
>
> Currently pci_register_io_range() has only one definition;
> therefore there is no use of the __weak attribute.
>
> Signed-off-by: Gabriele Paoloni <gabriele.paoloni@huawei.com>
> Acked-by: Bjorn Helgaas <bhelgaas@google.com>
> ---

Hi Bjorn,

So I will need to respin this series again (and it still requires many 
more SOB tags), so do you want to pick up this minor patch in isolation 
now? It would save me carrying it, and save people receiving it in future.

Thanks,
John

>  drivers/pci/pci.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> index 764ca7b..d8357ff 100644
> --- a/drivers/pci/pci.c
> +++ b/drivers/pci/pci.c
> @@ -3383,7 +3383,7 @@ struct io_range {
>   * Record the PCI IO range (expressed as CPU physical address + size).
>   * Return a negative value if an error has occured, zero otherwise
>   */
> -int __weak pci_register_io_range(phys_addr_t addr, resource_size_t size)
> +int pci_register_io_range(phys_addr_t addr, resource_size_t size)
>  {
>  	int err = 0;
>
>
