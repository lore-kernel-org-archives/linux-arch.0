From: Christoph Hellwig <hch@lst.de>
Subject: Re: Bug 205201 - overflow of DMA mask and bus mask
Date: Wed, 13 Nov 2019 12:02:07 +0100
Message-ID: <20191113110207.GA7280@lst.de>
References: <3504ee70-02de-049e-6402-2d530bf55a84@xenosoft.de> <46025f1b-db20-ac23-7dcd-10bc43bbb6ee@xenosoft.de> <20191105162856.GA15402@lst.de> <2f3c81bd-d498-066a-12c0-0a7715cda18f@xenosoft.de> <d2c614ec-c56e-3ec2-12d0-7561cd30c643@xenosoft.de> <af32bfcc-5559-578d-e1f4-75e454c965bf@xenosoft.de> <0c5a8009-d28b-601f-3d1a-9de0e869911c@xenosoft.de> <a794864f-04ae-9b90-50e7-01b416c861fe@xenosoft.de> <20191112144109.GA11805@lst.de> <9b14ca1b-2d5d-52b5-c7b4-0e637dbb1157@xenosoft.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <9b14ca1b-2d5d-52b5-c7b4-0e637dbb1157@xenosoft.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Christian Zigotzky <chzigotzky@xenosoft.de>
Cc: Christoph Hellwig <hch@lst.de>, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, linux-mm@kvack.org, iommu@lists.linux-foundation.org, Benjamin Herrenschmidt <benh@kernel.crashing.org>, paulus@samba.org, darren@stevens-zone.net, "contact@a-eon.com" <contact@a-eon.com>, rtd2@xtra.co.nz, mad skateman <madskateman@gmail.com>, Rob Herring <robh+dt@kernel.org>, linuxppc-dev <linuxppc-dev@lists.ozlabs.org>, nsaenzjulienne@suse.de
List-Id: linux-arch.vger.kernel.org

Interesting.  Give me some time to come up with a real fix, as drivers
really should not mess with GFP flags for these allocations, and even
if they did swiotlb is supposed to take care of any resulting problems.
