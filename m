Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from verein.lst.de ([213.95.11.211]:44714 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729818AbeK3EIJ (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Thu, 29 Nov 2018 23:08:09 -0500
Date: Thu, 29 Nov 2018 18:02:06 +0100
From: Christoph Hellwig <hch@lst.de>
Subject: Re: use generic DMA mapping code in powerpc V4
Message-ID: <20181129170206.GA27951@lst.de>
References: <20181114082314.8965-1-hch@lst.de> <20181127074253.GB30186@lst.de> <87zhttfonk.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87zhttfonk.fsf@concordia.ellerman.id.au>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: Christoph Hellwig <hch@lst.de>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Paul Mackerras <paulus@samba.org>, linux-arch@vger.kernel.org, linux-mm@kvack.org, iommu@lists.linux-foundation.org, linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Message-ID: <20181129170206.pgraPAQ83FY0NYRH-tHbuG1tWGkX8TosxJKbAGe7Pe8@z>

On Wed, Nov 28, 2018 at 10:05:19PM +1100, Michael Ellerman wrote:
> Is the plan that you take these via the dma-mapping tree or that they go
> via powerpc?

In principle either way is fine with me.  If it goes through the powerpc
tree we might run into a few minor conflicts with the dma-mapping tree
depending on how some of the current discussions go.
