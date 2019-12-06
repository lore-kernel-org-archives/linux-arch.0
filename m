From: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Subject: Re: [PATCH v6 10/18] sh/tlb: Convert SH to generic mmu_gather
Date: Fri, 6 Dec 2019 14:38:27 +0100
Message-ID: <a188f905-bb08-db98-0b8a-e31bec1dfa31@physik.fu-berlin.de>
References: <20190219103148.192029670@infradead.org>
 <20190219103233.443069009@infradead.org>
 <CAMuHMdW3nwckjA9Bt-_Dmf50B__sZH+9E5s0_ziK1U_y9onN=g@mail.gmail.com>
 <20191204104733.GR2844@hirez.programming.kicks-ass.net>
 <3c83eaec-8f33-1b90-1c70-9e7c1c8b1855@physik.fu-berlin.de>
 <20191205225610.GB2532@roeck-us.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20191205225610.GB2532@roeck-us.net>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Guenter Roeck <linux@roeck-us.net>
Cc: Peter Zijlstra <peterz@infradead.org>, Geert Uytterhoeven <geert@linux-m68k.org>, Will Deacon <will.deacon@arm.com>, "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>, Andrew Morton <akpm@linux-foundation.org>, Nicholas Piggin <npiggin@gmail.com>, Linux-Arch <linux-arch@vger.kernel.org>, Linux MM <linux-mm@kvack.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Russell King <linux@armlinux.org.uk>, Heiko Carstens <heiko.carstens@de.ibm.com>, Rik van Riel <riel@surriel.com>, Yoshinori Sato <ysato@users.sourceforge.jp>, Rich Felker <dalias@libc.org>, Linux-sh list <linux-sh@vger.kernel.org>
List-Id: linux-arch.vger.kernel.org

Hi!

On 12/5/19 11:56 PM, Guenter Roeck wrote:
>> I have to admit, I have been very lazy with kernel updates. I have been
>> planning to upgrade to a much more recent release on my boards for a while
>> now, I have just been postponing it since the machines run very stable
>> with the current kernel I am using.
>>
> 
> Hey, if you write a qemu emulation, I'll be happy to run it on a regular
> basis :-)

There is working SH emulation in QEMU. I have been wanting to prepare a
current Debian/sh4 test image for that purpose for a while now.

For the time being, you can use the image by Aurelien Jarno:

> https://people.debian.org/~aurel32/qemu/sh4/

> Problem is really that the architecture doesn't get as much attention as
> it needs. The backtrace pointed to by Rob has been seen for a long time,
> but either there is no one with the knowledge to fix it, or they are all
> busy with other stuff.

I fully agree. I'm mostly busy with the userland stuff, i.e. Debian packages
for sh4 and not so much with the kernel.

Adrian

-- 
 .''`.  John Paul Adrian Glaubitz
: :' :  Debian Developer - glaubitz@debian.org
`. `'   Freie Universitaet Berlin - glaubitz@physik.fu-berlin.de
  `-    GPG: 62FF 8A75 84E0 2956 9546  0006 7426 3B37 F5B5 F913
