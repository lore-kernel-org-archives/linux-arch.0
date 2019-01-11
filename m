Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-it1-f196.google.com ([209.85.166.196]:55736 "EHLO
        mail-it1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728944AbfAKQMI (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 11 Jan 2019 11:12:08 -0500
MIME-Version: 1.0
References: <20190110024404.25372-1-axboe@kernel.dk> <fe686e4316f9746c46b91fd58c984531@suse.de>
In-Reply-To: <fe686e4316f9746c46b91fd58c984531@suse.de>
From: Ilya Dryomov <idryomov@gmail.com>
Date: Fri, 11 Jan 2019 17:11:57 +0100
Message-ID: <CAOi1vP9B7Z5jm4vcLux8eOvixgWmC7V=zKBzGnOOJHYO1AhVwA@mail.gmail.com>
Subject: Re: [PATCHSET v2] io_uring IO interface
Content-Type: text/plain; charset="UTF-8"
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Roman Penyaev <rpenyaev@suse.de>
Cc: Jens Axboe <axboe@kernel.dk>, linux-fsdevel <linux-fsdevel@vger.kernel.org>, linux-aio@kvack.org, linux-block <linux-block@vger.kernel.org>, linux-arch@vger.kernel.org, Christoph Hellwig <hch@lst.de>, jmoyer@redhat.com, avi@scylladb.com, linux-block-owner@vger.kernel.org
Message-ID: <20190111161157.cc4VAVZ5YHBwynq4pOzi6Lsbus95uMsOe9kUy5HKIX0@z>

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
