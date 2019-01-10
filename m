Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-pg1-f193.google.com ([209.85.215.193]:42043 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728702AbfAJXrd (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 10 Jan 2019 18:47:33 -0500
Received: by mail-pg1-f193.google.com with SMTP id d72so5484238pga.9
        for <linux-arch@vger.kernel.org>; Thu, 10 Jan 2019 15:47:33 -0800 (PST)
Subject: Re: [PATCH 15/15] io_uring: add io_uring_event cache hit information
References: <20190110024404.25372-1-axboe@kernel.dk>
 <20190110024404.25372-16-axboe@kernel.dk>
 <x4936q0ds3y.fsf@segfault.boston.devel.redhat.com>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <cf92044f-1672-1354-b1c4-b86de52f55b9@kernel.dk>
Date: Thu, 10 Jan 2019 16:47:28 -0700
MIME-Version: 1.0
In-Reply-To: <x4936q0ds3y.fsf@segfault.boston.devel.redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Jeff Moyer <jmoyer@redhat.com>
Cc: linux-fsdevel@vger.kernel.org, linux-aio@kvack.org, linux-block@vger.kernel.org, linux-arch@vger.kernel.org, hch@lst.de, avi@scylladb.com
Message-ID: <20190110234728.dulNsx6FmhabGotUgoEjHLqOlXEvDL2WrCnIYqdIkoU@z>

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
