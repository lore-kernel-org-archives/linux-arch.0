From: Jens Axboe <axboe@kernel.dk>
Subject: Re: io_uring vs in_compat_syscall()
Date: Mon, 20 Jul 2020 10:36:40 -0600
Message-ID: <ceb21006-26d0-b216-84a9-5da0b89b5fbf@kernel.dk>
References: <20200720061046.GA10678@lst.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20200720061046.GA10678@lst.de>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Christoph Hellwig <hch@lst.de>
Cc: linux-arch@vger.kernel.org, linux-api@vger.kernel.org, linux-kernel@vger.kernel.org, io-uring@vger.kernel.org
List-Id: linux-arch.vger.kernel.org

On 7/20/20 12:10 AM, Christoph Hellwig wrote:
> Hi Jens,
> 
> I just found a (so far theoretical) issue with the io_uring submission
> offloading to workqueues or threads.  We have lots of places using
> in_compat_syscall() to check if a syscall needs compat treatmenet.
> While the biggest users is iocttl(), we also have a fair amount of
> places using in_compat_task() in read and write methods, and these
> will not do the wrong thing when used with io_uring under certain
> conditions.  I'm not sure how to best fix this, except for making sure
> in_compat_syscall() returns true one way or another for these cases.

We can probably propagate this information in the io_kiocb via a flag,
and have the io-wq worker set TS_COMPAT if that's the case.

-- 
Jens Axboe
