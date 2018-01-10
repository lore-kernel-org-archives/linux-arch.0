From: Dan Williams <dan.j.williams@intel.com>
Subject: Re: [PATCH 16/18] net: mpls: prevent bounds-check bypass via
 speculative execution
Date: Tue, 9 Jan 2018 17:33:18 -0800
Message-ID: <CAPcyv4hktYj3hmSD6Ga3X6ndkEGoMPLAJMdghYo4SisLDTBSKg@mail.gmail.com>
References: <151520099201.32271.4677179499894422956.stgit@dwillia2-desk3.amr.corp.intel.com>
 <151520108080.32271.16420298348259030860.stgit@dwillia2-desk3.amr.corp.intel.com>
 <87lgh7n2tf.fsf@xmission.com> <CAPcyv4iErvcOOSkaQbMa=9OJCmxNO7sDqi3qzg2ODvKqCApULQ@mail.gmail.com>
 <CA+55aFwDZ_K1uzuTq95hUXUVLFsCPCqGAMHpwa4PLCRvszmqkQ@mail.gmail.com> <CAPcyv4it+Nasf1mp-+ydGP6rjHkyNKJXDTMyPrERk4V5g4yP7A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAPcyv4it+Nasf1mp-+ydGP6rjHkyNKJXDTMyPrERk4V5g4yP7A@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: "Eric W. Biederman" <ebiederm@xmission.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-arch@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>, Netdev <netdev@vger.kernel.org>, Greg KH <gregkh@linuxfoundation.org>, Thomas Gleixner <tglx@linutronix.de>, "David S. Miller" <davem@davemloft.net>, Elena Reshetova <elena.reshetova@intel.com>, Alan Cox <alan@linux.intel.com>
List-Id: linux-arch.vger.kernel.org

On Tue, Jan 9, 2018 at 4:48 PM, Dan Williams <dan.j.williams@intel.com> wrote:
> On Mon, Jan 8, 2018 at 8:13 PM, Linus Torvalds
> <torvalds@linux-foundation.org> wrote:
>>
>> On Mon, Jan 8, 2018 at 7:42 PM, Dan Williams <dan.j.williams@intel.com> wrote:
>> >
>> > originally from Linus and tweaked by Alexei and I:
>>
>> Sadly, that tweak - while clever - is wrong.
>>
>> >         unsigned long _mask = ~(long)(_m - 1 - _i) >> BITS_PER_LONG - 1;\
>>
>> Why?
>>
>> Because "(long)(_m-1-_i)" is not negative just because "i >= m". It
>> can still be positive.
>>
>> Think "m = 100", "i=bignum". The subtraction will overflow and become
>> positive again, the shift will shift to zero, and then the mask will
>> become ~0.
>>
>> Now, you can fix it, but you need to be a tiny bit more clever.  In
>> particular, just make sure that you retain the high bit of "_i",
>> basically making the rule be that a negative index is not ever valid.
>>
>> And then instead of "(_m - 1 - _i)", you use "(_i | (_m - 1 - _i))".
>> Now the sign bit is set if _i had it set, _or_ if the subtraction
>> turned negative, and you don't have to worry about the overflow
>> situation.
>>
>> But it does require that extra step to be trustworthy. Still purely
>> cheap arithmetic operations, although there is possibly some
>> additional register pressure there.
>>
>> Somebody might be able to come up with something even more minimal (or
>> find a fault in my fix of your tweak).
>
> I looks like there is another problem, or I'm misreading the
> cleverness. We want the mask to be ~0 in the ok case and 0 in the
> out-of-bounds case. As far as I can see we end up with ~0 in the ok
> case, and ~1 in the bad case. Don't we need to do something like the
> following, at which point are we getting out of the realm of "cheap
> ALU instructions"?
>
> #define __nospec_array_ptr(base, idx, sz)                               \
> ({                                                                      \
>         union { typeof(&base[0]) _ptr; unsigned long _bit; } __u;       \
>         unsigned long _i = (idx);                                       \
>         unsigned long _s = (sz);                                        \
>         unsigned long _v = (long)(_i | _s - 1 - _i)                     \
>                                         >> BITS_PER_LONG - 1;           \
>         unsigned long _mask = _v * ~0UL;                                 \
>         OPTIMIZER_HIDE_VAR(_mask);                                      \
>         __u._ptr = &base[_i & _mask];                                   \
>         __u._bit &= _mask;                                              \
>         __u._ptr;                                                       \
> })

Sorry, I'm slow of course ~(-1L) is 0.
