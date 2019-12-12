Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from out02.mta.xmission.com ([166.70.13.232]:41028 "EHLO
        out02.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730164AbfLLS1h (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 12 Dec 2019 13:27:37 -0500
From: ebiederm@xmission.com (Eric W. Biederman)
References: <20191211184027.20130-1-catalin.marinas@arm.com>
        <20191211184027.20130-13-catalin.marinas@arm.com>
        <CAK8P3a1-eaR7NddhDce65vXKCGeZD3xUMrTTAWN4U3oW0ecN=g@mail.gmail.com>
Date: Thu, 12 Dec 2019 12:26:41 -0600
In-Reply-To: <CAK8P3a1-eaR7NddhDce65vXKCGeZD3xUMrTTAWN4U3oW0ecN=g@mail.gmail.com>
        (Arnd Bergmann's message of "Wed, 11 Dec 2019 20:31:28 +0100")
Message-ID: <87zhfxqu1q.fsf@x220.int.ebiederm.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [PATCH 12/22] arm64: mte: Add specific SIGSEGV codes
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Arnd Bergmann <arnd@arndb.de>
Cc: Catalin Marinas <catalin.marinas@arm.com>, Linux ARM <linux-arm-kernel@lists.infradead.org>, Will Deacon <will@kernel.org>, Marc Zyngier <maz@kernel.org>, Vincenzo Frascino <vincenzo.frascino@arm.com>, Szabolcs Nagy <szabolcs.nagy@arm.com>, Richard Earnshaw <Richard.Earnshaw@arm.com>, Kevin Brodsky <kevin.brodsky@arm.com>, Andrey Konovalov <andreyknvl@google.com>, Linux-MM <linux-mm@kvack.org>, linux-arch <linux-arch@vger.kernel.org>, Al Viro <viro@zeniv.linux.org.uk>
Message-ID: <20191212182641.Sv8dv56azP0gmdOwu1HMLKKCl1A5yEuMAXs9fMtJt2w@z>

Arnd Bergmann <arnd@arndb.de> writes:

> On Wed, Dec 11, 2019 at 7:40 PM Catalin Marinas <catalin.marinas@arm.com> wrote:
>>
>> From: Vincenzo Frascino <vincenzo.frascino@arm.com>
>>
>> Add MTE-specific SIGSEGV codes to siginfo.h.
>>
>> Note that the for MTE we are reusing the same SPARC ADI codes because
>> the two functionalities are similar and they cannot coexist on the same
>> system.

Please Please Please don't do that.

It is actively harmful to have architecture specific si_code values.
As it makes maintenance much more difficult.

Especially as the si_codes are part of union descrimanator.

If your functionality is identical reuse the numbers otherwise please
just select the next numbers not yet used.

We have at least 256 si_codes per signal 2**32 if we really need them so
there is no need to be reuse numbers.

The practical problem is that architecture specific si_codes start
turning kernel/signal.c into #ifdef soup, and we loose a lot of
basic compile coverage because of that.  In turn not compiling the code
leads to bit-rot in all kinds of weird places.



Now as far as the observation that this is almost the same as other
functionality why can't this fit the existing interface exposed to
userspace?   Sometimes there are good reasons, but technology gets
a lot more uptake and testing when the same interfaces are more widely
available.

Eric

p.s. As for coexistence there is always the possibility that one chip
in a cpu family does supports one thing and another chip in a cpu
family supports another.  So userspace may have to cope with the
situation even if an individual chip doesn't.

I remember a similar case where sparc had several distinct page table
formats and we had a single kernel that had to cope with them all.


>> Cc: Arnd Bergmann <arnd@arndb.de>
>> Signed-off-by: Vincenzo Frascino <vincenzo.frascino@arm.com>
>> [catalin.marinas@arm.com: renamed precise/imprecise to sync/async]
>> Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
>> ---
>>  include/uapi/asm-generic/siginfo.h | 9 +++++++--
>>  1 file changed, 7 insertions(+), 2 deletions(-)
>>
>> diff --git a/include/uapi/asm-generic/siginfo.h b/include/uapi/asm-generic/siginfo.h
>> index cb3d6c267181..a5184a5438c6 100644
>> --- a/include/uapi/asm-generic/siginfo.h
>> +++ b/include/uapi/asm-generic/siginfo.h
>> @@ -227,8 +227,13 @@ typedef struct siginfo {
>>  # define SEGV_PKUERR   4       /* failed protection key checks */
>>  #endif
>>  #define SEGV_ACCADI    5       /* ADI not enabled for mapped object */
>> -#define SEGV_ADIDERR   6       /* Disrupting MCD error */
>> -#define SEGV_ADIPERR   7       /* Precise MCD exception */
>> +#ifdef __aarch64__
>> +# define SEGV_MTEAERR  6       /* Asynchronous MTE error */
>> +# define SEGV_MTESERR  7       /* Synchronous MTE exception */
>> +#else
>> +# define SEGV_ADIDERR  6       /* Disrupting MCD error */
>> +# define SEGV_ADIPERR  7       /* Precise MCD exception */
>> +#endif
>
> SEGV_ADIPERR/SEGV_ADIDERR were added together with SEGV_ACCADI,
> it seems a bit odd to make only two of them conditional but not the others.
>
> I think we are generally working towards having the same constants
> across architectures even for features that only exist on one of them.
>
> Adding Al and Eric to Cc, maybe they have another suggestion on what
> constants should be used.
>
>      Arnd
