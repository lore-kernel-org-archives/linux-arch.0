From: Marc Zyngier <marc.zyngier@arm.com>
Subject: Re: [PATCH 02/17] pcie-xilinx: add missing 5th legacy interrupt
Date: Wed, 7 Jun 2017 10:24:59 +0100
Message-ID: <9e42e6d3-3433-0c3f-812f-28d98ef089dc@arm.com>
References: <20170523004107.536-1-palmer@dabbelt.com>
 <20170606230007.19101-1-palmer@dabbelt.com>
 <20170606230007.19101-3-palmer@dabbelt.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:57818 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751008AbdFGJZC (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Wed, 7 Jun 2017 05:25:02 -0400
In-Reply-To: <20170606230007.19101-3-palmer@dabbelt.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Palmer Dabbelt <palmer@dabbelt.com>, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>, olof@lixom.net
Cc: albert@sifive.com, patches@groups.riscv.org, "Wesley W. Terpstra" <wesley@sifive.com>, Bjorn Helgaas <bhelgaas@google.com>

+ Bjorn

On 06/06/17 23:59, Palmer Dabbelt wrote:
> From: "Wesley W. Terpstra" <wesley@sifive.com>
> 
> These are numbered from 1.
> 
> Signed-off-by: Palmer Dabbelt <palmer@dabbelt.com>
> ---
>  drivers/pci/host/pcie-xilinx.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/pci/host/pcie-xilinx.c b/drivers/pci/host/pcie-xilinx.c
> index 2fe2df51f9f8..8804145d399a 100644
> --- a/drivers/pci/host/pcie-xilinx.c
> +++ b/drivers/pci/host/pcie-xilinx.c
> @@ -443,7 +443,7 @@ static irqreturn_t xilinx_pcie_intr_handler(int irq, void *data)
>  			val = ((val & XILINX_PCIE_RPIFR1_INTR_MASK) >>
>  				XILINX_PCIE_RPIFR1_INTR_SHIFT) + 1;
>  			generic_handle_irq(irq_find_mapping(port->leg_domain,
> -							    val));
> +							    val + 1));
>  		}
>  	}
>  
> @@ -524,7 +524,7 @@ static int xilinx_pcie_init_irq_domain(struct xilinx_pcie_port *port)
>  		return -ENODEV;
>  	}
>  
> -	port->leg_domain = irq_domain_add_linear(pcie_intc_node, 4,
> +	port->leg_domain = irq_domain_add_linear(pcie_intc_node, 5,
>  						 &intx_domain_ops,
>  						 port);
>  	if (!port->leg_domain) {
> 

This is a common problem with the current OF code that numbers INTx from
1 instead of zero (there is no 5th legacy interrupts in the PCI spec,
despite what $SUBJECT says). I'd be inclined to fix this at the core
level rather than papering over it in the various drivers...

Thanks,

	M.
-- 
Jazz is not dead. It just smells funny...
