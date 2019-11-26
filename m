Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from out01.mta.xmission.com ([166.70.13.231]:36776 "EHLO
        out01.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725970AbfKZUG0 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 26 Nov 2019 15:06:26 -0500
From: ebiederm@xmission.com (Eric W. Biederman)
References: <8736eaxxdg.fsf@x220.int.ebiederm.org>
        <CAMo8BfK-Ua70sZe8JBHz3KK7+WjP1MvBa=jTK=-HrOHuAuDnHg@mail.gmail.com>
Date: Tue, 26 Nov 2019 14:05:50 -0600
In-Reply-To: <CAMo8BfK-Ua70sZe8JBHz3KK7+WjP1MvBa=jTK=-HrOHuAuDnHg@mail.gmail.com>
        (Max Filippov's message of "Tue, 26 Nov 2019 11:27:29 -0800")
Message-ID: <87v9r6wggx.fsf@x220.int.ebiederm.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: new uses of SYSCTL_SYSCALL
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Max Filippov <jcmvbkbc@gmail.com>
Cc: Linux-Arch <linux-arch@vger.kernel.org>, "open list:TENSILICA XTENSA PORT (xtensa)" <linux-xtensa@linux-xtensa.org>

Max Filippov <jcmvbkbc@gmail.com> writes:

> Hi Eric,
>
> On Tue, Nov 26, 2019 at 11:15 AM Eric W. Biederman
> <ebiederm@xmission.com> wrote:
>> Doing a test merge against linux-next I see that in the
>> tree git://github.com/jcmvbkbc/linux-xtensa.git#xtensa-for-next
>> a new defconfig is added:
>>
>> arch/xtensa/configs/xip_kc705_defconfig
>>
>> That defconfig adds CONFIG_SYSCTL_SYSCALL.
>>
>> Is xtensa actually using this system call?  So far I have not seen any
>> other users and I am serously proposing to remove it.
>
> I'm sure that this config symbol was inherited from some other config
> that I used as a base for the xip_kc705_defconfig. I didn't enable it
> intentionally. I'll drop it from the config and fix up the patch that
> introduced it.

Thank you for confirming that.

I would recommend an incremental commit/patch on top to change just this
one thing so you don't rebase just before you send a pull request and
cause Linus's to wonder if you have tested the code at all.

Eric
