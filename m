From: Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH 01/17] drivers: support PCIe in RISCV
Date: Wed, 7 Jun 2017 07:25:58 -0700
Message-ID: <20170607142558.GA21155@infradead.org>
References: <20170523004107.536-1-palmer@dabbelt.com>
 <20170606230007.19101-1-palmer@dabbelt.com>
 <20170606230007.19101-2-palmer@dabbelt.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20170606230007.19101-2-palmer@dabbelt.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Palmer Dabbelt <palmer@dabbelt.com>
Cc: linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>, olof@lixom.net, albert@sifive.com, patches@groups.riscv.org, "Wesley W. Terpstra" <wesley@sifive.com>
List-Id: linux-arch.vger.kernel.org

On Tue, Jun 06, 2017 at 03:59:51PM -0700, Palmer Dabbelt wrote:
> From: "Wesley W. Terpstra" <wesley@sifive.com>
> 
> There are RISC-V systems that have been mapped to Xilinx FPGAs that have
> their PCIe controllers on chip.  These build system changes allow RISC-V
> systems to enable the Xilinx PCIe controller, and to setup PCIe IRQs.
> 
> Signed-off-by: Palmer Dabbelt <palmer@dabbelt.com>
> ---
>  drivers/pci/Makefile     | 1 +
>  drivers/pci/host/Kconfig | 2 +-
>  2 files changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/pci/Makefile b/drivers/pci/Makefile
> index 462c1f5f5546..a29d9ec05d13 100644
> --- a/drivers/pci/Makefile
> +++ b/drivers/pci/Makefile
> @@ -41,6 +41,7 @@ obj-$(CONFIG_MIPS) += setup-irq.o
>  obj-$(CONFIG_TILE) += setup-irq.o
>  obj-$(CONFIG_SPARC_LEON) += setup-irq.o
>  obj-$(CONFIG_M68K) += setup-irq.o
> +obj-$(CONFIG_RISCV) += setup-irq.o

Can we do a cleanup here and add a ARCH_USE_GENERIC_PCI_SETUP Kconfig
symbol that all these architectures can select?

>  
>  #
>  # ACPI Related PCI FW Functions
> diff --git a/drivers/pci/host/Kconfig b/drivers/pci/host/Kconfig
> index 7f47cd5e10a5..5148f3d3cab7 100644
> --- a/drivers/pci/host/Kconfig
> +++ b/drivers/pci/host/Kconfig
> @@ -71,7 +71,7 @@ config PCI_HOST_GENERIC
>  
>  config PCIE_XILINX
>  	bool "Xilinx AXI PCIe host bridge support"
> -	depends on ARCH_ZYNQ || MICROBLAZE
> +	depends on ARCH_ZYNQ || MICROBLAZE || RISCV

What about of arch support does this driver need?  It seems to compile
just fine on x86 for me, so maybe we should just drop the arch
dependency entirely.
