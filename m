From: Waiman Long <waiman.long@hpe.com>
Subject: Re: [PATCH] locking/qrwlock: fix write unlock issue in big endian
Date: Fri, 3 Jun 2016 16:57:55 -0400
Message-ID: <5751EF53.3080205@hpe.com>
References: <1464862148-5672-1-git-send-email-xinhui.pan@linux.vnet.ibm.com> <4399273.0kije2Qdx5@wuerfel> <20160602110200.GZ3190@twins.programming.kicks-ass.net> <201606030718.u537FQg0009963@mx0a-001b2d01.pphosted.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <201606030718.u537FQg0009963@mx0a-001b2d01.pphosted.com>
Sender: linux-kernel-owner@vger.kernel.org
To: xinhui <xinhui.pan@linux.vnet.ibm.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Arnd Bergmann <arnd@arndb.de>, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, waiman.long@hp.com
List-Id: linux-arch.vger.kernel.org

On 06/03/2016 03:17 AM, xinhui wrote:
>
> On 2016=E5=B9=B406=E6=9C=8802=E6=97=A5 19:02, Peter Zijlstra wrote:
>> On Thu, Jun 02, 2016 at 12:44:51PM +0200, Arnd Bergmann wrote:
>>> On Thursday, June 2, 2016 6:09:08 PM CEST Pan Xinhui wrote:
>>>> diff --git a/include/asm-generic/qrwlock.h=20
>>>> b/include/asm-generic/qrwlock.h
>>>> index 54a8e65..eadd7a3 100644
>>>> --- a/include/asm-generic/qrwlock.h
>>>> +++ b/include/asm-generic/qrwlock.h
>>>> @@ -139,7 +139,7 @@ static inline void queued_read_unlock(struct=20
>>>> qrwlock *lock)
>>>>    */
>>>>   static inline void queued_write_unlock(struct qrwlock *lock)
>>>>   {
>>>> -       smp_store_release((u8 *)&lock->cnts, 0);
>>>> +       (void)atomic_sub_return_release(_QW_LOCKED, &lock->cnts);
>>>>   }
>>>
>>> Isn't this more expensive than the existing version?
>>
>> Yes, loads. And while this might be a suitable fix for asm-generic, =
it
>> will introduce a fairly large regression on x86 (which is currently =
the
>> only user of this).
>>
> well, to show respect to struct __qrwlock private field.
> We can keep smp_store_release((u8 *)&lock->cnts, 0) in little_endian=20
> machine.
> as this should be quick and no performance issue to all other=20
> archs(although there is only 1 now)
>
> BUT, We need use (void)atomic_sub_return_release(_QW_LOCKED,=20
> &lock->cnts) in big_endian machine.
> because it's bad to export struct __qrwlock and set its private field=
=20
> to NULL.
>
> How about code like below.
>
> static inline void queued_write_unlock(struct qrwlock *lock)
> {
> #ifdef __BIG_ENDIAN
>         (void)atomic_sub_return_release(_QW_LOCKED, &lock->cnts);
> #else
>     smp_store_release((u8 *)&lock->cnts, 0);
> #endif
> }
>
> BUT I think that would make thing a little complex to understand. :(
> So at last, in my opinion, I suggest my patch :)
> any thoughts?

Another alternative is to make queued_write_unlock() overrideable from=20
asm/qrwlock.h, just like what we did with queued_spin_unlock().

Cheers,
Longman
