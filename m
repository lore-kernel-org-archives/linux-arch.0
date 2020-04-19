From: Jens Axboe <axboe@kernel.dk>
Subject: Re: [PATCH v4 2/3] fs: openat2: Extend open_how to allow
 userspace-selected fds
Date: Sun, 19 Apr 2020 16:22:52 -0600
Message-ID: <b7dae79b-4c5f-65f6-0960-617070357201@kernel.dk>
References: <cover.1586830316.git.josh@joshtriplett.org>
 <f969e7d45a8e83efc1ca13d675efd8775f13f376.1586830316.git.josh@joshtriplett.org>
 <20200419104404.j4e5gxdn2duvmu6s@yavin.dot.cyphar.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725848AbgDSWW4 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>);
        Sun, 19 Apr 2020 18:22:56 -0400
Received: from mail-pl1-x641.google.com (mail-pl1-x641.google.com [IPv6:2607:f8b0:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65ECAC061A0C
        for <linux-arch@vger.kernel.org>; Sun, 19 Apr 2020 15:22:56 -0700 (PDT)
Received: by mail-pl1-x641.google.com with SMTP id d24so3211261pll.8
        for <linux-arch@vger.kernel.org>; Sun, 19 Apr 2020 15:22:56 -0700 (PDT)
In-Reply-To: <20200419104404.j4e5gxdn2duvmu6s@yavin.dot.cyphar.com>
Content-Language: en-US
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Aleksa Sarai <cyphar@cyphar.com>, Josh Triplett <josh@joshtriplett.org>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, io-uring@vger.kernel.org, linux-arch@vger.kernel.org, Alexander Viro <viro@zeniv.linux.org.uk>, Arnd Bergmann <arnd@arndb.de>

On 4/19/20 4:44 AM, Aleksa Sarai wrote:
> On 2020-04-13, Josh Triplett <josh@joshtriplett.org> wrote:
>> Inspired by the X protocol's handling of XIDs, allow userspace to select
>> the file descriptor opened by openat2, so that it can use the resulting
>> file descriptor in subsequent system calls without waiting for the
>> response to openat2.
>>
>> In io_uring, this allows sequences like openat2/read/close without
>> waiting for the openat2 to complete. Multiple such sequences can
>> overlap, as long as each uses a distinct file descriptor.
> 
> I'm not sure I understand this explanation -- how can you trigger a
> syscall with an fd that hasn't yet been registered (unless you're just
> hoping the race goes in your favour)?

io_uring can do chains of requests, where each link in the chain isn't
started until the previous one has completed. Hence if you know what fd
that openat2 will return, you can submit a chain ala:

<open file X, give me fd Y><read from fd Y><close fd Y>

as a single submission. This isn't possible to do currently, as the read
will depend on the output of the open, and we have no good way of
knowing what that fd will be.

-- 
Jens Axboe
