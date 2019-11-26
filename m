Return-Path: <hch@lst.de>
Date: Tue, 26 Nov 2019 17:40:26 +0100
From: Christoph Hellwig <hch@lst.de>
Subject: Re: Bug 205201 - Booting halts if Dawicontrol DC-2976 UW SCSI
 board installed, unless RAM size limited to 3500M
Message-ID: <20191126164026.GA8026@lst.de>
References: <F1EBB706-73DF-430E-9020-C214EC8ED5DA@xenosoft.de> <20191121072943.GA24024@lst.de> <dbde2252-035e-6183-7897-43348e60647e@xenosoft.de> <6eec5c42-019c-a988-fc2a-cb804194683d@xenosoft.de> <d0252d29-7a03-20e1-ccd7-e12d906e4bdf@arm.com> <b3217742-2c0b-8447-c9ac-608b93265363@xenosoft.de> <20191121180226.GA3852@lst.de> <2fde79cf-875f-94e6-4a1b-f73ebb2e2c32@xenosoft.de> <20191125073923.GA30168@lst.de> <4681f5fe-c095-15f5-9221-4b55e940bafc@xenosoft.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4681f5fe-c095-15f5-9221-4b55e940bafc@xenosoft.de>
To: Christian Zigotzky <chzigotzky@xenosoft.de>
Cc: Christoph Hellwig <hch@lst.de>, Robin Murphy <robin.murphy@arm.com>, linux-arch@vger.kernel.org, darren@stevens-zone.net, mad skateman <madskateman@gmail.com>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, linux-kernel@vger.kernel.org, linux-mm@kvack.org, iommu@lists.linux-foundation.org, Rob Herring <robh+dt@kernel.org>, paulus@samba.org, rtd2@xtra.co.nz, "contact@a-eon.com" <contact@a-eon.com>, linuxppc-dev <linuxppc-dev@lists.ozlabs.org>, nsaenzjulienne@suse.de, Mike Rapoport <rppt@linux.ibm.com>
List-ID: <linux-arch.vger.kernel.org>
Message-ID: <20191126164026.QEWdyjCLnF5t1AvzIQrMShjxiNjNx3A8AUQOMGj2MzM@z>

On Tue, Nov 26, 2019 at 12:26:38PM +0100, Christian Zigotzky wrote:
> Hello Christoph,
>
> The PCI TV card works with your patch! I was able to patch your Git kernel 
> with the patch above.
>
> I haven't found any error messages in the dmesg yet.

Thanks.  Unfortunately this is a bit of a hack as we need to set
the mask based on runtime information like the magic FSL PCIe window.
Let me try to draft something better up, and thanks already for testing
this one!
