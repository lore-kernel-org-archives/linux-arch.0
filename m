Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from b.ns.miles-group.at ([95.130.255.144]:1660 "EHLO radon.swed.at"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1754757AbaDXKIF (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Thu, 24 Apr 2014 06:08:05 -0400
Message-ID: <5358E27F.2000206@nod.at>
Date: Thu, 24 Apr 2014 12:07:59 +0200
From: Richard Weinberger <richard@nod.at>
MIME-Version: 1.0
Subject: Re: [PATCH 17/28] nios2: Signal handling support
References: <1397824031-4892-1-git-send-email-lftan@altera.com>	<1397824031-4892-14-git-send-email-lftan@altera.com>	<CAFLxGvyPCwo-d92QK9qAR5=gmRS4p24tYs9PiOApBGfrKdxJ5Q@mail.gmail.com> <CAFiDJ5-q5hzR+1BDCmCzwqbuVZOUdjX_-omR4u3rnC8xqdQZLA@mail.gmail.com>
In-Reply-To: <CAFiDJ5-q5hzR+1BDCmCzwqbuVZOUdjX_-omR4u3rnC8xqdQZLA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Ley Foon Tan <lftan@altera.com>
Cc: Linux-Arch <linux-arch@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>, cltang@codesourcery.com
Message-ID: <20140424100759.Ffg4FAm4_zKm6izmffsXyG42tIEOIvqCIyX2h1ux_SQ@z>

Am 24.04.2014 12:01, schrieb Ley Foon Tan:
> On Sun, Apr 20, 2014 at 3:29 AM, Richard Weinberger
 >>> +
>>> +       push_cache((unsigned long) &frame->retcode);
>>> +
>>> +       /* Set up registers for signal handler */
>>> +       regs->sp = (unsigned long) frame;
>>> +       regs->r4 = (unsigned long) (current_thread_info()->exec_domain
>>> +                       && current_thread_info()->exec_domain->signal_invmap
>>> +                       && sig < 32
>>> +                       ? current_thread_info()->exec_domain->signal_invmap[sig]
>>> +                       : sig);
>>
>> Does nios2 really need signal translation and supports execution domains?
> Nios2 have one default "default_exec_domain" only. So, we can change
> this to "regs->r4 = sig;".

Nice.

> BTW, most of the architectures have similar code.

Yep, because everyone is copy&pasting from each others without thinking. 8)
There is already a cleanup going on: https://lkml.org/lkml/2014/3/2/198

Thanks,
//richard
