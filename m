From: Christoph Hellwig <hch@lst.de>
Subject: Re: use generic DMA mapping code in powerpc V4
Date: Fri, 14 Dec 2018 17:45:28 +0100
Message-ID: <20181214164528.GB27074@lst.de>
References: <2242B4B2-6311-492E-BFF9-6740E36EC6D4@xenosoft.de> <84558d7f-5a7f-5219-0c3a-045e6b4c494f@xenosoft.de> <20181213091021.GA2106@lst.de> <835bd119-081e-a5ea-1899-189d439c83d6@xenosoft.de> <76bc684a-b4d2-1d26-f18d-f5c9ba65978c@xenosoft.de> <20181213112511.GA4574@lst.de> <e109de27-f4af-147d-dc0e-067c8bafb29b@xenosoft.de> <ad5a5a8a-d232-d523-a6f7-e9377fc3857b@xenosoft.de> <e60d6ca3-860c-f01d-8860-c5e022ec7179@xenosoft.de> <008c981e-bdd2-21a7-f5f7-c57e4850ae9a@xenosoft.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <008c981e-bdd2-21a7-f5f7-c57e4850ae9a@xenosoft.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Christian Zigotzky <chzigotzky@xenosoft.de>
Cc: Christoph Hellwig <hch@lst.de>, linux-arch@vger.kernel.org, Darren Stevens <darren@stevens-zone.net>, linux-kernel@vger.kernel.org, Julian Margetson <runaway@candw.ms>, linux-mm@kvack.org, iommu@lists.linux-foundation.org, Paul Mackerras <paulus@samba.org>, Olof Johansson <olof@lixom.net>, linuxppc-dev@lists.ozlabs.org
List-Id: linux-arch.vger.kernel.org

On Fri, Dec 14, 2018 at 01:00:26PM +0100, Christian Zigotzky wrote:
> On 12 December 2018 at 3:15PM, Christoph Hellwig wrote:
> > Thanks for bisecting.  I've spent some time going over the conversion
> > but can't really pinpoint it.  I have three little patches that switch
> > parts of the code to the generic version.  This is on top of the
> > last good commmit (977706f9755d2d697aa6f45b4f9f0e07516efeda).
> >
> > Can you check with whіch one things stop working?
>
> Hello Christoph,
>
> Great news! All your patches work!

No so great because that means I still have no idea what broke..

> I tested all your patches (including the patch '0004-alloc-free.patch' 
> today) and the PASEMI onboard ethernet works and the P5020 board boots 
> without any problems. Thank you for your work!
> I have a few days off. That means, I will work less and only for the A-EON 
> first level Linux support. I can test again on Thursday next week.

Enjoy your days off!

I think I'll need to prepare something new that is better bisectable,
and use that opportunity to reason about the changes a little more.
