From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [patch 4/6] ARM: move bridge enable out of
	pcibios_enable_resources()
Date: Thu, 6 Mar 2008 15:06:40 +0000
Message-ID: <20080306150640.GL3283@flint.arm.linux.org.uk>
References: <20080228000437.880811124@ldl.fc.hp.com>
	<20080228001053.013269726@ldl.fc.hp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.arm.linux.org.uk>
Content-Disposition: inline
In-Reply-To: <20080228001053.013269726@ldl.fc.hp.com>
List-Unsubscribe: <http://lists.arm.linux.org.uk/mailman/listinfo/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.arm.linux.org.uk?subject=unsubscribe>
List-Archive: <http://lists.arm.linux.org.uk/lurker/list/linux-arm-kernel.html>
List-Post: <mailto:linux-arm-kernel@lists.arm.linux.org.uk>
List-Help: <mailto:linux-arm-kernel-request@lists.arm.linux.org.uk?subject=help>
List-Subscribe: <http://lists.arm.linux.org.uk/mailman/listinfo/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.arm.linux.org.uk?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.arm.linux.org.uk
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org+linux-arm-kernel=m.gmane.org@lists.arm.linux.org.uk
To: Bjorn Helgaas <bjorn.helgaas@hp.com>
Cc: linux-arch@vger.kernel.org, Chris Zankel <chris@zankel.net>, Grant Grundler <grundler@parisc-linux.org>, linux-parisc@vger.kernel.org, Matthew Wilcox <matthew@wil.cx>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Kyle McMartin <kyle@parisc-linux.org>, linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>, linux-pci@atrey.karlin.mff.cuni.cz, linux-arm-kernel@lists.arm.linux.org.uk
List-Id: linux-arch.vger.kernel.org

On Wed, Feb 27, 2008 at 05:04:41PM -0700, Bjorn Helgaas wrote:
> Move bridge enable from pcibios_enable_resources() to
> platform_pci_enable_device() so the former matches other
> architectures and can be shared.
> 
> Signed-off-by: Bjorn Helgaas <bjorn.helgaas@hp.com>
> 
> Index: work6/arch/arm/kernel/bios32.c
> ===================================================================
> --- work6.orig/arch/arm/kernel/bios32.c	2008-02-27 11:25:29.000000000 -0700
> +++ work6/arch/arm/kernel/bios32.c	2008-02-27 11:55:59.000000000 -0700
> @@ -683,15 +683,32 @@
>  			cmd |= PCI_COMMAND_MEMORY;
>  	}
>  
> +	if (cmd != old_cmd) {
> +		printk("PCI: enabling device %s (%04x -> %04x)\n",
> +		       pci_name(dev), old_cmd, cmd);

Should be dev_info().

Apart from that...

Acked-by: Russell King <rmk+kernel@arm.linux.org.uk>

-------------------------------------------------------------------
List admin: http://lists.arm.linux.org.uk/mailman/listinfo/linux-arm-kernel
FAQ:        http://www.arm.linux.org.uk/mailinglists/faq.php
Etiquette:  http://www.arm.linux.org.uk/mailinglists/etiquette.php
