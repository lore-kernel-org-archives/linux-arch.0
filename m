Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-it1-f196.google.com ([209.85.166.196]:40540 "EHLO
        mail-it1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727448AbeKFLwG (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 6 Nov 2018 06:52:06 -0500
Received: by mail-it1-f196.google.com with SMTP id e11so12418416itl.5
        for <linux-arch@vger.kernel.org>; Mon, 05 Nov 2018 18:29:16 -0800 (PST)
MIME-Version: 1.0
References: <1541080581-4072-1-git-send-email-firoz.khan@linaro.org>
 <1541080581-4072-2-git-send-email-firoz.khan@linaro.org> <CAMo8BfK1AYn7LyF0ssAyFRGBJmCJEH6jP4+05RXR0n6+-udtDw@mail.gmail.com>
In-Reply-To: <CAMo8BfK1AYn7LyF0ssAyFRGBJmCJEH6jP4+05RXR0n6+-udtDw@mail.gmail.com>
From: Firoz Khan <firoz.khan@linaro.org>
Date: Tue, 6 Nov 2018 07:59:04 +0530
Message-ID: <CALxhOni=HJ=88Hw3EqG9ayuEp4xTE0HfeEj3jgF8hrFBXLh3hQ@mail.gmail.com>
Subject: Re: [PATCH v1 1/4] xtensa: move SYS_XTENSA_* macros to non uapi header
Content-Type: text/plain; charset="UTF-8"
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Max Filippov <jcmvbkbc@gmail.com>
Cc: Chris Zankel <chris@zankel.net>, linux-xtensa@linux-xtensa.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Philippe Ombredanne <pombredanne@nexb.com>, Thomas Gleixner <tglx@linutronix.de>, Kate Stewart <kstewart@linuxfoundation.org>, y2038 Mailman List <y2038@lists.linaro.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux-Arch <linux-arch@vger.kernel.org>, Arnd Bergmann <arnd@arndb.de>, Deepa Dinamani <deepa.kernel@gmail.com>, Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>
Message-ID: <20181106022904.DiNd223C-j96Jy-l7bFrn6UWOzaFNIdLE_71uqJPgRo@z>

Hi Max,

On Tue, 6 Nov 2018 at 02:59, Max Filippov <jcmvbkbc@gmail.com> wrote:
>
> On Thu, Nov 1, 2018 at 6:56 AM Firoz Khan <firoz.khan@linaro.org> wrote:
> > All the SYS_XTENSA_* macros used by sysxtensa syscall
> > handlers are resides in the uapi header file move to
> > non uapi header asm/unistd.h as it is not used by any
> > user space applications.
>
> These definitions are meant to be used by the userspace to
> perform atomic operations in the absence of atomic access
> instructions in the xtensa CPU variant.

Ohh. I can revert these changes.
Thanks for your feedback.

Firoz

>
> --
> Thanks.
> -- Max
