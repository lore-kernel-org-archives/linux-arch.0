Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from out02.mta.xmission.com ([166.70.13.232]:47877 "EHLO
        out02.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751979AbeFYB0d (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sun, 24 Jun 2018 21:26:33 -0400
From: ebiederm@xmission.com (Eric W. Biederman)
References: <20180420120605.1612248-1-arnd@arndb.de>
        <20180420120605.1612248-2-arnd@arndb.de>
        <20180621154915.GA31947@gmail.com>
        <CAK8P3a1QYTfRNQt2+a29BpvgYM_pnSFrO=NBvVo=BdUa2q9ngQ@mail.gmail.com>
        <20180621161121.GB7222@gmail.com>
        <CAK8P3a1mx16S+DhEMQA6WBJ7efdhN5YaKKVHU6n+E6kfifM-Qg@mail.gmail.com>
        <20180622021636.GA11266@gmail.com> <87a7rm3eb5.fsf@xmission.com>
        <20180624071258.GB29407@gmail.com>
Date: Sun, 24 Jun 2018 20:26:08 -0500
In-Reply-To: <20180624071258.GB29407@gmail.com> (Ingo Molnar's message of
        "Sun, 24 Jun 2018 09:12:58 +0200")
Message-ID: <87y3f31wsv.fsf@xmission.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [PATCH v2 2/2] rusage: allow 64-bit times ru_utime/ru_stime
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Ingo Molnar <mingo@kernel.org>
Cc: Arnd Bergmann <arnd@arndb.de>, y2038 Mailman List <y2038@lists.linaro.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, the arch/x86 maintainers <x86@kernel.org>, Linux API <linux-api@vger.kernel.org>, linux-arch <linux-arch@vger.kernel.org>, Paul Eggert <eggert@cs.ucla.edu>, Richard Henderson <rth@twiddle.net>, Ivan Kokshaysky <ink@jurassic.park.msu.ru>, Matt Turner <mattst88@gmail.com>, Al Viro <viro@zeniv.linux.org.uk>, Dominik Brodowski <linux@dominikbrodowski.net>, Thomas Gleixner <tglx@linutronix.de>, Andrew Morton <akpm@linux-foundation.org>, linux-alpha@vger.kernel.org, Deepa Dinamani <deepa.kernel@gmail.com>
Message-ID: <20180625012608.CPfbLM37lgoBoo54GSaHocVM6DSqPXB3mkNDKE9Iz2I@z>

Ingo Molnar <mingo@kernel.org> writes:

> * Eric W. Biederman <ebiederm@xmission.com> wrote:
>
>> The trouble with attributes is that means you can't filter your system
>> call arguments with seccomp. [...]
>
> There's nothing keeping seccomp from securely fetching those arguments and 
> extending filtering to them as well ...
>
> Allowing that would make sense for a lot of other system calls as
> well.

Possibly.  The challenge is that if the fetch for the kernel to use
those arguments is different from the fetch of seccomp to test those
arguments you have a time of test vs time of use race.

Given the location of the seccomp hook at the kernel user space border
there is no easy way for seccomp to share the fetch with the system
call itself.

So I don't see how seccomp could perform the fetch securely.

Eric
