From: xinhui <xinhui.pan@linux.vnet.ibm.com>
Subject: Re: [PATCH] locking/qrwlock: fix write unlock issue in big endian
Date: Fri, 03 Jun 2016 15:20:53 +0800
Message-ID: <57512FD5.5020301@linux.vnet.ibm.com>
References: <1464862148-5672-1-git-send-email-xinhui.pan@linux.vnet.ibm.com> <4399273.0kije2Qdx5@wuerfel> <575011FD.4070109@linux.vnet.ibm.com> <20160602111505.GB3190@twins.programming.kicks-ass.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:38951 "EHLO
	mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1751082AbcFCHWT (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Fri, 3 Jun 2016 03:22:19 -0400
Received: from pps.filterd (m0049461.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.11/8.16.0.11) with SMTP id u537KPh9024938
	for <linux-arch@vger.kernel.org>; Fri, 3 Jun 2016 03:22:18 -0400
Received: from e23smtp08.au.ibm.com (e23smtp08.au.ibm.com [202.81.31.141])
	by mx0a-001b2d01.pphosted.com with ESMTP id 23b3njcd8s-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <linux-arch@vger.kernel.org>; Fri, 03 Jun 2016 03:22:17 -0400
Received: from localhost
	by e23smtp08.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-arch@vger.kernel.org> from <xinhui.pan@linux.vnet.ibm.com>;
	Fri, 3 Jun 2016 17:22:14 +1000
In-Reply-To: <20160602111505.GB3190@twins.programming.kicks-ass.net>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Peter Zijlstra <peterz@infradead.org>
Cc: Arnd Bergmann <arnd@arndb.de>, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, waiman.long@hp.com



On 2016=E5=B9=B406=E6=9C=8802=E6=97=A5 19:15, Peter Zijlstra wrote:
> On Thu, Jun 02, 2016 at 07:01:17PM +0800, xinhui wrote:
>>
>> On 2016=E5=B9=B406=E6=9C=8802=E6=97=A5 18:44, Arnd Bergmann wrote:
>>> On Thursday, June 2, 2016 6:09:08 PM CEST Pan Xinhui wrote:
>>>> diff --git a/include/asm-generic/qrwlock.h b/include/asm-generic/q=
rwlock.h
>>>> index 54a8e65..eadd7a3 100644
>>>> --- a/include/asm-generic/qrwlock.h
>>>> +++ b/include/asm-generic/qrwlock.h
>>>> @@ -139,7 +139,7 @@ static inline void queued_read_unlock(struct q=
rwlock *lock)
>>>>    */
>>>>   static inline void queued_write_unlock(struct qrwlock *lock)
>>>>   {
>>>> -       smp_store_release((u8 *)&lock->cnts, 0);
>>>> +       (void)atomic_sub_return_release(_QW_LOCKED, &lock->cnts);
>>>>   }
>>>
>>> Isn't this more expensive than the existing version?
>>>
>> yes, a little more expensive than the existing version
>
> Think 20+ cycles worse.
>
>> But does this is generic code, I am not sure how it will impact the =
performance on other archs.
>
> As always, you get to audit users of stuff you change. And here you'r=
e
> lucky, there's only 1.
>
yes, and hope there will be 2 :)

>> If you like
>> we calculate the correct address to set to NULL
>> say,
>> static inline void queued_write_unlock(struct qrwlock *lock)
>> {
>> u8 *wl =3D lock;
>>
>> #ifdef __BIG_ENDIAN
>> wl +=3D 3;
>> #endif
>> smp_store_release(wl, 0);
>>
>> }
>
> No, that's horrible. Either lift __qrwlock into qrwlock_types.h or do
> what qspinlock does. And looking at that, we could make
agree.

> queued_spin_unlock() use the atomic_sub_return_relaxed() thing too I
> suppose, that generates slightly better code.
>
thanks for your suggestion.
I can have a try in queued_spin_unlock().
