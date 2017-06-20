From: Kees Cook <keescook@chromium.org>
Subject: Re: [PATCH v2] refcount: Create unchecked atomic_t implementation
Date: Mon, 19 Jun 2017 21:47:22 -0700
Message-ID: <CAGXu5jJs+sFhmWSWqOjDnyzpSn8fbACLYUw=KBB4w_YfEDVXNA@mail.gmail.com>
References: <20170608025831.GA43608@beast> <20170608055655.GB19269@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-io0-f175.google.com ([209.85.223.175]:34368 "EHLO
        mail-io0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750916AbdFTErY (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 20 Jun 2017 00:47:24 -0400
Received: by mail-io0-f175.google.com with SMTP id i7so76560069ioe.1
        for <linux-arch@vger.kernel.org>; Mon, 19 Jun 2017 21:47:24 -0700 (PDT)
In-Reply-To: <20170608055655.GB19269@kroah.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Greg KH <gregkh@linuxfoundation.org>, Ingo Molnar <mingo@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Christoph Hellwig <hch@infradead.org>, Peter Zijlstra <peterz@infradead.org>, "Eric W. Biederman" <ebiederm@xmission.com>, Andrew Morton <akpm@linux-foundation.org>, Josh Poimboeuf <jpoimboe@redhat.com>, Jann Horn <jannh@google.com>, Eric Biggers <ebiggers3@gmail.com>, Elena Reshetova <elena.reshetova@intel.com>, Hans Liljestrand <ishkamiel@gmail.com>, David Windsor <dwindsor@gmail.com>, Ingo Molnar <mingo@redhat.com>, Alexey Dobriyan <adobriyan@gmail.com>, "Serge E. Hallyn" <serge@hallyn.com>, arozansk@redhat.com, Davidlohr Bueso <dave@stgolabs.net>, Manfred Spraul <manfred@colorfullife.com>, "axboe@kernel.dk" <axboe@kernel.dk>, James Bottomley <James.Bottomley@hansenpartnership.com>, "x86@kernel.org" <x8>

On Wed, Jun 7, 2017 at 10:56 PM, Greg KH <gregkh@linuxfoundation.org> wrote:
> On Wed, Jun 07, 2017 at 07:58:31PM -0700, Kees Cook wrote:
>> Many subsystems will not use refcount_t unless there is a way to build the
>> kernel so that there is no regression in speed compared to atomic_t. This
>> adds CONFIG_REFCOUNT_FULL to enable the full refcount_t implementation
>> which has the validation but is slightly slower. When not enabled,
>> refcount_t uses the basic unchecked atomic_t routines, which results in
>> no code changes compared to just using atomic_t directly.
>>
>> Signed-off-by: Kees Cook <keescook@chromium.org>
>
> Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

Ping. tip maintainers, can you please take this patch to unblock the
refcount_t conversions?

Thanks!

-Kees

-- 
Kees Cook
Pixel Security
