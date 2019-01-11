From: Jens Axboe <axboe@kernel.dk>
Subject: Re: [PATCHSET v2] io_uring IO interface
Date: Fri, 11 Jan 2019 11:05:35 -0700
Message-ID: <4a4a23c7-7842-0a12-2d46-c892cf2082bd@kernel.dk>
References: <20190110024404.25372-1-axboe@kernel.dk>
 <fe686e4316f9746c46b91fd58c984531@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <owner-linux-aio@kvack.org>
In-Reply-To: <fe686e4316f9746c46b91fd58c984531@suse.de>
Content-Language: en-US
Sender: owner-linux-aio@kvack.org
To: Roman Penyaev <rpenyaev@suse.de>
Cc: linux-fsdevel@vger.kernel.org, linux-aio@kvack.org, linux-block@vger.kernel.org, linux-arch@vger.kernel.org, hch@lst.de, jmoyer@redhat.com, avi@scylladb.com, linux-block-owner@vger.kernel.org
List-Id: linux-arch.vger.kernel.org

On 1/11/19 2:46 AM, Roman Penyaev wrote:
> Hi Jens,
> 
> That is interesting.  Recently I sent an rfc related to epoll uring:
> 
> https://lore.kernel.org/lkml/20190109164025.24554-1-rpenyaev@suse.de
> 
> which can be mapped to userspace and all ready events can be consumed
> from it directly.  I am wondering, is it possible to make some common
> API for all kind of ready events / urings, or it doesn't make any
> sense?

Not sure that's easily possible, even out of the two rings in io_uring,
the sq and cq rings aren't the same. The latter is sequentially
written, as completions come in. The former ring is actually indexes
into the array, so you can submit things out of order when needed.

-- 
Jens Axboe

--
To unsubscribe, send a message with 'unsubscribe linux-aio' in
the body to majordomo@kvack.org.  For more info on Linux AIO,
see: http://www.kvack.org/aio/
Don't email: <a href=mailto:"aart@kvack.org">aart@kvack.org</a>
