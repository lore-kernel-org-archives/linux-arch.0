Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from verein.lst.de ([213.95.11.211]:49594 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751253AbdGQGmW (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Mon, 17 Jul 2017 02:42:22 -0400
Date: Mon, 17 Jul 2017 08:42:20 +0200
From: Christoph Hellwig <hch@lst.de>
Subject: Re: semantics of dma_map_single()
Message-ID: <20170717064220.GA15807@lst.de>
References: <dc128260-6641-828a-3bb6-c2f0b4f09f78@synopsys.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <dc128260-6641-828a-3bb6-c2f0b4f09f78@synopsys.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Vineet Gupta <Vineet.Gupta1@synopsys.com>
Cc: "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, "linux-mm@kvack.org" <linux-mm@kvack.org>, Christoph Hellwig <hch@lst.de>, bart.vanassche@sandisk.com, Alexander Duyck <alexander.h.duyck@intel.com>, Krzysztof Kozlowski <k.kozlowski@samsung.com>, Andrew Morton <akpm@linux-foundation.org>, lkml <linux-kernel@vger.kernel.org>, arcml <linux-snps-arc@lists.infradead.org>
Message-ID: <20170717064220.8mkkLBJ3exp_15qun5mkPt8RjWwhkb6Jzi0Xakw743o@z>

I would expect that it would support any contiguous range in
the kernel mapping (e.g. no vmalloc and friends).  But it's not
documented anywhere, and if no in kernel users makes use of that
fact at the moment it might be better to document a page size
limitation and add asserts to enforce it.
