From: Christoph Hellwig <hch@lst.de>
Subject: Re: use generic DMA mapping code in powerpc V4
Date: Fri, 18 Jan 2019 12:28:42 +0100
Message-ID: <20190118112842.GA9115@lst.de>
References: <075f70e3-7a4a-732f-b501-05a1a8e3c853@xenosoft.de> <b04d08ea-61f9-3212-b9a3-ad79e3b8bd05@xenosoft.de> <21f72a6a-9095-7034-f169-95e876228b2a@xenosoft.de> <27148ac2-2a92-5536-d886-2c0971ab43d9@xenosoft.de> <20190115133558.GA29225@lst.de> <685f0c06-af1b-0bec-ac03-f9bf1f7a2b35@xenosoft.de> <20190115151732.GA2325@lst.de> <e9345547-4dc6-747a-29ec-6375dc8bfe83@xenosoft.de> <20190118083539.GA30479@lst.de> <871403f2-fa7d-de15-89eb-070432e15c69@xenosoft.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <871403f2-fa7d-de15-89eb-070432e15c69@xenosoft.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Christian Zigotzky <chzigotzky@xenosoft.de>
Cc: Christoph Hellwig <hch@lst.de>, linux-arch@vger.kernel.org, Darren Stevens <darren@stevens-zone.net>, linux-kernel@vger.kernel.org, Julian Margetson <runaway@candw.ms>, linux-mm@kvack.org, iommu@lists.linux-foundation.org, Paul Mackerras <paulus@samba.org>, Olof Johansson <olof@lixom.net>, linuxppc-dev@lists.ozlabs.org
List-Id: linux-arch.vger.kernel.org

On Fri, Jan 18, 2019 at 12:10:26PM +0100, Christian Zigotzky wrote:
> For which commit?

On top of 257002094bc5935dd63207a380d9698ab81f0775, that is the first
one you identified as breaking the detection of the SATA disks.
