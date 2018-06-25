From: Dmitry Vyukov <dvyukov@google.com>
Subject: Re: [lkp-robot] a35353bb9e BUG: kernel hang in test stage
Date: Mon, 25 Jun 2018 10:52:03 +0200
Message-ID: <CACT4Y+ZV-gsMvR-jZDTV_3di0cqAnnedDmjHoQo-mQCqb3nxaw@mail.gmail.com>
References: <831EE4E5E37DCC428EB295A351E662494CBDE16D@shsmsx102.ccr.corp.intel.com>
 <0728338a-8d05-9d42-85cf-736f2017cf4f@cn.fujitsu.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <0728338a-8d05-9d42-85cf-736f2017cf4f@cn.fujitsu.com>
Sender: linux-kernel-owner@vger.kernel.org
To: kernel test robot <chenr.fnst@cn.fujitsu.com>
Cc: Ingo Molnar <mingo@kernel.org>, LKML <linux-kernel@vger.kernel.org>, linux-arch@vger.kernel.org, LKP <lkp@01.org>
List-Id: linux-arch.vger.kernel.org

On Mon, Jun 25, 2018 at 10:43 AM, kernel test robot
<chenr.fnst@cn.fujitsu.com> wrote:
>
> Greetings,
>
> 0day kernel testing robot got the below dmesg and the first bad commit is
>
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
>
> commit a35353bb9eb1990a44a0d7585f99e9589bcdb682
> Author:     Dmitry Vyukov <dvyukov@google.com>
> AuthorDate: Mon Jan 29 18:26:06 2018 +0100
> Commit:     Ingo Molnar <mingo@kernel.org>
> CommitDate: Mon Mar 12 12:15:35 2018 +0100
>
>     locking/atomic, asm-generic: Add KASAN instrumentation to atomic
> operations
>         KASAN uses compiler instrumentation to intercept all memory
> accesses. But it does
>     not see memory accesses done in assembly code. One notable user of
> assembly code
>     is atomic operations. Frequently, for example, an atomic reference
> decrement is
>     the last access to an object and a good candidate for a racy
> use-after-free.
>         Add manual KASAN checks to atomic operations.
>         Signed-off-by: Dmitry Vyukov <dvyukov@google.com>
>     Cc: Andrew Morton <akpm@linux-foundation.org>,
>     Cc: Andrey Ryabinin <aryabinin@virtuozzo.com>,
>     Cc: Linus Torvalds <torvalds@linux-foundation.org>
>     Cc: Mark Rutland <mark.rutland@arm.com>
>     Cc: Peter Zijlstra <peterz@infradead.org>
>     Cc: Thomas Gleixner <tglx@linutronix.de>
>     Cc: Will Deacon <will.deacon@arm.com>,
>     Cc: kasan-dev@googlegroups.com
>     Cc: linux-mm@kvack.org
>     Link:
> http://lkml.kernel.org/r/2fa6e7f0210fd20fe404e5b67e6e9213af2b69a1.1517246437.git.dvyukov@google.com
>     Signed-off-by: Ingo Molnar <mingo@kernel.org>
>
> 8bf705d130  locking/atomic/x86: Switch atomic.h to use atomic-instrumented.h
> a35353bb9e  locking/atomic, asm-generic: Add KASAN instrumentation to atomic
> operations
> 7daf201d7f  Linux 4.18-rc2
> deb5571a33  Add linux-next specific files for 20180625
> +------------------------------------------------------------------+------------+------------+-----------+---------------+
> |                                                                  |
> 8bf705d130 | a35353bb9e | v4.18-rc2 | next-20180625 |
> +------------------------------------------------------------------+------------+------------+-----------+---------------+
> | boot_successes                                                   | 893
> | 526        | 768       | 169           |
> | boot_failures                                                    | 56
> | 166        | 128       | 17            |
> | invoked_oom-killer:gfp_mask=0x                                   | 17
> | 13         |           |               |
> | Mem-Info                                                         | 55
> | 31         |           |               |
> | BUG:unable_to_handle_kernel                                      | 1
> | 0          | 13        | 2             |
> | Oops:#[##]                                                       | 1
> | 0          | 13        | 2             |
> | RIP:write_port                                                   | 1
> |            |           |               |
> | Kernel_panic-not_syncing:Fatal_exception                         | 1
> |            |           |               |
> | Out_of_memory:Kill_process                                       | 2
> | 5          |           |               |
> | Kernel_panic-not_syncing:Out_of_memory_and_no_killable_processes | 2
> | 4          |           |               |
> | RIP:copy_user_generic_unrolled                                   | 1
> |            |           |               |
> | RIP:__put_user_4                                                 | 1
> |            |           |               |
> | BUG:kernel_hang_in_test_stage                                    | 0
> | 135        | 87        | 7             |

