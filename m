From: Jesse Barnes <jesse.barnes@intel.com>
Subject: Re: PCIBIOS_MIN_IO/MEM problem
Date: Thu, 13 Nov 2008 11:33:00 -0800
Message-ID: <200811131133.00880.jesse.barnes@intel.com>
References: <1226379415.7530.94.camel@pasglop>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pci-owner@vger.kernel.org>
In-Reply-To: <1226379415.7530.94.camel@pasglop>
Content-Disposition: inline
Sender: linux-pci-owner@vger.kernel.org
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: linux-pci <linux-pci@vger.kernel.org>, Linux Arch list <linux-arch@vger.kernel.org>
List-Id: linux-arch.vger.kernel.org

On Monday, November 10, 2008 8:56 pm Benjamin Herrenschmidt wrote:
> Hi !
>
> I have a problem on platforms with multiple PCI domains and allocating
> resources.
>
> The mechanism of having the arch set PCIBIOS_MIN_IO and PCIBIOS_MIN_MEM
> to avoid allocating things over the legacy areas among other things
> doesn't work well for us.
>
> The reason is that on platforms where resource addresses are remapped
> because the PCI bus isn't mapped 1:1, the values of the ranges we try
> to avoid (typically 0...4K for IO space and legacy VGA memory) is
> different from one domain to the next.
>
> Right now, I'm doing a workaround for .28 that will reserve those
> regions on some platforms before the allocation occurs, but it's a bit
> fishy, especially it gives strange results when using things like legacy
> IDE PCI cards that really want to allocate in those areas.
>
> Ideally, we would need to pass the pci_bus pointer to those macros.
>
> Thus, is there any objection to me replacing those accross the board
> with something like that ?
>
> 	resource_size_t pcibios_min_assign_io(struct pci_bus *bus)
> 	resource_size_t pcibios_min_assign_mem(struct pci_bus *bus)
>
> Please holler if you have objections before I start fixing everybody :-)

Ah yeah, having per-bus ranges makes sense.  No objections here.

Thanks,
Jesse
