From: David Howells <dhowells@redhat.com>
Subject: Re: [patch 01/16] PCI: add generic pci_enable_resources()
Date: Wed, 05 Mar 2008 14:53:31 +0000
Message-ID: <20894.1204728811@redhat.com>
References: <20080304185819.885549413@ldl.fc.hp.com> <20080304185646.864917286@ldl.fc.hp.com>
Return-path: <linux-parisc-owner@vger.kernel.org>
In-Reply-To: <20080304185819.885549413@ldl.fc.hp.com>
Sender: linux-parisc-owner@vger.kernel.org
To: Bjorn Helgaas <bjorn.helgaas@hp.com>
Cc: dhowells@redhat.com, Russell King <rmk@arm.linux.org.uk>, linux-arm-kernel@lists.arm.linux.org.uk, Kyle McMartin <kyle@parisc-linux.org>, Matthew Wilcox <matthew@wil.cx>, Grant Grundler <grundler@parisc-linux.org>, linux-parisc@vger.kernel.org, Paul Mackerras <paulus@samba.org>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, linuxppc-dev@ozlabs.org, Chris Zankel <chris@zankel.net>, linux-pci@atrey.karlin.mff.cuni.cz, linux-arch@vger.kernel.org
List-Id: linux-arch.vger.kernel.org


Bjorn Helgaas <bjorn.helgaas@hp.com> wrote:

> Each architecture has its own pcibios_enable_resources() implementation.
> These differ in many minor ways that have nothing to do with actual
> architectural differences.  Follow-on patches will make most arches
> use this generic version instead.
> 
> This version is based on powerpc, which seemed most up-to-date.  The only
> functional difference from the x86 version is that this uses "!r->parent"
> to check for resource collisions instead of "!r->start && r->end".
> 
> Signed-off-by: Bjorn Helgaas <bjorn.helgaas@hp.com>

Acked-by: David Howells <dhowells@redhat.com>
