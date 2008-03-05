From: Greg KH <greg@kroah.com>
Subject: Re: [patch 05/16] frv: use generic pci_enable_resources()
Date: Wed, 5 Mar 2008 12:14:46 -0800
Message-ID: <20080305201446.GE13569@kroah.com>
References: <20080304185820.723623873@ldl.fc.hp.com> <20080304185646.864917286@ldl.fc.hp.com> <20881.1204728766@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-parisc-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20881.1204728766@redhat.com>
Sender: linux-parisc-owner@vger.kernel.org
To: David Howells <dhowells@redhat.com>
Cc: Bjorn Helgaas <bjorn.helgaas@hp.com>, Russell King <rmk@arm.linux.org.uk>, linux-arm-kernel@lists.arm.linux.org.uk, Kyle McMartin <kyle@parisc-linux.org>, Matthew Wilcox <matthew@wil.cx>, Grant Grundler <grundler@parisc-linux.org>, linux-parisc@vger.kernel.org, Paul Mackerras <paulus@samba.org>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, linuxppc-dev@ozlabs.org, Chris Zankel <chris@zankel.net>, linux-pci@atrey.karlin.mff.cuni.cz, linux-arch@vger.kernel.org
List-Id: linux-arch.vger.kernel.org

On Wed, Mar 05, 2008 at 02:52:46PM +0000, David Howells wrote:
> 
> Bjorn Helgaas <bjorn.helgaas@hp.com> wrote:
> 
> > Use the generic pci_enable_resources() instead of the arch-specific code.
> > 
> > Unlike this arch-specific code, the generic version:
> >     - checks PCI_NUM_RESOURCES (11), not 6, resources
> >     - skips resources that have neither IORESOURCE_IO nor IORESOURCE_MEM set
> >     - skips ROM resources unless IORESOURCE_ROM_ENABLE is set
> >     - checks for resource collisions with "!r->parent"
> > 
> > Signed-off-by: Bjorn Helgaas <bjorn.helgaas@hp.com>
> 
> Acked-by: David Howells <dhowells@redhat.com>

Added, thanks.

greg k-h
