Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-by2nam03on0066.outbound.protection.outlook.com ([104.47.42.66]:33492
        "EHLO NAM03-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1753048AbcLIUCY (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Fri, 9 Dec 2016 15:02:24 -0500
Subject: Re: [PATCH 3/5] Move dma_ops from archdata into struct device
References: <07c07529-4636-fafb-2598-7358d8a1460d@sandisk.com>
 <58a325aa-8df7-6a2e-fadb-5d9031d8a1a0@sandisk.com>
 <20161209182230.GC16622@lst.de> <1481310814.98151.11.camel@infradead.org>
From: Bart Van Assche <bart.vanassche@sandisk.com>
Message-ID: <cbfac346-3b71-fffb-65f6-3566a00366a4@sandisk.com>
Date: Fri, 9 Dec 2016 11:46:30 -0800
MIME-Version: 1.0
In-Reply-To: <1481310814.98151.11.camel@infradead.org>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: David Woodhouse <dwmw2@infradead.org>, Christoph Hellwig <hch@lst.de>
Cc: Doug Ledford <dledford@redhat.com>, Sagi Grimberg <sagi@grimberg.me>, "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>, virtualization@lists.linux-foundation.org, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org
Message-ID: <20161209194630.Al3ZmauJWg8eJZMBkSqbguUe0jLj4OHO4B2fJDEzawQ@z>

On 12/09/2016 11:13 AM, David Woodhouse wrote:
> On Fri, 2016-12-09 at 19:22 +0100, Christoph Hellwig wrote:
>> We'll need a bit of a wieder audience for this I think..
>>
>> On Wed, Dec 07, 2016 at 05:11:28PM -0800, Bart Van Assche wrote:
>>> Additionally, introduce set_dma_ops(). A later patch will introduce a
>>> call to that function in the RDMA drivers that will be modified to use
>>> dma_noop_ops.
>>
>> This looks good to me, and we had a lot of talk about this for other
>> purposes for a while.
>
> Hm, I'm not convinced we want per-device dma_ops. What we want is per-
> device IOMMU ops, and any dma_ops are just a generic or platform-
> specific (in some cases) wrapper around those. We shouldn't normally
> need per-device DMA ops at all.

Hello David,

Can you recommend an approach for e.g. the qib driver 
(drivers/infiniband/hw/qib)? That driver uses the CPU (PIO) instead of 
DMA to transfer data to a PCIe device. Sorry but I don't see how 
per-device IOMMU ops would allow to avoid that e.g. a cache flush is 
triggered before PIO starts.

Bart.

