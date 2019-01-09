Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from bombadil.infradead.org ([198.137.202.133]:50244 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730263AbfAIQAj (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 9 Jan 2019 11:00:39 -0500
Date: Wed, 9 Jan 2019 08:00:36 -0800
From: Matthew Wilcox <willy@infradead.org>
Subject: Re: [PATCHSET v1] io_uring IO interface
Message-ID: <20190109160036.GK6310@bombadil.infradead.org>
References: <20190108165645.19311-1-axboe@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190108165645.19311-1-axboe@kernel.dk>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-fsdevel@vger.kernel.org, linux-aio@kvack.org, linux-block@vger.kernel.org, linux-arch@vger.kernel.org, hch@lst.de, jmoyer@redhat.com, avi@scylladb.com
Message-ID: <20190109160036.pwwHBmbFtw65qZR8OYGaZogrwHOc5nPteRC_-_3XqOU@z>

On Tue, Jan 08, 2019 at 09:56:29AM -0700, Jens Axboe wrote:
> After some arm twisting from Christoph, I finally caved and divorced the
> aio-poll patches from aio/libaio itself. The io_uring interface itself
> is useful and efficient, and after rebasing all the new goodies on top
> of that, there was little reason to retail the aio connection.
> 
> Hence io_uring was born. This is what I previously called scqring for
> aio, but now as a standalone entity. Patch #5 adds the core of this
> interface, but in short, it has two main data structures:

Please can we call it something that looks a little less like io_urine?
aio_ring?  io_ring?  ring_io?
