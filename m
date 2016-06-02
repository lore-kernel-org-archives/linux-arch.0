From: xinhui <xinhui.pan@linux.vnet.ibm.com>
Subject: Re: [PATCH] locking/qrwlock: fix write unlock issue in big endian
Date: Thu, 02 Jun 2016 19:01:17 +0800
Message-ID: <575011FD.4070109@linux.vnet.ibm.com>
References: <1464862148-5672-1-git-send-email-xinhui.pan@linux.vnet.ibm.com> <4399273.0kije2Qdx5@wuerfel>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <4399273.0kije2Qdx5@wuerfel>
Sender: linux-kernel-owner@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, waiman.long@hp.com, peterz@infradead.org
List-Id: linux-arch.vger.kernel.org


On 2016=E5=B9=B406=E6=9C=8802=E6=97=A5 18:44, Arnd Bergmann wrote:
> On Thursday, June 2, 2016 6:09:08 PM CEST Pan Xinhui wrote:
>> diff --git a/include/asm-generic/qrwlock.h b/include/asm-generic/qrw=
lock.h
>> index 54a8e65..eadd7a3 100644
>> --- a/include/asm-generic/qrwlock.h
>> +++ b/include/asm-generic/qrwlock.h
>> @@ -139,7 +139,7 @@ static inline void queued_read_unlock(struct qrw=
lock *lock)
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
But does this is generic code, I am not sure how it will impact the per=
formance on other archs.

If you like
we calculate the correct address to set to NULL
say,
static inline void queued_write_unlock(struct qrwlock *lock)
{
u8 *wl =3D lock;

#ifdef __BIG_ENDIAN
wl +=3D 3;
#endif
smp_store_release(wl, 0);

}



> 	Arnd
>
