From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH] bitfield: Use __ffs64(x) to fix missing __ffsdi2()
Date: Tue, 10 Oct 2017 09:03:50 +0200
Message-ID: <CAMuHMdVTdPNV3EUx_ErXBL22RoNUuJ4eSAgOeTKPFEhw2+xS7g@mail.gmail.com>
References: <1507538449-22775-1-git-send-email-geert+renesas@glider.be> <20171009155311.17e1c7f8@cakuba.netronome.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-wm0-f67.google.com ([74.125.82.67]:33806 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752146AbdJJHDw (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 10 Oct 2017 03:03:52 -0400
In-Reply-To: <20171009155311.17e1c7f8@cakuba.netronome.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Jakub Kicinski <jakub.kicinski@netronome.com>
Cc: Geert Uytterhoeven <geert+renesas@glider.be>, Arnd Bergmann <arnd@arndb.de>, Andrew Morton <akpm@linux-foundation.org>, kbuild test robot <fengguang.wu@intel.com>, Linux-Arch <linux-arch@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

Hi Jakub,

On Tue, Oct 10, 2017 at 12:53 AM, Jakub Kicinski
<jakub.kicinski@netronome.com> wrote:
> On Mon,  9 Oct 2017 10:40:49 +0200, Geert Uytterhoeven wrote:
>> On most architectures[*], gcc turns __builtin_ffsll() into a call to
>> __ffsdi2(), which is not provided by any architecture, leading to
>> failures like:
>>
>>     rcar-gen3-cpg.c:(.text+0x289): undefined reference to `__ffsdi2'
>>
>> To fix this, use __ffs64() instead, which is available on all
>> architectures.
>>
>> [*] Known exceptions are some 64-bit architectures like amd64, arm64,
>>     ia64, powerpc64, and tilegx.
>>
>> Reported-by: kbuild test robot <fengguang.wu@intel.com>
>> Fixes: 3e9b3112ec74f192 ("add basic register-field manipulation macros")
>> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
>> ---
>>  include/linux/bitfield.h | 3 ++-
>>  1 file changed, 2 insertions(+), 1 deletion(-)
>>
>> diff --git a/include/linux/bitfield.h b/include/linux/bitfield.h
>> index 8b9d6fff002db113..0a827677372756fa 100644
>> --- a/include/linux/bitfield.h
>> +++ b/include/linux/bitfield.h
>> @@ -15,6 +15,7 @@
>>  #ifndef _LINUX_BITFIELD_H
>>  #define _LINUX_BITFIELD_H
>>
>> +#include <linux/bitops.h>
>>  #include <linux/bug.h>
>>
>>  /*
>> @@ -46,7 +47,7 @@
>>   *  reg |= FIELD_PREP(REG_FIELD_C, c);
>>   */
>>
>> -#define __bf_shf(x) (__builtin_ffsll(x) - 1)
>> +#define __bf_shf(x) __ffs64(x)
>
> Hm.  The build bot failure made me think.  I think rcar-gen3-cpg.c may
> be doing something wrong here, could you point me at the patch in
> question?  I don't see any FIELD_* there in Linus's tree.

See series "[PATCH v3 0/6] clk: renesas: r8a779[56]: Add Z and Z2 clock
support" (https://www.spinics.net/lists/arm-kernel/msg609499.html).

> __bf_shf() is supposed to be used with constant masks only, therefore
> the call must be optimized away completely.
>
>>  #define __BF_FIELD_CHECK(_mask, _reg, _val, _pfx)                    \
>>       ({                                                              \

IC.

Yes, it looks like __ffs64() can't be optimized away like __builtin_ffsll() :-(

Apparently the patch series above uses __bf_shf() directly, to avoid the
BUILD_BUG_ON_MSG(), which doesn't work when the call isn't optimized away.
Sorry for not noticing that before...

One way to fix that (non-)API abuse would be to get rid of __bf_shf(),
and open code it as __builtin_ffsll(x) - 1 everywhere...

What do you think?

Thanks!

Gr{oetje,eeting}s,

                        Geert
