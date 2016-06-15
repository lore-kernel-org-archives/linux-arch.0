Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:58767 "EHLO
	mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751212AbcFODrg (ORCPT
	<rfc822;linux-arch@vger.kernel.org>);
	Tue, 14 Jun 2016 23:47:36 -0400
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.11/8.16.0.11) with SMTP id u5F3iWg3119595
	for <linux-arch@vger.kernel.org>; Tue, 14 Jun 2016 23:47:36 -0400
Received: from e23smtp09.au.ibm.com (e23smtp09.au.ibm.com [202.81.31.142])
	by mx0a-001b2d01.pphosted.com with ESMTP id 23jfksudus-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <linux-arch@vger.kernel.org>; Tue, 14 Jun 2016 23:47:35 -0400
Received: from localhost
	by e23smtp09.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-arch@vger.kernel.org> from <xinhui.pan@linux.vnet.ibm.com>;
	Wed, 15 Jun 2016 13:47:33 +1000
Date: Wed, 15 Jun 2016 11:47:21 +0800
From: xinhui <xinhui.pan@linux.vnet.ibm.com>
MIME-Version: 1.0
Subject: Re: [PATCH] locking/qrwlock: fix write unlock issue in big endian
References: <1464862148-5672-1-git-send-email-xinhui.pan@linux.vnet.ibm.com> <20160608092244.GA27029@arm.com> <575FA024.7060608@linux.vnet.ibm.com> <20160614104032.GE19407@arm.com>
In-Reply-To: <20160614104032.GE19407@arm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Message-ID: <5760CFC9.6020006@linux.vnet.ibm.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Will Deacon <will.deacon@arm.com>
Cc: linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, arnd@arndb.de, waiman.long@hp.com, peterz@infradead.org
Message-ID: <20160615034721.DTmqV_vlQC7Kr_Qe71oW_x18jdPrY34S7LC3fxSAQvQ@z>



On 2016年06月14日 18:40, Will Deacon wrote:
> On Tue, Jun 14, 2016 at 02:11:48PM +0800, xinhui wrote:
>>
>> On 2016年06月08日 17:22, Will Deacon wrote:
>>> On Thu, Jun 02, 2016 at 06:09:08PM +0800, Pan Xinhui wrote:
>>>> strcut __qrwlock has different layout in big endian machine. we need set
>>>> the __qrwlock->wmode to NULL, and the address is not &lock->cnts in big
>>>> endian machine.
>>>>
>>>> Do as what read unlock does. we are lucky that the __qrwlock->wmode's
>>>> val is _QW_LOCKED.
>>>
>>> Doesn't this have wider implications for the qrwlocks, for example:
>>>
>>>    while ((cnts & _QW_WMASK) == _QW_LOCKED) { ... }
>>>
>>> would actually end up looking at the wrong field of the lock?
>>>
>> I does not clearly understand your idea. :(
>
> That's because I'm talking rubbish :) Sorry, I completely confused myself.
> Locking is bad enough on its own, but add big-endian to the mix and I'm
> all done.
>
>>> Shouldn't we just remove the #ifdef __LITTLE_ENDIAN stuff from __qrwlock,
>>> given that all the struct members are u8?
>>>
>> No. that makes codes complex. for example
>>
>> struct __qrwlock lock;
>>
>> WRITE_ONCE(lock->wmode, _QW_WAITING);
>> if (atomic_(&lock->cnts) == _QW_WAITING) {
>> 	do_something();
>> }
>>
>> IF you remove the  #ifdef __LITTLE_ENDIAN stuff from __qrwlock.
>> codes above obviously will break. And we already have such code.
>
> I was wondering more along the lines of having one definition of the data
> structure, but then defining _QW_* differently depending on endianness
> (i.e. add a << 24 when big-endian). That way queued_write_unlock can
make sense. And I review all the code, there is not much code to be changed.
I will work out one patch based on your idea :)

> stay like it is (having an arch override to handle the big-endian case
> is incredibly ugly).
>
I admit that. HOWEVER from the view of performance, having an arch override is acceptable.

thanks
xinhui
> Will
>

