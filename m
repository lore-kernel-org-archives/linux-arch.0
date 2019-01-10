From: Jens Axboe <axboe@kernel.dk>
Subject: Re: [PATCH 15/15] io_uring: add io_uring_event cache hit information
Date: Thu, 10 Jan 2019 16:47:28 -0700
Message-ID: <cf92044f-1672-1354-b1c4-b86de52f55b9@kernel.dk>
References: <20190110024404.25372-1-axboe@kernel.dk>
 <20190110024404.25372-16-axboe@kernel.dk>
 <x4936q0ds3y.fsf@segfault.boston.devel.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <owner-linux-aio@kvack.org>
In-Reply-To: <x4936q0ds3y.fsf@segfault.boston.devel.redhat.com>
Content-Language: en-US
Sender: owner-linux-aio@kvack.org
To: Jeff Moyer <jmoyer@redhat.com>
Cc: linux-fsdevel@vger.kernel.org, linux-aio@kvack.org, linux-block@vger.kernel.org, linux-arch@vger.kernel.org, hch@lst.de, avi@scylladb.com
List-Id: linux-arch.vger.kernel.org

On 1/10/19 4:12 PM, Jeff Moyer wrote:
> Jens Axboe <axboe@kernel.dk> writes:
> 
>> Add hint on whether a read was served out of the page cache, or if it
>> hit media. This is useful for buffered async IO, O_DIRECT reads would
>> never have this set (for obvious reasons).
>>
>> If the read hit page cache, cqe->flags will have IOCQE_FLAG_CACHEHIT
>> set.
> 
> We may want to hold off on this one until the whole mincore/RWF_NOWAIT
> debate is sorted. [1]

Definitely, it's why it's separate and at the end of the series. But
in reality, this doesn't leak anything that timing doesn't already
tell you. So it's kind of a moot point.

-- 
Jens Axboe

--
To unsubscribe, send a message with 'unsubscribe linux-aio' in
the body to majordomo@kvack.org.  For more info on Linux AIO,
see: http://www.kvack.org/aio/
Don't email: <a href=mailto:"aart@kvack.org">aart@kvack.org</a>
