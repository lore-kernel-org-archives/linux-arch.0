From: Kees Cook <keescook@chromium.org>
Subject: Re: [PATCH] x86/refcount: Implement fast refcount_t handling
Date: Tue, 25 Apr 2017 09:39:52 -0700
Message-ID: <CAGXu5jJF0g7Yw+2PDw_woyv0GsCOrX61noMu00p-hSO4Thi65Q@mail.gmail.com>
References: <20170421220939.GA65363@beast> <58FDDAC2.11341.175B5A99@pageexec.freemail.hu>
 <CAGXu5jLDybHn_K=vpXOhrsBE_-EtPA+jbXCqHmm3tUgbK24BOw@mail.gmail.com> <58FF3273.8060.1C99E526@pageexec.freemail.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-io0-f169.google.com ([209.85.223.169]:32798 "EHLO
        mail-io0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1432010AbdDYQjy (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 25 Apr 2017 12:39:54 -0400
Received: by mail-io0-f169.google.com with SMTP id k87so220619901ioi.0
        for <linux-arch@vger.kernel.org>; Tue, 25 Apr 2017 09:39:54 -0700 (PDT)
In-Reply-To: <58FF3273.8060.1C99E526@pageexec.freemail.hu>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: PaX Team <pageexec@freemail.hu>
Cc: Peter Zijlstra <peterz@infradead.org>, LKML <linux-kernel@vger.kernel.org>, Eric Biggers <ebiggers3@gmail.com>, Christoph Hellwig <hch@infradead.org>, "axboe@kernel.dk" <axboe@kernel.dk>, James Bottomley <James.Bottomley@hansenpartnership.com>, Elena Reshetova <elena.reshetova@intel.com>, Hans Liljestrand <ishkamiel@gmail.com>, David Windsor <dwindsor@gmail.com>, "x86@kernel.org" <x86@kernel.org>, Ingo Molnar <mingo@kernel.org>, Arnd Bergmann <arnd@arndb.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jann Horn <jann@thejh.net>, "David S. Miller" <davem@davemloft.net>, linux-arch <linux-arch@vger.kernel.org>, "kernel-hardening@lists.openwall.com" <kernel-hardening@lists.openwall.com>

On Tue, Apr 25, 2017 at 4:26 AM, PaX Team <pageexec@freemail.hu> wrote:
> INT_MAX threads would be needed when the leaking path is locked so
> that it can only be exercised once and you'll need to get normal
> (balanced) paths preempted just after the increment. if the leaking
> path is lockless (can be exercised in parallel without bounds) then
> 2 threads are enough where the one triggering the signed overflow
> would have to be preempted while the other one does INT_MAX increments
> and trigger the UAF. this is where the other mechanisms i talked about
> in the past become relevant: preemption or interrupts can be disabled
> or negative refcount values can be detected and acted upon (your blind
> copy-pasting effort passed upon this latter opportunity by not
> specializing the 'jo' into 'js' for the refcount case).

Well, it's not "blind" -- I'm trying to bring the code as-is to
upstream for discussion/examination with as little functional
differences as possible so it's easier to compare apples to apples.
(Which already resulted in more eyes looking at the code to find a bug
-- thanks Jann!) But yes, jo -> js hugely increases the coverage. I'll
make that change for v2.

Thanks!

-Kees

-- 
Kees Cook
Pixel Security
