Received: from mail.mainlining.org (mail.mainlining.org [5.75.144.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B72E497B70;
	Fri, 11 Sep 2026 22:14:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=5.75.144.95
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789164854; cv=none; b=EfVRy8nEbrzWC5RthVghQ3gU1GKOiuEAXc+90i2R4M14CQpW75jtrEEsVzlbzALtFUn1oA4tE40SkdZ0b9sSOxrL4k2jWNu7xcUNAzIU+lhgZc1RU0MhUxfnAmESFp9yVMjXziSe5UpfE0k59gQIyCSmcmvKTDZM6sB6pmG7RWE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789164854; c=relaxed/simple;
	bh=+o6vOHEhsWvdrU0JZaRi5i9nkhKzc2MgpcgoVYXhQu8=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=SXnW8XMx5qgfH36VZAPlCGEpDbFcQrJ4vYXFXXQ2o4xuXb2pV16GPGoFJ88qkrdYxja+5xAh+t0vUOVBHSZ3L2rgD58fw8CehA03rEQkNapvRqEAfrk4M45jXkbh3Bte03PJtWSIxjvdTQKMrKH2Oxsi0sPJzYng0yX0spzeTOk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mainlining.org; spf=pass smtp.helo=mail.mainlining.org; arc=none smtp.client-ip=5.75.144.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mainlining.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.helo=mail.mainlining.org
Date: Fri, 11 Sep 2026 23:13:57 +0100
From: Bradley Morgan <brads@mainlining.org>
To: David Laight <david.laight.linux@gmail.com>
CC: "Paul E. McKenney" <paulmck@kernel.org>, frederic@kernel.org,
 neeraj.upadhyay@kernel.org, boqun@kernel.org, joelagnelf@nvidia.com,
 rcu@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>,
 Arnd Bergmann <arnd@arndb.de>, linux-arch@vger.kernel.org,
 Vineet Gupta <vgupta@kernel.org>, linux-snps-arc@lists.infradead.org,
 Russell King <linux@armlinux.org.uk>, linux-arm-kernel@lists.infradead.org,
 Guo Ren <guoren@kernel.org>, linux-csky@vger.kernel.org,
 Yoshinori Sato <ysato@users.sourceforge.jp>, Rich Felker <dalias@libc.org>,
 John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
 linux-sh@vger.kernel.org, Chris Zankel <chris@zankel.net>,
 Max Filippov <jcmvbkbc@gmail.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/6] lib: Add two-byte cmpxchg emulation function
In-Reply-To: <20260911231017.550f8cd1@pumpkin>
References: <20260911192540.20983-1-brads@mainlining.org> <20260911192540.20983-2-brads@mainlining.org> <20260911231017.550f8cd1@pumpkin>
Message-ID: <0B8A055D-0B2C-4531-8326-590892B3092A@mainlining.org>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 8bit

On 11 September 2026 23:10:17 BST, David Laight
<david.laight.linux@gmail.com> wrote:
>On Fri, 11 Sep 2026 19:25:34 +0000
>Bradley Morgan <brads@mainlining.org> wrote:
>
>> cmpxchg_emu_u8() emulates one-byte cmpxchg() in terms of four-byte
>> cmpxchg() for the architectures lacking native one-byte atomics.
>> The same architectures also lack native two-byte cmpxchg(), where
>> such an operation is not supported and either fails to compile via
>> BUILD_BUG() or fails to link, because the bad pointer sentinels
>> these architectures declare are never defined.
>> 
>> Add cmpxchg_emu_u16(), the two-byte sibling. It reads the enclosing
>> word with READ_ONCE(), splices the two target bytes through a union
>> and loops on cmpxchg() of the full word until the compare succeeds.
>> Like cmpxchg_emu_u8() it is fully ordered.
>> 
>> The Kconfig symbol gating this file is renamed from
>> ARCH_NEED_CMPXCHG_1_EMU to ARCH_NEED_CMPXCHG_1_2_EMU, as it now
>> selects both the one-byte and the two-byte emulation.
>> 
>> Suggested-by: Paul E. McKenney <paulmck@kernel.org>
>> Signed-off-by: Bradley Morgan <brads@mainlining.org>
>> ---
>>  arch/Kconfig                |  2 +-
>>  arch/arc/Kconfig            |  2 +-
>>  arch/arm/Kconfig            |  2 +-
>>  arch/csky/Kconfig           |  2 +-
>>  arch/sh/Kconfig             |  2 +-
>>  arch/xtensa/Kconfig         |  2 +-
>>  include/linux/cmpxchg-emu.h |  1 +
>>  lib/Makefile                |  2 +-
>>  lib/cmpxchg-emu.c           | 35 ++++++++++++++++++++++++++++++++---
>>  9 files changed, 40 insertions(+), 10 deletions(-)
>> 
>...
>> diff --git a/include/linux/cmpxchg-emu.h b/include/linux/cmpxchg-emu.h
>> index 998deec67740..fee8171fa05e 100644
>> --- a/include/linux/cmpxchg-emu.h
>> +++ b/include/linux/cmpxchg-emu.h
>> @@ -11,5 +11,6 @@
>>  #define __LINUX_CMPXCHG_EMU_H
>>  
>>  uintptr_t cmpxchg_emu_u8(volatile u8 *p, uintptr_t old, uintptr_t new);
>> +uintptr_t cmpxchg_emu_u16(volatile u16 *p, uintptr_t old, uintptr_t
>new);
>
>Why uintptr_t? Shouldn't it just be u16?

Hi, Paul suggested I make it as identical as possible to u8, Do you reckon
this would break anything?


>(Which probably means the code would better if it was just 'unsigned int')

Ehh, subjective.

>
>David
>
>

--- Thanks!
https://lore.kernel.org/all/EE579805-42F2-4C58-B752-F28779EEB717@grrlz.net/
