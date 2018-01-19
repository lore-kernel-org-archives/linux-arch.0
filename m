From: ebiederm@xmission.com (Eric W. Biederman)
Subject: Re: [PATCH 22/22] signal: Unify and correct copy_siginfo_to_user32
Date: Fri, 19 Jan 2018 15:04:15 -0600
Message-ID: <87shb1a7cg.fsf@xmission.com>
References: <87k1wimybi.fsf_-_@xmission.com>
        <20180116004009.31036-22-ebiederm@xmission.com>
        <20180119180322.GK13338@ZenIV.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from out02.mta.xmission.com ([166.70.13.232]:36821 "EHLO
        out02.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756525AbeASVFK (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 19 Jan 2018 16:05:10 -0500
In-Reply-To: <20180119180322.GK13338@ZenIV.linux.org.uk> (Al Viro's message of
        "Fri, 19 Jan 2018 18:03:22 +0000")
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Al Viro <viro@ZenIV.linux.org.uk>
Cc: linux-kernel@vger.kernel.org, Oleg Nesterov <oleg@redhat.com>, linux-arch@vger.kernel.org

Al Viro <viro@ZenIV.linux.org.uk> writes:

> On Mon, Jan 15, 2018 at 06:40:09PM -0600, Eric W. Biederman wrote:
>> Among the existing architecture specific versions of
>> copy_siginfo_to_user32 there are several different implementation
>> problems.  Some architectures fail to handle all of the cases in in
>> the siginfo union.  Some architectures perform a blind copy of the
>> siginfo union when the si_code is negative.  A blind copy suggests the
>> data is expected to be in 32bit siginfo format, which means that
>> receiving such a signal via signalfd won't work, or that the data is
>> in 64bit siginfo and the code is copying nonsense to userspace.
>
> Huh?  Negative si_code comes from rt_sigqueueinfo(2); in that case
> the sucker is supposed to pass user-supplied opaque chunk of data
> in ->_sifields._pad.  "Copy everything when ->si_code is negative"
> is exactly the right behaviour.  Failing to copy it out (and in, for
> copy_siginfo_from_user32()) is a bug.
>
> 32bit tasks should behave on 64bit host like they would on 32bit one
> when we have biarch compat.  And "application using sigqueueinfo() to
> pass data might be using different layouts of the payload" is not
> an excuse for failing to transmit it in the first place.

If glibc actually offered rt_sigqueueinfo or any function that would
queue a full siginfo that would be a compelling argument.

As it is the only users of rt_sigqueueinfo that I am aware of
is CRIU and the implementation of sigqueue.

A couple of months ago I went hunting for users and for anyone who was
defining si_codes and I did not find a single instance of anything
defining signals that would pass more information than is known to
the kernel, and except for CRIU all I found was limited to what
you can do with sigqueue.

So no I do not think my choice will cause a regression.

Further SI_TIMER which the kernel does send is also negative.  The
difference between negative and positive is that negative si_codes
are supposed to be signal agnostic and positive si_codes are signal
specific.

If this causes a single regression, or if anyone can point me at the
code of an application this will cause a regression for.  I will
change the code right then and there.

My concern is that people have not been careful when defining new
signals.  What looks like rules in one place are not the rules in
another place.  If we had been careful struct siginfo would be the same
on both 32bit and 64bit, and in singalfd.  As it is I am battling
accidental redefinitions of SI_USER by the kernel to be something else.

I think it is far more likley that someone will define a signal layout
that needs help going from 64bit to 32bit that my choice not copying all
of the bits will catch, rather than I will break some existing userspace
application.  And if we catch it and the siginfo needs translation
because we are not commited to copying everything we can fix it.

Which is a long way of saying I think it would be gravely irresponsible
to just copy all of the bits of struct siginfo when si_code is negative.

Eric
