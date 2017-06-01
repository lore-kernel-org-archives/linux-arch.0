Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-it0-f47.google.com ([209.85.214.47]:36341 "EHLO
        mail-it0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751083AbdFAOnj (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 1 Jun 2017 10:43:39 -0400
Received: by mail-it0-f47.google.com with SMTP id m47so40784515iti.1
        for <linux-arch@vger.kernel.org>; Thu, 01 Jun 2017 07:43:39 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20170531110918.tgbppvxgkkhoaclk@hirez.programming.kicks-ass.net>
References: <1496180392-98718-1-git-send-email-keescook@chromium.org>
 <1496180392-98718-2-git-send-email-keescook@chromium.org> <2236FBA76BA1254E88B949DDB74E612B6B215E2E@IRSMSX102.ger.corp.intel.com>
 <20170531110918.tgbppvxgkkhoaclk@hirez.programming.kicks-ass.net>
From: Kees Cook <keescook@chromium.org>
Date: Thu, 1 Jun 2017 07:43:37 -0700
Message-ID: <CAGXu5j+eX4A5E5YQq3WmgWmW16nCUwswZsbwzVGdd1v8i72JLA@mail.gmail.com>
Subject: Re: [PATCH v5 1/3] refcount: Create unchecked atomic_t implementation
Content-Type: text/plain; charset="UTF-8"
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Peter Zijlstra <peterz@infradead.org>
Cc: "Reshetova, Elena" <elena.reshetova@intel.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Christoph Hellwig <hch@infradead.org>, "Eric W. Biederman" <ebiederm@xmission.com>, Andrew Morton <akpm@linux-foundation.org>, Josh Poimboeuf <jpoimboe@redhat.com>, PaX Team <pageexec@freemail.hu>, Jann Horn <jannh@google.com>, Eric Biggers <ebiggers3@gmail.com>, Hans Liljestrand <ishkamiel@gmail.com>, David Windsor <dwindsor@gmail.com>, Greg KH <gregkh@linuxfoundation.org>, Ingo Molnar <mingo@redhat.com>, Alexey Dobriyan <adobriyan@gmail.com>, "Serge E. Hallyn" <serge@hallyn.com>, "arozansk@redhat.com" <arozansk@redhat.com>, Davidlohr Bueso <dave@stgolabs.net>, Manfred Spraul <manfred@colorfullife.com>, "axboe@kernel.dk" <axboe@kernel.dk>, James Bottomley <James.Bottomley@hansenpartnership.com>, "x86@kernel.org" <x86@kernel.org>, Ingo Molnar <mingo@kernel.org>, Arnd Bergmann <arnd@arndb.de>, "David S. Miller" <davem@davemloft.net>, Rik van Riel <riel@redhat.com>, linux-arch <linux-arch@vger.kernel.org>, "kernel-hardening@lists.openwall.com" <kernel-hardening@lists.openwall.com>
Message-ID: <20170601144337.D1U_eQP1dTK8RlE1zs13O1ulHeOyfIfmdII4Ojfhoig@z>

On Wed, May 31, 2017 at 4:09 AM, Peter Zijlstra <peterz@infradead.org> wrote:
> On Wed, May 31, 2017 at 10:45:09AM +0000, Reshetova, Elena wrote:
>
>> > +static inline __must_check bool refcount_add_not_zero(unsigned int i,
>> > +
>> >           refcount_t *r)
>> > +{
>> > +   return atomic_add_return(i, &r->refs) != 0;
>> > +}
>>
>> Maybe atomic_add_unless(&r->refs, i, 0) in order to be consistent with the below inc_not_zero implementation?
>
> Yes, atomic_add_return() is strictly incorrect here since the add is
> unconditional.
>
>> > +static inline __must_check bool refcount_sub_and_test(unsigned int i,
>> > +
>> >           refcount_t *r)
>> > +{
>> > +   return atomic_sub_return(i, &r->refs) == 0;
>> > +}
>>
>> Any reason for not using atomic_sub_and_test() here?
>
>> > +static inline __must_check bool refcount_dec_and_test(refcount_t *r)
>> > +{
>> > +   return atomic_dec_return(&r->refs) == 0;
>> > +}
>>
>> Same here: atomic_dec_and_test()?
>
> Both those are better because they return condition codes generated from
> the operand itself.

Ah yes, thanks to both of you for the corrections. I'll send a new version...

-Kees

-- 
Kees Cook
Pixel Security
