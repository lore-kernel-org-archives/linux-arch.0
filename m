Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from verein.lst.de ([213.95.11.211]:57995 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730496AbeLPQv7 (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Sun, 16 Dec 2018 11:51:59 -0500
Date: Sun, 16 Dec 2018 17:51:57 +0100
From: Christoph Hellwig <hch@lst.de>
Subject: Re: use generic DMA mapping code in powerpc V4
Message-ID: <20181216165157.GA14652@lst.de>
References: <20181114082314.8965-1-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181114082314.8965-1-hch@lst.de>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>, Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>
Cc: linux-arch@vger.kernel.org, linux-mm@kvack.org, iommu@lists.linux-foundation.org, linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Message-ID: <20181216165157.6WwoRnvOr-T5et6lA3KOqe8UK0217U4AaYiHVVBI13A@z>

FYI, given that we are one week before the expected 4.20 release
date and I haven't found the bug plaging Christians setups I think
we need to defer most of this to the next merge window.

I'd still like to get a few bits in earlier, which I will send out
separately now.
