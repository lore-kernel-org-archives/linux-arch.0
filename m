From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: Re: [PATCH 06/27] arm64/sve: System register and exception syndrome definitions
Date: Mon, 21 Aug 2017 16:34:11 +0100
Message-ID: <87ziat3pfw.fsf@linaro.org>
References: <1502280338-23002-1-git-send-email-Dave.Martin@arm.com> <1502280338-23002-7-git-send-email-Dave.Martin@arm.com> <87a82t5kos.fsf@linaro.org> <8760dh5cbl.fsf@linaro.org> <20170821142627.GQ6321@e103592.cambridge.arm.com> <871so55613.fsf@linaro.org> <20170821151957.GS6321@e103592.cambridge.arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-wr0-f177.google.com ([209.85.128.177]:34124 "EHLO
        mail-wr0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754114AbdHUPeN (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 21 Aug 2017 11:34:13 -0400
Received: by mail-wr0-f177.google.com with SMTP id p14so33751442wrg.1
        for <linux-arch@vger.kernel.org>; Mon, 21 Aug 2017 08:34:13 -0700 (PDT)
In-reply-to: <20170821151957.GS6321@e103592.cambridge.arm.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Dave Martin <Dave.Martin@arm.com>
Cc: linux-arch@vger.kernel.org, libc-alpha@sourceware.org, Ard Biesheuvel <ard.biesheuvel@linaro.org>, Szabolcs Nagy <szabolcs.nagy@arm.com>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, Richard Sandiford <richard.sandiford@arm.com>, kvmarm@lists.cs.columbia.edu, linux-arm-kernel@lists.infradead.org


Dave Martin <Dave.Martin@arm.com> writes:

> On Mon, Aug 21, 2017 at 03:50:32PM +0100, Alex Bennée wrote:
>> Dave Martin <Dave.Martin@arm.com> writes:
>> > On Mon, Aug 21, 2017 at 01:34:38PM +0100, Alex Bennée wrote:
>
> [...]
>
>> >> > Dave Martin <Dave.Martin@arm.com> writes:
>
> [...]
>
>> >> >> +#define ZCR_ELx_LEN_SHIFT	0
>> >> >> +#define ZCR_ELx_LEN_SIZE	9
>> >> >> +#define ZCR_ELx_LEN_MASK	0x1ff
>> >> >> +
>> >>
>> >> LEN should be 0/4/0xf
>> >>
>> >> LEN, bits [3:0]
>> >>
>> >> Constrains the scalable vector register length for EL1 and EL0 to
>> >> (LEN+1)x128 bits.
>> >
>> > The SVE supplement is not very explicit about the meaning of bits [8:4],
>> > but they are reserved to extend the LEN field in the future, in case
>> > that's ever needed for future architecture revisions.  I've aimed for
>> > Linux to cope with this.
>> >
>> > Basically bits [8:4] are read-as-zero, write-ignore today, but in
>> > the future some or all of them may be LEN field bits.
>> >
>> > In particular, this means that writing all bits [8:0] with 1 will
>> > configure the largest supported vector length, even on future
>> > architecture versions that may have a larger LEN field.
>>
>> Ahh ok. It's not clear from the html and it is certainly implied in the
>> supplement (2.1.1) that the architectural max is:
>>
>>   The size of every vector register is an IMPLEMENTATION DEFINED
>>   multiple of 128 bits, up to an architectural maximum of 2048 bits.
>>
>> >
>> > It didn't seem useful to distinguish the two classes of bits here.
>>
>> Maybe a comment clarifying would be useful then?
>
> OK, I think I can say something like:
>
> /*
>  * The ZCR_ELx_LEN_* definitions intentionally include bits [8:4]
>  * which are reserved by the SVE architecture for future expansion of
>  * the LEN field, with compatible semantics.
>  */
>
> Any good?

Works for me ;-)

>
> Cheers
> ---Dave
