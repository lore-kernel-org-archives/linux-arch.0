From: Jesper Nilsson <jesper.nilsson@axis.com>
Subject: Re: [PATCH v3 08/32] cris: include default ioremap_nopost()
 implementation
Date: Tue, 11 Apr 2017 15:15:59 +0200
Message-ID: <20170411131559.GW26295@axis.com>
References: <20170411122923.6285-1-lorenzo.pieralisi@arm.com>
 <20170411122923.6285-9-lorenzo.pieralisi@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pci-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20170411122923.6285-9-lorenzo.pieralisi@arm.com>
Sender: linux-pci-owner@vger.kernel.org
To: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc: linux-pci@vger.kernel.org, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Niklas Cassel <nks@flawful.org>, Bjorn Helgaas <bhelgaas@google.com>, Jesper Nilsson <jespern@axis.com>, Mikael Starvik <starvik@axis.com>
List-Id: linux-arch.vger.kernel.org

On Tue, Apr 11, 2017 at 01:28:48PM +0100, Lorenzo Pieralisi wrote:
> The PCI specifications (Rev 3.0, 3.2.5 "Transaction Ordering and Posting")
> mandate non-posted configuration transactions. As further highlighted in
> the PCIe specifications (4.0 - Rev0.3, "Ordering Considerations for the
> Enhanced Configuration Access Mechanism"), through ECAM and
> ECAM-derivative configuration mechanism, the memory mapped transactions
> from the host CPU into Configuration Requests on the PCI express fabric
> may create ordering problems for software because writes to memory
> address are typically posted transactions (unless the architecture can
> enforce through virtual address mapping non-posted write transactions
> behaviour) but writes to Configuration Space are not posted on the PCI
> express fabric.
> 
> Include the asm-generic ioremap_nopost() implementation (currently
> falling back to ioremap_nocache()) to provide a non-posted writes
> ioremap interface to kernel subsystems.
> 
> Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
> Cc: Niklas Cassel <nks@flawful.org>
> Cc: Bjorn Helgaas <bhelgaas@google.com>

For the CRIS-part:

Acked-by: Jesper Nilsson <jesper.nilsson@axis.com>

/^JN - Jesper Nilsson
-- 
               Jesper Nilsson -- jesper.nilsson@axis.com
