From: Ian Campbell <Ian.Campbell@eu.citrix.com>
Subject: Re: [PATCH] PCI: remove pcibios_scan_all_fns()
Date: Wed, 24 Jun 2009 11:30:54 +0100
Message-ID: <1245839454.31273.40.camel@zakaz.uk.xensource.com>
References: <20090622140807.25509.54448.stgit@bob.kio>
	 <20090622143431.GT19977@parisc-linux.org> <4A3FCB68.3030004@goop.org>
	 <20090622183056.GY19977@parisc-linux.org> <1245714008.4017.7.camel@pasglop>
	 <20090623190826.GJ19977@parisc-linux.org>  <4A413C66.5010306@goop.org>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1751936AbZFXKbU@vger.kernel.org>
In-Reply-To: <4A413C66.5010306@goop.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Jeremy Fitzhardinge <jeremy@goop.org>
Cc: Matthew Wilcox <matthew@wil.cx>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Alex Chiang <achiang@hp.com>, jbarnes@virtuousgeek.org, linux-arch@vger.kernel.org, Kyle McMartin <kyle@mcmartin.ca>, Tony Luck <tony.luck@intel.com>, Russell King <linux@arm.linux.org.uk>, Arnd Bergmann <arnd@arndb.de>, Yoshinori Sato <ysato@users.sourceforge.jp>, Jeff Dike <jdike@addtoit.com>, linux-kernel@vger.kernel.org, Ralf Baechle <ralf@linux-mips.org>, David Howells <dhowells@redhat.com>, Paul Mundt <lethal@linux-sh.org>, Ivan Kokshaysky <ink@jurassic.park.msu.ru>, Ingo Molnar <mingo@redhat.com>, "David S. Miller" <davem@davemloft.net>, Avi Kivity <avi@redhat.com>
List-Id: linux-arch.vger.kernel.org

On Tue, 2009-06-23 at 13:34 -0700, Jeremy Fitzhardinge wrote:
> On 06/23/09 12:08, Matthew Wilcox wrote:
> > I think simply materialising them, either the way the OF code does,
> > or the way the IOV code does is the best route forwards.
> >   
> 
> On reflection, I think this will work.  We have a Xen pci passthrough
> driver which gets told about the passed-through devices via xenbus, and
> does the appropriate setup.  At first glance, there doesn't seem to be
> any problem with that code just explicitly instantiate the devices at
> the PCI level in the same way pci_scan_device does (ie,
> alloc_pci_device, initalize the dev struct, pci_setup_device).
> 
> Is that what you mean?
> 
> IanC has looked at that code more closely, so perhaps he can confirm
> that this will work on our side.

I'm not 100% familiar with this stuff but pcifront_rescan_root()
currently iterates over all devfns for a bus and calls
pci_scan_single_device(). I don't see where we call pci_scan_slot()
which I think would be the only way pcibios_scan_all_fns() would matter
to us so I'm not sure why we have that patch. It's possible all this has
changed since AlexN originally did the work? It was quite a long time
ago now.

Ian.
