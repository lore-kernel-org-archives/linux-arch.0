From: Max Filippov <jcmvbkbc@gmail.com>
Subject: Re: [PATCH 0/2] xtensa queue 2013/10/15 for 3.12
Date: Tue, 15 Oct 2013 22:29:17 +0400
Message-ID: <CAMo8Bf+g1ALW94-9uJ332fn6c690xQVf-wYoVZZ0PzJ4aBEfOQ@mail.gmail.com>
References: <1381789363-2411-1-git-send-email-jcmvbkbc@gmail.com>
	<525D824B.4020106@zankel.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-oa0-f47.google.com ([209.85.219.47]:56541 "EHLO
	mail-oa0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754010Ab3JOS3T (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Tue, 15 Oct 2013 14:29:19 -0400
Received: by mail-oa0-f47.google.com with SMTP id i1so6054735oag.6
        for <linux-arch@vger.kernel.org>; Tue, 15 Oct 2013 11:29:18 -0700 (PDT)
In-Reply-To: <525D824B.4020106@zankel.net>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Chris Zankel <chris@zankel.net>
Cc: Marc Gauthier <marc@tensilica.com>, Baruch Siach <baruch@tkos.co.il>, "linux-xtensa@linux-xtensa.org" <linux-xtensa@linux-xtensa.org>, Linux-Arch <linux-arch@vger.kernel.org>

On Tue, Oct 15, 2013 at 9:58 PM, Chris Zankel <chris@zankel.net> wrote:
> Hi Max,
>
> Thanks for the patches. Is my assumption correct that this fixes memory
> faults while in double exception? And, instead of panic-ing, it works
> now but registers are likely wrong with ptrace?

Well, one of them fixes the fixup handler for register spilling. It is
not functional
in xtensa-2.6.29-smp and I've blindly ported it with a3/excsave
changes. If register
spilling causes an exception current fixup handler messes up registers, which
results in unrecoverable exception with very obscure trace. I don't
think the fix has
any effect on ptrace. This fix is not related to the issue with
delivering signals
generated in double exception, I haven't got chance to fix it it properly yet.

Related ML thread:
http://lists.linux-xtensa.org/pipermail/linux-xtensa/Week-of-Mon-20130909/001198.html
http://lists.linux-xtensa.org/pipermail/linux-xtensa/Week-of-Mon-20130916/001209.html

> Also, should that go in for 3.12 (rc6?) or only in 3.13?

This is for 3.12. I have another (bigger :) pile for 3.13, will send
it in a couple
of days.

> On 10/14/2013 03:22 PM, Max Filippov wrote:
>> Hi Chris,
>>
>> could you please push these two fixes to the 3.12?
>> One fixes the regression introduced by the a3/excsave conversion in 3.12-rc1,
>> and the other fixes use of nonexistent alternative signal stack by threads.
>>
>> You can pull these changes from my git tree,
>> the following changes since commit 61e6cfa80de5760bbe406f4e815b7739205754d2:
>>
>>   Linux 3.12-rc5 (2013-10-13 15:41:28 -0700)
>>
>> are available in the git repository at:
>>   git://github.com/jcmvbkbc/linux-xtensa.git xtensa-fixes-for-upstream
>>
>> Baruch Siach (1):
>>       xtensa: don't use alternate signal stack on threads
>>
>> Max Filippov (1):
>>       xtensa: fix fast_syscall_spill_registers_fixup
>>
>>  arch/xtensa/kernel/entry.S  |   49 ++++++++++++++++++++++++++----------------
>>  arch/xtensa/kernel/signal.c |    2 +-
>>  2 files changed, 31 insertions(+), 20 deletions(-)
>>

-- 
Thanks.
-- Max
