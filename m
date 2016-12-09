Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from verein.lst.de ([213.95.11.211]:45240 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750982AbcLISWc (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Fri, 9 Dec 2016 13:22:32 -0500
Date: Fri, 9 Dec 2016 19:22:30 +0100
From: Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH 3/5] Move dma_ops from archdata into struct device
Message-ID: <20161209182230.GC16622@lst.de>
References: <07c07529-4636-fafb-2598-7358d8a1460d@sandisk.com> <58a325aa-8df7-6a2e-fadb-5d9031d8a1a0@sandisk.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <58a325aa-8df7-6a2e-fadb-5d9031d8a1a0@sandisk.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Bart Van Assche <bart.vanassche@sandisk.com>
Cc: Doug Ledford <dledford@redhat.com>, Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>, "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>, David Woodhouse <dwmw2@infradead.org>, virtualization@lists.linux-foundation.org, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org
Message-ID: <20161209182230.0BMw8kjBduBa2epklOU24QwgrwxeC2ZeQP3QFlR8ktU@z>

We'll need a bit of a wieder audience for this I think..

On Wed, Dec 07, 2016 at 05:11:28PM -0800, Bart Van Assche wrote:
> Additionally, introduce set_dma_ops(). A later patch will introduce a
> call to that function in the RDMA drivers that will be modified to use
> dma_noop_ops.

This looks good to me, and we had a lot of talk about this for other
purposes for a while. 
