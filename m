From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH] arch: remove unused macro/function thread_saved_pc()
Date: Wed, 28 Jun 2017 16:36:09 +0200
Message-ID: <CAMuHMdVqL4_QVR5z=s3+tf=VxkoF5sDD4MVCcfefQskyYxOKzw@mail.gmail.com>
References: <20170628133003.17432-1-tklauser@distanz.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-io0-f193.google.com ([209.85.223.193]:35379 "EHLO
        mail-io0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751602AbdF1OgL (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 28 Jun 2017 10:36:11 -0400
In-Reply-To: <20170628133003.17432-1-tklauser@distanz.ch>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Tobias Klauser <tklauser@distanz.ch>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@linux-foundation.org>, Linux-Arch <linux-arch@vger.kernel.org>, Linus Torvalds <torvalds@linux-foundation.org>, Ingo Molnar <mingo@kernel.org>

On Wed, Jun 28, 2017 at 3:30 PM, Tobias Klauser <tklauser@distanz.ch> wrote:
> The only user of thread_saved_pc() in non-arch-specific code was removed
> in commit 8243d5597793 ("sched/core: Remove pointless printout in
> sched_show_task()"). Remove the implementations as well.
>
> Some architectures use thread_saved_pc() in their arch-specific code.
> Leave their thread_saved_pc() intact.
>
> Cc: Linus Torvalds <torvalds@linux-foundation.org>
> Cc: Ingo Molnar <mingo@kernel.org>
> Signed-off-by: Tobias Klauser <tklauser@distanz.ch>

>  arch/m68k/include/asm/processor.h       |  2 --
>  arch/m68k/kernel/process.c              | 14 --------------

For the m68k part:
Acked-by: Geert Uytterhoeven <geert@linux-m68k.org>

Gr{oetje,eeting}s,

                        Geert
