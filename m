From: Jesse Barnes <jbarnes@virtuousgeek.org>
Subject: Re: [patch 4/6] ARM: move bridge enable out of pcibios_enable_resources()
Date: Mon, 3 Mar 2008 12:43:51 -0800
Message-ID: <200803031243.51613.jbarnes@virtuousgeek.org>
References: <20080228000437.880811124@ldl.fc.hp.com> <200803030959.35625.jbarnes@virtuousgeek.org> <1204576557.21545.4.camel@pasglop>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-parisc-owner@vger.kernel.org>
In-Reply-To: <1204576557.21545.4.camel@pasglop>
Content-Disposition: inline
Sender: linux-parisc-owner@vger.kernel.org
To: benh@kernel.crashing.org
Cc: linux-pci@atrey.karlin.mff.cuni.cz, Bjorn Helgaas <bjorn.helgaas@hp.com>, linux-arch@vger.kernel.org, Russell King <rmk@arm.linux.org.uk>, linux-arm-kernel@lists.arm.linux.org.uk, Kyle McMartin <kyle@parisc-linux.org>, Matthew Wilcox <matthew@wil.cx>, Grant Grundler <grundler@parisc-linux.org>, linux-parisc@vger.kernel.org, Paul Mackerras <paulus@samba.org>, linuxppc-dev@ozlabs.org, Chris Zankel <chris@zankel.net>
List-Id: linux-arch.vger.kernel.org

On Monday, March 03, 2008 12:35 pm Benjamin Herrenschmidt wrote:
> On Mon, 2008-03-03 at 09:59 -0800, Jesse Barnes wrote:
> > On Wednesday, February 27, 2008 4:04 pm Bjorn Helgaas wrote:
> > > Move bridge enable from pcibios_enable_resources() to
> > > platform_pci_enable_device() so the former matches other
> > > architectures and can be shared.
> >
> > I really like the direction of these patches.  Getting PCI resources
> > assigned & devices setup correctly for new arches has always been a bit
> > more trouble than it should be...
>
> You'll noticed that I recently moved powerpc to something more common to
> x86 in the are of resource allocation. Still -slightly- different but I
> do believe there is room for somebody with some skills to try to turn
> some of that into generic code.

Yeah, I think that would be a good thing to shoot for.  Even on PCs there are 
times when we need resource allocation to be done (or re-done) by the kernel 
for hotplug or just because the platform is pared down enough that it doesn't 
to it all by itself.

I might be able to find time to look into that myself in the next few weeks; I 
think we even have some open PCI bugs that could be solved by better resource 
allocation.

Jesse
