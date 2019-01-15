Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-pf1-f196.google.com ([209.85.210.196]:41891 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730746AbfAOQzh (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 15 Jan 2019 11:55:37 -0500
Received: by mail-pf1-f196.google.com with SMTP id b7so1576313pfi.8
        for <linux-arch@vger.kernel.org>; Tue, 15 Jan 2019 08:55:36 -0800 (PST)
Subject: Re: [PATCH 05/16] Add io_uring IO interface
References: <20190115025531.13985-1-axboe@kernel.dk>
 <20190115025531.13985-6-axboe@kernel.dk> <20190115095134.6286b7d6@lwn.net>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <5e1fe0b7-7998-d15d-267b-4dbbc01b0b53@kernel.dk>
Date: Tue, 15 Jan 2019 09:55:32 -0700
MIME-Version: 1.0
In-Reply-To: <20190115095134.6286b7d6@lwn.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Jonathan Corbet <corbet@lwn.net>
Cc: linux-fsdevel@vger.kernel.org, linux-aio@kvack.org, linux-block@vger.kernel.org, linux-arch@vger.kernel.org, hch@lst.de, jmoyer@redhat.com, avi@scylladb.com
Message-ID: <20190115165532.nAI1yQstRKPUNCqDQ59HVXSwb5ZtdPn59UCstQdDJg0@z>

On 1/15/19 9:51 AM, Jonathan Corbet wrote:
> On Mon, 14 Jan 2019 19:55:20 -0700
> Jens Axboe <axboe@kernel.dk> wrote:
> 
> So the [0/16] cover letter seems to have gone astray this time?

It did go out, but I forgot to add a Subject line to it...

https://marc.info/?l=linux-block&m=154752095709422&w=2


>> The submission queue (SQ) and completion queue (CQ) rings are shared
>> between the application and the kernel. This eliminates the need to
>> copy data back and forth to submit and complete IO.
>>
>> IO submissions use the io_uring_sqe data structure, and completions
>> are generated in the form of io_uring_sqe data structures. The SQ
>> ring is an index into the io_uring_sqe array, which makes it possible
>> to submit a batch of IOs without them being contiguous in the ring.
>> The CQ ring is always contiguous, as completion events are inherently
>> unordered and can point to any io_uring_iocb.
>>
>> Two new system calls are added for this:
>>
>> io_uring_setup(entries, iovecs, params)
>> 	Sets up a context for doing async IO. On success, returns a file
>> 	descriptor that the application can mmap to gain access to the
>> 	SQ ring, CQ ring, and io_uring_iocbs.
> 
> Looking at the code, it would appear that the "iovecs" parameter doesn't
> actually exist.

Indeed, need to update that commit message. and io_uring_iocbs should
now be io_uring_sqes.

The iovec/file registration is done through io_uring_register(2).

>> io_uring_enter(fd, to_submit, min_complete, flags)
>> 	Initiates IO against the rings mapped to this fd, or waits for
>> 	them to complete, or both The behavior is controlled by the
>> 	parameters passed in. If 'min_complete' is non-zero, then we'll
>> 	try and submit new IO. If IORING_ENTER_GETEVENTS is set, the
>> 	kernel will wait for 'min_complete' events, if they aren't
>> 	already available.
> 
> I feel like I'm missing something here.  Rather than have the
> IORING_ENTER_GETEVENTS flag, why not just wait if min_complete > 0 ?

For polled IO, it's useful to be able to check if we have events that
can be readily reaped. If min_complete > 0, then you're asking the
interface to wait/poll for these events. IORING_ENTER_GETEVENTS +
min_complete == 0 is a valid combination to just reap events that are
already completed.

-- 
Jens Axboe
