Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-qt1-f193.google.com ([209.85.160.193]:33011 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725942AbfBVOhD (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 22 Feb 2019 09:37:03 -0500
Received: by mail-qt1-f193.google.com with SMTP id z39so2722726qtz.0
        for <linux-arch@vger.kernel.org>; Fri, 22 Feb 2019 06:37:02 -0800 (PST)
MIME-Version: 1.0
References: <20190222122430.21180-1-vincenzo.frascino@arm.com>
 <20190222122430.21180-3-vincenzo.frascino@arm.com> <CAK8P3a1ssUdsqk7YW-tjD-dihEAP-voKLOEGO-W=TL7Lb8E7vw@mail.gmail.com>
In-Reply-To: <CAK8P3a1ssUdsqk7YW-tjD-dihEAP-voKLOEGO-W=TL7Lb8E7vw@mail.gmail.com>
From: Arnd Bergmann <arnd@arndb.de>
Date: Fri, 22 Feb 2019 15:36:45 +0100
Message-ID: <CAK8P3a3wE1VzsAGjuFudYNDNWAtyubAiCsYU=Sd_40Nj6+-sfw@mail.gmail.com>
Subject: Re: [PATCH v5 02/23] kernel: Define gettimeofday vdso common code
Content-Type: text/plain; charset="UTF-8"
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Vincenzo Frascino <vincenzo.frascino@arm.com>
Cc: linux-arch <linux-arch@vger.kernel.org>, Linux ARM <linux-arm-kernel@lists.infradead.org>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, Russell King <linux@armlinux.org.uk>, Ralf Baechle <ralf@linux-mips.org>, Paul Burton <paul.burton@mips.com>, Daniel Lezcano <daniel.lezcano@linaro.org>, Thomas Gleixner <tglx@linutronix.de>, Mark Salyzyn <salyzyn@android.com>, Peter Collingbourne <pcc@google.com>, Shuah Khan <shuah@kernel.org>, Dmitry Safonov <0x7f454c46@gmail.com>, Rasmus Villemoes <linux@rasmusvillemoes.dk>
Message-ID: <20190222143645.YowKxZI0sohf4reiL12dKkYWlhkc0KlFTo5pmIpfbHk@z>

On Fri, Feb 22, 2019 at 2:49 PM Arnd Bergmann <arnd@arndb.de> wrote:
>
> On Fri, Feb 22, 2019 at 1:25 PM Vincenzo Frascino <vincenzo.frascino@arm.com> wrote:
> For __vdso_timespec, I see how you ended up with this
> redefinition, and it makes the current version of your patches
> easier, but I fear it will in turn make it harder to add the
> __kernel_old_timeval based variant.

I meant __kernel_timespec here, not __kernel_old_timeval.

      Arnd
