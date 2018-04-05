From: Sinan Kaya <okaya@codeaurora.org>
Subject: Re: [PATCH v2 2/2] io: prevent compiler reordering on the default
 readX() implementation
Date: Wed, 4 Apr 2018 20:06:42 -0400
Message-ID: <d7c63b8f-b315-8593-9683-588598dd1dc1@codeaurora.org>
References: <mhng-fe49c525-788d-4ce7-9703-95e2b3eaeca6@palmer-si-x1c4>
 <691b903c-e97d-0a25-28c5-690318bb215a@codeaurora.org>
 <CAK8P3a2pGQb7TqQtuw0ZpQ=8CwXiRmRKKc1GwvEgKDgofxJ3nA@mail.gmail.com>
 <9b0d7db3-0830-9661-6dc8-39523daa8f32@codeaurora.org>
 <CAK8P3a2Cg59cTzUq2_8sopeY9BktM7a6_4nunMJVA5fQFaVLug@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAK8P3a2Cg59cTzUq2_8sopeY9BktM7a6_4nunMJVA5fQFaVLug@mail.gmail.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: Palmer Dabbelt <palmer@sifive.com>, Mark Rutland <mark.rutland@arm.com>, Timur Tabi <timur@codeaurora.org>, sulrich@codeaurora.org, linux-arm-msm@vger.kernel.org, Linux ARM <linux-arm-kernel@lists.infradead.org>, linux-arch <linux-arch@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: linux-arch.vger.kernel.org

On 4/4/2018 3:50 PM, Arnd Bergmann wrote:
> On Wed, Apr 4, 2018 at 7:48 PM, Sinan Kaya <okaya@codeaurora.org> wrote:
>> On 4/4/2018 11:55 AM, Arnd Bergmann wrote:
>>> Yes, exactly, plus the same for write and in/out of course.
>>
>> I was looking at this...
>>
>> inb() and outb() seem to be calling writeb(). It gets the wmb/barrier automatically
>> when we fix writeb().
>>
>> Did I miss something?
> 
> At least outb() needs stricter barriers than writeb() in theory, what
> we want here
> is that outb() has not just made it out to the device but that the
> write has been
> confirmed completed by the device. Some architectures can't do it, but those
> that can should have an easy way to hook into that using a separate set of
> barriers.
> 
> Using the riscv barrier names, we could do this like
> 
> #ifndef __io_bw()
> #define __io_bw()      wmb()
> #endif
> 
> #ifndef __io_aw
> #define __io_aw()      barrier()
> #endif
> 
> #ifndef __io_pbw
> #define __io_pbw()     __io_bw()
> #endif
> 
> #ifndef __io_paw
> #define __io_paw()     __io_aw()
> #endif
> 
> and the same thing for reads. This way, an architecture could override
> any of those, but still get reasonable defaults for the others.
> For __io_bw(), I picked barrier() instead of do {} while (0), no idea
> if that's any better, I just play safe here.

I posted V3. I hope I captured what you mean above correctly.

> 
>      Arnd
> 


-- 
Sinan Kaya
Qualcomm Datacenter Technologies, Inc. as an affiliate of Qualcomm Technologies, Inc.
Qualcomm Technologies, Inc. is a member of the Code Aurora Forum, a Linux Foundation Collaborative Project.
