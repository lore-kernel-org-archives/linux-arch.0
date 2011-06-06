From: Mike Frysinger <vapier@gentoo.org>
Subject: Re: [uclinux-dist-devel] [PATCH/RFC] asm-generic/mutex-dec.h: add SMP support
Date: Mon, 6 Jun 2011 18:33:44 -0400
Message-ID: <BANLkTimRpcygQT-M1PJNOQCeeR46j8Vw+g@mail.gmail.com>
References: <1306725568-10922-1-git-send-email-vapier@gentoo.org>
 <20110606142301.c0a570da.akpm@linux-foundation.org> <BANLkTikq5-a8a5A4iq=3Br-m+PhuKYSePA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-fx0-f46.google.com ([209.85.161.46]:32913 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756634Ab1FFWeG convert rfc822-to-8bit (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Mon, 6 Jun 2011 18:34:06 -0400
In-Reply-To: <BANLkTikq5-a8a5A4iq=3Br-m+PhuKYSePA@mail.gmail.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-arch@vger.kernel.org, Piggin <npiggin@kernel.dk>, Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org, Nick@blackfin.uclinux.org, uclinux-dist-devel@blackfin.uclinux.org

On Mon, Jun 6, 2011 at 17:31, Mike Frysinger wrote:
> On Mon, Jun 6, 2011 at 17:23, Andrew Morton wrote:
>> On Sun, 29 May 2011 23:19:28 -0400 Mike Frysinger wrote:
>>> To make these guys work on SMP systems, we just need to sprinkle a =
few
>>> barriers around.
>>>
>>> diff --git a/include/asm-generic/mutex-dec.h b/include/asm-generic/=
mutex-dec.h
>>> index f104af7..e746c3c 100644
>>> --- a/include/asm-generic/mutex-dec.h
>>> +++ b/include/asm-generic/mutex-dec.h
>>> @@ -22,6 +22,8 @@ __mutex_fastpath_lock(atomic_t *count, void (*fai=
l_fn)(atomic_t *))
>>> =C2=A0{
>>> =C2=A0 =C2=A0 =C2=A0 if (unlikely(atomic_dec_return(count) < 0))
>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 fail_fn(count);
>>> + =C2=A0 =C2=A0 else
>>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 smp_mb();
>>> =C2=A0}
>>>
>>> =C2=A0/**
>>> @@ -39,6 +41,7 @@ __mutex_fastpath_lock_retval(atomic_t *count, int=
 (*fail_fn)(atomic_t *))
>>> =C2=A0{
>>> =C2=A0 =C2=A0 =C2=A0 if (unlikely(atomic_dec_return(count) < 0))
>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return fail_fn(cou=
nt);
>>> + =C2=A0 =C2=A0 smp_mb();
>>> =C2=A0 =C2=A0 =C2=A0 return 0;
>>> =C2=A0}
>>>
>>> @@ -58,6 +61,7 @@ __mutex_fastpath_lock_retval(atomic_t *count, int=
 (*fail_fn)(atomic_t *))
>>> =C2=A0static inline void
>>> =C2=A0__mutex_fastpath_unlock(atomic_t *count, void (*fail_fn)(atom=
ic_t *))
>>> =C2=A0{
>>> + =C2=A0 =C2=A0 smp_mb();
>>> =C2=A0 =C2=A0 =C2=A0 if (unlikely(atomic_inc_return(count) <=3D 0))
>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 fail_fn(count);
>>> =C2=A0}
>>> @@ -82,8 +86,10 @@ __mutex_fastpath_unlock(atomic_t *count, void (*=
fail_fn)(atomic_t *))
>>> =C2=A0static inline int
>>> =C2=A0__mutex_fastpath_trylock(atomic_t *count, int (*fail_fn)(atom=
ic_t *))
>>> =C2=A0{
>>> - =C2=A0 =C2=A0 if (likely(atomic_cmpxchg(count, 1, 0) =3D=3D 1))
>>> + =C2=A0 =C2=A0 if (likely(atomic_cmpxchg(count, 1, 0) =3D=3D 1)) {
>>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 smp_mb();
>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return 1;
>>> + =C2=A0 =C2=A0 }
>>> =C2=A0 =C2=A0 =C2=A0 return 0;
>>> =C2=A0}
>>
>> This patch basically reverts Nick's a8ddac7e53e89cb ("mutex: speed u=
p
>> generic mutex implementations"). =C2=A0What's up with that?
>>
>> I could try to review this patch but I'm pathetic with barriers. =C2=
=A0Help.
>
> thanks for that tip. =C2=A0i think we can chalk this patch up to the
> origins of the Blackfin SMP port ... it branched this code before
> Nick's patch, and never incorporated common changes back. =C2=A0so i'=
ll
> just drop it once i boot up a system to double check and convert the
> Blackfin code over to the asm-generic version completely to avoid
> future issues.

seems to be ok (and our core atomic's do include barriers themselves),
so let's just drop this patch on the floor and forget about it.
thanks all!
-mike
