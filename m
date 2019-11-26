Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-pl1-f194.google.com ([209.85.214.194]:40274 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726033AbfKZT1k (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 26 Nov 2019 14:27:40 -0500
Received: by mail-pl1-f194.google.com with SMTP id g6so219181plp.7
        for <linux-arch@vger.kernel.org>; Tue, 26 Nov 2019 11:27:39 -0800 (PST)
MIME-Version: 1.0
References: <8736eaxxdg.fsf@x220.int.ebiederm.org>
In-Reply-To: <8736eaxxdg.fsf@x220.int.ebiederm.org>
From: Max Filippov <jcmvbkbc@gmail.com>
Date: Tue, 26 Nov 2019 11:27:29 -0800
Message-ID: <CAMo8BfK-Ua70sZe8JBHz3KK7+WjP1MvBa=jTK=-HrOHuAuDnHg@mail.gmail.com>
Subject: Re: new uses of SYSCTL_SYSCALL
Content-Type: text/plain; charset="UTF-8"
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: Linux-Arch <linux-arch@vger.kernel.org>, "open list:TENSILICA XTENSA PORT (xtensa)" <linux-xtensa@linux-xtensa.org>

Hi Eric,

On Tue, Nov 26, 2019 at 11:15 AM Eric W. Biederman
<ebiederm@xmission.com> wrote:
> Doing a test merge against linux-next I see that in the
> tree git://github.com/jcmvbkbc/linux-xtensa.git#xtensa-for-next
> a new defconfig is added:
>
> arch/xtensa/configs/xip_kc705_defconfig
>
> That defconfig adds CONFIG_SYSCTL_SYSCALL.
>
> Is xtensa actually using this system call?  So far I have not seen any
> other users and I am serously proposing to remove it.

I'm sure that this config symbol was inherited from some other config
that I used as a base for the xip_kc705_defconfig. I didn't enable it
intentionally. I'll drop it from the config and fix up the patch that
introduced it.

-- 
Thanks.
-- Max
