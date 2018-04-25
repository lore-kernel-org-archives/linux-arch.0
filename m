Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-ua0-f193.google.com ([209.85.217.193]:38382 "EHLO
        mail-ua0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755348AbeDYSgR (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 25 Apr 2018 14:36:17 -0400
MIME-Version: 1.0
In-Reply-To: <20180425160311.2718314-3-arnd@arndb.de>
References: <20180425160311.2718314-1-arnd@arndb.de> <20180425160311.2718314-3-arnd@arndb.de>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Wed, 25 Apr 2018 20:36:15 +0200
Message-ID: <CAMuHMdVThd7nV=EsSSZ1puC6b8V85pWHDSGvJpLaeeafo-vRaw@mail.gmail.com>
Subject: Re: [PATCH 02/17] y2038: Remove newstat family from default syscall set
Content-Type: text/plain; charset="UTF-8"
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Arnd Bergmann <arnd@arndb.de>
Cc: y2038 Mailman List <y2038@lists.linaro.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux API <linux-api@vger.kernel.org>, Linux-Arch <linux-arch@vger.kernel.org>, libc-alpha <libc-alpha@sourceware.org>, Thomas Gleixner <tglx@linutronix.de>, netdev <netdev@vger.kernel.org>, Deepa Dinamani <deepa.kernel@gmail.com>, Al Viro <viro@zeniv.linux.org.uk>, "Albert ARIBAUD (3ADEV)" <albert.aribaud@3adev.fr>, Peter Zijlstra <peterz@infradead.org>, Darren Hart <dvhart@infradead.org>, "Eric W. Biederman" <ebiederm@xmission.com>, Dominik Brodowski <linux@dominikbrodowski.net>
Message-ID: <20180425183615.qgR36gJ6_6qQMnq0QYoAEuyhxwpq8vvREJ_sOzUoH9Q@z>

On Wed, Apr 25, 2018 at 6:02 PM, Arnd Bergmann <arnd@arndb.de> wrote:
> We have four generations of stat() syscalls:
> - the oldstat syscalls that are only used on the older architectures
> - the newstat family that is used on all 64-bit architectures but
>   lacked support for large files on 32-bit architectures.
> - the stat64 family that is used mostly on 32-bit architectures to
>   replace newstat
> - statx() to replace all of the above, adding 64-bit timestamps among
>   other things.
>
> We already compile stat64 only on those architectures that need it,
> but newstat is always built, including on those that don't reference
> it. This adds a new __ARCH_WANT_NEW_STAT symbol along the lines of
> __ARCH_WANT_OLD_STAT and __ARCH_WANT_STAT64 to control compilation of
> newstat. All architectures that need it use an explict define, the
> others now get a little bit smaller, and future architecture (including
> 64-bit targets) won't ever see it.
>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

For m68k:
Acked-by: Geert Uytterhoeven <geert@linux-m68k.org>

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
