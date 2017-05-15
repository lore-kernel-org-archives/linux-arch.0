From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH] sched: remove sched_find_first_bit()
Date: Mon, 15 May 2017 16:18:49 +0200
Message-ID: <CAK8P3a18vzO2AigK3FiTHL33SjXcHGL4dxB3qASrLFm7bJN7ww@mail.gmail.com>
References: <20170513010152.13986-1-ynorov@caviumnetworks.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-oi0-f67.google.com ([209.85.218.67]:36054 "EHLO
        mail-oi0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934356AbdEOOSu (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 15 May 2017 10:18:50 -0400
In-Reply-To: <20170513010152.13986-1-ynorov@caviumnetworks.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Yury Norov <ynorov@caviumnetworks.com>
Cc: linux-arch <linux-arch@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>, Richard Henderson <rth@twiddle.net>, Ivan Kokshaysky <ink@jurassic.park.msu.ru>, Matt Turner <mattst88@gmail.com>, Akinobu Mita <mita@miraclelinux.com>, Mike Galbraith <efault@gmx.de>

On Sat, May 13, 2017 at 3:01 AM, Yury Norov <ynorov@caviumnetworks.com> wrote:

> include/asm-generic/bitops/sched.h as it declares only this
> function.  Alpha has it's own implementation, very similar to
> generic one, so it is also removed.

Nice consolidation, I see that every architecture once had a copy of
this function, and they were all removed at one point long ago,
except for Alpha, and there is no reason to leave that one in the tree.

I'll leave it to you and Ingo to figure out what the two callers should
do, but for removing function from asm-generic:

Acked-by: Arnd Bergmann <arnd@arndb.de>

Maybe you could split the patch into two changesets, and make the
first of them move the function to kernel/sched/rt.c, and the second
one (if we still want it then) can change the implementation to whatever
you conclude is ideal.

      Arnd
