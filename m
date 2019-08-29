Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.110.172]:47270 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727022AbfH2Ps7 (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Thu, 29 Aug 2019 11:48:59 -0400
Subject: Re: [PATCH 2/7] lib: vdso: Build 32 bit specific functions in the
 right context
References: <20190829111843.41003-1-vincenzo.frascino@arm.com>
 <20190829111843.41003-3-vincenzo.frascino@arm.com>
 <CALCETrWNbMhYwpsKtutCTW4M7rMmOF0YUy-k1QgGEpY-Gd1xQw@mail.gmail.com>
From: Vincenzo Frascino <vincenzo.frascino@arm.com>
Message-ID: <91cf55b4-63a1-9548-c7e0-c4dfa350b687@arm.com>
Date: Thu, 29 Aug 2019 16:48:55 +0100
MIME-Version: 1.0
In-Reply-To: <CALCETrWNbMhYwpsKtutCTW4M7rMmOF0YUy-k1QgGEpY-Gd1xQw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Andy Lutomirski <luto@kernel.org>
Cc: linux-arch <linux-arch@vger.kernel.org>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, LKML <linux-kernel@vger.kernel.org>, linux-mips@vger.kernel.org, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, Paul Burton <paul.burton@mips.com>, Thomas Gleixner <tglx@linutronix.de>, Mark Salyzyn <salyzyn@android.com>, Dmitry Safonov <0x7f454c46@gmail.com>
Message-ID: <20190829154855.BD3qhcEUVOVTtFDxQFMjf5M0J9PksGwtpeP4CsNCn0M@z>

On 29/08/2019 16:23, Andy Lutomirski wrote:
> On Thu, Aug 29, 2019 at 4:19 AM Vincenzo Frascino
> <vincenzo.frascino@arm.com> wrote:
>>
>> clock_gettime32 and clock_getres_time32 should be compiled only with a
>> 32 bit vdso library.
>>
>> Exclude these symbols when BUILD_VDSO32 is not defined.
> 
> Reviewed-by: Andy Lutomirski <luto@kernel.org>
> 
> BTW, this is a great patch: it's either correct or it won't build.  I
> like patches like that.
> 

Thanks :)

-- 
Regards,
Vincenzo
