From: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Subject: Re: [PATCH v6 10/18] sh/tlb: Convert SH to generic mmu_gather
Date: Thu, 5 Dec 2019 20:30:17 +0100
Message-ID: <3c83eaec-8f33-1b90-1c70-9e7c1c8b1855@physik.fu-berlin.de>
References: <20190219103148.192029670@infradead.org>
 <20190219103233.443069009@infradead.org>
 <CAMuHMdW3nwckjA9Bt-_Dmf50B__sZH+9E5s0_ziK1U_y9onN=g@mail.gmail.com>
 <20191204104733.GR2844@hirez.programming.kicks-ass.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20191204104733.GR2844@hirez.programming.kicks-ass.net>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Peter Zijlstra <peterz@infradead.org>, Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Will Deacon <will.deacon@arm.com>, "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>, Andrew Morton <akpm@linux-foundation.org>, Nicholas Piggin <npiggin@gmail.com>, Linux-Arch <linux-arch@vger.kernel.org>, Linux MM <linux-mm@kvack.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Russell King <linux@armlinux.org.uk>, Heiko Carstens <heiko.carstens@de.ibm.com>, Rik van Riel <riel@surriel.com>, Yoshinori Sato <ysato@users.sourceforge.jp>, Rich Felker <dalias@libc.org>, Linux-sh list <linux-sh@vger.kernel.org>, Guenter Roeck <linux@roeck-us.net>
List-Id: linux-arch.vger.kernel.org

Hi!

On 12/4/19 11:47 AM, Peter Zijlstra wrote:
>> I got remote access to an SH7722-based Migo-R again, which spews a long
>> sequence of BUGs during userspace startup.  I've bisected this to commit
>> c5b27a889da92f4a ("sh/tlb: Convert SH to generic mmu_gather").
> 
> Whoopsy.. also, is this really the first time anybody booted an SH
> kernel in over a year ?!?

I have to admit, I have been very lazy with kernel updates. I have been
planning to upgrade to a much more recent release on my boards for a while
now, I have just been postponing it since the machines run very stable
with the current kernel I am using.

Adrian

-- 
 .''`.  John Paul Adrian Glaubitz
: :' :  Debian Developer - glaubitz@debian.org
`. `'   Freie Universitaet Berlin - glaubitz@physik.fu-berlin.de
  `-    GPG: 62FF 8A75 84E0 2956 9546  0006 7426 3B37 F5B5 F913
