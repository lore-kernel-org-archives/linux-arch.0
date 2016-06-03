From: xinhui <xinhui.pan@linux.vnet.ibm.com>
Subject: Re: [PATCH] locking/qrwlock: fix write unlock issue in big endian
Date: Fri, 03 Jun 2016 15:17:51 +0800
Message-ID: <201606030718.u537FRan010002@mx0a-001b2d01.pphosted.com>
References: <1464862148-5672-1-git-send-email-xinhui.pan@linux.vnet.ibm.com> <4399273.0kije2Qdx5@wuerfel> <20160602110200.GZ3190@twins.programming.kicks-ass.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20160602110200.GZ3190@twins.programming.kicks-ass.net>
Sender: linux-kernel-owner@vger.kernel.org
To: Peter Zijlstra <peterz@infradead.org>, Arnd Bergmann <arnd@arndb.de>
Cc: linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, waiman.long@hp.com
List-Id: linux-arch.vger.kernel.org


On 2016=E5=B9=B406=E6=9C=8802=E6=97=A5 19:02, Peter Zijlstra wrote:
> On Thu, Jun 02, 2016 at 12:44:51PM +0200, Arnd Bergmann wrote:
>> On Thursday, June 2, 2016 6:09:08 PM CEST Pan Xinhui wrote:
>>> diff --git a/include/asm-generic/qrwlock.h b/include/asm-generic/qr=
wlock.h
>>> index 54a8e65..eadd7a3 100644
>>> --- a/include/asm-generic/qrwlock.h
>>> +++ b/include/asm-generic/qrwlock.h
>>> @@ -139,7 +139,7 @@ static inline void queued_read_unlock(struct qr=
wlock *lock)
>>>    */
>>>   static inline void queued_write_unlock(struct qrwlock *lock)
>>>   {
>>> -       smp_store_release((u8 *)&lock->cnts, 0);
>>> +       (void)atomic_sub_return_release(_QW_LOCKED, &lock->cnts);
>>>   }
>>
>> Isn't this more expensive than the existing version?
>
> Yes, loads. And while this might be a suitable fix for asm-generic, i=
t
> will introduce a fairly large regression on x86 (which is currently t=
he
> only user of this).
>
well, to show respect to struct __qrwlock private field.
We can keep smp_store_release((u8 *)&lock->cnts, 0) in little_endian ma=
chine.
as this should be quick and no performance issue to all other archs(alt=
hough there is only 1 now)

BUT, We need use (void)atomic_sub_return_release(_QW_LOCKED, &lock->cnt=
s) in big_endian machine.
because it's bad to export struct __qrwlock and set its private field t=
o NULL.

How about code like below.

static inline void queued_write_unlock(struct qrwlock *lock)
{
#ifdef __BIG_ENDIAN
         (void)atomic_sub_return_release(_QW_LOCKED, &lock->cnts);
#else
	smp_store_release((u8 *)&lock->cnts, 0);
#endif
}

BUT I think that would make thing a little complex to understand. :(
So at last, in my opinion, I suggest my patch :)
any thoughts?

thanks
xinhui



 =20
