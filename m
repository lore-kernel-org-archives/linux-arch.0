Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from bombadil.infradead.org ([198.137.202.133]:54920 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729260AbfHZGi0 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 26 Aug 2019 02:38:26 -0400
Date: Sun, 25 Aug 2019 23:38:18 -0700
From: Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH V2] csky: Fixup 610 vipt cache flush mechanism
Message-ID: <20190826063818.GA29871@infradead.org>
References: <1566443122-17540-1-git-send-email-guoren@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1566443122-17540-1-git-send-email-guoren@kernel.org>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: guoren@kernel.org
Cc: arnd@arndb.de, hch@infradead.org, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, linux-csky@vger.kernel.org, douzhk@nationalchip.com, Guo Ren <ren_guo@c-sky.com>
Message-ID: <20190826063818.biMn523S2qurit6NNJZif9MFFRL-Y_qm48AUVe3GVXw@z>

On Thu, Aug 22, 2019 at 11:05:22AM +0800, guoren@kernel.org wrote:
> From: Guo Ren <ren_guo@c-sky.com>
> 
> 610 has vipt aliasing issue, so we need to finish the cache flush
> apis mentioned in cachetlb.rst to avoid data corruption.
> 
> Here is the list of modified apis in the patch:

Looks sensible to me, although I can't really verify the details.
You might also want to Cc linux-mm.
