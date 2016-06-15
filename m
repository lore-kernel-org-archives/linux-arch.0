From: xinhui <xinhui.pan@linux.vnet.ibm.com>
Subject: Re: [PATCH] locking/qrwlock: Let qrwlock has same layout regardless
 of the endian
Date: Wed, 15 Jun 2016 17:28:17 +0800
Message-ID: <57611FB1.8050205@linux.vnet.ibm.com>
References: <1465982177-2949-1-git-send-email-xinhui.pan@linux.vnet.ibm.com> <20160615092051.GC24029@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20160615092051.GC24029@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Will Deacon <will.deacon@arm.com>
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, ingo@redhat.com, peterz@infradead.org, arnd@arndb.de, Waiman.Long@hpe.com
List-Id: linux-arch.vger.kernel.org



On 2016=E5=B9=B406=E6=9C=8815=E6=97=A5 17:20, Will Deacon wrote:
> On Wed, Jun 15, 2016 at 05:16:17PM +0800, Pan Xinhui wrote:
>> This patch aims to get rid of endianness in queued_write_unlock(). W=
e
>> want to set  __qrwlock->wmode to NULL, however the address is not
>> &lock->cnts in big endian machine. That causes queued_write_unlock()
>> write NULL to the wrong field of __qrwlock.
>>
>> Actually qrwlock can have same layout, IOW we can remove the #if
>> __little_endian in struct __qrwlock. With such modification, we only
>> need define some _QW* and _QR* with corresponding values in differen=
t
>> endian systems.
>>
>> Suggested-by: Will Deacon <will.deacon@arm.com>
>> Signed-off-by: Pan Xinhui <xinhui.pan@linux.vnet.ibm.com>
>> ---
>>   include/asm-generic/qrwlock.h | 15 +++++++++++----
>>   kernel/locking/qrwlock.c      | 10 ++++------
>>   2 files changed, 15 insertions(+), 10 deletions(-)
>>
>> diff --git a/include/asm-generic/qrwlock.h b/include/asm-generic/qrw=
lock.h
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
> Well, there are other typos that could've been worse, but you probabl=
y
> want to fix this...
>
oh... I am really in rush. sorry. will fix it and seed patch v2 soon.

thank you for pointing it out.

> Will
>