Hi,

What is the timeout value? This commit could increase runtime, but I
would expect the increase to be almost invisible.
Am I reading it correctly that this bug rate is close to zero both
before and after the commit (both on 8bf705d130 and on next-20180625)?
If yes, can it be some temporal infrastructure problem? I know that
doing any timeout-related checks reliably is generally hard.

Thanks


> | IP-Config:Auto-configuration_of_network_failed                   | 0
> | 0          | 2         |               |
> | BUG:KASAN:slab-out-of-bounds_in_c                                | 0
> | 0          | 1         |               |
> | PANIC:double_fault                                               | 0
> | 0          | 1         |               |
> | RIP:error_entry                                                  | 0
> | 0          | 1         |               |
> | Kernel_panic-not_syncing:Machine_halted                          | 0
> | 0          | 1         |               |
> | WARNING:at_kernel/sched/core.c:#preempt_count_add                | 0
> | 0          | 1         |               |
> | RIP:preempt_count_add                                            | 0
> | 0          | 2         |               |
> | BUG:KASAN:use-after-free_in_f                                    | 0
> | 0          | 1         |               |
> | BUG:kernel_reboot-without-warning_in_test_stage                  | 0
> | 0          | 23        | 8             |
> | RIP:cmp_ex_search                                                | 0
> | 0          | 1         |               |
> | Kernel_panic-not_syncing:Fatal_exception_in_interrupt            | 0
> | 0          | 14        | 2             |
> | BUG:KASAN:slab-out-of-bounds_in_f                                | 0
> | 0          | 4         |               |
> | RIP:depot_fetch_stack                                            | 0
> | 0          | 10        |               |
> | BUG:KASAN:stack-out-of-bounds_in_p                               | 0
> | 0          | 5         |               |
> | BUG:KASAN:use-after-free_in_s                                    | 0
> | 0          | 2         |               |
> | WARNING:at_kernel/sched/core.c:#preempt_count_add/0x             | 0
> | 0          | 1         |               |
> | general_protection_fault:#[##]                                   | 0
> | 0          | 1         |               |
> | RIP:ftrace_ops_assist_func                                       | 0
> | 0          | 1         |               |
> | BUG:KASAN:slab-out-of-bounds_in_s                                | 0
> | 0          | 1         |               |
> | BUG:KASAN:use-after-free_in_n                                    | 0
> | 0          | 0         | 1             |
> +------------------------------------------------------------------+------------+------------+-----------+---------------+
>
> [    9.996837] Freeing unused kernel memory: 68K
> [    9.997637] rodata_test: all tests were successful
> /etc/rcS.d/S00fbsetup: line 3: /sbin/modprobe: not found
> Starting udev
> Kernel tests: Boot OK!
> BUG: kernel hang in test stage
>
>
>                                                           # HH:MM RESULT
> GOOD BAD GOOD_BUT_DIRTY DIRTY_NOT_BAD
> git bisect start v4.17 v4.16 --
> git bisect  bad 83beed7b2b26f232d782127792dd0cd4362fdc41  # 07:43  B     33
> 5    0  20  Merge branch 'fixes' of
> git://git.kernel.org/pub/scm/linux/kernel/git/evalenti/linux-soc-thermal
> git bisect  bad 8844a509863d7da41024194e40190ec00c2cd890  # 08:21  B    182
> 4   56  56  Merge branch 'misc.sparc' of
> git://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs
> git bisect  bad a8f8e8ac766ddb8702ef9baf01b7ae4f8d3a940c  # 08:57  B     57
> 1   20  20  Merge tag '4.17-SMB3-Fixes' of
> git://git.samba.org/sfrench/cifs-2.6
> git bisect  bad 642e7fd23353e22290e3d51719fcb658dc252342  # 09:33  B     42
> 1   18  18  Merge branch 'syscalls-next' of
> git://git.kernel.org/pub/scm/linux/kernel/git/brodo/linux
> git bisect  bad 5e46caf62d8910f6999fd378b743b9c0e1b21cf9  # 10:10  B     21
> 1    6   6  Merge branch 'x86-asm-for-linus' of
> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip
> git bisect  bad 701f3b314905ac05f09fc052c87b022825d831f2  # 10:47  B     18
> 1    7   7  Merge branch 'locking-core-for-linus' of
> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip
> git bisect good 61d1757f562da687bfd5277a652bd007ad2a8419  # 22:06  G    901
> 0  278 278  Merge branch 'core-debugobjects-for-linus' of
> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip
> git bisect good cc67ccecd3e6e2827b6706bad3287786202498f5  # 23:12  G    901
> 0  269 269  Merge branch 'core-headers-for-linus' of
> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip
> git bisect good 8747a29173c6eb6f4b3e8d3b3bcabc0fa132678a  # 00:18  G    905
> 0  297 297  Merge branch 'core-rcu-for-linus' of
> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip
> git bisect good 6ce5ae7977c89f2a09092954396a66c90e8213f2  # 01:25  G    908
> 0  251 251  mutex: Drop linkage.h from mutex.h
> git bisect good b06ed71a624ba088a3e3e3ac7d4185f48c7c1660  # 02:39  G    903
> 0  282 282  locking/atomic, asm-generic: Add
> asm-generic/atomic-instrumented.h
> git bisect  bad b3c39758c8a6972f02b43f83dba7fe7a352371b9  # 03:15  B     90
> 1   25  25  lockdep: Make the lock debug output more useful
> git bisect  bad a35353bb9eb1990a44a0d7585f99e9589bcdb682  # 03:57  B     96
> 1   33  33  locking/atomic, asm-generic: Add KASAN instrumentation to atomic
> operations
> git bisect good 8bf705d130396e69c04cd8e6e010244ad2ce71f4  # 08:33  G    901
> 0  286 286  locking/atomic/x86: Switch atomic.h to use atomic-instrumented.h
> # first bad commit: [a35353bb9eb1990a44a0d7585f99e9589bcdb682]
> locking/atomic, asm-generic: Add KASAN instrumentation to atomic operations
> git bisect good 8bf705d130396e69c04cd8e6e010244ad2ce71f4  # 08:56  G   1006
> 0  115 403  locking/atomic/x86: Switch atomic.h to use atomic-instrumented.h
> # extra tests with debug options
> git bisect  bad a35353bb9eb1990a44a0d7585f99e9589bcdb682  # 09:32  B    194
> 1   64  64  locking/atomic, asm-generic: Add KASAN instrumentation to atomic
> operations
> # extra tests on HEAD of linux-devel/devel-catchup-201806231618
> git bisect  bad 3a3fa6b63b7f74d04a2c1fc760e8f804fdd7a8ee  # 09:33  B     10
> 3    0   0  0day head guard for 'devel-catchup-201806231618'
> # extra tests on tree/branch linus/master
> git bisect  bad 7daf201d7fe8334e2d2364d4e8ed3394ec9af819  # 10:14  B     52
> 1    3   3  Linux 4.18-rc2
> # extra tests with first bad commit reverted
> git bisect good bdab4e4c216b552a2c616dbcd6b555b897421145  # 15:04  G    902
> 0   21  21  Revert "locking/atomic, asm-generic: Add KASAN instrumentation
> to atomic operations"
> # extra tests on tree/branch linux-next/master
> git bisect  bad deb5571a333c08f20bee8cb1324644f774b27a66  # 15:40  B    130
> 1   10  10  Add linux-next specific files for 20180625
>
> ---
> 0-DAY kernel test infrastructure                Open Source Technology
> Center
> https://lists.01.org/pipermail/lkp                          Intel
> Corporation
>
>
>
>
