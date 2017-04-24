From: Kees Cook <keescook@chromium.org>
Subject: Re: [PATCH] x86/refcount: Implement fast refcount_t handling
Date: Mon, 24 Apr 2017 13:21:38 -0700
Message-ID: <CAGXu5jLK9YwgaPSyykGoyXD1Ls=yZZ7b76Lns6pZY2+dpP+05w@mail.gmail.com>
References: <20170421220939.GA65363@beast> <20170424104853.k6s2jjmcdbbghit4@hirez.programming.kicks-ass.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <kernel-hardening-return-7523-glkh-kernel-hardening=m.gmane.org@lists.openwall.com>
List-Post: <mailto:kernel-hardening@lists.openwall.com>
List-Help: <mailto:kernel-hardening-help@lists.openwall.com>
List-Unsubscribe: <mailto:kernel-hardening-unsubscribe@lists.openwall.com>
List-Subscribe: <mailto:kernel-hardening-subscribe@lists.openwall.com>
Sender: keescook@google.com
In-Reply-To: <20170424104853.k6s2jjmcdbbghit4@hirez.programming.kicks-ass.net>
To: Peter Zijlstra <peterz@infradead.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Eric Biggers <ebiggers3@gmail.com>, Christoph Hellwig <hch@infradead.org>, "axboe@kernel.dk" <axboe@kernel.dk>, James Bottomley <James.Bottomley@hansenpartnership.com>, Elena Reshetova <elena.reshetova@intel.com>, Hans Liljestrand <ishkamiel@gmail.com>, David Windsor <dwindsor@gmail.com>, "x86@kernel.org" <x86@kernel.org>, Ingo Molnar <mingo@kernel.org>, Arnd Bergmann <arnd@arndb.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jann Horn <jann@thejh.net>, "David S. Miller" <davem@davemloft.net>, linux-arch <linux-arch@vger.kernel.org>, "kernel-hardening@lists.openwall.com" <kernel-hardening@lists.openwall.com>, PaX Team <pageexec@freemail.hu>
List-Id: linux-arch.vger.kernel.org

On Mon, Apr 24, 2017 at 3:48 AM, Peter Zijlstra <peterz@infradead.org> wrote:
> On Fri, Apr 21, 2017 at 03:09:39PM -0700, Kees Cook wrote:
>> diff --git a/drivers/misc/lkdtm_bugs.c b/drivers/misc/lkdtm_bugs.c
>> index e3f4cd8876b5..1bdafb29b802 100644
>> --- a/drivers/misc/lkdtm_bugs.c
>> +++ b/drivers/misc/lkdtm_bugs.c
>> @@ -135,9 +135,15 @@ void lkdtm_HUNG_TASK(void)
>>       schedule();
>>  }
>>
>> +#ifdef CONFIG_FAST_REFCOUNT
>> +#define REFCOUNT_MAX INT_MAX
>> +#else
>> +#define REFCOUNT_MAX UINT_MAX
>> +#endif
>
> That doesn't seem like a sensible place for this.

I'll drop the LKDTM changes from this particular patch. As for the
define, I think it's only interesting to LKDTM since it's the only
part interested in refcount_t internals. (i.e. nothing else would (or
should) use this information.)

-Kees

-- 
Kees Cook
Pixel Security
