Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from verein.lst.de ([213.95.11.211]:57024 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729961AbfAKQVq (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Fri, 11 Jan 2019 11:21:46 -0500
Date: Fri, 11 Jan 2019 17:21:43 +0100
From: Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCHSET v2] io_uring IO interface
Message-ID: <20190111162143.GA14914@lst.de>
References: <20190110024404.25372-1-axboe@kernel.dk> <fe686e4316f9746c46b91fd58c984531@suse.de> <CAOi1vP9B7Z5jm4vcLux8eOvixgWmC7V=zKBzGnOOJHYO1AhVwA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOi1vP9B7Z5jm4vcLux8eOvixgWmC7V=zKBzGnOOJHYO1AhVwA@mail.gmail.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Ilya Dryomov <idryomov@gmail.com>
Cc: Roman Penyaev <rpenyaev@suse.de>, Jens Axboe <axboe@kernel.dk>, linux-fsdevel <linux-fsdevel@vger.kernel.org>, linux-aio@kvack.org, linux-block <linux-block@vger.kernel.org>, linux-arch@vger.kernel.org, Christoph Hellwig <hch@lst.de>, jmoyer@redhat.com, avi@scylladb.com, linux-block-owner@vger.kernel.org
Message-ID: <20190111162143.Cqm6TpCo6yz36w3K0WJ_7wAeshM2bILjMJUqOmiFcdk@z>

On Fri, Jan 11, 2019 at 05:11:57PM +0100, Ilya Dryomov wrote:
> I think you can use the new IOCB_CMD_POLL from Christoph and avoid
> epoll_wait() in favor of aio/io_uring interface, at least in new high
> performance applications.  Reaping events entirely in userspace (i.e.
> performing io_getevents() without entering the kernel) has been
> possible for a long time even with the existing aio interface.

For io_uring we can reuse the IOCB_CMD_POLL concept, but we'd have to
add a new cancel command, as the uring right now doesn't support
cancelation.  But I'd rather make that command a new opcode instead
of a separate syscall, which would lead to a nicer design.

A prototype for this should be fairly easy, I'd just want someone
to actually use it for real life testing, like ScyllaDB does for
IOCB_CMD_POLL.
