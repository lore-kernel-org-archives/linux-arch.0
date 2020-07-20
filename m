Return-Path: <SRS0=C7+S=A7=vger.kernel.org=linux-arch-owner@kernel.org>
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732980AbgGTQgn (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 20 Jul 2020 12:36:43 -0400
Received: from mail-il1-x129.google.com (mail-il1-x129.google.com [IPv6:2607:f8b0:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07C49C061794
        for <linux-arch@vger.kernel.org>; Mon, 20 Jul 2020 09:36:43 -0700 (PDT)
Received: by mail-il1-x129.google.com with SMTP id x9so13854528ila.3
        for <linux-arch@vger.kernel.org>; Mon, 20 Jul 2020 09:36:42 -0700 (PDT)
Subject: Re: io_uring vs in_compat_syscall()
References: <20200720061046.GA10678@lst.de>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <ceb21006-26d0-b216-84a9-5da0b89b5fbf@kernel.dk>
Date: Mon, 20 Jul 2020 10:36:40 -0600
MIME-Version: 1.0
In-Reply-To: <20200720061046.GA10678@lst.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: linux-arch@vger.kernel.org, linux-api@vger.kernel.org, linux-kernel@vger.kernel.org, io-uring@vger.kernel.org
Message-ID: <20200720163640.aSn5_vTO62lYpmtpgx6QyTWVXcqEcINUbbILnvlcak0@z>

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
