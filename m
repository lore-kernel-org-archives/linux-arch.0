From: Davidlohr Bueso <dave@stgolabs.net>
Subject: Re: [PATCH v2] refcount: Create unchecked atomic_t implementation
Date: Thu, 8 Jun 2017 13:09:31 -0700
Message-ID: <20170608200931.GC2464@linux-80c1.suse>
References: <20170608025831.GA43608@beast>
 <20170608065809.GC14568@infradead.org>
 <2236FBA76BA1254E88B949DDB74E612B6FF0E5C7@IRSMSX102.ger.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:58505 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751510AbdFHUJv (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Thu, 8 Jun 2017 16:09:51 -0400
Content-Disposition: inline
In-Reply-To: <2236FBA76BA1254E88B949DDB74E612B6FF0E5C7@IRSMSX102.ger.corp.intel.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: "Reshetova, Elena" <elena.reshetova@intel.com>
Cc: Christoph Hellwig <hch@infradead.org>, Kees Cook <keescook@chromium.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Peter Zijlstra <peterz@infradead.org>, "Eric W. Biederman" <ebiederm@xmission.com>, Andrew Morton <akpm@linux-foundation.org>, Josh Poimboeuf <jpoimboe@redhat.com>, Jann Horn <jannh@google.com>, Eric Biggers <ebiggers3@gmail.com>, Hans Liljestrand <ishkamiel@gmail.com>, David Windsor <dwindsor@gmail.com>, Greg KH <gregkh@linuxfoundation.org>, Ingo Molnar <mingo@redhat.com>, Alexey Dobriyan <adobriyan@gmail.com>, "Serge E. Hallyn" <serge@hallyn.com>, "arozansk@redhat.com" <arozansk@redhat.com>, Manfred Spraul <manfred@colorfullife.com>, "axboe@kernel.dk" <axboe@kernel.dk>, James Bottomley <James.Bottomley@han>

On Thu, 08 Jun 2017, Reshetova, Elena wrote:

>> On Wed, Jun 07, 2017 at 07:58:31PM -0700, Kees Cook wrote:
>> > Many subsystems will not use refcount_t unless there is a way to build the
>> > kernel so that there is no regression in speed compared to atomic_t. This
>> > adds CONFIG_REFCOUNT_FULL to enable the full refcount_t implementation
>> > which has the validation but is slightly slower. When not enabled,
>> > refcount_t uses the basic unchecked atomic_t routines, which results in
>> > no code changes compared to just using atomic_t directly.
>> >
>> > Signed-off-by: Kees Cook <keescook@chromium.org>
>> > ---
>> > This is v2 of this patch, which I've split from the arch-specific
>> > alternative implementation for x86. Getting this patch in will unblock
>> > atomic_t -> refcount_t conversion, and the x86 alternative implementation
>> > can be developed in parallel. Changes from v1: use better atomic ops,
>> > thanks to Elena and Peter.
>>
>> Yeah, can we get this in ASAP?  Without having to always incur the over
>> this will allow us to convert subsystems to refcount_t broadly.
>
>+1. If this gets in, I can refresh the rest of the patches in net, mm, ipc, block, etc. and send them for review again.

Yes, this would be a prerequisite for ipc; which I initially thought didn't
take a performance hit.

Thanks,
Davidlohr
