Received: from sg-1-100.ptr.blmpb.com (sg-1-100.ptr.blmpb.com [118.26.132.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16F4033987
	for <linux-arch@vger.kernel.org>; Mon,  2 Mar 2026 02:42:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=118.26.132.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772419338; cv=none; b=QYRRp+VVl20BIVYLJl4+0EKKNVBogS9BVXoo2JkQ5XAHR1YX8uAeppm1IP15mvcm7NT5gNJ+tnse8s0xXxKGOlk06LMOWSUhSrB1lZnI26Q25LMQgwVhmxyQ1D3n+4hMi6Gt1ZI0LeluDyNZvMA0ouEBRN+Uh81NgrK73sRnmC0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772419338; c=relaxed/simple;
	bh=SLCaDIXfTpGuN0yh3HjmFh9+lzD39NDYAbWlrmxsA+0=;
	h=To:From:Message-Id:Mime-Version:In-Reply-To:Cc:Subject:Date:
	 References:Content-Type; b=DFKeOdS4kQH1mK4qDuZLqQTujedqjvvxm3bzzmaHtw/Jm76JBQ0T1Sm64nQqSTULCo4GZlKXMzA8RZRRrQ+dUuM+q6LJkyL65Pio//cOqYSbcfKd7tvgqdfd0SY2lQlhIb5wO2bLXctQ9rzSfobvGQ++BcCiHmwDrFYmwZt5i5M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=N4xutGVP; arc=none smtp.client-ip=118.26.132.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="N4xutGVP"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=2212171451; d=bytedance.com; t=1772419323; h=from:subject:
 mime-version:from:date:message-id:subject:to:cc:reply-to:content-type:
 mime-version:in-reply-to:message-id;
 bh=/eJxG3ytsS/czBn3wkR3RtXxETDxvhKr4cW1xKi3D/0=;
 b=N4xutGVPkdfgvmzt5HD54YPKQFkEkc/EZWpltQX99SxbYmI0aGPlUxd3xX2v+vmDvTGBT8
 zG7T3U+nCuZgI06Cjrtsn3KApBMkMMjbsNr+Oe5H6vPp9nyedSLz64CLP7K3PqOuc+Wq8R
 No9H4HD599UCuixpi54bDoYWjT3hi6O8rujPhB3eYg7xl3B8aiY4O6AI250nUNg2klR8oY
 zpSJ/uABIT/RVslZ4dpFkkuWHy98FTHzuyiN2X0Y6ItMOkbr/gjDwxitTEpdH/K+lIto2W
 rtFoHJvJtoa4zDoS3zBM/UXpGSneb0NMXdkbd9XpxRE8VnovA8Mg3mYgf2drdQ==
Content-Transfer-Encoding: quoted-printable
To: "Conor Dooley" <conor@kernel.org>
From: "Rui Qi" <qirui.001@bytedance.com>
Message-Id: <f4d46b2a-6375-4e86-8dc8-65753c1ca6ac@bytedance.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Original-From: Rui Qi <qirui.001@bytedance.com>
In-Reply-To: <20260227-scanner-trembling-5e41445f9e93@spud>
Cc: <paul.walmsley@sifive.com>, <palmer@dabbelt.com>, 
	<aou@eecs.berkeley.edu>, <alex@ghiti.fr>, <cyrilbur@tenstorrent.com>, 
	<tglx@kernel.org>, <peterz@infradead.org>, <debug@rivosinc.com>, 
	<andybnac@gmail.com>, <charlie@rivosinc.com>, <geomatsi@gmail.com>, 
	<thuth@redhat.com>, <bjorn@rivosinc.com>, <songshuaishuai@tinylab.org>, 
	<martin@kaiser.cx>, <masahiroy@kernel.org>, <kees@kernel.org>, 
	<linux-arch@vger.kernel.org>, <linux-riscv@lists.infradead.org>, 
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] riscv: add system error interrupt handler support
Date: Mon, 2 Mar 2026 10:41:39 +0800
X-Lms-Return-Path: <lba+269a4f8f9+386d15+vger.kernel.org+qirui.001@bytedance.com>
References: <20260226082735.56108-1-qirui.001@bytedance.com> <20260226-comprised-untold-1f2c0d2d48d6@spud> <2bc446a4-0082-4525-baab-0ac4c332cfa8@bytedance.com> <20260227-scanner-trembling-5e41445f9e93@spud>
User-Agent: Mozilla Thunderbird
Content-Type: text/plain; charset=UTF-8

On 2/27/26 6:08 PM, Conor Dooley wrote:
> On Fri, Feb 27, 2026 at 03:54:39PM +0800, Rui Qi wrote:
>> On 2/26/26 5:22 PM, Conor Dooley wrote:
>>> On Thu, Feb 26, 2026 at 04:27:35PM +0800, Rui Qi wrote:
>>>> Add a system error interrupt handler for RISC-V that panics
>>>> the system when hardware errors are detected. The implementation inclu=
des:
>>>>
>>>> - Add IRQ_SYS_ERROR (23) interrupt definition to CSR header
>>>> - Implement sys_error.c module with panic handler
>>>> - Register per-CPU interrupt handler for system error interrupts
>>>> - Add module to kernel build system
>>>>
>>>> When a system error interrupt occurs, the handler immediately panics
>>>> the system with a descriptive message to ensure the error is properly
>>>> captured and the system is halted safely.
>>>>
>>>> Signed-off-by: Rui Qi <qirui.001@bytedance.com>
>>>> ---
>>>>  arch/riscv/include/asm/csr.h  |  4 +-
>>>>  arch/riscv/kernel/Makefile    |  1 +
>>>>  arch/riscv/kernel/sys_error.c | 80 ++++++++++++++++++++++++++++++++++=
+
>>>>  include/linux/cpuhotplug.h    |  1 +
>>>>  4 files changed, 85 insertions(+), 1 deletion(-)
>>>>  create mode 100644 arch/riscv/kernel/sys_error.c
>>>>
>>>> diff --git a/arch/riscv/include/asm/csr.h b/arch/riscv/include/asm/csr=
.h
>>>> index 31b8988f4488..1f43c25b07ed 100644
>>>> --- a/arch/riscv/include/asm/csr.h
>>>> +++ b/arch/riscv/include/asm/csr.h
>>>> @@ -99,7 +99,8 @@
>>>>  #define IRQ_M_EXT		11
>>>>  #define IRQ_S_GEXT		12
>>>>  #define IRQ_PMU_OVF		13
>>>> -#define IRQ_LOCAL_MAX		(IRQ_PMU_OVF + 1)
>>>> +#define IRQ_SYS_ERROR		23
>>>
>>> Hmmm, two problems I think with this. 23 is one of the interrupts that
>>> has been reserved for use with AIA. I don't think they use it right now=
,
>>> but in the future it might see use there.
>>>
>>> The first problem is kind of moot though, because reserving 16-23 for
>>> AIA is a retcon, and previously these interrupts were available custom
>>> use on any platform (as you have done here), so while it might be a
>>> system error on your platform, it could be something completely innocuo=
us
>>> on mine!
>>>
>>> With that in mind, does having this in arch code make sense at all?
>>> Can this just be a normal driver, that'll only probe on your specific
>>> platform?
>>
>> Thanks for the comment.
>>
>> I checked the latest RISC-V Interrupt Spec (2025-03-12). In that
>> version, interrupts 16=E2=80=9323 are defined as architectural local int=
errupts,
>> and interrupt 23 is tentatively proposed for a =E2=80=9CBus or system er=
ror=E2=80=9D
>=20
> Right, tentative is kinda no use to either of us though. Do you have
> hardware that does this?
>=20
>> type condition. That suggests this interrupt number is no longer just a
>> free, platform-defined slot =E2=80=94 it now carries architectural inten=
t and a
>> potential standardized meaning.
>=20
> Emphasis on "potential", of course ;) Still a platform defined slot for
> anyone that doesn't implement AIA, I think...
> I don't understand the interaction between extensions and the priv spec
> here, since the priv spec still says that 16 and higher are platform
> specific.
>=20
>> Given this context, my current implementation treats interrupt 23 as a
>> local condition that matches the spec=E2=80=99s intent for a system-leve=
l error
>> signal, rather than an arbitrary, custom platform interrupt. This seemed
>> reasonable as long as it aligns with the architectural semantics for
>> local interrupts.
>>
>> That said, I=E2=80=99m open to the concern about placing this handling i=
n
>> arch/riscv, and I=E2=80=99d like to understand your preference: do you t=
hink
>> this should be entirely moved into platform-specific code, or would a
>> conditional, spec-aware arch implementation (e.g., gated on the presence
>> of the relevant AIA/local interrupt support) be acceptable? Please let
>=20
> It can't be gated on AIA, because AIA isn't the extension that says that
> this is what interrupt 23 does (it specifically says that new extensions
> are expected to define the use of the three interrupts "proposes"), and
> we don't permit extension related stuff that is not frozen. I couldn't
> find an extension at any stage that set the behaviour in stone, are you
> aware of one? If one exists, a spec-aware arch implementation would be
> okay. If one does not, you'll have to make this specific to your
> platform until that extension shows up.
>=20
>> me know what approach you=E2=80=99d suggest.

Thanks for the clarification =E2=80=94 that makes sense.

You're right that AIA itself does not normatively define the semantics
of interrupt 23, and that the wording there is explicitly provisional. I
also understand the policy around not merging extension-related behavior
unless it is tied to a frozen specification.

My reasoning was based on the architectural direction indicated in the
interrupt spec, but I agree that =E2=80=9Ctentative=E2=80=9D does not const=
itute a
stable architectural contract, and therefore isn't sufficient to justify
arch-level handling at this point.

Given that, I can move this into platform-specific code for now. If and
when a ratified extension formally assigns defined semantics to
interrupt 23, we could then revisit a spec-aware arch implementation
gated on that extension.

Please let me know if that approach aligns better with your expectations.
