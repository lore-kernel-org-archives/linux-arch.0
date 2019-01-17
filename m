From: Christoph Hellwig <hch@lst.de>
Subject: Re: use generic DMA mapping code in powerpc V4
Date: Thu, 17 Jan 2019 10:31:17 +0100
Message-ID: <20190117093117.GA31557@lst.de>
References: <3504ee70-02de-049e-6402-2d530bf55a84@xenosoft.de> <23284859-bf0a-9cd5-a480-2a7fd7802056@xenosoft.de> <075f70e3-7a4a-732f-b501-05a1a8e3c853@xenosoft.de> <b04d08ea-61f9-3212-b9a3-ad79e3b8bd05@xenosoft.de> <21f72a6a-9095-7034-f169-95e876228b2a@xenosoft.de> <27148ac2-2a92-5536-d886-2c0971ab43d9@xenosoft.de> <20190115133558.GA29225@lst.de> <685f0c06-af1b-0bec-ac03-f9bf1f7a2b35@xenosoft.de> <20190115151732.GA2325@lst.de> <e9345547-4dc6-747a-29ec-6375dc8bfe83@xenosoft.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <e9345547-4dc6-747a-29ec-6375dc8bfe83@xenosoft.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Christian Zigotzky <chzigotzky@xenosoft.de>
Cc: Christoph Hellwig <hch@lst.de>, linux-arch@vger.kernel.org, Darren Stevens <darren@stevens-zone.net>, linux-kernel@vger.kernel.org, Julian Margetson <runaway@candw.ms>, linux-mm@kvack.org, iommu@lists.linux-foundation.org, Paul Mackerras <paulus@samba.org>, Olof Johansson <olof@lixom.net>, linuxppc-dev@lists.ozlabs.org
List-Id: linux-arch.vger.kernel.org

On Thu, Jan 17, 2019 at 10:21:11AM +0100, Christian Zigotzky wrote:
> The X1000 boots and the PASEMI onboard ethernet works!
>
> Bad news for the X5000 (P5020 board). U-Boot loads the kernel and the dtb 
> file. Then the kernel starts but it doesn't find any hard disks 
> (partitions).

Thanks for bisecting so far, and lets stop here until I manage to
resolve the problem.

Can you send me the .config and the dtb file for this board?
