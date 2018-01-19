From: Al Viro <viro@ZenIV.linux.org.uk>
Subject: Re: [PATCH 22/22] signal: Unify and correct copy_siginfo_to_user32
Date: Fri, 19 Jan 2018 18:03:22 +0000
Message-ID: <20180119180322.GK13338@ZenIV.linux.org.uk>
References: <87k1wimybi.fsf_-_@xmission.com>
 <20180116004009.31036-22-ebiederm@xmission.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from zeniv.linux.org.uk ([195.92.253.2]:57486 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755949AbeASSDY (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 19 Jan 2018 13:03:24 -0500
Content-Disposition: inline
In-Reply-To: <20180116004009.31036-22-ebiederm@xmission.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: linux-kernel@vger.kernel.org, Oleg Nesterov <oleg@redhat.com>, linux-arch@vger.kernel.org

On Mon, Jan 15, 2018 at 06:40:09PM -0600, Eric W. Biederman wrote:
> Among the existing architecture specific versions of
> copy_siginfo_to_user32 there are several different implementation
> problems.  Some architectures fail to handle all of the cases in in
> the siginfo union.  Some architectures perform a blind copy of the
> siginfo union when the si_code is negative.  A blind copy suggests the
> data is expected to be in 32bit siginfo format, which means that
> receiving such a signal via signalfd won't work, or that the data is
> in 64bit siginfo and the code is copying nonsense to userspace.

Huh?  Negative si_code comes from rt_sigqueueinfo(2); in that case
the sucker is supposed to pass user-supplied opaque chunk of data
in ->_sifields._pad.  "Copy everything when ->si_code is negative"
is exactly the right behaviour.  Failing to copy it out (and in, for
copy_siginfo_from_user32()) is a bug.

32bit tasks should behave on 64bit host like they would on 32bit one
when we have biarch compat.  And "application using sigqueueinfo() to
pass data might be using different layouts of the payload" is not
an excuse for failing to transmit it in the first place.
