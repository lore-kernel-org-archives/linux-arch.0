From: Nicholas Piggin <npiggin@gmail.com>
Subject: Re: [PATCH v2] powerpc: select ARCH_HAS_MEMBARRIER_SYNC_CORE
Date: Thu, 16 Jul 2020 10:57:50 +1000
Message-ID: <1594860978.y7ksqnxc5n.astroid@bobo.none>
References: <20200715094829.252208-1-npiggin@gmail.com>
        <849841781.14062.1594816035327.JavaMail.zimbra@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726479AbgGPA6A (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 15 Jul 2020 20:58:00 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0D03C061755
        for <linux-arch@vger.kernel.org>; Wed, 15 Jul 2020 17:57:59 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id k6so5061233wrn.3
        for <linux-arch@vger.kernel.org>; Wed, 15 Jul 2020 17:57:59 -0700 (PDT)
In-Reply-To: <849841781.14062.1594816035327.JavaMail.zimbra@efficios.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: Christophe Leroy <christophe.leroy@csgroup.eu>, linux-arch <linux-arch@vger.kernel.org>, linuxppc-dev <linuxppc-dev@lists.ozlabs.org>, Andy Lutomirski <luto@kernel.org>, Peter Zijlstra <peterz@infradead.org>

Excerpts from Mathieu Desnoyers's message of July 15, 2020 10:27 pm:
> ----- On Jul 15, 2020, at 5:48 AM, Nicholas Piggin npiggin@gmail.com wrot=
e:
> [...]
>> index 47bd4ea0837d..a4704f405e8d 100644
>> --- a/arch/powerpc/include/asm/exception-64s.h
>> +++ b/arch/powerpc/include/asm/exception-64s.h
>> @@ -68,6 +68,13 @@
>>  *
>>  * The nop instructions allow us to insert one or more instructions to f=
lush the
>>  * L1-D cache when returning to userspace or a guest.
>> + *
>> + * powerpc relies on return from interrupt/syscall being context synchr=
onising
>> + * (which hrfid, rfid, and rfscv are) to support ARCH_HAS_MEMBARRIER_SY=
NC_CORE
>> + * without additional additional synchronisation instructions. soft-mas=
ked
>> + * interrupt replay does not include a context-synchronising rfid, but =
those
>> + * always return to kernel, the context sync is only required for IPIs =
which
>> + * return to user.
>>  */
>> #define RFI_FLUSH_SLOT							\
>> 	RFI_FLUSH_FIXUP_SECTION;					\
>=20
> I suspect the statement "the context sync is only required for IPIs which=
 return to
> user." is misleading.
>=20
> As I recall that we need more than just context sync after IPI. We need c=
ontext sync
> in return path of any trap/interrupt/system call which returns to user-sp=
ace, else
> we'd need to add the proper core serializing barriers in the scheduler, a=
s we had
> to do for lazy tlb on x86.
>=20
> Or am I missing something ?

Maybe ambiguous wording. For IPIs, the context synch is only required=20
for those which return to user. Other things also require context sync.

I will try to improve it.

Thanks,
Nick
