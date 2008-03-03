From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [patch 4/6] ARM: move bridge enable out of
	pcibios_enable_resources()
Date: Tue, 04 Mar 2008 07:35:57 +1100
Message-ID: <1204576557.21545.4.camel@pasglop>
References: <20080228000437.880811124@ldl.fc.hp.com>
	<20080228001053.013269726@ldl.fc.hp.com>
	<200803030959.35625.jbarnes@virtuousgeek.org>
Reply-To: benh@kernel.crashing.org
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linuxppc-dev-bounces+glppd-linuxppc64-dev=m.gmane.org@ozlabs.org>
In-Reply-To: <200803030959.35625.jbarnes@virtuousgeek.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>
Sender: linuxppc-dev-bounces+glppd-linuxppc64-dev=m.gmane.org@ozlabs.org
Errors-To: linuxppc-dev-bounces+glppd-linuxppc64-dev=m.gmane.org@ozlabs.org
To: Jesse Barnes <jbarnes@virtuousgeek.org>
Cc: linux-arch@vger.kernel.org, Chris Zankel <chris@zankel.net>, Grant Grundler <grundler@parisc-linux.org>, linux-parisc@vger.kernel.org, Matthew Wilcox <matthew@wil.cx>, Kyle McMartin <kyle@parisc-linux.org>, linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>, linux-pci@atrey.karlin.mff.cuni.cz, linux-arm-kernel@lists.arm.linux.org.uk, Russell King <rmk@arm.linux.org.uk>, Bjorn Helgaas <bjorn.helgaas@hp.com>
List-Id: linux-arch.vger.kernel.org


On Mon, 2008-03-03 at 09:59 -0800, Jesse Barnes wrote:
> On Wednesday, February 27, 2008 4:04 pm Bjorn Helgaas wrote:
> > Move bridge enable from pcibios_enable_resources() to
> > platform_pci_enable_device() so the former matches other
> > architectures and can be shared.
> 
> I really like the direction of these patches.  Getting PCI resources assigned 
> & devices setup correctly for new arches has always been a bit more trouble 
> than it should be...

You'll noticed that I recently moved powerpc to something more common to
x86 in the are of resource allocation. Still -slightly- different but I
do believe there is room for somebody with some skills to try to turn
some of that into generic code.

Ben.
