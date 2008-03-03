From: Jesse Barnes <jbarnes@virtuousgeek.org>
Subject: Re: [patch 5/6] PARISC: move PERR & SERR enables out of pcibios_enable_resources()
Date: Mon, 3 Mar 2008 10:30:58 -0800
Message-ID: <200803031030.59305.jbarnes@virtuousgeek.org>
References: <20080228000437.880811124@ldl.fc.hp.com> <20080228001053.209248743@ldl.fc.hp.com> <20080228173125.GA16270@colo.lackof.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-parisc-owner@vger.kernel.org>
In-Reply-To: <20080228173125.GA16270@colo.lackof.org>
Content-Disposition: inline
Sender: linux-parisc-owner@vger.kernel.org
To: linux-pci@atrey.karlin.mff.cuni.cz
Cc: Grant Grundler <grundler@parisc-linux.org>, Bjorn Helgaas <bjorn.helgaas@hp.com>, linux-arch@vger.kernel.org, Russell King <rmk@arm.linux.org.uk>, linux-arm-kernel@lists.arm.linux.org.uk, Kyle McMartin <kyle@parisc-linux.org>, Matthew Wilcox <matthew@wil.cx>, linux-parisc@vger.kernel.org, Paul Mackerras <paulus@samba.org>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, linuxppc-dev@ozlabs.org, Chris Zankel <chris@zankel.net>
List-Id: linux-arch.vger.kernel.org

On Thursday, February 28, 2008 9:31 am Grant Grundler wrote:
> In general, I'm wondering if the check for device class would be
> sufficient here to NOT enable PERR/SERR for graphics automatically.
> While disabling PERR was "the right thing" for older "mostly write"
> devices of the 1990's and early 2000, it might not be correct for
> current 3-D graphics devices which use host mem to buffer processed
> results. I'm thinking of Intel graphics controllers in particular
> but I don't know any details of how they actually work.

Well, in general chipset devices aren't required to support parity checking, 
AIUI; Intel gfx devices don't bother (PERR enable is hardwired to 0).

> I'm also a bit concerned about this now becuase (IIRC) AGP didn't
> implement parity though it looked like PCI protocol. PCI-e certainly
> does but it's possible BIOS/Firmware disable parity generation
> on the host bridge when connected to a gfx device.
> We wouldn't want to enable parity checking on a PCI-e gfx device in this
> case and I hope someone (perhaps at Intel) could double check this.

I'd have to ping our BIOS folks to see if that's the case, but I doubt it.  It 
would be a bad idea to disable any PCIe error reporting (including legacy 
error mapping) just because a gfx device was attached.  Apparently the AMD 
PCIe parts include PERR generation, so disabling upstream reporting at boot 
time seems like it would be an outright bug; it should be left up to driver & 
OS software.

Jesse


