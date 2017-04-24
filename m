Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-io0-f181.google.com ([209.85.223.181]:35537 "EHLO
        mail-io0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1166408AbdDXIxv (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 24 Apr 2017 04:53:51 -0400
Received: by mail-io0-f181.google.com with SMTP id r16so178340410ioi.2
        for <linux-arch@vger.kernel.org>; Mon, 24 Apr 2017 01:53:51 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20170424083250.h2wv2exbi4ytigac@hirez.programming.kicks-ass.net>
References: <20170421220939.GA65363@beast> <20170424083250.h2wv2exbi4ytigac@hirez.programming.kicks-ass.net>
From: Jann Horn <jannh@google.com>
Date: Mon, 24 Apr 2017 10:53:30 +0200
Message-ID: <CAG48ez1z4F0sTBV3DCvkVJazQXxXGe=NyWKqYjKveEj-CQVy7w@mail.gmail.com>
Subject: Re: [kernel-hardening] Re: [PATCH] x86/refcount: Implement fast
 refcount_t handling
Content-Type: text/plain; charset=UTF-8
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Peter Zijlstra <peterz@infradead.org>
Cc: Kees Cook <keescook@chromium.org>, linux-kernel@vger.kernel.org, Eric Biggers <ebiggers3@gmail.com>, Christoph Hellwig <hch@infradead.org>, "axboe@kernel.dk" <axboe@kernel.dk>, James Bottomley <James.Bottomley@hansenpartnership.com>, Elena Reshetova <elena.reshetova@intel.com>, Hans Liljestrand <ishkamiel@gmail.com>, David Windsor <dwindsor@gmail.com>, x86@kernel.org, Ingo Molnar <mingo@kernel.org>, Arnd Bergmann <arnd@arndb.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jann Horn <jann@thejh.net>, "David S. Miller" <davem@davemloft.net>, linux-arch@vger.kernel.org, kernel-hardening@lists.openwall.com, PaX Team <pageexec@freemail.hu>
Message-ID: <20170424085330.wrxJpwktgk71v9uXHjih0yX3mA_ckf15rIe-OIa9RTk@z>

On Mon, Apr 24, 2017 at 10:32 AM, Peter Zijlstra <peterz@infradead.org> wrote:
> On Fri, Apr 21, 2017 at 03:09:39PM -0700, Kees Cook wrote:
>> This patch ports the x86-specific atomic overflow handling from PaX's
>> PAX_REFCOUNT to the upstream refcount_t API. This is an updated version
>> from PaX that eliminates the saturation race condition by resetting the
>> atomic counter back to the INT_MAX saturation value on both overflow and
>> underflow. To win a race, a system would have to have INT_MAX threads
>> simultaneously overflow before the saturation handler runs.
>
> And is this impossible? Highly unlikely I'll grant you, but absolutely
> impossible?
>
> Also, you forgot nr_cpus in your bound. Afaict the worst case here is
> O(nr_tasks + 3*nr_cpus).
>
> Because PaX does it, is not a correctness argument. And this really
> wants one.
