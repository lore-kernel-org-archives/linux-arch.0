Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from ozlabs.org ([203.11.71.1]:58579 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726262AbeLQBOz (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Sun, 16 Dec 2018 20:14:55 -0500
From: Michael Ellerman <mpe@ellerman.id.au>
Subject: Re: use generic DMA mapping code in powerpc V4
In-Reply-To: <20181216165157.GA14652@lst.de>
References: <20181114082314.8965-1-hch@lst.de> <20181216165157.GA14652@lst.de>
Date: Mon, 17 Dec 2018 12:14:47 +1100
Message-ID: <87d0q1uf7c.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Christoph Hellwig <hch@lst.de>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Paul Mackerras <paulus@samba.org>
Cc: linux-arch@vger.kernel.org, linux-mm@kvack.org, iommu@lists.linux-foundation.org, linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Message-ID: <20181217011447.42vE_Z8uaRjTuYKS8h9JkiS3GQVfhaQuI9y_0uoIfKs@z>

Christoph Hellwig <hch@lst.de> writes:

> FYI, given that we are one week before the expected 4.20 release
> date and I haven't found the bug plaging Christians setups I think
> we need to defer most of this to the next merge window.

OK, sorry I couldn't help. I tried powering up my pasemi board last week
but it just gives me a couple of status leds and nothing else, the fan
never spins up.

> I'd still like to get a few bits in earlier, which I will send out
> separately now.

OK.

cheers
