From: =?iso-8859-1?Q?M=E5ns_Rullg=E5rd?= <mans@mansr.com>
Subject: Re: [RFC][PATCH 2/3] math128: Introduce {mult,add,cmp}_u128
Date: Tue, 24 Apr 2012 21:12:20 +0100
Message-ID: <yw1xy5pkj3dn.fsf@unicorn.mansr.com>
References: <20120424161039.293018424@chello.nl>
	<20120424162224.526249106@chello.nl>
	<CA+55aFyvBTDh_DkXs6Z6zFmjyYxvWaAEm9-rJDXhvPx8CpDiKA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CA+55aFyvBTDh_DkXs6Z6zFmjyYxvWaAEm9-rJDXhvPx8CpDiKA@mail.gmail.com>
	(Linus Torvalds's message of "Tue, 24 Apr 2012 12:37:53 -0700")
Sender: linux-kernel-owner@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <a.p.zijlstra@chello.nl>, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>, Juri Lelli <juri.lelli@gmail.com>, Ingo Molnar <mingo@kernel.org>, Thomas Gleixner <tglx@linutronix.de>
List-Id: linux-arch.vger.kernel.org

Linus Torvalds <torvalds@linux-foundation.org> writes:

> On Tue, Apr 24, 2012 at 9:10 AM, Peter Zijlstra <a.p.zijlstra@chello.=
nl> wrote:
>> Grow rudimentary u128 support without relying on gcc/libgcc.
>>
>> +#ifndef add_u128
>> +static inline u128 add_u128(u128 a, u128 b)
>> +{
>> + =A0 =A0 =A0 u128 res;
>> +
>> + =A0 =A0 =A0 res.hi =3D a.hi + b.hi;
>> + =A0 =A0 =A0 res.lo =3D a.lo + b.lo;
>> +
>> + =A0 =A0 =A0 if (res.lo < a.lo || res.lo < b.lo)
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 res.hi++;
>
> This is wrong. Or at least stupid.
>
> Just do one of the comparisons, not both. If overflow occurs, the
> result will be smaller than *either* of the added numbers, so
> comparing both is just silly and confused.
>
> So just pick one.
>
> Also, it might be worth looking at code generation, to see if it's
> better to just do
>
>    a.hi +=3D b.hi;
>    a.low +=3D b.low;
>    if (a.low < b.low)
>       a.hi++;
>    return a;

I have no idea if it makes a difference, but that if statement can be
written as a.hi +=3D a.low < b.low.  Just an observation.

> because that might make it clear that there are fewer actual values
> live at any particular time. But gcc may not care. Try it.
>
> Also, for the multiply, please make sure gcc knows to do a "32x32->64=
"
> multiplication, rather than thinking it needs to do full 64x64
> multiplies..

On ARM it does the right thing at least since 4.3, which is the oldest
ARM compiler I have at hand.

--=20
M=E5ns Rullg=E5rd
mans@mansr.com
