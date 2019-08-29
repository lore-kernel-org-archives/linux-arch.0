From: Vincenzo Frascino <vincenzo.frascino@arm.com>
Subject: Re: [PATCH 2/7] lib: vdso: Build 32 bit specific functions in the
 right context
Date: Thu, 29 Aug 2019 16:48:55 +0100
Message-ID: <91cf55b4-63a1-9548-c7e0-c4dfa350b687@arm.com>
References: <20190829111843.41003-1-vincenzo.frascino@arm.com>
 <20190829111843.41003-3-vincenzo.frascino@arm.com>
 <CALCETrWNbMhYwpsKtutCTW4M7rMmOF0YUy-k1QgGEpY-Gd1xQw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CALCETrWNbMhYwpsKtutCTW4M7rMmOF0YUy-k1QgGEpY-Gd1xQw@mail.gmail.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Andy Lutomirski <luto@kernel.org>
Cc: linux-arch <linux-arch@vger.kernel.org>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, LKML <linux-kernel@vger.kernel.org>, linux-mips@vger.kernel.org, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, Paul Burton <paul.burton@mips.com>, Thomas Gleixner <tglx@linutronix.de>, Mark Salyzyn <salyzyn@android.com>, Dmitry Safonov <0x7f454c46@gmail.com>
List-Id: linux-arch.vger.kernel.org

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
