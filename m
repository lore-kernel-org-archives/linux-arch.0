Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-wm0-f49.google.com ([74.125.82.49]:52252 "EHLO
        mail-wm0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751636AbdJIJe1 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 9 Oct 2017 05:34:27 -0400
Received: by mail-wm0-f49.google.com with SMTP id k4so21617303wmc.1
        for <linux-arch@vger.kernel.org>; Mon, 09 Oct 2017 02:34:27 -0700 (PDT)
References: <1504198860-12951-1-git-send-email-Dave.Martin@arm.com> <1504198860-12951-27-git-send-email-Dave.Martin@arm.com> <59D7A4AF.40408@arm.com> <20171006173715.GC3611@e103592.cambridge.arm.com>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: Re: [PATCH v2 26/28] arm64/sve: Add documentation
In-reply-to: <20171006173715.GC3611@e103592.cambridge.arm.com>
Date: Mon, 09 Oct 2017 10:34:25 +0100
Message-ID: <878tgkbr6m.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Dave Martin <Dave.Martin@arm.com>
Cc: Szabolcs Nagy <szabolcs.nagy@arm.com>, linux-arm-kernel@lists.infradead.org, linux-arch@vger.kernel.org, Mark Rutland <mark.rutland@arm.com>, libc-alpha@sourceware.org, Ard Biesheuvel <ard.biesheuvel@linaro.org>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, Richard Sandiford <richard.sandiford@arm.com>nd@arm.com, kvmarm@lists.cs.columbia.edu
Message-ID: <20171009093425.Ntk51Hrd9K5jjBheei61_m0uKDKYFWRBWDmw6SFPBlg@z>


Dave Martin <Dave.Martin@arm.com> writes:

> On Fri, Oct 06, 2017 at 04:43:43PM +0100, Szabolcs Nagy wrote:
>> On 31/08/17 18:00, Dave Martin wrote:
>> > +9.  System runtime configuration
>> > +--------------------------------
>> > +
>> > +* To mitigate the ABI impact of expansion of the signal frame, a poli=
cy
>> > +  mechanism is provided for administrators, distro maintainers and de=
velopers
>> > +  to set the default vector length for userspace processes:
>> > +
>> > +/proc/cpu/sve_default_vector_length
>>
>>
>> elsewhere in the patch series i see
>>
>> /proc/sys/abi/sve_default_vector_length
>>
>> is this supposed to be the same?
>
> Good spot, thanks!
>
> /proc/cpu/ was the old location: they should both say /proc/abi/.
> I'll fix it.

Isn't /sys (or rather sysfs) the preferred location for modern control
knobs that mirror the kernels object model or is SVE a special case for
extending /proc?


>
> ---Dave


--
Alex Benn=C3=A9e
