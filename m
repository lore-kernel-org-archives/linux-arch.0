From: Rob Landley <rob@landley.net>
Subject: Re: [PATCH v6 10/18] sh/tlb: Convert SH to generic mmu_gather
Date: Thu, 5 Dec 2019 13:24:02 -0600
Message-ID: <e2cf6780-ba7e-d6f6-9d15-92e182f98e84@landley.net>
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

On 12/4/19 4:47 AM, Peter Zijlstra wrote:
> On Tue, Dec 03, 2019 at 12:19:00PM +0100, Geert Uytterhoeven wrote:
>> Hoi Peter,
>>
>> On Tue, Feb 19, 2019 at 11:35 AM Peter Zijlstra <peterz@infradead.org> wrote:
>>> Generic mmu_gather provides everything SH needs (range tracking and
>>> cache coherency).
>>>
>>> Cc: Will Deacon <will.deacon@arm.com>
>>> Cc: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
>>> Cc: Andrew Morton <akpm@linux-foundation.org>
>>> Cc: Nick Piggin <npiggin@gmail.com>
>>> Cc: Yoshinori Sato <ysato@users.sourceforge.jp>
>>> Cc: Rich Felker <dalias@libc.org>
>>> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
>>
>> I got remote access to an SH7722-based Migo-R again, which spews a long
>> sequence of BUGs during userspace startup.  I've bisected this to commit
>> c5b27a889da92f4a ("sh/tlb: Convert SH to generic mmu_gather").
> 
> Whoopsy.. also, is this really the first time anybody booted an SH
> kernel in over a year ?!?

No, but most people running this kind of hardware tend not to upgrade to current
kernels on a regular basis.

The j-core guys tested the 5.3 release. I can't find an email about 5.4 so I
dunno if that's been tested yet?

I just tested yesterday's git and it works fine with
http://lkml.iu.edu/hypermail/linux/kernel/1912.0/01554.html installed, modulo it
_still_ has the suprious stack dump shortly before calling init, which I've
complained about on linux-sh and off for a year now?

------------[ cut here ]------------
WARNING: CPU: 0 PID: 1 at mm/slub.c:2451 kmem_cache_free_bulk+0x2c2/0x37c

CPU: 0 PID: 1 Comm: swapper Not tainted 5.4.0 #1
PC is at kmem_cache_free_bulk+0x2c2/0x37c
PR is at kmem_cache_alloc_bulk+0x36/0x1a0
PC  : 8c0a6fae SP  : 8f829e9c SR  : 400080f0
TEA : c0001240
R0  : 8c0a6de4 R1  : 00000100 R2  : 00000100 R3  : 00000000
R4  : 8f8020a0 R5  : 00000dc0 R6  : 8c01d66c R7  : 8fff5180
R8  : 8c011a00 R9  : 8fff5180 R10 : 8c01d66c R11 : 80000000
R12 : 00007fff R13 : 00000dc0 R14 : 8f8020a0
MACH: 0000017a MACL: 0ae4849d GBR : 00000000 PR  : 8c0a709e

Call trace:
 [<(ptrval)>] copy_process+0x218/0x1094
 [<(ptrval)>] copy_process+0x7ba/0x1094
 [<(ptrval)>] kmem_cache_alloc_bulk+0x36/0x1a0
 [<(ptrval)>] restore_sigcontext+0x94/0x1b0
 [<(ptrval)>] restore_sigcontext+0x70/0x1b0
 [<(ptrval)>] copy_process+0x218/0x1094
 [<(ptrval)>] sysfs_slab_add+0x106/0x354
 [<(ptrval)>] restore_sigcontext+0x70/0x1b0
 [<(ptrval)>] copy_process+0x218/0x1094
 [<(ptrval)>] copy_process+0x218/0x1094
 [<(ptrval)>] fprop_fraction_single+0x38/0xa4
 [<(ptrval)>] pipe_read+0x7a/0x23c
 [<(ptrval)>] restore_sigcontext+0x70/0x1b0
 [<(ptrval)>] restore_sigcontext+0x94/0x1b0
 [<(ptrval)>] alloc_pipe_info+0x162/0x1c8
 [<(ptrval)>] restore_sigcontext+0x94/0x1b0
 [<(ptrval)>] restore_sigcontext+0x70/0x1b0
 [<(ptrval)>] handle_bad_irq+0x154/0x188
 [<(ptrval)>] raw6_exit_net+0x0/0x14
 [<(ptrval)>] prepare_stack+0xe4/0x2fc
 [<(ptrval)>] sys_sched_get_priority_min+0x18/0x28
 [<(ptrval)>] ndisc_net_exit+0x4/0x24

---[ end trace 6ce4eefeb577b078 ]---

But it's cosmetic...

I haven't got one of the new Turtle boards yet (next time I visit Japan...) and
the USB connector broke off my old one, so I haven't got test hardware in my bag
to boot it on with me at this coffee shop. So just qemu testing at the moment.
The actual j-core deployment environment I'm working on this month is a deeply
embedded thing with 128k sram so isn't running Linux. :)

Rob
