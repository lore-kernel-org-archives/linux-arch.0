Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-qk1-f196.google.com ([209.85.222.196]:39606 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730143AbfJNH0D (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 14 Oct 2019 03:26:03 -0400
MIME-Version: 1.0
References: <20191013221310.30748-1-sebastian@breakpoint.cc> <20191013221310.30748-2-sebastian@breakpoint.cc>
In-Reply-To: <20191013221310.30748-2-sebastian@breakpoint.cc>
From: Arnd Bergmann <arnd@arndb.de>
Date: Mon, 14 Oct 2019 09:25:46 +0200
Message-ID: <CAK8P3a0q+03=uNcnnHrGqHGOcAO3-mytxSmoBWLtHY+5StMNOQ@mail.gmail.com>
Subject: Re: [PATCH 1/6] sh: Move cmpxchg-xchg.h to asm-generic
Content-Type: text/plain; charset="UTF-8"
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Sebastian Andrzej Siewior <sebastian@breakpoint.cc>
Cc: Linux ARM <linux-arm-kernel@lists.infradead.org>, Peter Zijlstra <peterz@infradead.org>, Russell King <linux@armlinux.org.uk>, Ingo Molnar <mingo@redhat.com>, Waiman Long <longman@redhat.com>, Will Deacon <will@kernel.org>, Yoshinori Sato <ysato@users.sourceforge.jp>, Rich Felker <dalias@libc.org>, Linux-sh list <linux-sh@vger.kernel.org>, linux-arch <linux-arch@vger.kernel.org>
Message-ID: <20191014072546.Yf7ZNVrbb6wfwMJ36yPILQFbOxSaUgiPzqIfJLK0E-s@z>

On Mon, Oct 14, 2019 at 12:13 AM Sebastian Andrzej Siewior
<sebastian@breakpoint.cc> wrote:
>
> The header file is very generic and could be reused by other
> architectures as long as they provide __cmpxchg_u32().
>
> Move sh's cmpxchg-xchg.h to asm-generic.
>
> Cc: Yoshinori Sato <ysato@users.sourceforge.jp>
> Cc: Rich Felker <dalias@libc.org>
> Cc: Arnd Bergmann <arnd@arndb.de>

Acked-by: Arnd Bergmann <arnd@arndb.de>

Maybe change the "#ifndef __ASM_SH_CMPXCHG_XCHG_H"
to __ASM_GENERIC_*.

        Arnd
