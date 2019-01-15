From: Jonathan Corbet <corbet@lwn.net>
Subject: Re: [PATCH 05/16] Add io_uring IO interface
Date: Tue, 15 Jan 2019 09:51:34 -0700
Message-ID: <20190115095134.6286b7d6@lwn.net>
References: <20190115025531.13985-1-axboe@kernel.dk>
	<20190115025531.13985-6-axboe@kernel.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Return-path: <owner-linux-aio@kvack.org>
In-Reply-To: <20190115025531.13985-6-axboe@kernel.dk>
Sender: owner-linux-aio@kvack.org
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-fsdevel@vger.kernel.org, linux-aio@kvack.org, linux-block@vger.kernel.org, linux-arch@vger.kernel.org, hch@lst.de, jmoyer@redhat.com, avi@scylladb.com
List-Id: linux-arch.vger.kernel.org

On Mon, 14 Jan 2019 19:55:20 -0700
Jens Axboe <axboe@kernel.dk> wrote:

So the [0/16] cover letter seems to have gone astray this time?

Anyway, a couple of minor notes/questions:

> The submission queue (SQ) and completion queue (CQ) rings are shared
> between the application and the kernel. This eliminates the need to
> copy data back and forth to submit and complete IO.
> 
> IO submissions use the io_uring_sqe data structure, and completions
> are generated in the form of io_uring_sqe data structures. The SQ
> ring is an index into the io_uring_sqe array, which makes it possible
> to submit a batch of IOs without them being contiguous in the ring.
> The CQ ring is always contiguous, as completion events are inherently
> unordered and can point to any io_uring_iocb.
> 
> Two new system calls are added for this:
> 
> io_uring_setup(entries, iovecs, params)
> 	Sets up a context for doing async IO. On success, returns a file
> 	descriptor that the application can mmap to gain access to the
> 	SQ ring, CQ ring, and io_uring_iocbs.

Looking at the code, it would appear that the "iovecs" parameter doesn't
actually exist.

> io_uring_enter(fd, to_submit, min_complete, flags)
> 	Initiates IO against the rings mapped to this fd, or waits for
> 	them to complete, or both The behavior is controlled by the
> 	parameters passed in. If 'min_complete' is non-zero, then we'll
> 	try and submit new IO. If IORING_ENTER_GETEVENTS is set, the
> 	kernel will wait for 'min_complete' events, if they aren't
> 	already available.

I feel like I'm missing something here.  Rather than have the
IORING_ENTER_GETEVENTS flag, why not just wait if min_complete > 0 ?

Thanks,

jon

--
To unsubscribe, send a message with 'unsubscribe linux-aio' in
the body to majordomo@kvack.org.  For more info on Linux AIO,
see: http://www.kvack.org/aio/
Don't email: <a href=mailto:"aart@kvack.org">aart@kvack.org</a>
