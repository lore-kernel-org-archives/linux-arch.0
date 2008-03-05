From: David Howells <dhowells@redhat.com>
Subject: Re: [patch 05/16] frv: use generic pci_enable_resources()
Date: Wed, 05 Mar 2008 14:52:46 +0000
Message-ID: <20881.1204728766@redhat.com>
References: <20080304185820.723623873@ldl.fc.hp.com>
	<20080304185646.864917286@ldl.fc.hp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linuxppc-dev-bounces+glppd-linuxppc64-dev=m.gmane.org@ozlabs.org>
In-Reply-To: <20080304185820.723623873@ldl.fc.hp.com>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>
Sender: linuxppc-dev-bounces+glppd-linuxppc64-dev=m.gmane.org@ozlabs.org
Errors-To: linuxppc-dev-bounces+glppd-linuxppc64-dev=m.gmane.org@ozlabs.org
To: Bjorn Helgaas <bjorn.helgaas@hp.com>
Cc: linux-arch@vger.kernel.org, Chris Zankel <chris@zankel.net>, Grant Grundler <grundler@parisc-linux.org>, linux-parisc@vger.kernel.org, Matthew Wilcox <matthew@wil.cx>, Kyle McMartin <kyle@parisc-linux.org>, linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>, linux-pci@atrey.karlin.mff.cuni.cz, linux-arm-kernel@lists.arm.linux.org.uk, Russell King <rmk@arm.linux.org.uk>
List-Id: linux-arch.vger.kernel.org


Bjorn Helgaas <bjorn.helgaas@hp.com> wrote:

> Use the generic pci_enable_resources() instead of the arch-specific code.
> 
> Unlike this arch-specific code, the generic version:
>     - checks PCI_NUM_RESOURCES (11), not 6, resources
>     - skips resources that have neither IORESOURCE_IO nor IORESOURCE_MEM set
>     - skips ROM resources unless IORESOURCE_ROM_ENABLE is set
>     - checks for resource collisions with "!r->parent"
> 
> Signed-off-by: Bjorn Helgaas <bjorn.helgaas@hp.com>

Acked-by: David Howells <dhowells@redhat.com>
