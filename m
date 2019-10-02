Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from out01.mta.xmission.com ([166.70.13.231]:54494 "EHLO
        out01.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726411AbfJBOua (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 2 Oct 2019 10:50:30 -0400
From: ebiederm@xmission.com (Eric W. Biederman)
References: <8736gcjosv.fsf@x220.int.ebiederm.org>
        <201910011140.EA0181F13@keescook>
        <87imp8hyc8.fsf@x220.int.ebiederm.org>
        <CAK8P3a1zLATC7rzYxSpAK-z=NJ1rw7-3ZgHqCOJUUf6b9HwK1A@mail.gmail.com>
Date: Wed, 02 Oct 2019 09:49:48 -0500
In-Reply-To: <CAK8P3a1zLATC7rzYxSpAK-z=NJ1rw7-3ZgHqCOJUUf6b9HwK1A@mail.gmail.com>
        (Arnd Bergmann's message of "Wed, 2 Oct 2019 09:31:01 +0200")
Message-ID: <87v9t7gq2b.fsf@x220.int.ebiederm.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [RFC][PATCH] sysctl: Remove the sysctl system call
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Arnd Bergmann <arnd@arndb.de>
Cc: Kees Cook <keescook@chromium.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, linux-arch <linux-arch@vger.kernel.org>, Linux API <linux-api@vger.kernel.org>, Linus Torvalds <torvalds@linux-foundation.org>, Andi Kleen <andi@firstfloor.org>, Andi Kleen <ak@linux.intel.com>, Cong Wang <xiyou.wangcong@gmail.com>, Luis Chamberlain <mcgrof@kernel.org>, Apelete Seketeli <apelete@seketeli.net>, Chee Nouk Phoon <cnphoon@altera.com>, Chris Zankel <chris@zankel.net>, Christian Ruppert <christian.ruppert@abilis.com>, Greg Ungerer <gerg@uclinux.org>, Helge Deller <deller@gmx.de>, Hongliang Tao <taohl@lemote.com>, Huacai Chen <chenhc@lemote.com>, Jonas Jensen <jonas.jensen@gmail.com>, Josh Boyer <jwboyer@gmail.com>, Jun Nie <jun.nie@linaro.org>, Lars-Peter Clausen <lars@metafoo.de>, Ley Foon Tan <lftan@altera.com>, Linus Walleij <linus.walleij@linaro.org>, Max Filippov <jcmvbkbc@gmail.com>, Olof Johansson <olof@lixom.net>, Paul Burton <paul.burton@mips.com>, Phil Edworthy <phil.edworthy@renesas.com>, Pierrick Hascoet <pierrick.hascoet@abilis.com>, Ralf Baechle <ralf@linux-mips.org>, Roland Stigge <stigge@antcom.de>, Vineet Gupta <vgupta@synopsys.com>
Message-ID: <20191002144948.P8gQjPwP4idKiV_jj9tySmyEVK1HM4YANl57FqFvmNM@z>

Arnd Bergmann <arnd@arndb.de> writes:

> On Wed, Oct 2, 2019 at 12:54 AM Eric W. Biederman <ebiederm@xmission.com> wrote:

>> arch/arm/configs/lpc32xx_defconfig:CONFIG_SYSCTL_SYSCALL=y
>> arch/arm/configs/moxart_defconfig:CONFIG_SYSCTL_SYSCALL=y
>
> Ancient hardware, but still in active use. These tend to have very little
> RAM, but they both enable CONFIG_PROC_FS.

You actually have to enable CONFIG_PROC_FS to enable
CONFIG_SYSCTL_SYSCALL at this point.  CONFIG_SYSCTL_SYSCALL is just an
emulation of the old interface built on top of /proc.

Thank you for the feedback.

Eric
