From: Kees Cook <keescook@chromium.org>
Subject: Re: [PATCH v5 0/3] Implement fast refcount overflow protection
Date: Wed, 31 May 2017 06:20:25 -0700
Message-ID: <CAGXu5jK7Yn6b7__uSM5V6XPdn=wqBTh5Q8SojPpNq=Jnzc6T7w@mail.gmail.com>
References: <1496180392-98718-1-git-send-email-keescook@chromium.org> <20170531122732.GA24923@linux-80c1.suse>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-it0-f50.google.com ([209.85.214.50]:36911 "EHLO
        mail-it0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751011AbdEaNU1 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 31 May 2017 09:20:27 -0400
Received: by mail-it0-f50.google.com with SMTP id g126so11194027ith.0
        for <linux-arch@vger.kernel.org>; Wed, 31 May 2017 06:20:27 -0700 (PDT)
In-Reply-To: <20170531122732.GA24923@linux-80c1.suse>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Davidlohr Bueso <dave@stgolabs.net>
Cc: LKML <linux-kernel@vger.kernel.org>, Christoph Hellwig <hch@infradead.org>, Peter Zijlstra <peterz@infradead.org>, "Eric W. Biederman" <ebiederm@xmission.com>, Andrew Morton <akpm@linux-foundation.org>, Josh Poimboeuf <jpoimboe@redhat.com>, PaX Team <pageexec@freemail.hu>, Jann Horn <jannh@google.com>, Eric Biggers <ebiggers3@gmail.com>, Elena Reshetova <elena.reshetova@intel.com>, Hans Liljestrand <ishkamiel@gmail.com>, David Windsor <dwindsor@gmail.com>, Greg KH <gregkh@linuxfoundation.org>, Ingo Molnar <mingo@redhat.com>, Alexey Dobriyan <adobriyan@gmail.com>, "Serge E. Hallyn" <serge@hallyn.com>, arozansk@redhat.com, Manfred Spraul <manfred@colorfullife.com>, "axboe@kernel.dk" <axboe@kernel.dk>, James Bottomley <James.Bottomley@hansenpartnership.>

On Wed, May 31, 2017 at 5:27 AM, Davidlohr Bueso <dave@stgolabs.net> wrote:
> On Tue, 30 May 2017, Kees Cook wrote:
>
>> A new patch has been added at the start of this series to make the default
>> refcount_t implementation just use an unchecked atomic_t implementation,
>> since many kernel subsystems want to be able to opt out of the full
>> validation, since it includes a small performance overhead. When enabling
>> CONFIG_REFCOUNT_FULL, the full validation is used.
>>
>> The other two patches provide overflow protection on x86 without incurring
>> a performance penalty. The changelog for patch 3 is reproduced here for
>> details:
>
>
> To be sure I'm getting this right, after this all archs with the exception
> of x86 will use the regular atomic_t ("unsecure") flavor, right?

If a build does not select CONFIG_REFCOUNT_FULL and lacks
CONFIG_ARCH_HAS_REFCOUNT, refcount_t will be the same at atomic_t
(i.e. no change from the historical behavior where all the ref
counters in the kernel used atomic_t).

-Kees

-- 
Kees Cook
Pixel Security
