From: Mike Frysinger <vapier@gentoo.org>
Subject: Re: [uclinux-dist-devel] [PATCH/RFC] asm-generic/mutex-dec.h: add SMP support
Date: Mon, 6 Jun 2011 17:31:08 -0400
Message-ID: <BANLkTikq5-a8a5A4iq=3Br-m+PhuKYSePA@mail.gmail.com>
References: <1306725568-10922-1-git-send-email-vapier@gentoo.org> <20110606142301.c0a570da.akpm@linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-fx0-f46.google.com ([209.85.161.46]:64632 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750919Ab1FFVba convert rfc822-to-8bit (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Mon, 6 Jun 2011 17:31:30 -0400
In-Reply-To: <20110606142301.c0a570da.akpm@linux-foundation.org>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-arch@vger.kernel.org, Piggin <npiggin@kernel.dk>, Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org, Nick@blackfin.uclinux.org, uclinux-dist-devel@blackfin.uclinux.org

On Mon, Jun 6, 2011 at 17:23, Andrew Morton wrote:
> On Sun, 29 May 2011 23:19:28 -0400 Mike Frysinger wrote:
>> To make these guys work on SMP systems, we just need to sprinkle a f=
ew
>> barriers around.
>>
>> diff --git a/include/asm-generic/mutex-dec.h b/include/asm-generic/m=
utex-dec.h
>> index f104af7..e746c3c 100644
>> --- a/include/asm-generic/mutex-dec.h
>> +++ b/include/asm-generic/mutex-dec.h
>> @@ -22,6 +22,8 @@ __mutex_fastpath_lock(atomic_t *count, void (*fail=
_fn)(atomic_t *))
>> =C2=A0{
>> =C2=A0 =C2=A0 =C2=A0 if (unlikely(atomic_dec_return(count) < 0))
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 fail_fn(count);
>> + =C2=A0 =C2=A0 else
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 smp_mb();
>> =C2=A0}
>>
>> =C2=A0/**
>> @@ -39,6 +41,7 @@ __mutex_fastpath_lock_retval(atomic_t *count, int =
(*fail_fn)(atomic_t *))
>> =C2=A0{
>> =C2=A0 =C2=A0 =C2=A0 if (unlikely(atomic_dec_return(count) < 0))
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return fail_fn(coun=
t);
>> + =C2=A0 =C2=A0 smp_mb();
>> =C2=A0 =C2=A0 =C2=A0 return 0;
>> =C2=A0}
>>
>> @@ -58,6 +61,7 @@ __mutex_fastpath_lock_retval(atomic_t *count, int =
(*fail_fn)(atomic_t *))
>> =C2=A0static inline void
>> =C2=A0__mutex_fastpath_unlock(atomic_t *count, void (*fail_fn)(atomi=
c_t *))
>> =C2=A0{
>> + =C2=A0 =C2=A0 smp_mb();
>> =C2=A0 =C2=A0 =C2=A0 if (unlikely(atomic_inc_return(count) <=3D 0))
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 fail_fn(count);
>> =C2=A0}
>> @@ -82,8 +86,10 @@ __mutex_fastpath_unlock(atomic_t *count, void (*f=
ail_fn)(atomic_t *))
>> =C2=A0static inline int
>> =C2=A0__mutex_fastpath_trylock(atomic_t *count, int (*fail_fn)(atomi=
c_t *))
>> =C2=A0{
>> - =C2=A0 =C2=A0 if (likely(atomic_cmpxchg(count, 1, 0) =3D=3D 1))
>> + =C2=A0 =C2=A0 if (likely(atomic_cmpxchg(count, 1, 0) =3D=3D 1)) {
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 smp_mb();
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return 1;
>> + =C2=A0 =C2=A0 }
>> =C2=A0 =C2=A0 =C2=A0 return 0;
>> =C2=A0}
>
> This patch basically reverts Nick's a8ddac7e53e89cb ("mutex: speed up
> generic mutex implementations"). =C2=A0What's up with that?
>
> I could try to review this patch but I'm pathetic with barriers. =C2=A0=
Help.

thanks for that tip.  i think we can chalk this patch up to the
origins of the Blackfin SMP port ... it branched this code before
Nick's patch, and never incorporated common changes back.  so i'll
just drop it once i boot up a system to double check and convert the
Blackfin code over to the asm-generic version completely to avoid
future issues.
-mike
