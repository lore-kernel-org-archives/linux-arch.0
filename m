Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:49081 "EHLO
	mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1752221AbcFOJ2e (ORCPT
	<rfc822;linux-arch@vger.kernel.org>);
	Wed, 15 Jun 2016 05:28:34 -0400
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.11/8.16.0.11) with SMTP id u5F9OFUT031173
	for <linux-arch@vger.kernel.org>; Wed, 15 Jun 2016 05:28:33 -0400
Received: from e23smtp03.au.ibm.com (e23smtp03.au.ibm.com [202.81.31.145])
	by mx0a-001b2d01.pphosted.com with ESMTP id 23je2m8shn-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <linux-arch@vger.kernel.org>; Wed, 15 Jun 2016 05:28:33 -0400
Received: from localhost
	by e23smtp03.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-arch@vger.kernel.org> from <xinhui.pan@linux.vnet.ibm.com>;
	Wed, 15 Jun 2016 19:28:30 +1000
Date: Wed, 15 Jun 2016 17:28:17 +0800
From: xinhui <xinhui.pan@linux.vnet.ibm.com>
MIME-Version: 1.0
Subject: Re: [PATCH] locking/qrwlock: Let qrwlock has same layout regardless
 of the endian
References: <1465982177-2949-1-git-send-email-xinhui.pan@linux.vnet.ibm.com> <20160615092051.GC24029@arm.com>
In-Reply-To: <20160615092051.GC24029@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Message-ID: <57611FB1.8050205@linux.vnet.ibm.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Will Deacon <will.deacon@arm.com>
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, ingo@redhat.com, peterz@infradead.org, arnd@arndb.de, Waiman.Long@hpe.com
Message-ID: <20160615092817.W_8_D_V5yb-ZMDzAOGFuOCEspPN5dXQu71XZJaq9Gdc@z>



On 2016年06月15日 17:20, Will Deacon wrote:
> On Wed, Jun 15, 2016 at 05:16:17PM +0800, Pan Xinhui wrote:
>> This patch aims to get rid of endianness in queued_write_unlock(). We
>> want to set  __qrwlock->wmode to NULL, however the address is not
>> &lock->cnts in big endian machine. That causes queued_write_unlock()
>> write NULL to the wrong field of __qrwlock.
>>
>> Actually qrwlock can have same layout, IOW we can remove the #if
>> __little_endian in struct __qrwlock. With such modification, we only
>> need define some _QW* and _QR* with corresponding values in different
>> endian systems.
>>
>> Suggested-by: Will Deacon <will.deacon@arm.com>
>> Signed-off-by: Pan Xinhui <xinhui.pan@linux.vnet.ibm.com>
>> ---
>>   include/asm-generic/qrwlock.h | 15 +++++++++++----
>>   kernel/locking/qrwlock.c      | 10 ++++------
>>   2 files changed, 15 insertions(+), 10 deletions(-)
>>
>> diff --git a/include/asm-generic/qrwlock.h b/include/asm-generic/qrwlock.h
>> index 54a8e65..b135c11 100644
>> --- a/include/asm-generic/qrwlock.h
>> +++ b/include/asm-generic/qrwlock.h
>> @@ -27,11 +27,18 @@
>>   /*
>>    * Writer states & reader shift and bias
>>    */
>> -#define	_QW_WAITING	1		/* A writer is waiting	   */
>> -#define	_QW_LOCKED	0xff		/* A writer holds the lock */
>> -#define	_QW_WMASK	0xff		/* Writer mask		   */
>> +#ifdef	__LITTLE_ENDIAN
>>   #define	_QR_SHIFT	8		/* Reader count shift	   */
>> -#define _QR_BIAS	(1U << _QR_SHIFT)
>> +#define	_QW_SHIFF	0		/* Writer mode shift	*/
>
> Well, there are other typos that could've been worse, but you probably
> want to fix this...
>
oh... I am really in rush. sorry. will fix it and seed patch v2 soon.

thank you for pointing it out.

> Will
>

