Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-lf0-f65.google.com ([209.85.215.65]:40687 "EHLO
        mail-lf0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933399AbeFUQZg (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 21 Jun 2018 12:25:36 -0400
MIME-Version: 1.0
In-Reply-To: <20180621161121.GB7222@gmail.com>
References: <20180420120605.1612248-1-arnd@arndb.de> <20180420120605.1612248-2-arnd@arndb.de>
 <20180621154915.GA31947@gmail.com> <CAK8P3a1QYTfRNQt2+a29BpvgYM_pnSFrO=NBvVo=BdUa2q9ngQ@mail.gmail.com>
 <20180621161121.GB7222@gmail.com>
From: Arnd Bergmann <arnd@arndb.de>
Date: Thu, 21 Jun 2018 18:25:33 +0200
Message-ID: <CAK8P3a1mx16S+DhEMQA6WBJ7efdhN5YaKKVHU6n+E6kfifM-Qg@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] rusage: allow 64-bit times ru_utime/ru_stime
Content-Type: text/plain; charset="UTF-8"
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Ingo Molnar <mingo@kernel.org>
Cc: y2038 Mailman List <y2038@lists.linaro.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, the arch/x86 maintainers <x86@kernel.org>, Linux API <linux-api@vger.kernel.org>, linux-arch <linux-arch@vger.kernel.org>, Paul Eggert <eggert@cs.ucla.edu>, "Eric W . Biederman" <ebiederm@xmission.com>, Richard Henderson <rth@twiddle.net>, Ivan Kokshaysky <ink@jurassic.park.msu.ru>, Matt Turner <mattst88@gmail.com>, Al Viro <viro@zeniv.linux.org.uk>, Dominik Brodowski <linux@dominikbrodowski.net>, Thomas Gleixner <tglx@linutronix.de>, Andrew Morton <akpm@linux-foundation.org>, linux-alpha@vger.kernel.org, Deepa Dinamani <deepa.kernel@gmail.com>
Message-ID: <20180621162533.uSGRlr5C9h6NOdEoirQRsV7Y7O24HnkVrLIWQRxQ8KQ@z>

On Thu, Jun 21, 2018 at 6:11 PM, Ingo Molnar <mingo@kernel.org> wrote:
>
> * Arnd Bergmann <arnd@arndb.de> wrote:
>
>> Sure, no problem. Do you have an opinion on the question I raised in the
>> first patch [1], i.e. whether we actually want this to be done this way in the
>> kernel, or one of the other approaches I described there?
>
> So this looks like the most forward looking variant:
>
>> a) deprecate the wait4() and getrusage() system calls, and create
>>    a set of kernel interfaces based around a newly defined structure that
>>    could solve multiple problems at once, e.g. provide more fine-grained
>>    timestamps. The C library could then implement the posix interfaces
>>    on top of the new system calls.
>
> ... but given the pretty long propagation time of new ABIs, is this a good
> solution? What would the limitations/trade-offs be on old-ABI systems?

The main purpose of this is to enable consistent 64-bit time_t interfaces in
user space, and for most users this would not change anything as the
existing glibc (both 64-bit and 32-bit) can continue calling the same
interfaces as before.

For those users that are interested in 64-bit time_t on 32-bit binaries,
the first step would be to change the glibc implementation to emulate
the existing interfaces with the new time_t on top of the new syscall
rather than the old (unsafe) syscall. Those users already require both
a new kernel and a new glibc version.

If the new kernel interfaces offer a real benefit, others could start
using them directly as soon as they have updated the libc version.
Note that glibc has not updated their kernel headers version for
a long time, they still allow building with linux-3.2 header files.
However, the glibc maintainers have indicated that they would
probably update that requirement to the then-latest version
when adding support to the new 64-bit time_t syscalls, so this
would become available immediately to all users of the new glibc
version.

However, the other question that has to be asked then is whether
there is anything wrong with wait4()/waitid() and getrusuage() that
we want to change beyond the time value passing. We have
answered a similar question with 'yes' for stat(), which has led
to the introduction of statx(), but so far I expect all other syscalls
to start compatible. See [1] for my current list. In that list, I have
currently marked waitid() and getrusuage() as not to be addressed,
i.e. my approach c) of applying only the first of the two patches but
not the second.

       Arnd

[1] https://docs.google.com/spreadsheets/d/1HCYwHXxs48TsTb6IGUduNjQnmfRvMPzCN6T_0YiQwis/edit#gid=0
