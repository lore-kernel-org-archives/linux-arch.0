Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from shards.monkeyblade.net ([149.20.54.216]:50914 "EHLO
	shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754117AbbJ2AHA (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Wed, 28 Oct 2015 20:07:00 -0400
Date: Wed, 28 Oct 2015 17:23:39 -0700 (PDT)
Message-ID: <20151028.172339.458418017721569530.davem@davemloft.net>
Subject: Re: [PATCH v1 2/2] dma-mapping-common: add DMA attribute -
 DMA_ATTR_IOMMU_BYPASS
From: David Miller <davem@davemloft.net>
In-Reply-To: <1446040632.3405.222.camel@infradead.org>
References: <1446039110.3405.212.camel@infradead.org>
	<20151028.070705.1277125569024626755.davem@davemloft.net>
	<1446040632.3405.222.camel@infradead.org>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: dwmw2@infradead.org
Cc: shamir.rabinovitch@oracle.com, arnd@arndb.de, corbet@lwn.net, linux-doc@vger.kernel.org, linux-arch@vger.kernel.org, luto@kernel.org, jroedel@suse.de, borntraeger@de.ibm.com, cornelia.huck@de.ibm.com, sebott@linux.vnet.ibm.com, pbonzini@redhat.com, hch@lst.de, benh@kernel.crashing.org, kvm@vger.kernel.org, schwidefsky@de.ibm.com, linux-s390@vger.kernel.org
Message-ID: <20151029002339.JtMrML8Jp5MO_VYRu3sR2qt_JBVn7zYqmW7aVbkL2ZY@z>

From: David Woodhouse <dwmw2@infradead.org>
Date: Wed, 28 Oct 2015 22:57:12 +0900

> On Wed, 2015-10-28 at 07:07 -0700, David Miller wrote:
>> In the sparc64 case, the 64-bit DMA address space is divided into
>> IOMMU translated and non-IOMMU translated.
>> 
>> You just set the high bits differently depending upon what you want.
> 
> Wait, does that mean a (rogue) device could *always* get full access to
> physical memory just by setting the high bits appropriately? That
> mapping is *always* available?

The IOMMU supports several modes, one of which disallows passthrough
and this is what you would use in a virtual guest.
