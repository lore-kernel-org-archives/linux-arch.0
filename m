Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-yw1-f65.google.com ([209.85.161.65]:35313 "EHLO
        mail-yw1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387638AbeKFGuk (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 6 Nov 2018 01:50:40 -0500
MIME-Version: 1.0
References: <1541080581-4072-1-git-send-email-firoz.khan@linaro.org> <1541080581-4072-2-git-send-email-firoz.khan@linaro.org>
In-Reply-To: <1541080581-4072-2-git-send-email-firoz.khan@linaro.org>
From: Max Filippov <jcmvbkbc@gmail.com>
Date: Mon, 5 Nov 2018 13:28:48 -0800
Message-ID: <CAMo8BfK1AYn7LyF0ssAyFRGBJmCJEH6jP4+05RXR0n6+-udtDw@mail.gmail.com>
Subject: Re: [PATCH v1 1/4] xtensa: move SYS_XTENSA_* macros to non uapi header
Content-Type: text/plain; charset="UTF-8"
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: firoz.khan@linaro.org
Cc: Chris Zankel <chris@zankel.net>, linux-xtensa@linux-xtensa.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Philippe Ombredanne <pombredanne@nexb.com>, Thomas Gleixner <tglx@linutronix.de>, Kate Stewart <kstewart@linuxfoundation.org>, y2038@lists.linaro.org, LKML <linux-kernel@vger.kernel.org>, Linux-Arch <linux-arch@vger.kernel.org>, Arnd Bergmann <arnd@arndb.de>, deepa.kernel@gmail.com, marcin.juszkiewicz@linaro.org
Message-ID: <20181105212848.D5FnjMPvpl4rTTGZdVDknlupVTeYjaJtbGYpf7mjS_A@z>

On Thu, Nov 1, 2018 at 6:56 AM Firoz Khan <firoz.khan@linaro.org> wrote:
> All the SYS_XTENSA_* macros used by sysxtensa syscall
> handlers are resides in the uapi header file move to
> non uapi header asm/unistd.h as it is not used by any
> user space applications.

These definitions are meant to be used by the userspace to
perform atomic operations in the absence of atomic access
instructions in the xtensa CPU variant.

-- 
Thanks.
-- Max
