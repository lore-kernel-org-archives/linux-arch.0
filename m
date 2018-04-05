From: okaya@codeaurora.org
Subject: Re: [PATCH v3 1/5] io: define several IO & PIO barrier types for the
 asm-generic version
Date: Thu, 05 Apr 2018 07:48:36 -0400
Message-ID: <e2290e35d919d46a6d45b0e47abb866e@codeaurora.org>
References: <1522886301-25955-1-git-send-email-okaya@codeaurora.org>
 <CAK8P3a0Noun+8AaRUcMdOX09KXxFXZxfcyUgJnezPkS2gVkg6w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAK8P3a0Noun+8AaRUcMdOX09KXxFXZxfcyUgJnezPkS2gVkg6w@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: Timur Tabi <timur@codeaurora.org>, sulrich@codeaurora.org, linux-arm-msm@vger.kernel.org, Linux ARM <linux-arm-kernel@lists.infradead.org>, linux-arch <linux-arch@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, arndbergmann@gmail.com
List-Id: linux-arch.vger.kernel.org

On 2018-04-05 03:00, Arnd Bergmann wrote:
> On Thu, Apr 5, 2018 at 1:58 AM, Sinan Kaya <okaya@codeaurora.org> 
> wrote:
> 
> Looks good, but I'd change the comments to ones that document exactly
> what those barriers are for:
> 
>> +#ifndef __io_ar
>> +#ifdef rmb
>> +/* prefer rmb() as the default implementation of __io_ar() if 
>> supported */
>> +#define __io_ar()      rmb()
> 
> /*
>  * prevent prefetching of coherent DMA data ahead of a dma-complete */
> 
>> +#ifndef __io_bw
>> +#ifdef wmb
>> +/* prefer wmb() as the default implementation of __io_bw() if 
>> supported */
>> +#define __io_bw()      wmb()
>> +#else
> 
> /* flush writes to coherent DMA data before possibly triggering a DMA 
> read */
> 
>> +#ifndef __io_aw
>> +#define __io_aw()      barrier()
>> +#endif
> 
> /* serialize device access against a spin_unlock, usually handled there 
> */
> 

I will add these and post the next version.

> The other four patches look perfect already.  What's the timing we need 
> for
> these patches? Are they 4.18 material, or do we need them in 4.17 and
> stable kernels to work around known bugs?

I was hoping to get all arch stuff in for 4.17.

Driver developers started removing redundant wmb().

> 
>       Arnd
