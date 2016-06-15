From: xinhui <xinhui.pan@linux.vnet.ibm.com>
Subject: Re: [PATCH] locking/qrwlock: fix write unlock issue in big endian
Date: Wed, 15 Jun 2016 11:47:21 +0800
Message-ID: <5760CFC9.6020006@linux.vnet.ibm.com>
References: <1464862148-5672-1-git-send-email-xinhui.pan@linux.vnet.ibm.com> <20160608092244.GA27029@arm.com> <575FA024.7060608@linux.vnet.ibm.com> <20160614104032.GE19407@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20160614104032.GE19407@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Will Deacon <will.deacon@arm.com>
Cc: linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, arnd@arndb.de, waiman.long@hp.com, peterz@infradead.org
List-Id: linux-arch.vger.kernel.org



On 2016=E5=B9=B406=E6=9C=8814=E6=97=A5 18:40, Will Deacon wrote:
> On Tue, Jun 14, 2016 at 02:11:48PM +0800, xinhui wrote:
>>
>> On 2016=E5=B9=B406=E6=9C=8808=E6=97=A5 17:22, Will Deacon wrote:
>>> On Thu, Jun 02, 2016 at 06:09:08PM +0800, Pan Xinhui wrote:
>>>> strcut __qrwlock has different layout in big endian machine. we ne=
ed set
>>>> the __qrwlock->wmode to NULL, and the address is not &lock->cnts i=
n big
>>>> endian machine.
>>>>
>>>> Do as what read unlock does. we are lucky that the __qrwlock->wmod=
e's
>>>> val is _QW_LOCKED.
>>>
>>> Doesn't this have wider implications for the qrwlocks, for example:
>>>
>>>    while ((cnts & _QW_WMASK) =3D=3D _QW_LOCKED) { ... }
>>>
>>> would actually end up looking at the wrong field of the lock?
>>>
>> I does not clearly understand your idea. :(
>
> That's because I'm talking rubbish :) Sorry, I completely confused my=
self.
> Locking is bad enough on its own, but add big-endian to the mix and I=
'm
> all done.
>
>>> Shouldn't we just remove the #ifdef __LITTLE_ENDIAN stuff from __qr=
wlock,
>>> given that all the struct members are u8?
>>>
>> No. that makes codes complex. for example
>>
>> struct __qrwlock lock;
>>
>> WRITE_ONCE(lock->wmode, _QW_WAITING);
>> if (atomic_(&lock->cnts) =3D=3D _QW_WAITING) {
>> 	do_something();
>> }
>>
>> IF you remove the  #ifdef __LITTLE_ENDIAN stuff from __qrwlock.
>> codes above obviously will break. And we already have such code.
>
> I was wondering more along the lines of having one definition of the =
data
> structure, but then defining _QW_* differently depending on endiannes=
s
> (i.e. add a << 24 when big-endian). That way queued_write_unlock can
make sense. And I review all the code, there is not much code to be cha=
nged.
I will work out one patch based on your idea :)

> stay like it is (having an arch override to handle the big-endian cas=
e
> is incredibly ugly).
>
I admit that. HOWEVER from the view of performance, having an arch over=
ride is acceptable.

thanks
xinhui
> Will
>
