Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-io0-f181.google.com ([209.85.223.181]:36035 "EHLO
        mail-io0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750998AbdEaQJS (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 31 May 2017 12:09:18 -0400
Received: by mail-io0-f181.google.com with SMTP id o12so18921911iod.3
        for <linux-arch@vger.kernel.org>; Wed, 31 May 2017 09:09:18 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20170531140318.5piqb4ksynq4evwi@hirez.programming.kicks-ass.net>
References: <1496180392-98718-1-git-send-email-keescook@chromium.org>
 <1496180392-98718-3-git-send-email-keescook@chromium.org> <20170531111309.3kyfgxu5dkthu2dn@hirez.programming.kicks-ass.net>
 <CAGXu5j+MKKSU+=VGmwamC0aekRKt+WDvpVpdmFce2br8YoecgA@mail.gmail.com> <20170531140318.5piqb4ksynq4evwi@hirez.programming.kicks-ass.net>
From: Kees Cook <keescook@chromium.org>
Date: Wed, 31 May 2017 09:09:16 -0700
Message-ID: <CAGXu5jKV-NjD5=tFsfeik-Egh4sctzPnQnZtuv9D7-WSkkREVw@mail.gmail.com>
Subject: Re: [PATCH v5 2/3] x86/asm: Add suffix macro for GEN_*_RMWcc()
Content-Type: text/plain; charset="UTF-8"
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Peter Zijlstra <peterz@infradead.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Christoph Hellwig <hch@infradead.org>, "Eric W. Biederman" <ebiederm@xmission.com>, Andrew Morton <akpm@linux-foundation.org>, Josh Poimboeuf <jpoimboe@redhat.com>, PaX Team <pageexec@freemail.hu>, Jann Horn <jannh@google.com>, Eric Biggers <ebiggers3@gmail.com>, Elena Reshetova <elena.reshetova@intel.com>, Hans Liljestrand <ishkamiel@gmail.com>, David Windsor <dwindsor@gmail.com>, Greg KH <gregkh@linuxfoundation.org>, Ingo Molnar <mingo@redhat.com>, Alexey Dobriyan <adobriyan@gmail.com>, "Serge E. Hallyn" <serge@hallyn.com>, arozansk@redhat.com, Davidlohr Bueso <dave@stgolabs.net>, Manfred Spraul <manfred@colorfullife.com>, "axboe@kernel.dk" <axboe@kernel.dk>, James Bottomley <James.Bottomley@hansenpartnership.com>, "x86@kernel.org" <x86@kernel.org>, Ingo Molnar <mingo@kernel.org>, Arnd Bergmann <arnd@arndb.de>, "David S. Miller" <davem@davemloft.net>, Rik van Riel <riel@redhat.com>, linux-arch <linux-arch@vger.kernel.org>, "kernel-hardening@lists.openwall.com" <kernel-hardening@lists.openwall.com>
Message-ID: <20170531160916.gkJhZE-ZhM0vHr1-NSf7d3hT11P_4O26uHwwlztjF78@z>

On Wed, May 31, 2017 at 7:03 AM, Peter Zijlstra <peterz@infradead.org> wrote:
> On Wed, May 31, 2017 at 06:17:16AM -0700, Kees Cook wrote:
>> On Wed, May 31, 2017 at 4:13 AM, Peter Zijlstra <peterz@infradead.org> wrote:
>> > On Tue, May 30, 2017 at 02:39:51PM -0700, Kees Cook wrote:
>> >> The coming x86 refcount protection needs to be able to add trailing
>> >> instructions to the GEN_*_RMWcc() operations. This extracts the
>> >> difference between the goto/non-goto cases so the helper macros
>> >> can be defined outside the #ifdef cases. Additionally adds argument
>> >> naming to the resulting asm for referencing from suffixed
>> >> instructions, and adds clobbers for "cc", and "cx" to let suffixes
>> >> use _ASM_CX, and retain any set flags.
>> >
>> > Another option is to simply require __GCC_ASM_FLAG_OUTPUT__ for the fast
>> > refcount stuff. That would result in simpler and more readable code.
>>
>> What versions of GCC support that?
>
> IIRC 6+

Given how many folks are still using 4.9 (and lower, see the thread
with Arnd[1]), I'd like to just keep this as I have it. It's not much
less readable, IMO (It was already pretty complex). I cleaned it up a
little before making it more ugly, so I think on sum, it's only a
little more weird. I think that's better than making this
compiler-specific or copy/pasting.

-Kees

[1] https://lkml.org/lkml/2017/4/25/66

-- 
Kees Cook
Pixel Security
