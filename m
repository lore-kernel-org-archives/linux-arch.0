From: Kees Cook <keescook@chromium.org>
Subject: Re: [PATCH 2/2] arm: apply more __ro_after_init
Date: Wed, 10 Aug 2016 11:32:07 -0700
Message-ID: <CAGXu5j+9saxwnKTK_vdnLCuXdbvUqQWXkbxOu8QrzB9SHmQGYA@mail.gmail.com>
References: <1464979224-2085-1-git-send-email-keescook@chromium.org>
 <1464979224-2085-3-git-send-email-keescook@chromium.org> <20160810094339.GK1041@n2100.armlinux.org.uk>
Reply-To: kernel-hardening@lists.openwall.com
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <kernel-hardening-return-4326-glkh-kernel-hardening=m.gmane.org@lists.openwall.com>
List-Post: <mailto:kernel-hardening@lists.openwall.com>
List-Help: <mailto:kernel-hardening-help@lists.openwall.com>
List-Unsubscribe: <mailto:kernel-hardening-unsubscribe@lists.openwall.com>
List-Subscribe: <mailto:kernel-hardening-subscribe@lists.openwall.com>
Sender: keescook@google.com
In-Reply-To: <20160810094339.GK1041@n2100.armlinux.org.uk>
To: Russell King - ARM Linux <linux@armlinux.org.uk>
Cc: "kernel-hardening@lists.openwall.com" <kernel-hardening@lists.openwall.com>, linux-arch <linux-arch@vger.kernel.org>, Ard Biesheuvel <ard.biesheuvel@linaro.org>, "x86@kernel.org" <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@linux-foundation.org>, Mathias Krause <minipli@googlemail.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: linux-arch.vger.kernel.org

On Wed, Aug 10, 2016 at 2:43 AM, Russell King - ARM Linux
<linux@armlinux.org.uk> wrote:
> On Fri, Jun 03, 2016 at 11:40:24AM -0700, Kees Cook wrote:
>> @@ -1309,16 +1309,11 @@ void __init arm_mm_memblock_reserve(void)
>>   * Any other function or debugging method which may touch any device _will_
>>   * crash the kernel.
>>   */
>> +static char vectors[PAGE_SIZE * 2] __ro_after_init __aligned(PAGE_SIZE);
>>  static void __init devicemaps_init(const struct machine_desc *mdesc)
>>  {
>>       struct map_desc map;
>>       unsigned long addr;
>> -     void *vectors;
>> -
>> -     /*
>> -      * Allocate the vector page early.
>> -      */
>> -     vectors = early_alloc(PAGE_SIZE * 2);
>
> This one is not appropriate.  We _do_ write to these pages after init
> for FIQ handler updates.  See set_fiq_handler().

Ah, interesting. I guess none of that hardware is being tested on
linux-next. I'll drop that chunk and resubmit.

Thanks!

-Kees

-- 
Kees Cook
Nexus Security
