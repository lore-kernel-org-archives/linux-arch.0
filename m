Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:49855 "EHLO
	mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S932567AbcFBLCW (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Thu, 2 Jun 2016 07:02:22 -0400
Received: from pps.filterd (m0075420.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.11/8.16.0.11) with SMTP id u52B0ZTk006806
	for <linux-arch@vger.kernel.org>; Thu, 2 Jun 2016 07:02:21 -0400
Received: from e23smtp09.au.ibm.com (e23smtp09.au.ibm.com [202.81.31.142])
	by mx0a-001b2d01.pphosted.com with ESMTP id 23abqecqbw-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <linux-arch@vger.kernel.org>; Thu, 02 Jun 2016 07:02:20 -0400
Received: from localhost
	by e23smtp09.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-arch@vger.kernel.org> from <xinhui.pan@linux.vnet.ibm.com>;
	Thu, 2 Jun 2016 21:02:17 +1000
Date: Thu, 02 Jun 2016 19:01:17 +0800
From: xinhui <xinhui.pan@linux.vnet.ibm.com>
MIME-Version: 1.0
Subject: Re: [PATCH] locking/qrwlock: fix write unlock issue in big endian
References: <1464862148-5672-1-git-send-email-xinhui.pan@linux.vnet.ibm.com> <4399273.0kije2Qdx5@wuerfel>
In-Reply-To: <4399273.0kije2Qdx5@wuerfel>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Message-ID: <575011FD.4070109@linux.vnet.ibm.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Arnd Bergmann <arnd@arndb.de>
Cc: linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, waiman.long@hp.com, peterz@infradead.org
Message-ID: <20160602110117.98JzyxA1bYgoxXw8dogGJENFiD8Ey5kj_Rwn6OaIDXI@z>


On 2016年06月02日 18:44, Arnd Bergmann wrote:
> On Thursday, June 2, 2016 6:09:08 PM CEST Pan Xinhui wrote:
>> diff --git a/include/asm-generic/qrwlock.h b/include/asm-generic/qrwlock.h
>> index 54a8e65..eadd7a3 100644
>> --- a/include/asm-generic/qrwlock.h
>> +++ b/include/asm-generic/qrwlock.h
>> @@ -139,7 +139,7 @@ static inline void queued_read_unlock(struct qrwlock *lock)
>>    */
>>   static inline void queued_write_unlock(struct qrwlock *lock)
>>   {
>> -       smp_store_release((u8 *)&lock->cnts, 0);
>> +       (void)atomic_sub_return_release(_QW_LOCKED, &lock->cnts);
>>   }
>
> Isn't this more expensive than the existing version?
>
yes, a little more expensive than the existing version
But does this is generic code, I am not sure how it will impact the performance on other archs.

If you like
we calculate the correct address to set to NULL
say,
static inline void queued_write_unlock(struct qrwlock *lock)
{
u8 *wl = lock;

#ifdef __BIG_ENDIAN
wl += 3;
#endif
smp_store_release(wl, 0);

}



> 	Arnd
>

