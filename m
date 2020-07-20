From: Jens Axboe <axboe-tSWWG44O7X1aa/9Udqfwiw@public.gmane.org>
Subject: Re: io_uring vs in_compat_syscall()
Date: Mon, 20 Jul 2020 11:02:19 -0600
Message-ID: <b754dad5-ee85-8a2f-f41a-8bdc56de42e8@kernel.dk>
References: <ceb21006-26d0-b216-84a9-5da0b89b5fbf@kernel.dk>
 <BACE670C-6A65-4D86-BC5F-A7EA267C3140@amacapital.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-api-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <BACE670C-6A65-4D86-BC5F-A7EA267C3140-kltTT9wpgjJwATOyAt5JVQ@public.gmane.org>
Content-Language: en-US
Sender: linux-api-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Andy Lutomirski <luto-kltTT9wpgjJwATOyAt5JVQ@public.gmane.org>
Cc: Christoph Hellwig <hch-jcswGhMUV9g@public.gmane.org>, linux-arch-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-api-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, io-uring-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-arch.vger.kernel.org

On 7/20/20 10:58 AM, Andy Lutomirski wrote:
> 
>> On Jul 20, 2020, at 9:37 AM, Jens Axboe <axboe-tSWWG44O7X1aa/9Udqfwiw@public.gmane.org> wrote:
>>
>> ﻿On 7/20/20 12:10 AM, Christoph Hellwig wrote:
>>> Hi Jens,
>>>
>>> I just found a (so far theoretical) issue with the io_uring submission
>>> offloading to workqueues or threads.  We have lots of places using
>>> in_compat_syscall() to check if a syscall needs compat treatmenet.
>>> While the biggest users is iocttl(), we also have a fair amount of
>>> places using in_compat_task() in read and write methods, and these
>>> will not do the wrong thing when used with io_uring under certain
>>> conditions.  I'm not sure how to best fix this, except for making sure
>>> in_compat_syscall() returns true one way or another for these cases.
>>
>> We can probably propagate this information in the io_kiocb via a flag,
>> and have the io-wq worker set TS_COMPAT if that's the case.
>>
> 
> Is TS_COMPAT actually a cross-arch concept for which this is safe?
> Having a real arch helper for “set the current syscall arch for the
> current kernel thread” seems more sensible to me. 

Sure, I'd consider that implementation detail for the actual patch(es)
for this issue.

-- 
Jens Axboe
