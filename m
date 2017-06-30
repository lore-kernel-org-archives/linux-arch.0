From: Li Kun <hw.likun@huawei.com>
Subject: Re: [PATCH v5 3/3] x86/refcount: Implement fast
 refcount overflow protection
Date: Fri, 30 Jun 2017 10:42:05 +0800
Message-ID: <afcc7ab0-c1ca-e89d-169c-66be444274e4@huawei.com>
References: <1496180392-98718-1-git-send-email-keescook@chromium.org>
 <1496180392-98718-4-git-send-email-keescook@chromium.org>
 <3812aec2-682f-e95c-4d61-8e7eac33cc88@huawei.com>
 <CAGXu5jLzL3URMvF81EbH1Bt74MnwL9-25AU41yQnbEBcWA7J8Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
Return-path: <kernel-hardening-return-8844-glkh-kernel-hardening=m.gmane.org@lists.openwall.com>
List-Post: <mailto:kernel-hardening@lists.openwall.com>
List-Help: <mailto:kernel-hardening-help@lists.openwall.com>
List-Unsubscribe: <mailto:kernel-hardening-unsubscribe@lists.openwall.com>
List-Subscribe: <mailto:kernel-hardening-subscribe@lists.openwall.com>
In-Reply-To: <CAGXu5jLzL3URMvF81EbH1Bt74MnwL9-25AU41yQnbEBcWA7J8Q@mail.gmail.com>
To: Kees Cook <keescook@chromium.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Christoph Hellwig <hch@infradead.org>, Peter Zijlstra <peterz@infradead.org>, "Eric W.
 Biederman" <ebiederm@xmission.com>, Andrew Morton <akpm@linux-foundation.org>, Josh Poimboeuf <jpoimboe@redhat.com>, PaX Team <pageexec@freemail.hu>, Jann Horn <jannh@google.com>, Eric Biggers <ebiggers3@gmail.com>, Elena Reshetova <elena.reshetova@intel.com>, Hans
 Liljestrand <ishkamiel@gmail.com>, David Windsor <dwindsor@gmail.com>, Greg KH <gregkh@linuxfoundation.org>, Ingo Molnar <mingo@redhat.com>, Alexey Dobriyan <adobriyan@gmail.com>, "Serge E. Hallyn" <serge@hallyn.com>, arozansk@redhat.com, Davidlohr Bueso <dave@stgolabs.net>, Manfred Spraul <manfred@colorfullife.com>, "axboe@kernel.dk" <axboe@kernel.dk>, James
List-Id: linux-arch.vger.kernel.org



on 2017/6/30 6:05, Kees Cook wrote:
> On Wed, Jun 28, 2017 at 9:13 PM, Li Kun <hw.likun@huawei.com> wrote:
>> 在 2017/5/31 5:39, Kees Cook 写道:
>>> +bool ex_handler_refcount(const struct exception_table_entry *fixup,
>>> +                        struct pt_regs *regs, int trapnr)
>>> +{
>>> +       int reset;
>>> +
>>> +       /*
>>> +        * If we crossed from INT_MAX to INT_MIN, the OF flag (result
>>> +        * wrapped around) and the SF flag (result is negative) will be
>>> +        * set. In this case, reset to INT_MAX in an attempt to leave the
>>> +        * refcount usable. Otherwise, we've landed here due to producing
>>> +        * a negative result from either decrementing zero or operating on
>>> +        * a negative value. In this case things are badly broken, so we
>>> +        * we saturate to INT_MIN / 2.
>>> +        */
>>> +       if (regs->flags & (X86_EFLAGS_OF | X86_EFLAGS_SF))
>>> +               reset = INT_MAX;
>>      Should it be like this to indicate that the refcount is wapped from
>> INT_MAX to INT_MIN ?
>>          if (regs->flags & (X86_EFLAGS_OF | X86_EFLAGS_SF)
>>                  == (X86_EFLAGS_OF | X86_EFLAGS_SF))
>>
>>                  reset = INT_MAX;
> Ah yes, thanks for the catch. Yeah, that test is expecting both
> condition flags to be set.
>
> I'm still on the fence about the best way to deal with the bad states.
> I've been pondering just strictly using a saturation value (INT_MIN /
> 2), which should offer the same system state protection (except for
> the inherent resource leak), but that means there isn't really a good
> way to kill an offending process (since after saturation ALL processes
> will look like violators). It can be argued that killing the process
> doesn't actually provide any benefit since the system is still safe,
> though.
An immature idea,can we set the count to INT_MAX/2 when we detect and 
kill the offending process,
and wait to see if there will be another offender touching the fence. 
Er,not very acurate,but better than
killing all the processes doing refcount_add ,i think.
>>> +       else
>>> +               reset = INT_MIN / 2;
>>> +       *(int *)regs->cx = reset;
> Thanks for looking at this!
>
> -Kees
>

-- 
Best Regards
Li Kun
