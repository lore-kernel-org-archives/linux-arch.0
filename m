From: Guenter Roeck <linux@roeck-us.net>
Subject: Re: [PATCH v6 10/18] sh/tlb: Convert SH to generic mmu_gather
Date: Fri, 6 Dec 2019 06:03:50 -0800
Message-ID: <4f959f9b-9b8c-c880-0f55-172db732b783@roeck-us.net>
References: <20190219103148.192029670@infradead.org>
 <20190219103233.443069009@infradead.org>
 <CAMuHMdW3nwckjA9Bt-_Dmf50B__sZH+9E5s0_ziK1U_y9onN=g@mail.gmail.com>
 <20191204104733.GR2844@hirez.programming.kicks-ass.net>
 <3c83eaec-8f33-1b90-1c70-9e7c1c8b1855@physik.fu-berlin.de>
 <20191205225610.GB2532@roeck-us.net>
 <a188f905-bb08-db98-0b8a-e31bec1dfa31@physik.fu-berlin.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <a188f905-bb08-db98-0b8a-e31bec1dfa31@physik.fu-berlin.de>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Cc: Peter Zijlstra <peterz@infradead.org>, Geert Uytterhoeven <geert@linux-m68k.org>, Will Deacon <will.deacon@arm.com>, "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>, Andrew Morton <akpm@linux-foundation.org>, Nicholas Piggin <npiggin@gmail.com>, Linux-Arch <linux-arch@vger.kernel.org>, Linux MM <linux-mm@kvack.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Russell King <linux@armlinux.org.uk>, Heiko Carstens <heiko.carstens@de.ibm.com>, Rik van Riel <riel@surriel.com>, Yoshinori Sato <ysato@users.sourceforge.jp>, Rich Felker <dalias@libc.org>, Linux-sh list <linux-sh@vger.kernel.org>
List-Id: linux-arch.vger.kernel.org

On 12/6/19 5:38 AM, John Paul Adrian Glaubitz wrote:
> Hi!
> 
> On 12/5/19 11:56 PM, Guenter Roeck wrote:
>>> I have to admit, I have been very lazy with kernel updates. I have been
>>> planning to upgrade to a much more recent release on my boards for a while
>>> now, I have just been postponing it since the machines run very stable
>>> with the current kernel I am using.
>>>
>>
>> Hey, if you write a qemu emulation, I'll be happy to run it on a regular
>> basis :-)
> 
> There is working SH emulation in QEMU. I have been wanting to prepare a
> current Debian/sh4 test image for that purpose for a while now.
> 

I do run this emulation in my tests. It does not support the affected CPU,
unfortunately.

Guenter

> For the time being, you can use the image by Aurelien Jarno:
> 
>> https://people.debian.org/~aurel32/qemu/sh4/
> 
>> Problem is really that the architecture doesn't get as much attention as
>> it needs. The backtrace pointed to by Rob has been seen for a long time,
>> but either there is no one with the knowledge to fix it, or they are all
>> busy with other stuff.
> 
> I fully agree. I'm mostly busy with the userland stuff, i.e. Debian packages
> for sh4 and not so much with the kernel.
> 
> Adrian
> 
