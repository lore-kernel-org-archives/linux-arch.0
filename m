From: ebiederm@xmission.com (Eric W. Biederman)
Subject: Re: [PATCH 03/11] signal/openrisc: Fix do_unaligned_access to send the proper signal
Date: Fri, 12 Jan 2018 11:37:40 -0600
Message-ID: <87fu7b2d23.fsf@xmission.com>
References: <87373b6ghs.fsf@xmission.com>
        <20180112005940.23279-3-ebiederm@xmission.com>
        <20180112132521.GF13019@lianli.shorne-pla.net>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from out03.mta.xmission.com ([166.70.13.233]:46989 "EHLO
        out03.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932859AbeALRib (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 12 Jan 2018 12:38:31 -0500
In-Reply-To: <20180112132521.GF13019@lianli.shorne-pla.net> (Stafford Horne's
        message of "Fri, 12 Jan 2018 22:25:21 +0900")
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Stafford Horne <shorne@gmail.com>
Cc: linux-kernel@vger.kernel.org, Al Viro <viro@zeniv.linux.org.uk>, Oleg Nesterov <oleg@redhat.com>, linux-arch@vger.kernel.org, stable@vger.kernel.org, Jonas Bonn <jonas@southpole.se>, Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>, Arnd Bergmann <arnd@arndb.de>, openrisc@lists.librecores.org

Stafford Horne <shorne@gmail.com> writes:

> On Thu, Jan 11, 2018 at 06:59:32PM -0600, Eric W. Biederman wrote:
>> While reviewing the signal sending on openrisc the do_unaligned_access
>> function stood out because it is obviously wrong.  A comment about an
>> si_code set above when actually si_code is never set.  Leading to a
>> random si_code being sent to userspace in the event of an unaligned
>> access.
>> 
>> Looking further SIGBUS BUS_ADRALN is the proper pair of signal and
>> si_code to send for an unaligned access. That is what other
>> architectures do and what is required by posix.
>> 
>> Given that do_unaligned_access is broken in a way that no one can be
>> relying on it on openrisc fix the code to just do the right thing.
>
> Thanks, this looks good to me.
>
> Acked-by: Stafford Horne <shorne@gmail.com>
>
> I see you have a series of related issues, so I guess you want to get them
> merged together.  Let me know if I should put this patch onto my queue
> seperately.

Yes,  I have a follow on patch that restructures the code that fills out
siginfo, and makes the it a little less error prone.  I am hoping to
merge all of it in the next merge window.  *Fingers crossed*

And having it all in one tree will facilitate that.

> Trivia: this looks to have been copied from the mm page fault handling code,
> hence the strange comment.
>
>   $ grep -r "info.si_code has been set above" arch/
>   arch/cris/mm/fault.c:           /* info.si_code has been set above */
>   arch/m32r/mm/fault.c:           /* info.si_code has been set above */
>   arch/mn10300/mm/fault.c:                /* info.si_code has been set above */
>   arch/openrisc/mm/fault.c:               /* info.si_code has been set above */
>   arch/openrisc/kernel/traps.c:           /* info.si_code has been set above */
>   arch/arc/mm/fault.c:            /* info.si_code has been set above */
>   arch/xtensa/mm/fault.c:         /* info.si_code has been set above */
>   arch/mips/mm/fault.c:           /* info.si_code has been set above */
>   arch/score/mm/fault.c:          /* info.si_code has been set above */
>   arch/frv/mm/fault.c:            /* info.si_code has been set above */
>

It looks like it.    When I look at those I can actually find the
si_code being set higher up in the code.  It looks like the si_code
value was missed when this work was done.

Eric
