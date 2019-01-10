From: Jeff Moyer <jmoyer@redhat.com>
Subject: Re: [PATCH 15/15] io_uring: add io_uring_event cache hit information
Date: Thu, 10 Jan 2019 18:12:49 -0500
Message-ID: <x4936q0ds3y.fsf@segfault.boston.devel.redhat.com>
References: <20190110024404.25372-1-axboe@kernel.dk>
	<20190110024404.25372-16-axboe@kernel.dk>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <owner-linux-aio@kvack.org>
In-Reply-To: <20190110024404.25372-16-axboe@kernel.dk> (Jens Axboe's message
	of "Wed, 9 Jan 2019 19:44:04 -0700")
Sender: owner-linux-aio@kvack.org
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-fsdevel@vger.kernel.org, linux-aio@kvack.org, linux-block@vger.kernel.org, linux-arch@vger.kernel.org, hch@lst.de, avi@scylladb.com
List-Id: linux-arch.vger.kernel.org

Jens Axboe <axboe@kernel.dk> writes:

> Add hint on whether a read was served out of the page cache, or if it
> hit media. This is useful for buffered async IO, O_DIRECT reads would
> never have this set (for obvious reasons).
>
> If the read hit page cache, cqe->flags will have IOCQE_FLAG_CACHEHIT
> set.

We may want to hold off on this one until the whole mincore/RWF_NOWAIT
debate is sorted. [1]

Cheers,
Jeff

[1] https://lore.kernel.org/lkml/20190109022430.GE27534@dastard/

--
To unsubscribe, send a message with 'unsubscribe linux-aio' in
the body to majordomo@kvack.org.  For more info on Linux AIO,
see: http://www.kvack.org/aio/
Don't email: <a href=mailto:"aart@kvack.org">aart@kvack.org</a>
