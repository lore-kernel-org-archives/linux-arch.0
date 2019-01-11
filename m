From: Ilya Dryomov <idryomov@gmail.com>
Subject: Re: [PATCHSET v2] io_uring IO interface
Date: Fri, 11 Jan 2019 17:11:57 +0100
Message-ID: <CAOi1vP9B7Z5jm4vcLux8eOvixgWmC7V=zKBzGnOOJHYO1AhVwA@mail.gmail.com>
References: <20190110024404.25372-1-axboe@kernel.dk> <fe686e4316f9746c46b91fd58c984531@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <owner-linux-aio@kvack.org>
In-Reply-To: <fe686e4316f9746c46b91fd58c984531@suse.de>
Sender: owner-linux-aio@kvack.org
To: Roman Penyaev <rpenyaev@suse.de>
Cc: Jens Axboe <axboe@kernel.dk>, linux-fsdevel <linux-fsdevel@vger.kernel.org>, linux-aio@kvack.org, linux-block <linux-block@vger.kernel.org>, linux-arch@vger.kernel.org, Christoph Hellwig <hch@lst.de>, jmoyer@redhat.com, avi@scylladb.com, linux-block-owner@vger.kernel.org
List-Id: linux-arch.vger.kernel.org

On Fri, Jan 11, 2019 at 10:51 AM Roman Penyaev <rpenyaev@suse.de> wrote:
>
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

I think you can use the new IOCB_CMD_POLL from Christoph and avoid
epoll_wait() in favor of aio/io_uring interface, at least in new high
performance applications.  Reaping events entirely in userspace (i.e.
performing io_getevents() without entering the kernel) has been
possible for a long time even with the existing aio interface.

Thanks,

                Ilya

--
To unsubscribe, send a message with 'unsubscribe linux-aio' in
the body to majordomo@kvack.org.  For more info on Linux AIO,
see: http://www.kvack.org/aio/
Don't email: <a href=mailto:"aart@kvack.org">aart@kvack.org</a>
