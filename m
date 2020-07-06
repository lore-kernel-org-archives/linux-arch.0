From: Nicholas Piggin <npiggin@gmail.com>
Subject: Re: [RFC PATCH 4/5] powerpc/mm: Remove custom stack expansion
 checking
Date: Mon, 06 Jul 2020 11:15:22 +1000
Message-ID: <1593997323.8pwn48yz8u.astroid@bobo.none>
References: <20200703141327.1732550-1-mpe@ellerman.id.au>
        <20200703141327.1732550-4-mpe@ellerman.id.au>
        <fb3aad5f-17a1-93cc-1a3a-c50fe16ab711@csgroup.eu>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728280AbgGFBP2 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sun, 5 Jul 2020 21:15:28 -0400
In-Reply-To: <fb3aad5f-17a1-93cc-1a3a-c50fe16ab711@csgroup.eu>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Christophe Leroy <christophe.leroy@csgroup.eu>, linuxppc-dev@ozlabs.org, Michael Ellerman <mpe@ellerman.id.au>
Cc: hughd@google.com, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org

Excerpts from Christophe Leroy's message of July 6, 2020 3:49 am:
>=20
>=20
> Le 03/07/2020 =C3=A0 16:13, Michael Ellerman a =C3=A9crit=C2=A0:
>> We have powerpc specific logic in our page fault handling to decide if
>> an access to an unmapped address below the stack pointer should expand
>> the stack VMA.
>>=20
>> The logic aims to prevent userspace from doing bad accesses below the
>> stack pointer. However as long as the stack is < 1MB in size, we allow
>> all accesses without further checks. Adding some debug I see that I
>> can do a full kernel build and LTP run, and not a single process has
>> used more than 1MB of stack. So for the majority of processes the
>> logic never even fires.
>>=20
>> We also recently found a nasty bug in this code which could cause
>> userspace programs to be killed during signal delivery. It went
>> unnoticed presumably because most processes use < 1MB of stack.
>>=20
>> The generic mm code has also grown support for stack guard pages since
>> this code was originally written, so the most heinous case of the
>> stack expanding into other mappings is now handled for us.
>>=20
>> Finally although some other arches have special logic in this path,
>> from what I can tell none of x86, arm64, arm and s390 impose any extra
>> checks other than those in expand_stack().
>>=20
>> So drop our complicated logic and like other architectures just let
>> the stack expand as long as its within the rlimit.
>=20
> I agree that's probably not worth a so complicated logic that is nowhere=20
> documented.

Agreed.

>> @@ -569,30 +488,15 @@ static int __do_page_fault(struct pt_regs *regs, u=
nsigned long address,
>>   	vma =3D find_vma(mm, address);
>>   	if (unlikely(!vma))
>>   		return bad_area(regs, address);
>> -	if (likely(vma->vm_start <=3D address))
>> -		goto good_area;
>> -	if (unlikely(!(vma->vm_flags & VM_GROWSDOWN)))
>> -		return bad_area(regs, address);
>>  =20
>> -	/* The stack is being expanded, check if it's valid */
>> -	if (unlikely(bad_stack_expansion(regs, address, vma, flags,
>> -					 &must_retry))) {
>> -		if (!must_retry)
>> +	if (unlikely(vma->vm_start > address)) {
>> +		if (unlikely(!(vma->vm_flags & VM_GROWSDOWN)))
>=20
> We are already in an unlikely() branch, I don't think it is worth having=20
> a second level of unlikely(), better let gcc decide what's most efficient=
.

I'm not sure being nested matters. It does in terms of how the code is=20
generated and how much it might acutally matter, but if we say we=20
optimise the expand stack case rather than the segfault case, then=20
unlikely is fine here. I find it can be a readability aid as well.

Thanks,
Nick
