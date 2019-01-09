From: Matthew Wilcox <willy@infradead.org>
Subject: Re: [PATCHSET v1] io_uring IO interface
Date: Wed, 9 Jan 2019 08:00:36 -0800
Message-ID: <20190109160036.GK6310@bombadil.infradead.org>
References: <20190108165645.19311-1-axboe@kernel.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <owner-linux-aio@kvack.org>
Content-Disposition: inline
In-Reply-To: <20190108165645.19311-1-axboe@kernel.dk>
Sender: owner-linux-aio@kvack.org
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-fsdevel@vger.kernel.org, linux-aio@kvack.org, linux-block@vger.kernel.org, linux-arch@vger.kernel.org, hch@lst.de, jmoyer@redhat.com, avi@scylladb.com
List-Id: linux-arch.vger.kernel.org

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

--
To unsubscribe, send a message with 'unsubscribe linux-aio' in
the body to majordomo@kvack.org.  For more info on Linux AIO,
see: http://www.kvack.org/aio/
Don't email: <a href=mailto:"aart@kvack.org">aart@kvack.org</a>
