Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:38968 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726149AbfAJXMu (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Thu, 10 Jan 2019 18:12:50 -0500
From: Jeff Moyer <jmoyer@redhat.com>
Subject: Re: [PATCH 15/15] io_uring: add io_uring_event cache hit information
References: <20190110024404.25372-1-axboe@kernel.dk>
        <20190110024404.25372-16-axboe@kernel.dk>
Date: Thu, 10 Jan 2019 18:12:49 -0500
In-Reply-To: <20190110024404.25372-16-axboe@kernel.dk> (Jens Axboe's message
        of "Wed, 9 Jan 2019 19:44:04 -0700")
Message-ID: <x4936q0ds3y.fsf@segfault.boston.devel.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-fsdevel@vger.kernel.org, linux-aio@kvack.org, linux-block@vger.kernel.org, linux-arch@vger.kernel.org, hch@lst.de, avi@scylladb.com
Message-ID: <20190110231249.RD67BcWZWRPBbNou_RkOZSdyQ3x8IZk_XXwH2tsvchc@z>

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
