From: Liviu Dudau <liviu@dudau.co.uk>
Subject: Re: [PATCH v12 10/12] PCI: Assign unassigned bus resources in
 pci_scan_root_bus()
Date: Wed, 24 Sep 2014 02:18:51 +0100
Message-ID: <20140924011851.GD32643@bart.dudau.co.uk>
References: <1411498874-9864-1-git-send-email-Liviu.Dudau@arm.com>
 <1411498874-9864-11-git-send-email-Liviu.Dudau@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <1411498874-9864-11-git-send-email-Liviu.Dudau@arm.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Liviu Dudau <Liviu.Dudau@arm.com>
Cc: linux-arch <linux-arch@vger.kernel.org>, Grant Likely <grant.likely@secretlab.ca>, Kukjin Kim <kgene.kim@samsung.com>, Russell King <linux@arm.linux.org.uk>, Arnd Bergmann <arnd@arndb.de>, Device Tree ML <devicetree@vger.kernel.org>, linux-pci <linux-pci@vger.kernel.org>, Catalin Marinas <catalin.marinas@arm.com>, Linus Walleij <linus.walleij@linaro.org>, Jingoo Han <jg1.han@samsung.com>, Will Deacon <Will.Deacon@arm.com>, LKML <linux-kernel@vger.kernel.org>, Jason Gunthorpe <jgunthorpe@obsidianresearch.com>, Rob Herring <robh+dt@kernel.org>, Tanmay Inamdar <tinamdar@apm.com>, Suravee Suthikulanit <suravee.suthikulpanit@amd.com>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Bjorn Helgaas <bhelgaas@google.com>, Sinan Kaya <okaya@codeaurora.org>, LAKML <linux-arm-kernel@lists.infradead.org>
List-Id: linux-arch.vger.kernel.org

On Tue, Sep 23, 2014 at 08:01:12PM +0100, Liviu Dudau wrote:
> If the firmware has not assigned all the bus resources and
> we are not just probing the PCIe busses, it makes sense to
> assign the unassigned resources in pci_scan_root_bus().
> 
> Cc: Bjorn Helgaas <bhelgaas@google.com>
> Cc: Arnd Bergmann <arnd@arndb.de>
> Cc: Jason Gunthorpe <jgunthorpe@obsidianresearch.com>
> Cc: Rob Herring <robh+dt@kernel.org>
> Signed-off-by: Liviu Dudau <Liviu.Dudau@arm.com>
> ---
>  drivers/pci/probe.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
> index ef891d2..508cf61 100644
> --- a/drivers/pci/probe.c
> +++ b/drivers/pci/probe.c
> @@ -1953,6 +1953,9 @@ struct pci_bus *pci_scan_root_bus(struct device *parent, int bus,
>  	if (!found)
>  		pci_bus_update_busn_res_end(b, max);
>  
> +	if (!pci_has_flag(PCI_PROBE_ONLY))
> +		pci_assign_unassigned_bus_resources(b);
> +
>  	pci_bus_add_devices(b);
>  	return b;
>  }
> -- 
> 2.1.0
> 

Bjorn,

If you are OK with this patch, can you let me know how do you feel about
making pci_scan_root_bus() set up the bus->msi pointer as well?

Side note: I don't know exactly how to do it now, but setting bus->msi is
needed by platforms that are based on my patches and want to use MSI,
otherwise they have to open code pci_scan_root_bus() to set it. I haven't
made any attempts to do it in this series as the GICv2m patches are not
ready yet, but I can see the need arriving soon.

Best regards,
Liviu

> --
> To unsubscribe from this list: send the line "unsubscribe linux-pci" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 

-- 
-------------------
   .oooO
   (   )
    \ (  Oooo.
     \_) (   )
          ) /
         (_/

 One small step
   for me ...
