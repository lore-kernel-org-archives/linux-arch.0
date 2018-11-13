Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-yb1-f193.google.com ([209.85.219.193]:43626 "EHLO
        mail-yb1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726408AbeKNJyA (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 14 Nov 2018 04:54:00 -0500
MIME-Version: 1.0
References: <1542104370-22831-1-git-send-email-firoz.khan@linaro.org>
In-Reply-To: <1542104370-22831-1-git-send-email-firoz.khan@linaro.org>
From: Max Filippov <jcmvbkbc@gmail.com>
Date: Tue, 13 Nov 2018 15:53:09 -0800
Message-ID: <CAMo8BfLt0NuQOTP6MBbRdOpK0_fWwtvfZArwVhwW1SZyzH4mbQ@mail.gmail.com>
Subject: Re: [PATCH v2 0/3] xtensa: system call table generation support
Content-Type: text/plain; charset="UTF-8"
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Firoz Khan <firoz.khan@linaro.org>
Cc: Chris Zankel <chris@zankel.net>, linux-xtensa@linux-xtensa.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Philippe Ombredanne <pombredanne@nexb.com>, Thomas Gleixner <tglx@linutronix.de>, Kate Stewart <kstewart@linuxfoundation.org>, y2038@lists.linaro.org, LKML <linux-kernel@vger.kernel.org>, Linux-Arch <linux-arch@vger.kernel.org>, Arnd Bergmann <arnd@arndb.de>, Deepa Dinamani <deepa.kernel@gmail.com>, marcin.juszkiewicz@linaro.org
Message-ID: <20181113235309.fEa9JmANBTjRhA5LkYkfRWGikq1bpfqePj6-ozNsqwc@z>

Hi Firoz,

On Tue, Nov 13, 2018 at 2:19 AM Firoz Khan <firoz.khan@linaro.org> wrote:
[...]
> Firoz Khan (3):
>   xtensa: add __NR_syscalls along with __NR_syscall_count
>   xtensa: add system call table generation support
>   xtensa: generate uapi header and syscall table header files

What's your plan for submission of this series? Are you going to
submit it with other similar series in a common tree, or shall I take
it into the xtensa tree?

-- 
Thanks.
-- Max
