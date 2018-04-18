Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from out01.mta.xmission.com ([166.70.13.231]:54250 "EHLO
        out01.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750872AbeDRR7r (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 18 Apr 2018 13:59:47 -0400
From: ebiederm@xmission.com (Eric W. Biederman)
References: <CA+55aFxdg2bYHtbKXb4mT5UuP2GH_qjkc=WeZY-RYHWZFQ2Gng@mail.gmail.com>
        <20180412172051.GK16141@n2100.armlinux.org.uk>
        <CA+55aFwjZqd8J0=veki1g+quQg8amEG4NnMe-h7HFksn=F=x_Q@mail.gmail.com>
        <20180413094211.GN16141@n2100.armlinux.org.uk>
        <CA+55aFwoThxqUeAZSsMhf--ODyhGkmOENH5R6=4+CuaopFx9eA@mail.gmail.com>
        <20180413170827.GB16308@e103592.cambridge.arm.com>
        <20180413175407.GO16141@n2100.armlinux.org.uk>
        <CA+55aFyya6B9_aq8ZSrZT-S-BGbpbDgFvDff5z8upDirpcoiHA@mail.gmail.com>
        <20180413184522.GD16308@e103592.cambridge.arm.com>
        <CA+55aFwMUQbALx60b3JDrTcWVSBS7imS+zCYEMz8NOs=6rE6+A@mail.gmail.com>
        <20180415131206.GR16141@n2100.armlinux.org.uk>
        <87604sa2fu.fsf_-_@xmission.com>
        <CA+55aFw1gmfFH1o+oWMo4TnU5hEczAOiY1g=eMxqYZmy9JqDYw@mail.gmail.com>
Date: Wed, 18 Apr 2018 12:58:21 -0500
In-Reply-To: <CA+55aFw1gmfFH1o+oWMo4TnU5hEczAOiY1g=eMxqYZmy9JqDYw@mail.gmail.com>
        (Linus Torvalds's message of "Sun, 15 Apr 2018 11:16:04 -0700")
Message-ID: <87a7u0tn0i.fsf@xmission.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [RFC PATCH 0/3] Dealing with the aliases of SI_USER
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Dave Martin <Dave.Martin@arm.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, "Dmitry V. Levin" <ldv@altlinux.org>, sparclinux <sparclinux@vger.kernel.org>, ppc-dev <linuxppc-dev@lists.ozlabs.org>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, Russell King - ARM Linux <linux@armlinux.org.uk>, linux-arch <linux-arch@vger.kernel.org>
Message-ID: <20180418175821.ZiqtWP86foWPYSrq7-LFwtx9pbkAExjvNHTsx3fNKQs@z>

Linus Torvalds <torvalds@linux-foundation.org> writes:

> (
>
> On Sun, Apr 15, 2018 at 8:56 AM, Eric W. Biederman
> <ebiederm@xmission.com> wrote:

[snip bit about wanting what is effectively force_sig_fault instead of
clear_siginfo everywhere]

> The other thing we should do is to get rid of the stupid padding.
> Right now "struct siginfo" is pointlessly padded to 128 bytes. That is
> completely insane, when it's always just zero in the kernel.
>
> So put that _pad[] thing inside #ifndef __KERNEL__, and make
> copy_siginfo_to_user() write the padding zeroes when copying to user
> space. The reason for the padding is "future expansion", so we do want
> to tell the user space that it's maybe up to 128 bytes in size, but if
> we don't fill it all, we shouldn't waste time and memory on clearing
> the padding internally.
>
> I'm certainly *hoping* nobody depends on the whole 128 bytes in
> rt_sigqueueinfo(). In theory you can fill it all (as long as si_code
> is negative), but the man-page only says "si_value", and the compat
> function doesn't copy any more than that either, so any user that
> tries to fill in more than si_value is already broken. In fact, it
> might even be worth enforcing that in rt_sigqueueinfo(), just to see
> if anybody plays any games..
