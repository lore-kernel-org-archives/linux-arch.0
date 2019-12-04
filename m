From: Christoph Hellwig <hch@lst.de>
Subject: Re: Bug 205201 - Booting halts if Dawicontrol DC-2976 UW SCSI
 board installed, unless RAM size limited to 3500M
Date: Wed, 4 Dec 2019 09:56:34 +0100
Message-ID: <20191204085634.GA25929@lst.de>
References: <dbde2252-035e-6183-7897-43348e60647e@xenosoft.de> <6eec5c42-019c-a988-fc2a-cb804194683d@xenosoft.de> <d0252d29-7a03-20e1-ccd7-e12d906e4bdf@arm.com> <b3217742-2c0b-8447-c9ac-608b93265363@xenosoft.de> <20191121180226.GA3852@lst.de> <2fde79cf-875f-94e6-4a1b-f73ebb2e2c32@xenosoft.de> <20191125073923.GA30168@lst.de> <4681f5fe-c095-15f5-9221-4b55e940bafc@xenosoft.de> <20191126164026.GA8026@lst.de> <20191127065624.GB16913@linux.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20191127065624.GB16913@linux.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Mike Rapoport <rppt@linux.ibm.com>
Cc: Christoph Hellwig <hch@lst.de>, Christian Zigotzky <chzigotzky@xenosoft.de>, Robin Murphy <robin.murphy@arm.com>, linux-arch@vger.kernel.org, darren@stevens-zone.net, mad skateman <madskateman@gmail.com>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, linux-kernel@vger.kernel.org, linux-mm@kvack.org, iommu@lists.linux-foundation.org, Rob Herring <robh+dt@kernel.org>, paulus@samba.org, rtd2@xtra.co.nz, "contact@a-eon.com" <contact@a-eon.com>, linuxppc-dev <linuxppc-dev@lists.ozlabs.org>, nsaenzjulienne@suse.de
List-Id: linux-arch.vger.kernel.org

On Wed, Nov 27, 2019 at 08:56:25AM +0200, Mike Rapoport wrote:
> On Tue, Nov 26, 2019 at 05:40:26PM +0100, Christoph Hellwig wrote:
> > On Tue, Nov 26, 2019 at 12:26:38PM +0100, Christian Zigotzky wrote:
> > > Hello Christoph,
> > >
> > > The PCI TV card works with your patch! I was able to patch your Git kernel 
> > > with the patch above.
> > >
> > > I haven't found any error messages in the dmesg yet.
> > 
> > Thanks.  Unfortunately this is a bit of a hack as we need to set
> > the mask based on runtime information like the magic FSL PCIe window.
> > Let me try to draft something better up, and thanks already for testing
> > this one!
> 
> Maybe we'll simply force bottom up allocation before calling
> swiotlb_init()? Anyway, it's the last memblock allocation.

So I think we should go with this fix (plus a source code comment) for
now.  Revamping the whole memory initialization is going to take a
while, and this fix also is easily backportable.
