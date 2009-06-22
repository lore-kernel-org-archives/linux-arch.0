From: Matthew Wilcox <matthew@wil.cx>
Subject: Re: [PATCH] PCI: remove pcibios_scan_all_fns()
Date: Mon, 22 Jun 2009 08:34:31 -0600
Message-ID: <20090622143431.GT19977@parisc-linux.org>
References: <20090622140807.25509.54448.stgit@bob.kio>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1757283AbZFVOem@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20090622140807.25509.54448.stgit@bob.kio>
Sender: linux-kernel-owner@vger.kernel.org
To: Alex Chiang <achiang@hp.com>
Cc: jbarnes@virtuousgeek.org, linux-arch@vger.kernel.org, Kyle McMartin <kyle@mcmartin.ca>, Tony Luck <tony.luck@intel.com>, Russell King <linux@arm.linux.org.uk>, Arnd Bergmann <arnd@arndb.de>, Yoshinori Sato <ysato@users.sourceforge.jp>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Jeff Dike <jdike@addtoit.com>, linux-kernel@vger.kernel.org, Ralf Baechle <ralf@linux-mips.org>, David Howells <dhowells@redhat.com>, Paul Mundt <lethal@linux-sh.org>, Ivan Kokshaysky <ink@jurassic.park.msu.ru>, Ingo Molnar <mingo@redhat.com>, "David S. Miller" <davem@davemloft.net>
List-Id: linux-arch.vger.kernel.org

On Mon, Jun 22, 2009 at 08:08:07AM -0600, Alex Chiang wrote:
> This was #define'd as 0 on all platforms, so let's get rid of it.
> 
> This change makes pci_scan_slot() slightly easier to read.

> diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
> index f1ae247..b613cad 100644
> --- a/drivers/pci/probe.c
> +++ b/drivers/pci/probe.c
> @@ -1056,8 +1056,7 @@ int pci_scan_slot(struct pci_bus *bus, int devfn)
>  	if (dev && !dev->is_added)	/* new device? */
>  		nr++;
>  
> -	if ((dev && dev->multifunction) ||
> -	    (!dev && pcibios_scan_all_fns(bus, devfn))) {
> +	if (dev && dev->multifunction) {
>  		for (fn = 1; fn < 8; fn++) {
>  			dev = pci_scan_single_device(bus, devfn + fn);
>  			if (dev) {

What a good idea.  I was just looking at making this more complicated
(due to the ARI capability).

I'd like to know what the KVM / Xen / ... people think about this.
I don't know if they rely on function 5 being able to show up out of
the blue.

Anyway,
Reviewed-by: Matthew Wilcox <willy@linux.intel.com>

-- 
Matthew Wilcox				Intel Open Source Technology Centre
"Bill, look, we understand that you're interested in selling us this
operating system, but compare it to ours.  We can't possibly take such
a retrograde step."
