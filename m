Return-Path: <SRS0=C7+S=A7=vger.kernel.org=linux-arch-owner@kernel.org>
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730579AbgGTRCW (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 20 Jul 2020 13:02:22 -0400
Received: from mail-il1-x143.google.com (mail-il1-x143.google.com [IPv6:2607:f8b0:4864:20::143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 003B4C061794
        for <linux-arch@vger.kernel.org>; Mon, 20 Jul 2020 10:02:21 -0700 (PDT)
Received: by mail-il1-x143.google.com with SMTP id q3so13913541ilt.8
        for <linux-arch@vger.kernel.org>; Mon, 20 Jul 2020 10:02:21 -0700 (PDT)
Subject: Re: io_uring vs in_compat_syscall()
References: <ceb21006-26d0-b216-84a9-5da0b89b5fbf@kernel.dk>
 <BACE670C-6A65-4D86-BC5F-A7EA267C3140@amacapital.net>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <b754dad5-ee85-8a2f-f41a-8bdc56de42e8@kernel.dk>
Date: Mon, 20 Jul 2020 11:02:19 -0600
MIME-Version: 1.0
In-Reply-To: <BACE670C-6A65-4D86-BC5F-A7EA267C3140@amacapital.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Andy Lutomirski <luto@amacapital.net>
Cc: Christoph Hellwig <hch@lst.de>, linux-arch@vger.kernel.org, linux-api@vger.kernel.org, linux-kernel@vger.kernel.org, io-uring@vger.kernel.org
Message-ID: <20200720170219.UsdjmZaAAC5xBtWyVDDrQ7v_IuIrMAKBPeNX9OD9V8o@z>

On 7/20/20 10:58 AM, Andy Lutomirski wrote:
> 
>> On Jul 20, 2020, at 9:37 AM, Jens Axboe <axboe@kernel.dk> wrote:
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
