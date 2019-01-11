From: Roman Penyaev <rpenyaev@suse.de>
Subject: Re: [PATCHSET v2] io_uring IO interface
Date: Fri, 11 Jan 2019 17:39:33 +0100
Message-ID: <43189f1be5f03697f750631d31ffaed5@suse.de>
References: <20190110024404.25372-1-axboe@kernel.dk>
 <fe686e4316f9746c46b91fd58c984531@suse.de>
 <CAOi1vP9B7Z5jm4vcLux8eOvixgWmC7V=zKBzGnOOJHYO1AhVwA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <owner-linux-aio@kvack.org>
In-Reply-To: <CAOi1vP9B7Z5jm4vcLux8eOvixgWmC7V=zKBzGnOOJHYO1AhVwA@mail.gmail.com>
Sender: owner-linux-aio@kvack.org
To: Ilya Dryomov <idryomov@gmail.com>
Cc: Jens Axboe <axboe@kernel.dk>, linux-fsdevel <linux-fsdevel@vger.kernel.org>, linux-aio@kvack.org, linux-block <linux-block@vger.kernel.org>, linux-arch@vger.kernel.org, Christoph Hellwig <hch@lst.de>, jmoyer@redhat.com, avi@scylladb.com, linux-block-owner@vger.kernel.org
List-Id: linux-arch.vger.kernel.org

On 2019-01-11 17:11, Ilya Dryomov wrote:
> On Fri, Jan 11, 2019 at 10:51 AM Roman Penyaev <rpenyaev@suse.de> 
> wrote:
>> 
>> Hi Jens,
>> 
>> That is interesting.  Recently I sent an rfc related to epoll uring:
>> 
>> https://lore.kernel.org/lkml/20190109164025.24554-1-rpenyaev@suse.de
>> 
>> which can be mapped to userspace and all ready events can be consumed
>> from it directly.  I am wondering, is it possible to make some common
>> API for all kind of ready events / urings, or it doesn't make any
>> sense?
> 
> I think you can use the new IOCB_CMD_POLL from Christoph and avoid
> epoll_wait() in favor of aio/io_uring interface, at least in new high
> performance applications.

Yeah, I saw this extension for aio from Christoph.  I was motivated to
extend epoll with uring to avoid constant recharging of file 
descriptors,
i.e. once you inserted descriptor to epoll you just consume events from
uring (of course in that particular case only edge triggered events are
supported).

Also recently for epoll I fixed contention on event callback making hot
path completely lockless, i.e. with uring epoll can become a nice thingy
in terms of performance.

But can any descriptor (on vfs layer) be extended to have a uring? To 
have
some common API? Then if event source (say socket) has a uring (do not
know how, just thoughts) and event destination (aio, epoll) has a uring,
then reading on userside can be a matter of traversing urings.

> Reaping events entirely in userspace (i.e.
> performing io_getevents() without entering the kernel) has been
> possible for a long time even with the existing aio interface.

True.

--
Roman

--
To unsubscribe, send a message with 'unsubscribe linux-aio' in
the body to majordomo@kvack.org.  For more info on Linux AIO,
see: http://www.kvack.org/aio/
Don't email: <a href=mailto:"aart@kvack.org">aart@kvack.org</a>
