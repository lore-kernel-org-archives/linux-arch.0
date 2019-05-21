Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:36728 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726900AbfEUNKs (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Tue, 21 May 2019 09:10:48 -0400
From: Florian Weimer <fweimer@redhat.com>
Subject: Re: [PATCH 1/2] open: add close_range()
References: <20190521113448.20654-1-christian@brauner.io>
        <87tvdoau12.fsf@oldenburg2.str.redhat.com>
        <20190521130438.q3u4wvve7p6md6cm@brauner.io>
Date: Tue, 21 May 2019 15:10:11 +0200
In-Reply-To: <20190521130438.q3u4wvve7p6md6cm@brauner.io> (Christian Brauner's
        message of "Tue, 21 May 2019 15:04:39 +0200")
Message-ID: <87h89o9cng.fsf@oldenburg2.str.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Christian Brauner <christian@brauner.io>
Cc: viro@zeniv.linux.org.uk, linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-api@vger.kernel.org, jannh@google.com, oleg@redhat.com, tglx@linutronix.de, torvalds@linux-foundation.org, arnd@arndb.de, shuah@kernel.org, dhowells@redhat.com, tkjos@android.com, ldv@altlinux.org, miklos@szeredi.hu, linux-alpha@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-ia64@vger.kernel.org, linux-m68k@lists.linux-m68k.org, linux-mips@vger.kernel.org, linux-parisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org, linux-sh@vger.kernel.org, sparclinux@vger.kernel.org, linux-xtensa@linux-xtensa.org, linux-arch@vger.kernel.org, linux-kselftest@vger.kernel.org, x86@kernel.org
Message-ID: <20190521131011.C3ypZuui0ld6CVj1WxVvEJ5Or7h1PVe5kA8aQv2Q6v8@z>

* Christian Brauner:

>> Solaris has an fdwalk function:
>> 
>>   <https://docs.oracle.com/cd/E88353_01/html/E37843/closefrom-3c.html>
>> 
>> So a different way to implement this would expose a nextfd system call
>
> Meh. If nextfd() then I would like it to be able to:
> - get the nextfd(fd) >= fd
> - get highest open fd e.g. nextfd(-1)

The highest open descriptor isn't istering for fdwalk because nextfd
would just fail.

> But then I wonder if nextfd() needs to be a syscall and isn't just
> either:
> fcntl(fd, F_GET_NEXT)?
> or
> prctl(PR_GET_NEXT)?

I think the fcntl route is a bit iffy because you might need it to get
the *first* valid descriptor.

>> to userspace, so that we can use that to implement both fdwalk and
>> closefrom.  But maybe fdwalk is just too obscure, given the existence of
>> /proc.
>
> Yeah we probably don't need fdwalk.

Agreed.  Just wanted to bring it up for completeness.  I certainly don't
want to derail the implementation of close_range.

Thanks,
Florian
