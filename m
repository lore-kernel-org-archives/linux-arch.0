Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-lj1-f196.google.com ([209.85.208.196]:42828 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755221AbeFYLmX (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 25 Jun 2018 07:42:23 -0400
MIME-Version: 1.0
In-Reply-To: <87a7rm3eb5.fsf@xmission.com>
References: <20180420120605.1612248-1-arnd@arndb.de> <20180420120605.1612248-2-arnd@arndb.de>
 <20180621154915.GA31947@gmail.com> <CAK8P3a1QYTfRNQt2+a29BpvgYM_pnSFrO=NBvVo=BdUa2q9ngQ@mail.gmail.com>
 <20180621161121.GB7222@gmail.com> <CAK8P3a1mx16S+DhEMQA6WBJ7efdhN5YaKKVHU6n+E6kfifM-Qg@mail.gmail.com>
 <20180622021636.GA11266@gmail.com> <87a7rm3eb5.fsf@xmission.com>
From: Arnd Bergmann <arnd@arndb.de>
Date: Mon, 25 Jun 2018 13:42:19 +0200
Message-ID: <CAK8P3a0G-MHA=buSL3Ymp3=-+=qgJWw1N3NtPQNr9wmpXV2cmA@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] rusage: allow 64-bit times ru_utime/ru_stime
Content-Type: text/plain; charset="UTF-8"
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: Ingo Molnar <mingo@kernel.org>, y2038 Mailman List <y2038@lists.linaro.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, the arch/x86 maintainers <x86@kernel.org>, Linux API <linux-api@vger.kernel.org>, linux-arch <linux-arch@vger.kernel.org>, Paul Eggert <eggert@cs.ucla.edu>, Richard Henderson <rth@twiddle.net>, Ivan Kokshaysky <ink@jurassic.park.msu.ru>, Matt Turner <mattst88@gmail.com>, Al Viro <viro@zeniv.linux.org.uk>, Dominik Brodowski <linux@dominikbrodowski.net>, Thomas Gleixner <tglx@linutronix.de>, Andrew Morton <akpm@linux-foundation.org>, linux-alpha@vger.kernel.org, Deepa Dinamani <deepa.kernel@gmail.com>
Message-ID: <20180625114219.60fKPjM_RVhCgWyv6Yophm8w2yC4RTpla3CU9DZ2hmw@z>

On Fri, Jun 22, 2018 at 7:45 PM, Eric W. Biederman
<ebiederm@xmission.com> wrote:
> Ingo Molnar <mingo@kernel.org> writes:
>
> So I suspect the simplest thing to do would be to set a flag in the
> idtype member of waitid that says give me rusage64 and then we would
> be done.

It would have to be a flag in both the 'idtype' field of waitid(), and also
'who' field of getrusage(), which unfortunately uses a separate set of
flags. Not hard to do, but still a bit more complexity.

> Alternately we could use the low bits of the resource usage
> pointer.  Assuming we don't want to introduce another syscall that is.
> I really don't see much incremental extensibility potential in the wait
> or rusage interface right now.

This is also my conclusion after looking at how various other
operating systems implement getrusage() and wait4() today.
It seems that this is one of the most stable APIs, everyone uses
exactly the same structure layout (Linux/x32 being one exception,
they have the 64-bit Linux compatible layout using __s64 instead of
long members).

For the other ~20 system calls we introduce for y2038, the general
idea has been to stay mostly compatible with the source level interface,
just using a new syscall number. statx() is a notable exception here,
with clock_adjtime() and getitimer()/setitimer() still being undecided.

If we don't do an extensible layout or any other new fields, there
are still the open questions about whether any types should change:

- changing everything to 64-bit would allow sharing the kernel
  code between compat and native
- changing only __old_kernel_timeval to new 64-bit timeval would
  be the simplest user space change (only the syscall number
  changes with sizeof(time_t)), avoiding an extra copy thorough
  the user space stack.
- changing timeval to (64-bit) timespec would seem the most
  sensible update, since it avoids the silly nanosecond-to-
  microsecond conversion in the kernel (glibc would still need
  to do it for compatibility). This is what I'm considering for
  getitimer/setitimer,  too.

         Arnd
