From: xinhui <xinhui.pan@linux.vnet.ibm.com>
Subject: Re: [PATCH] locking/qrwlock: fix write unlock issue in big endian
Date: Fri, 03 Jun 2016 15:17:51 +0800
Message-ID: <201606030718.u537FRZs009765@mx0a-001b2d01.pphosted.com>
References: <1464862148-5672-1-git-send-email-xinhui.pan@linux.vnet.ibm.com> <4399273.0kije2Qdx5@wuerfel> <20160602110200.GZ3190@twins.programming.kicks-ass.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:7958 "EHLO
	mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1750923AbcFCHS6 (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Fri, 3 Jun 2016 03:18:58 -0400
Received: from pps.filterd (m0048817.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.11/8.16.0.11) with SMTP id u537FRZs009765
	for <linux-arch@vger.kernel.org>; Fri, 3 Jun 2016 03:18:57 -0400
Received: from e28smtp05.in.ibm.com (e28smtp05.in.ibm.com [125.16.236.5])
	by mx0a-001b2d01.pphosted.com with ESMTP id 23b3aqn1k5-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <linux-arch@vger.kernel.org>; Fri, 03 Jun 2016 03:18:56 -0400
Received: from localhost
	by e28smtp05.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-arch@vger.kernel.org> from <xinhui.pan@linux.vnet.ibm.com>;
	Fri, 3 Jun 2016 12:48:50 +0530
In-Reply-To: <20160602110200.GZ3190@twins.programming.kicks-ass.net>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Peter Zijlstra <peterz@infradead.org>, Arnd Bergmann <arnd@arndb.de>
Cc: linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, waiman.long@hp.com


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
