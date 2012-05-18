From: "H.J. Lu" <hjl.tools@gmail.com>
Subject: Re: [PATCH 08/10] Use __kernel_ulong_t in struct msqid64_ds
Date: Thu, 17 May 2012 20:47:37 -0700
Message-ID: <CAMe9rOo-g+RomUQziagrGUZKwZJwkQ3uRW0Tk3bH9uaxv5ejbw@mail.gmail.com>
References: <1337292816-10839-1-git-send-email-hjl.tools@gmail.com>
	<1337292816-10839-9-git-send-email-hjl.tools@gmail.com>
	<4FB58EFD.7010302@zytor.com>
	<4FB5C050.9070805@kernel.org>
	<CAMe9rOrKq8Ait8wKudRF535J5c=dDTKekmUN_=HOs5BBLtsoGQ@mail.gmail.com>
	<CAMe9rOprvq3awrunB+HDW=sHb6VNvfB=PGDAP7Fj_NOx3KQU7g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-qc0-f174.google.com ([209.85.216.174]:34067 "EHLO
	mail-qc0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760223Ab2ERDri convert rfc822-to-8bit (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Thu, 17 May 2012 23:47:38 -0400
In-Reply-To: <CAMe9rOprvq3awrunB+HDW=sHb6VNvfB=PGDAP7Fj_NOx3KQU7g@mail.gmail.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: "H. Peter Anvin" <hpa@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, torvalds@linux-foundation.org, mingo@kernel.org, tglx@linutronix.de, Paul Mundt <lethal@linux-sh.org>

On Thu, May 17, 2012 at 8:43 PM, H.J. Lu <hjl.tools@gmail.com> wrote:
> On Thu, May 17, 2012 at 8:39 PM, H.J. Lu <hjl.tools@gmail.com> wrote:
>> On Thu, May 17, 2012 at 8:21 PM, H. Peter Anvin <hpa@kernel.org> wro=
te:
>>> On 05/17/2012 04:51 PM, H. Peter Anvin wrote:
>>>>
>>>> This patch and the one before it seems to have another problem: we
>>>> currently define __BITS_PER_LONG as:
>>>>
>>>> #ifdef __x86_64__
>>>> # define __BITS_PER_LONG 64
>>>> #else
>>>> # define __BITS_PER_LONG 32
>>>> #endif
>>>>
>>>
>>> H.J., do you see any problem *other* than this wretched struct
>>> msqid64_ds with changing the above from __x86_64__ to
>>>
>>> #if defined(__x86_64__) && !defined(__ILP32__)
>>>
>>> ... in the above?
>>>
>>> As far as struct msqid64_ds, =A0I think we can fix it simply becaus=
e x86
>>> is the only compat-aware architecture which has to deal with it.
>>>
>>> (Incidentally, if sh is ever expanded to 64 bits, it will have a pr=
oblem
>>> in the bigendian configuration...)
>>
>> That will be wrong. =A0 __BITS_PER_LONG defines # bits of long
>> as seen by kernel. =A0We don't use it in user space. =A0Remember
>> x32 uses the identical interface as x86-64. =A0So
>>
>> #ifdef __x86_64__
>> # define __BITS_PER_LONG 64
>> #else
>> # define __BITS_PER_LONG 32
>> #endif
>>
>> struct msqid64_ds {
>> =A0 =A0 =A0 =A0struct ipc64_perm msg_perm;
>> =A0 =A0 =A0 =A0__kernel_time_t msg_stime; =A0 =A0 =A0/* last msgsnd =
time */
>> #if __BITS_PER_LONG !=3D 64
>> =A0 =A0 =A0 =A0unsigned long =A0 __unused1;
>> #endif
>> =A0 =A0 =A0 =A0__kernel_time_t msg_rtime; =A0 =A0 =A0/* last msgrcv =
time */
>> #if __BITS_PER_LONG !=3D 64
>> =A0 =A0 =A0 =A0unsigned long =A0 __unused2;
>> #endif
>> =A0 =A0 =A0 =A0__kernel_time_t msg_ctime; =A0 =A0 =A0/* last change =
time */
>> #if __BITS_PER_LONG !=3D 64
>> =A0 =A0 =A0 =A0unsigned long =A0 __unused3;
>> #endif
>>
>> are absolutely correct for x32. =A0You can think
>>
>> #if __BITS_PER_LONG !=3D 64
>>
>> as
>>
>> #ifndef __x86_64__
>>
>> which is used in glibc.
>>
>
> Now I remembered. =A0Here is another patch. =A0Here
>
> #if __BITS_PER_LONG =3D=3D 64
>
> means
>
> #ifdef __x86_64__
>
> Change =A0__BITS_PER_LONG to __BITS_PER_LONG_AS_SEEN_BY_KERNEL
> may avoid this confusion.
>

Or __BITS_PER_NATURAL_WORD.

--=20
H.J.
