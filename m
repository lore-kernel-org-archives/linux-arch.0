From: kernel test robot <chenr.fnst@cn.fujitsu.com>
Subject: [lkp-robot] a35353bb9e BUG: kernel hang in test stage
Date: Mon, 25 Jun 2018 16:43:28 +0800
Message-ID: <0728338a-8d05-9d42-85cf-736f2017cf4f@cn.fujitsu.com>
References: <831EE4E5E37DCC428EB295A351E662494CBDE16D@shsmsx102.ccr.corp.intel.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
        boundary="------------A3949C00DD8EFFA86862B870"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <831EE4E5E37DCC428EB295A351E662494CBDE16D@shsmsx102.ccr.corp.intel.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Dmitry Vyukov <dvyukov@google.com>
Cc: Ingo Molnar <mingo@kernel.org>, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, LKP <lkp@01.org>
List-Id: linux-arch.vger.kernel.org

--------------A3949C00DD8EFFA86862B870
Content-Type: text/plain; charset="gbk"; format=flowed
Content-Transfer-Encoding: 7bit


Greetings,

0day kernel testing robot got the below dmesg and the first bad commit is

https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master

commit a35353bb9eb1990a44a0d7585f99e9589bcdb682
Author:     Dmitry Vyukov <dvyukov@google.com>
AuthorDate: Mon Jan 29 18:26:06 2018 +0100
Commit:     Ingo Molnar <mingo@kernel.org>
CommitDate: Mon Mar 12 12:15:35 2018 +0100

     locking/atomic, asm-generic: Add KASAN instrumentation to atomic operations
     
     KASAN uses compiler instrumentation to intercept all memory accesses. But it does
     not see memory accesses done in assembly code. One notable user of assembly code
     is atomic operations. Frequently, for example, an atomic reference decrement is
     the last access to an object and a good candidate for a racy use-after-free.
     
     Add manual KASAN checks to atomic operations.
     
     Signed-off-by: Dmitry Vyukov <dvyukov@google.com>
     Cc: Andrew Morton <akpm@linux-foundation.org>,
     Cc: Andrey Ryabinin <aryabinin@virtuozzo.com>,
     Cc: Linus Torvalds <torvalds@linux-foundation.org>
     Cc: Mark Rutland <mark.rutland@arm.com>
     Cc: Peter Zijlstra <peterz@infradead.org>
     Cc: Thomas Gleixner <tglx@linutronix.de>
     Cc: Will Deacon <will.deacon@arm.com>,
     Cc: kasan-dev@googlegroups.com
     Cc: linux-mm@kvack.org
     Link: http://lkml.kernel.org/r/2fa6e7f0210fd20fe404e5b67e6e9213af2b69a1.1517246437.git.dvyukov@google.com
     Signed-off-by: Ingo Molnar <mingo@kernel.org>

8bf705d130  locking/atomic/x86: Switch atomic.h to use atomic-instrumented.h
a35353bb9e  locking/atomic, asm-generic: Add KASAN instrumentation to atomic operations
7daf201d7f  Linux 4.18-rc2
deb5571a33  Add linux-next specific files for 20180625
+------------------------------------------------------------------+------------+------------+-----------+---------------+
|                                                                  | 8bf705d130 | a35353bb9e | v4.18-rc2 | next-20180625 |
+------------------------------------------------------------------+------------+------------+-----------+---------------+
| boot_successes                                                   | 893        | 526        | 768       | 169           |
| boot_failures                                                    | 56         | 166        | 128       | 17            |
| invoked_oom-killer:gfp_mask=0x                                   | 17         | 13         |           |               |
| Mem-Info                                                         | 55         | 31         |           |               |
| BUG:unable_to_handle_kernel                                      | 1          | 0          | 13        | 2             |
| Oops:#[##]                                                       | 1          | 0          | 13        | 2             |
| RIP:write_port                                                   | 1          |            |           |               |
| Kernel_panic-not_syncing:Fatal_exception                         | 1          |            |           |               |
| Out_of_memory:Kill_process                                       | 2          | 5          |           |               |
| Kernel_panic-not_syncing:Out_of_memory_and_no_killable_processes | 2          | 4          |           |               |
| RIP:copy_user_generic_unrolled                                   | 1          |            |           |               |
| RIP:__put_user_4                                                 | 1          |            |           |               |
| BUG:kernel_hang_in_test_stage                                    | 0          | 135        | 87        | 7             |
| IP-Config:Auto-configuration_of_network_failed                   | 0          | 0          | 2         |               |
| BUG:KASAN:slab-out-of-bounds_in_c                                | 0          | 0          | 1         |               |
| PANIC:double_fault                                               | 0          | 0          | 1         |               |
| RIP:error_entry                                                  | 0          | 0          | 1         |               |
| Kernel_panic-not_syncing:Machine_halted                          | 0          | 0          | 1         |               |
| WARNING:at_kernel/sched/core.c:#preempt_count_add                | 0          | 0          | 1         |               |
| RIP:preempt_count_add                                            | 0          | 0          | 2         |               |
| BUG:KASAN:use-after-free_in_f                                    | 0          | 0          | 1         |               |
| BUG:kernel_reboot-without-warning_in_test_stage                  | 0          | 0          | 23        | 8             |
| RIP:cmp_ex_search                                                | 0          | 0          | 1         |               |
| Kernel_panic-not_syncing:Fatal_exception_in_interrupt            | 0          | 0          | 14        | 2             |
| BUG:KASAN:slab-out-of-bounds_in_f                                | 0          | 0          | 4         |               |
| RIP:depot_fetch_stack                                            | 0          | 0          | 10        |               |
| BUG:KASAN:stack-out-of-bounds_in_p                               | 0          | 0          | 5         |               |
| BUG:KASAN:use-after-free_in_s                                    | 0          | 0          | 2         |               |
| WARNING:at_kernel/sched/core.c:#preempt_count_add/0x             | 0          | 0          | 1         |               |
| general_protection_fault:#[##]                                   | 0          | 0          | 1         |               |
| RIP:ftrace_ops_assist_func                                       | 0          | 0          | 1         |               |
| BUG:KASAN:slab-out-of-bounds_in_s                                | 0          | 0          | 1         |               |
| BUG:KASAN:use-after-free_in_n                                    | 0          | 0          | 0         | 1             |
+------------------------------------------------------------------+------------+------------+-----------+---------------+

[    9.996837] Freeing unused kernel memory: 68K
[    9.997637] rodata_test: all tests were successful
/etc/rcS.d/S00fbsetup: line 3: /sbin/modprobe: not found
Starting udev
Kernel tests: Boot OK!
BUG: kernel hang in test stage


                                                           # HH:MM RESULT GOOD BAD GOOD_BUT_DIRTY DIRTY_NOT_BAD
git bisect start v4.17 v4.16 --
git bisect  bad 83beed7b2b26f232d782127792dd0cd4362fdc41  # 07:43  B     33     5    0  20  Merge branch 'fixes' of git://git.kernel.org/pub/scm/linux/kernel/git/evalenti/linux-soc-thermal
git bisect  bad 8844a509863d7da41024194e40190ec00c2cd890  # 08:21  B    182     4   56  56  Merge branch 'misc.sparc' of git://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs
git bisect  bad a8f8e8ac766ddb8702ef9baf01b7ae4f8d3a940c  # 08:57  B     57     1   20  20  Merge tag '4.17-SMB3-Fixes' of git://git.samba.org/sfrench/cifs-2.6
git bisect  bad 642e7fd23353e22290e3d51719fcb658dc252342  # 09:33  B     42     1   18  18  Merge branch 'syscalls-next' of git://git.kernel.org/pub/scm/linux/kernel/git/brodo/linux
git bisect  bad 5e46caf62d8910f6999fd378b743b9c0e1b21cf9  # 10:10  B     21     1    6   6  Merge branch 'x86-asm-for-linus' of git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip
git bisect  bad 701f3b314905ac05f09fc052c87b022825d831f2  # 10:47  B     18     1    7   7  Merge branch 'locking-core-for-linus' of git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip
git bisect good 61d1757f562da687bfd5277a652bd007ad2a8419  # 22:06  G    901     0  278 278  Merge branch 'core-debugobjects-for-linus' of git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip
git bisect good cc67ccecd3e6e2827b6706bad3287786202498f5  # 23:12  G    901     0  269 269  Merge branch 'core-headers-for-linus' of git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip
git bisect good 8747a29173c6eb6f4b3e8d3b3bcabc0fa132678a  # 00:18  G    905     0  297 297  Merge branch 'core-rcu-for-linus' of git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip
git bisect good 6ce5ae7977c89f2a09092954396a66c90e8213f2  # 01:25  G    908     0  251 251  mutex: Drop linkage.h from mutex.h
git bisect good b06ed71a624ba088a3e3e3ac7d4185f48c7c1660  # 02:39  G    903     0  282 282  locking/atomic, asm-generic: Add asm-generic/atomic-instrumented.h
git bisect  bad b3c39758c8a6972f02b43f83dba7fe7a352371b9  # 03:15  B     90     1   25  25  lockdep: Make the lock debug output more useful
git bisect  bad a35353bb9eb1990a44a0d7585f99e9589bcdb682  # 03:57  B     96     1   33  33  locking/atomic, asm-generic: Add KASAN instrumentation to atomic operations
git bisect good 8bf705d130396e69c04cd8e6e010244ad2ce71f4  # 08:33  G    901     0  286 286  locking/atomic/x86: Switch atomic.h to use atomic-instrumented.h
# first bad commit: [a35353bb9eb1990a44a0d7585f99e9589bcdb682] locking/atomic, asm-generic: Add KASAN instrumentation to atomic operations
git bisect good 8bf705d130396e69c04cd8e6e010244ad2ce71f4  # 08:56  G   1006     0  115 403  locking/atomic/x86: Switch atomic.h to use atomic-instrumented.h
# extra tests with debug options
git bisect  bad a35353bb9eb1990a44a0d7585f99e9589bcdb682  # 09:32  B    194     1   64  64  locking/atomic, asm-generic: Add KASAN instrumentation to atomic operations
# extra tests on HEAD of linux-devel/devel-catchup-201806231618
git bisect  bad 3a3fa6b63b7f74d04a2c1fc760e8f804fdd7a8ee  # 09:33  B     10     3    0   0  0day head guard for 'devel-catchup-201806231618'
# extra tests on tree/branch linus/master
git bisect  bad 7daf201d7fe8334e2d2364d4e8ed3394ec9af819  # 10:14  B     52     1    3   3  Linux 4.18-rc2
# extra tests with first bad commit reverted
git bisect good bdab4e4c216b552a2c616dbcd6b555b897421145  # 15:04  G    902     0   21  21  Revert "locking/atomic, asm-generic: Add KASAN instrumentation to atomic operations"
# extra tests on tree/branch linux-next/master
git bisect  bad deb5571a333c08f20bee8cb1324644f774b27a66  # 15:40  B    130     1   10  10  Add linux-next specific files for 20180625

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/lkp                          Intel Corporation





--------------A3949C00DD8EFFA86862B870
Content-Type: application/gzip; name=
	"dmesg-yocto-lkp-hsw01-10020180625072952x86_64-randconfig-s1-062315204.16.0-rc5-00029-ga35353b1.gz"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
	filename*0="dmesg-yocto-lkp-hsw01-10020180625072952x86_64-randconfig-s1-";
	filename*1="062315204.16.0-rc5-00029-ga35353b1.gz"

H4sICAedMFsAA2RtZXNnLXlvY3RvLWxrcC1oc3cwMS0xMDA6MjAxODA2MjUw
NzI5NTI6eDg2XzY0LXJhbmRjb25maWctczEtMDYyMzE1MjA6NC4xNi4wLXJj
NS0wMDAyOS1nYTM1MzUzYjoxAOxbW3PbSK5+PvkVqN2Hkc9aMpt3cktbK9ty
RseRrbGczNRJpVQU2ZQ5pkgOL77Mrz9Aty4UKTl2xudtlYolksDXaDQaDaCb
3MvjZ/DTpEhjDlECBS+rDG8E/ANvPuNPZe755eye5wmPP0RJVpWzwCs9F5Qn
Zf3RdKaphrF6HPNk56kyV7y5qX5IqxIf7zxi8mv1qMWpOubcCe0PsvVZmZZe
PCuiP/kuVahxAvlwzv10meW8KKJkAZ+ipHrq9Xow8XJxY/jpgi6DNOG9D6dp
WtLN8o6DhO99+Ar4UXoS9ZsEgAeO3GkCeo+ZPaWb+0ZXSNZdeJqB/+bQuZ9X
URz8O77PunfFk6IeQWfh+xtOs6f3FFAVZjFFNaFzzueRt7rddY6O4O8MpuMJ
TG6Gw/HkFsbI8z9VAqoBiuYyxzUcOJveEoLdlPEsXS69JIA4SlApOXaqfxLw
h5PcWypwVyWLWekV97PMSyK/zyDg82oBXoYX8mfxXOR/zLz40XsuZjzx5jEP
IPerDMeY9/DHzM+qWYF6R/VHS44D1cdBg4SXvShMvCUv+gpkeZSU9z1s+H5Z
LPoov2ywy6BIwzJO/fsq2wiRLKPZo1f6d0G66IubkKZZsfoZp14wQ/GDqLjv
qwiNQ1pubigQ5POgt4ySNJ/5aZWUfZs6UfJl0IvTBZrQA4/7PM8hWiANn+FN
cW9t1f2yfFZAGLoUm25MlWPGDBU7VqPa3nxYeH0EW3ox5I+k6/v+iRz0bsmL
sjjJq6T7R8UrfvKc+mXalabwqLCTJ9ucmXo3x0FC6DBadAvWVUxVI+STmEys
G5B8rvjb9UkxVdalwRZkJrPdlaXNHT5njqN4uu4pgWXYRug43DFsZ+4Hc9NW
3XlUcL/sSlimnvQelvT7z+5rEdbtGoqmapraNR3TbXSpS+M/xw75d/2a/CeH
5YfT6+vb2Wg8+Djsn2T3C9nt76gGZ1DXPHmt3Cfrjh6epnsMhwyd52GvuKvK
IH1M+kpzfqGMJ2FWuTCtsizNhcv4bTr4MoSQe2WVc+GImAs/PdkWhGi8giRL
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
89X//In1zIhj8J359Pkn+Lrzv+mMiukFiAAA

--------------A3949C00DD8EFFA86862B870
Content-Type: application/gzip; name=
	"dmesg-yocto-lkp-hsw01-10020180625052206x86_64-randconfig-s1-062315204.16.0-rc5-00028-g8bf705d1.gz"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
	filename*0="dmesg-yocto-lkp-hsw01-10020180625052206x86_64-randconfig-s1-";
	filename*1="062315204.16.0-rc5-00028-g8bf705d1.gz"

H4sICFqcMFsAA2RtZXNnLXlvY3RvLWxrcC1oc3cwMS0xMDA6MjAxODA2MjUw
NTIyMDY6eDg2XzY0LXJhbmRjb25maWctczEtMDYyMzE1MjA6NC4xNi4wLXJj
NS0wMDAyOC1nOGJmNzA1ZDoxAOxbW1PjSLJ+Pv0rMnYfxpzFRqW7vOGNNWC6
fWiDB9M9HaeDcMhSyWiQJY0uBubXn8wqX2TJpqGH87aOAFtS5ldZWVlZmVkl
7mbRM3hJnCcRhzCGnBdlijd8/oHXn/GnInO9YvrAs5hHH8I4LYup7xZuF5Qn
Zf3RdFVRDWP1OOLxzlPFDZyZyj4kZYGPdx4x+bV61OBUHdNyAvuDbH1aJIUb
TfPwT75LFWgugXw4516ySDOe52E8h89hXD51Oh0Yu5m4Mfh8QZd+EvPOh9Mk
Kehmcc9Bwnc+fAf8KB2JeicBYMmRO4lB7zCzo7Qzz2hTm3Z7bs8CSzF8aD3M
yjDy/+25YZYcQWvueRsus6N3FFAVZjFFNaF1zmehu7rddo6O4O8MJqMxjG8G
g9H4FkbI8z9lDKoBit5V1C6z4WxySwh2Xb6zZLFwYx+iMEaFZNih3onPlyeZ
u1Dgvozn08LNH6apG4dej4HPZ+Uc3BQv5M/8Oc/+mLrRo/ucT3nsziLuQ+aV
KY4v7+CPqZeW0xx1jqoPFxwHqYcDBjEvOmEQuwue9xRIszAuHjrY8MMin/dQ
ftlgm0GeBEWUeA9luhEiXoTTR7fw7v1k3hM3IUnSfPUzSlx/iuL7Yf7QUxEa
h7PY3FDAz2Z+ZxHGSTb1kjIuejZ1ouALvxMlczSfJY96PMsgnCMNn+JNcW9t
0b2ieFZAGLkUm25MlGPGDBU7VqHa3lzO3R6CLdwIskfS9UPvRA54u+B5kZ9k
Zdz+o+QlP3lOvCJpRw9p+z5/VNjJk21OTb2d4SAhdBDO2zlrK6aqEfJJRObV
9km+rvjf9kgxZdqmwRZkJrO7KytjmqI5JjcdT9E93+Ymx8mj6rrrqx63WKB3
Z2HOvaItYZl60lku6Pef7dcirNs1FF2xFaWtqmq31qU2jf8MO+Td9yrynxyW
H06vr2+nw1H/46B3kj7MZbd/oBqcQW3z5LVyn6w7eniK7jEcMnSeBZ38viz8
5DHuKfX5hTKeBGnZhUmZpkkm3MW3Sf/rAALuFmXGhRNiXfjlybYgQOMVJGmC
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
I0QGtcXVcNpFJPM+aixoKfvZzk9H592fj3/6+VPn/UX35OwXvFJ91/r4uKX1
wO0Jl8uxB7xuATd/Nxv8sR860zuPIeWkEq5MK8U53F8qCJU4nKC4Zm1op5Bt
MkQFDMTjr3D5s6qQlWS/38/ZbMC51XAUtsU/3p98EiTpovIkymaJnZEx8ug3
8SPnFu0hCjSioXPECYqCNHVDCWlaUrV06WBjeBVhvxxCBrzkF6D4S1ri4Kdn
fzfFq0L6Nz/Kr/GghYoWtUZcmM42uiYlI59Rq15ArYzJfbOAJRHxV9Htdme0
em4RJk8tlQKg6tUQA87P4MnGw+s6sZYaB1mPGkdJrbGxlsK/IhmuOy66/Wya
2ZdRdceTbDHgToKcyMIaVaihWBMVOullg7HFV0M01HG9JWcRCrzEZDLsWrUG
LXshtUzqw444ecVh2lXXdfYTEGSyxT89Qcx16oigfGPZOP/KU/Kf9t50yZEj
SRP8XXwKyOz84JWk3UeKUHpZbFYVpStJbrK42z0lJRAEjsyYjACiAEQms2f2
3VdVzQ9zd3M3dwSczG1hlBQzgFBTt8vN1L5PTdVgJWJBY23Rd5goC3NKbY/3
cHpeHmhIsCo87hRHQc5AnHKmhKPDspzW+AThcIC4lFEhz0yoPwzhdhcGfAnn
U5B3DqQ3sSzd1QRZfKsedtAt4Un433fbzWc4RZrzRDBZTICgOER+Cw2Q2AAf
y9JNyVFVEdwQooudg2fc5WG/Dpf3ocEU2hXbS30fFRIKDw9Q6HGP92Gp55c7
WFRwqKTFWeCjvhGSMzZJ3iI0ECq12tz+sjzDKXm5hgqeaTKscR6LaPYIpdCv
ZREP2Nv7FTbYo2jcO5rOT7A+QrdHI4ydvsZ2iljWEEL/L4V0sd+C5uUGEw4d
cC5L7J249ob8gdu1vzsc3jw+YO0l1p5Hb4mwXIYZGlLohbxTMP9Xm82SMkVD
Mb9rjZx1RSc9hORJodTy9HgD0qsdDVkk7jT3k58RsB5qytv75XaPQZujt9ha
fMo2LuAIbo87FxZZnK7nspdvsJdFNLclo9hmRSEwXFBwCa/GZ/ge39CLEEnD
a6cqaTrb08S9PdPSCVsTLlbR3JCCrrphy28ftsvHPcJn9BY3x00KXbw2heoy
YxKuEQq1WhVJy7AGFlhXqMgJd/lQH6oKPkHs4kJehjULe/18WGKNaErQGxZX
BoPbkeTx3fItPGH3fgnb14pWWaxKJKq5ou4LDw+cNSpfYV4CWhAVttTHRVwx
4crqU9fcPO7grad0hom3Hi/jFsvKoWzp+YADioJxh8N0Vr0zk69aM1Nipkrc
AiutoQlUhXXrVYHTEiveyL7mQkPbzUV6qZjGpxtcD4/n5TtE+2ho2/XxFq9N
L97uMDDLw/tijq32NHsltVZFQwUVQgxr8dP7nxLyYeOKFyAFVmjoR0RcV+cl
FkTDFcsZRTOTtRYiBQeB0Gx6Cs5gfFHQpw7kd7jj8WhygsmjygZjGjF6QaqJ
b1A82u+gMc5OrZC0nheDFiC4JUlucXLKaJuGitBeR45Zy5/+46dvvv7rX0F2
udrh6vP6XbkNKHxZbmxdMFy7fvndj+ikIeVzENFwWvaRhEGk9+VPJCFunqPr
h93t1hh+bbX2bvHtn/769Z9/KvxChDKLH15+9+fly6///XnThYkrU2sFawEq
TELNC3ub1eLlHxNFFy+/aXzbqqbWGk9DL/+1U1RsoPLftb5lNwJk29+CbK3Q
EKf58o8/BqGqyRvFFi+Zq4ua4n/wrW8/Jprx2mr0InjJWVvISviWt77FjnzJ
RUehqBU6jXeCXnJZ1lDtdvrGg3Hu4FsVFQXDyzkJNeS6LRvV0GjyEXqxvX/2
3X53qI1sYyiIUgioAlvNYf9cGeggOMPE3wmF0cNDEsPtJnzH2kpKLTjtn7Na
A302denw907pxz0ecIOjkAYbHOMbnN+DIlppMGgC/P64D3RNovzpbnUDbypF
tSQR470O3z7u4+8545p3ioc0yM85BhgJO9hzozGWBu6mIebGc7AhKd7+OvX8
HSzWz73l9MvyYf3wXKvw+/p+VcqrL5gU5NfzPbpyskbPc7BIDHvzx1bne+QK
4dtG98ZS9I1Q8FXchwI2NixW9vvHqOyTULL8CkuGr4rmG6a8gI9F38NvUe/D
p9AxUEvYSMqPy/NrOENXf10+3G8KbfQlPrYWqdQtz/cPpLIeUhSGhbAxWv8C
5+Gy67hTEs3Uousw6gR1OtcaG3p/u8cQivAbnAKec+oQJIyfc+Xq7gs9DYcl
1+loKjHcy6zVyVWTHmC9RxYEv6BMPvsz1MtTZ96v9jCHcG55euo9ZSjckGwg
rMIZIxSupxt+LKcb/FrNq9BE2DSqT/U0e/PHuresR+wLOgNHpQjx9fd/IEIA
tkj8/7qIo+N03cFShC7Ga4pFFwtJjcI+honvyk4Gm0i1e9nisSs1n5nL9nTv
fO7tbjiKW8Oi/oad05KassOhvqrd5yLMhKjbubKmp+cF1aDu+/A52ft4v9ml
e7/4Xy0q6RZl3evPF/xTrOjHLz5ZiE+xeh//TL/S4+h3/qkUhQT/1JDwz/gr
F676XWhT/M4+hWUNfoe/M1FqZp8KRm8G+xRDBcEvXy3Cq1TXTAupm/PhOYqT
KlfosWW1PllIX1QLn6/rerGiXqyoU1kfVtYnVZcw5+q6WI7rrGVQpcW5yu0d
UjrVWXGDKOVSgAMBGLzhbxjarv67k3ikYcWf/gLzF7bGL18c3uIM+GF/9z4S
9RgsTHItS/Ey+W8t48lc/Dtm4VrgVfBH+HdxfnW7CfWEs9+Cfo6n0+LhVZhm
yxDS4vRu9RDyCcXgHsFspX68TI15UOCjQIIGf9iCPtDvgmsb9CuFCTYWBowZ
tih+ql8Wz+gCM9LSm1o17DmMVEv0fSkLwIdStSlUazdVtWQ4d0i1j1X7tmqh
pqpWBBH8HTHdSDV8CKrBHCtKB409qsMnDEZ6d3gVadcUGAQ+GgTMyzLwgX7n
dXc7egxmTnJ92o/rWq9xeHolvS7W61p6uSC9CoHCvg75yftnx/UXtBTVT3CE
6dETfPwE3645H6p5eALmWn+Ak96pVu8ppweqJ8ChVB+UxeqVz6r37FmBS1f6
OaPwMaifsMxSv6CyUCrMwYU1Eh/EjYVDdZ/+2KeifgIMbtFBIh5awYsncFs8
geH3iKGb3haknyAlIsL0BBU/QRV9VPyCixN11dAgn+6224datSJaCD5S+j6u
vFSYPR6L+/AywdHYS1LgjcJvcFVlyamvoxasRf0QbS09BEbTUP2fORraQr8r
esgw+oZjFKBE/Vv6Wa3fCmOCfhfG+Jlf0IfQPSp0ywIOQIr0Ix6Y1c9r/U6z
UH8KrklKF/Qh1F+EqUnJv8brl7V+byWNL24usBtxzuDAqxQNqA/PYDasFDC2
4pJnwIvAWXgGRsqDgfZMaIXrBH7TfIjmnl/SUfCDHiV/p0mOHSWUDjM+6C8n
KkZoxC/QJSfxsvUOtJDWFvpN/arhh6L+xUSSioaeC+NtXn89UYVmyOT98HjG
q0ylw9e/3d7dVY5I+FJ8XBf9ZEH76wJ3h8NxcVqtj+idt12sX9/e1cu/MBwv
7qCmcMEtrYt29mdv758r6S3YMp/TQecZbPHPuXRouWAQmrstfUPngM/D+Yi+
QIhe1caNUMbiaKARcNyu6Fol/dtfASQK39XPZI3nsebTIrsUrw+gMfHb0ZUK
b/xRXNtr05WoWUgmZqIrUT1uCAm6kv4ES+4gXYlCmOUtQ1eimOYFVDxMV5Ko
pcfm6UoUNtJNpCuxlOUFyTlIV5KkJTYsQ1eiZEgPNpKupALesixdiYKerkSO
pCuhgIYDhZhEV1Ihr+wYjlCFS5psAl2p6KpmQV9k6EqSddqNrYokP7EJdCUW
gj1Zj6UfSd4bM0VeB1NpJF2JJQxdS8zSlSRK4arzdCXK2pI0GktXYiEnU7Xv
oysVXfDkfBKVSIVswe/n6UqFdzxlMSkmPMPAe14uO3m6kgpYoo3H05VYSCg1
kq5EaTh5u9F0JRVwJXvWT1eiHOwAfhxdidKa0fs+nq6kQhSqLEdXoqSh1JdZ
upJEvZ5CV2IR2CL0JLoSCzlZrnADdCUJUljoUXQliodAWyPoSgwoEaKDT6Ar
qZCvfDIydCVKc0327yi6EuWFIO2j6EqSd4ZPYQexDK6JI+lKFAcLjY+jK0ma
uKBpFdIavWwzdKWiS8sYkWoiXUkFHVrdfXQlSlhCSa9JVyq6s4xbyZXoSlTo
FbGL16ErFaYBVsQuXoeuRIWcQgZdia5EhXCotlejK1EhQhsduhL/oKVt0ZVo
bbTpSgTfdZqurJU0+AfeYh94mq6MSjfoSlhgR9GVUfkuXamkTdGVsOCYTumS
rVSYMSCQcpbjATpmKyVvsZWRgsBWOltzG4h0delK6bnkabpScO8SdKW1gYSL
u1N16J0uu8P0ZLZSw1RWebbSYcaKX4mtfF/TEHAgpDgkV6ErXbej/2vRlYph
5NhJdCVeF47mZoOuDC2ZRFcKpnWim+FMa9v0+/j5/BS2UosuW8mpLjFbKUkq
1fHGikbXh8/pzrcON5kRbCVeJ0anxg+PrVQcxFmarYzqxYt6wa+KRXSlLSv2
7aV8pWJxl3Jh0fCD5ZDzYb5SgVWB5lUfX6m4puyuI/hKzFmCx4MhvlJxI5ye
j69UPJyjZ+ArFXdW+ln4SgVdxsQsfKXC2wd8Lr4SMUlEIK7NVyo4qdtZ+UqF
5wo9G1+ppLNOz8dXwuwVys3JVyolNDNz8pVKYciDWfhKBb0a3tV5qESlDDdu
BJVoOM3YqQwZVN9yPx+VqDTzVsxLJSoEkkWeSiyoPuXsJR2F1/XVfFSiwvjh
M1KJmBwSHTOGqEQa9Zp+kxWXaMQAlwibkEImt8UldpXVZCLzaE1EZCLytA1u
jzOpW2wiKGyYHhgX3P22HJ8yRshZOD5lLGUAnInjU8bRNprg+JSBc6TIcHwg
RFFhMxyfsqy8BJjj+ECUgk2M4viU5UpP5viUhYOFG8PxYWp19O/Pc3wKg1rX
OvMcHywLFKEly/GBoOHl/YwxHJ+ycGSZdiWRCo28B4iyxhRswliOT1lLDhhj
OD6Q9UyMrYoLHPMUjk+BZaJGX0kkeTqsj5Z3GPBqCsenHI7FKI4PRCn91xiO
TzlRQuvjOT4Fr59wUzg+5RS58Ezi36CQLeb/GI4PrPnyTuuUZxhmy5vQYzg+
KGA79z1zHB/YEWERGsXxKYfIxwSODwo46fMcn3K+uu2W5/iURyx/Isen8Po/
H8PxgQU3luMD0akcn0KTzUzk+MA+l0Xlhzk+NORHX0lEcTR8RnJ8ymvBpnJ8
UMjzcvfMcnzIEEzh+BRy7Wo8xwfy5V3i0ZSa8m4Kxwd2O/eV50aO4wNpV9ww
H10hsN20LO+RDnF8mnFOu+9Ujg8KOow438/xoSsOuo5cl+PTDA8GV+T4NFOK
MgNfi+PTTCvcHq/G8WlmFB5prsbxYcY39JK6GsenQQbBmQ7HB6di2vgbHJ+W
rsPxweJu+ji+UsllHF9V+kKOryp/EcdXlS45PgnWa8nxCfjU4PhYl+OrFASO
T7uI41MiwfFpLp0zaY5PcK0SnIi2rs0+zcXxwcLkRnB8ThMe/ytzfGBqa/S/
vAbHJ5nqdHSbSP3/NcWnBacMiRMoPoyU49IUn7BlD0+h+Kwgxqc7nds3Ej8k
ik+wPopPG9fo+vA53flGIYY8guKDw7Jk5kOk+LTwdFRoUnx13dinoThVS9qr
sns036qKSE4Z9OAQb8Uwu6clLO6qn93TmJxWjWL3wEAz6Eo8xO5pqYh1m4vd
0zLYKjOwexr9IPks7B56vZh52D0N55Jw/XMOdg92Xwp2dW12TyvMFDUnu4du
424+dk8rRU7gc7F7MMu1FHOyexoOEUrMye7p4prFDOyehkN+GN152D0w+ywX
87F7WuPl9nnZN5xABYM4H/umYRppPh/7huF3PJuPfdPa0s2GQfYNR70mzHjF
vmk/wL5p7TzO/jb71lFWs28aqtJg3xSXIse+ea+iOAXwUIcvxATyDc7CbM2I
fPu3b19+/+1fl19/880PP3//t/+9XOKX/+Pblz9cxsJpj6bCHCyc9kqK+Vg4
2DMpZ0GChYM/+XCDYICFM7Alo3NAhoWDxanE6XMsHK5jtA+MYeEMgyVWT2Xh
oJQ3cgwLZ5gN6GGWhYP9nKspLBwUcGLMTTvYx6UfHxgUCsBaQWMyhYXDO0lO
TWLWDGwOVbTX0wqOb4EuO+M0QkpENOFhwwUv6J03eDQiGz5UEaQ3xDbxWNoW
QS0JR0DmaHc4YvV3hDvHFZGyuG5HKHI9YfhqRxjyzSYSxrv8odabQ6kSTEWc
sbtYzCg1QkyLgvp4ONzdrt9TN4OkxkE0sRwlcVg8nIsmL2Ekib9AhZGckURJ
LJeVJErRSxKrM54mT2gvkj4lar7mBPyzaBJzmMRhumMnUqrit3A+IW7t9HgT
/t2ujkRkdQbZSVnOvuU9ZktekoGColh3IWJZX5I0Dw9374mmieum6CVQ0UvA
vRHlFDreQN0w/cpy9fgq5F9EKkgh6yGjARRMClE1p8j3WzXk1Qqr5k2zFTCx
yPRrz4+b7bY9PwS3FeWxvtuu9o+w+kG7Ya3tUpZGCKlKyrLZOxKnyjaW9FWw
w1xHCpgEhVaqMXTk44lWVrNtMBCw/IWomoOTVCjyiwR1KLK83YQliZi5iPww
QotiXRzDlRgMROpb4qdKPKHe1FeGs9yKEba6k/b+tHxbNI7olLinrNVjbkwZ
WPLk9ACPWNAzDFPTZFPEze4mkiBPlD42ZctGsylMukqrhFdYjGdT8OTQYVMa
1ZSwaKgUm0JFu2wKfttgUzjmxOW8VigMbhkJNoW32JTAVbg2m1J8WyuUxnYC
PKLQjWYT2JRIYchGWrEptVIlWmxK1eSSTcGfdfjZ1AoNRfvssCnwB6Jim2wK
LLtdNsXxPjalVHIZm1KVbrApYCaPZFOq8l02BY4aaTalBpCr0hWbApZlxabg
YT5mU3SXTakUFGyKitgUOEd12RSjOOX+TLIpQvAU/Ow7d3lGwM+wGF/Apjg8
4eTYFI9hg359NgUsG/87mzKSTTHK0VWPCWyKURieN82mBKJiKpviE70M0/mS
C4DFdH4Cm8Jdgk0RqtXrsPP3Xpii8tGFKfqc7HzMSd4TXLPFphiNt/c+RDYF
WsBFJ7yjlp9WTIkLtfs2qhz+XhEr316HWTGNnrVkrFswoDJxHmFhplyvfcyK
wVTqfhSzAqLGZOI8GsO04PMxKwYORI7NwqxgjGIjZ2FWjAnJ+mZgVgym37Rz
MSsG/cj19ZkVmEfaiDmZFWO8K6mPGZgVgzcW/XzMirGw1Ks5mRWDoSLknMwK
OsXyeZgVY/HgNoJZgdkfKj+NWTGwjXI9L/OB0eyYnJn5MPASCDEf82EczDwx
H/NhnHA+xMKU5P9c6g+jWb8HohgEhjeMp+hXgpf6ZaxflvqDEgyStSBuzbop
g+y0UgW9hYgoZ0oJWLM1DXIYW3xImElSak2dJJzLNyIaZFjsZI4easRGZOPo
IeMc5Z/s0ENtZVGkR2Fckx6SKns5y/P4bpYB4wafOhDpsVODwVCPqv20OK6k
lZjEOyKjRP4mGGNiLSIyqiCh8FrYi29fFJ++/+H/+frl95eRUlYKaztXw2DS
t0gpMZmUslJSc2cipSymCmJJUgojNrkqsmMPKWUlkgdZUspiwK5xV8OstJSD
fBQpBcLey6mkFGyllteZ5QZIKbyWR7eUsqQUSHo2PlsdFFBMFzEFh0kpqzhX
Ze6zMaQUFHBcTSSlrBJaTLvuhe7TRTe+xaTaNf8Az9rdPZ6Q4xBbJJvkLi7l
C0d+LPT2vrwxoppwu8XAoiJP98AGGJIq4uWfUGMUrK827OgGjY0LlDHsMFf9
8v6weaQhUjpwJjoeJCONiJWXvISKZcqRR2we3/Ra50a0Zjfe29PFPYycqONi
dD2dVaPxfqt8SeKN0Ow9JVXMof5WM00k4lTUH8xOyQfvUICEI0/9p9+hYKtd
rRUOkH4C6r/aDd+hsFrSibRC/cMlAWe3rIv62xX+r0b9Y9laofLoGzlwh8K4
HSxfXu78egMrimyi/rtV+F+tUJOHEKH+YHlhmFVsxhr2c3fJHQrME6sScdLA
VB59hwJk4yYHB5cO6m8xenoH9VfMdFF/7vpQ/1LJZah/VbqB+nOwAceh/lX5
8ai/NL5TukL9YYuPUP/mHQrRRf0rBUWctCzqbw2ceUTfHYoAJLZh0hCPaSJM
yoxoQPyjUH9hCWvLov4hMc+vjPpby9W14qT9l0f9LWwdiP1MQP2hSG+YNHcR
6i95N6sTTucLwqQV0/kpqD/r9Hgip5NwTwf9LZyPMXb+CNDfOqfFB3mFAikb
zGjUukKhfYH6v/j2k4VUZQWJA6iRf1UC/yRV1PFFAvgXReWoXZksTy7uYkx2
7An9N5l7FRbT65p+9N96RTHtRqD/1msyNIfQf1hBWUiVNA/6b72VIbPI1dF/
652e6V4FnChtEaHq2ui/YyF78jzoP8aMUDPcq3Cwoik/J/rvBPeCz4b+O3gB
hZkP/XeY68TOif47mBli1qhpTuBF3FnQfydcwUrNh847OMsZPTM6jyn29CB6
XqDPKnT+VPQcDrlFvMaR6HnPKPfrlxS/sx89lwX6b80EYLseBKkIjcug5zK8
1BiMcXwnRYMApyVXPMTHjShnUklhSGbG62e1fkvO4qjfxYPsqkFuDMLCY+LV
rv6BV016ZgsSw8XD7MphLoYBnkBtwuhd+RbUwwCzHl2OBvkFfCeS10/kAL/g
oKlIc7b5hY6yKPib6AR/C18M8gsy5hdgp9cI1HxQiL/TIVTR9RF/pw3Fmp0J
8XfaEvyZQPwdetLlEj6BkNX5ayiY7ttXPtiDiD+IhshbYxB/h/dQgq/ymIhS
DumJ4grCcfVueXq43UfBlW4aHuaOvOoTvMBm06QFHOyKtPZkaQGHvsX1/Zc8
LQAFbHEZYpgWgFecbiuNpgWggCfX9Cm0gDPaTowC54wpR34CLeDQRUPkaQGQ
M0WMuUFawBknmsh9hhZwmPRFjAPFnfFauWFawFlWhiXLY/0gbNk4WsBZLtnY
etpgV4+jBZwVWvuxmiWnmIk5WgAELaUKm0oLIKGBLFY/LQDrEMM34Lq0gAMT
CQ+tV6MFnMURuyIt4Kyj6NhXowWc9UTiXo0WAKuRow11NVoAw+np1GUA54TA
F6dJCxgrOrSAFaKPFiiVXEYLVKUvpAWq8l1agLl0aCU4bnZKV7QAHl37aIHE
ZYBKQaAF4BhW0wLSJmgBBwu86QutBKa56+KoGN3w16IFApL9YdICzsPJ9/fL
AONoAYdZp+wkWgCsN7pQmKIFCMudSgs4mcqeopy/nOW6Ni1AhNu4uwAhnFgU
WUn1RVZy3mtk/UfQArBMay8/RFrAg7Du3AXgTnxaYfzaRawA11UN4ZNJ8QI/
p4gBXhEDWV5AuLh6SiFKMoIXwOXKD8Rbgr9rDGgxghfwzHBUNcQLeIxTMmM2
FY/v1TzZVDzzZMPOwAvA2u2Un4UX8BgObbZsKp5sguvzAp7DIZjPyQt4bljF
PFyfF/DcVrGE5uAFPHcU8WM+XsBzb/2svACcH5WYJ5uKB2tRmHl5AQ+7vTTz
QfZeYLjM+SB7aC1FJJkLsvfCMc5nhuy9CF60c0H2oN2oIcheFi+0hJ/xgxDp
h+Ojnw+w91JyVuqPB9lVtxqeSDl4TJIucpQAvHOpfDDKDlACXmqvUpRAW1lM
CTjVpgSyEaksY9ElAK+sdVE6GGzrr5QQhjq5rodXeKEpZgFwdW+SAFS7qTQA
GOAKA9TPRAN47Sl9RYIG8LBXEAw+RAOg6wiGBMjQAN7wMiVIjgbwiL6bkTSA
xwAq/eH72zSANwVcOYYGAGHaVLM0gMfY13oMDQCS3tYq8zQADE6Z4HyYBvDG
iKIjxtEAeCl4Mg3gDRgQ00JWeboLNmGEMLMFib9b3aLs/nQLc2p5DpVym5Do
wUclcMZQiSMcmu7WGDqoOFgvz1Qo5GypS1hG1xBHJGDxZcb1dwWBgbGBEN7G
3lxFU8By5UIaHoxadLdd3mNOjsc7HKq1xufzHY/EBRdliKcQmKgUbvEXHqPw
uoJFKYM1FblJJIX7kSoSlrJIlVGgA9iHlBOB6WYAL483hEVFS6DcLcV+IvpC
RENulS6IqFIQFdINGR63SNPetUg1vyNqKY3PEiMoUa+WomKL4L+NW2TK/DTw
/hEXVGYT2h6PIWHIlmbENipjy2RLFBcNRuS4uT3+8wTv5m55fv24p9lNmT3W
USFbBN1and7v16167RoXh7x1sshwMUrYkzWSEFW6JQqrfXkFInANNwz5jo22
vl6ywVSTdSoJxpp8x07XwY9qRqBm2KC4Q7qkg6F7JyhMWxNDtyqBobPegDql
kssw9Kr0hRh6Vf4iDL0qXWLowrtJrvWVggJDlxGGLlQCQ/fOaM77MHRvkhg6
uyCgzkUYOvf6w3Wt954T1vU7hj4CQ/deczUtAzkiv+jYksLQ5SXpCZwxSQyd
XU4JXRtD78TT6XetV4Tl1j0fPnf7Xn+Blj0e2bMYOol6Lj48DB1rJqztJCCH
g1QdUEeJGEM3MYbu5sDQ8WRYV09rPIVkMXQUxUiefRg6/Z0SgmUxdBS1ejhn
Aco4HjCPOTB01O9lgS1eF0MH1Rifdg7felTNvVUzYOioWlJG+TkwdNQOVuLV
MXTU63SFzc+AoeMTwLp0M2HooB4PNLP51qN+oSv8eQYMHZ8AiwufD0PHJ+g6
OtA1MXRUbbQcTCT9FHwb9Ts2KaDLJHwb9cMyJufCt0G/hHVYz4pv40MEZ3Yu
fBv1S8P0KHzb+/GDEOlXTtq58G3Ub5hV8+Hb+ARLB+hhfBuGO+XyrvrznaNm
Z3Hid/DttrII3+a65fJOAWyG8W3lZWzXKOPsb45vYz0c+aJfHd9G1d6KuQLb
gHrNvEjh2/gnWB6H3dxJyLOcmzuKCV0FJR/Ct1EUXtNx2RZImGywUegpisOy
Ns7NHYU1seoZfJsEjRyBb6OkEWI8vk0FSlf7IXwbBa0qcwiMwLexgKOIRhPw
bSrkirj94/BtLOJ1AViPGiFYMovA8KPwbSrhiqsLo/BtLMG1GoNvo6gIk3EQ
3yY5K8fi2yiOV8zy+DZJ+oKRyeHbKKx0kZt9GN9GUS0Yz+LbJEgU4iC+jWJG
qjH4Nol67cbg2yhrdZFyYyS+jWWcKCJGjcW3qZC34/BtFPam6LwRwhZsczYC
3yZRJ9Qwvo1SwQa8CN+m4h6t7Ba+jX+QNCVa+Lbuho7pxbdrJZfg21Hpi/Dt
qPwEfNuqTulR+DZv49uRgoBvGx/j27KDb2OBkMokiW9Llgod8zu+XXSdAzNO
/45vj8C3sbMMk1N8xKmIdabHR/yS0DHOqvR0/pDxbdWPb4sWvi36+h4Oa3Ik
vu25a957+GDwbS8pcGcL3+auxrelLOqH8LaaHd4WjS7WFFhiDLztjXC9gePx
75ai0IyBt5GOHnQR13DuMt7K+eBtjly1nwXeBhtb8TkCx4NqqLZms8DbnAsm
9VzwNkcXcXV9eBtsNCvknPA254aVPtwzwNucW6XdfPA2Bqiuwq7MAm9z7r2e
0UUcngDTWs0Db3O83zQjvA01E2w2923UH8UTnwHexuAGZWidOZBnhErK/h9G
nrXk4/sn0g9zk8+HPGMigdL9fx7kGRZOgfTaMPJs4vgookKeYaPuR565hF5O
5PrtKIs9qxlrIs9MtZFn4VwLeZYqMjng0KDxwsFQMPd2DQaDubPW08hcrZ+m
6Sr7hMzCmHmoB+V+Ym5hrI7l6FvUDOrinpxbGDU7WmBmQru58hrfzwTazaF9
snLU7kG7OQZvrhIQ96LdHEaLl/DeMNoNok6MC+OOwmB96NFYKtqlXoxEu0HY
FjEwhtFu2MQk+Thn0W6QpFQgo9FuOHPoIgrMMNoN9iHXZRzvMWg3FCBkbRLa
DTaLlnoS2s21E1W0mUwkEZKm8x6O5+O5qNPd7YlarKlzdCTsFcWLyaPWvLyZ
kEKjud7tWnA0x6TSdiTIzDHuhymFb0J+1wDKRyKuwKHXK1iSMFLNarMhtNY3
ewCMH9wWRsDG3MAmxcfBxiBr+SS3aCwDRyQ2ETbmRvOCUMojwSBs9XhhIwnF
zsPGIOptnQ+W3zyHmbbbqmhaGkvu9wQZc1aBxkUcljVerIpAYwos4mFpdrUC
T7RMBzTmNqRnaIHGzE4BjUsll4HGVekLQeOq/ATQ2IlO6Ro0Nr2BRcB86oDG
lYIAGvs4sIjtBhbBAs5F0RtaTtFOJwI0/5qgsbMfamAR6DrYa5X9HTQeBRpz
DPU1DTSGwSd0IQUaq4sCi4TYGx8yaNwJLCJ6A4s43gSNw+dk33vYF3tivbdA
Y+5D1N4PDzTmXlNAhRZo7GUUb9zoVGQRijkSo8ZqCDUel2qUJmBdNUuh0Ecg
xhwzLsp+xJhjiG05CjGGUwrH2HmDiDGcZOZEjAVGEjOzIMYCDlDBv+/qiLGA
/cLYWRBjQb4bcyHGglnHrp5qFPU6b2YMKgJP4GD/idkQY8G5K9NozoEYCwz/
6OdEjAVXWqo5EWN8FyuX6+sixgK2Nu/mQ3QFOuyz+RBdASu4mdGXWIjA2s6F
6IKlrtyMiC6S2aXD+xhEd6ovN143qHyVbazfNvsfhpUP1H9g8qPLfjYWB0yn
VCwOqQYQYxhYgi87iDH0fV8sDq5cy1dZN8Nzg63TgnAjcw4Gg+6zfyD4rVCw
Xpg58FvkiXC6zYTfgnrn097KQknuKkfkHvwWhLTOpeFEMXh5ylSSw/gtiCq8
XzYKvwVhZ4Le0Wk4sRRMZ5FAZltpOEnSoqmah2aFMnRHfjQ0CwW0GwPNgmDp
sDoOmhUKTHE7EZqFQs5PCbSBRZwSI3M/krQrQhjkoVk4qwk7zqEYRE2RhnMU
NCs043xcfAsS1sVM6YNmQcR5NgaaFRqv946CZkHUeDEOmoUjmykm0mhoVmC4
UjcRmoVCRo110hUarHQ/Xjj42uehWRB1BLz2QrOYsUY8BZoFBRR6vgPNCsMo
Nk4LmoXD2ARotlRyGTRblb4Qmq3Kd6BZDZVOQrPwCnRK1zGfwRasoFmwETL+
vJWCwp9XRNCsZwloFqPQKdUHzXpCKX47aFY4Qkfy0CzFL/iVoVlhDMXx+h2a
HQHNYvhw1pOOsAeaBftetCMUFNCsCC2ZHK8i0csfOjTb688b1Nc9Hz4n+97C
2dmMgmZB1DR91D8UaFZY6VQ3XoWzETRrWW/Q5xKbbTr0XozMskb3asoHMgKZ
BVHlesM9098d4pEjkFkBD1ODaSBJhoK7zYbMQpND2rTrI7PW6Som85WRWeul
4PMgs47NGKoCb+zrOZBZWJq4nRWZdaIOhjEDMutg25gxVAWcKvS8vrwCGRk9
KzLrDDdiHmQWsybxGZFZB+uMmhGZhQOPnC3xIOr3So+K8nAhMusZvbezIace
DFQ7AjmF/qEnegf27BT9gs7tM+CmGEDapGI8yMtx00SMB6Hj2FXQCwp9Nobb
42JXW1a3ZyhmBXQrufx3ceCWsro9MNhNz2FJ8ZZbnsOq2R4nI8tLwmTk+RAc
Pt2coeGRHPaF5PD4vuYkHKFle3g6jtAIrETtkUyjx2NmeGwypAisjQPtgQal
h8f2hhRhpjXdEsMjWsPjXeRpLRVsbzLj192qwBS/7tbDBO0embkgkk7xwgz1
nYL9Sabmguh3ipei9aoKN57ikFpRiO/Bjms9fUrHNR6lPc+vCDI55Ya7TcOJ
LU6hyp/TYSAAu6vz7WG/2K1u7x6P2+eBZ3nOP1/cwyHqOWVTVWzNutlUv/nh
xY9doqZ+prNINrTIGNsmY/hkMkZq7xmbjYyRhnMchgQZA3/S2dAxEswxMpCh
bvtlmR6SB8RcxmKmSBDZoROWp9WO6ApBiLGICklZoMyYTvF8WK4P9w+rdYHk
I6YrVk3wXBrFrBgqwjeyU8QWkSbAil6eb++3x+XpsDvfHv/5GcH+TfAf7Go1
7IW+07sW0yGN4ZJPYjqgiCuc0N+sTqv98k2VfJNLAsltJGsJdkNZhDPomL2s
E4ESg0DN0FEZx2URUfx8f3q1hDdpvzssbx7hVVqe3uBdBH3TvIsAZVwRBqZR
ZvsWTsUl+RBXy2vbFUeA3Tfio0jLuC6jv7y6PWGuzP32vEFwCStvtpYUxwVc
QQMN5+REUYQSSXRaVk4sKgQLM+P21f2DWb46Hh6JaaEBu1k3WUQQd0RwhO4H
4XfLG2jOHmcRMVMymttWKgqRs4OaE9xaju6Oo9q4cxRz2Nbk0C6JS8F7I6Y1
vujfHDzt39y35N8ssb+INZWyNRKaYmBFpQoEBV/9JrcERwshYs4vTJqtwoqs
YzHHyqBGXaWOtZRaXVBlt2EKVLMLBhJnQSzreMXwZslAkLZFFJrb3XJ/hxPy
dPufWAdxg/NL8kjWS6LNxr8a0Eaj2yX6XgzHLK2GmdcCmkeDMfKlAJO0yEVc
9Nz6NWUi3m1XZ9jscPUjRjh6OZwwRcCp0/m4pqhIYt0gv2AFFqzMuRCiHNFJ
l6hLkNzGkq6SbImucZqJaPo7pehyVatpJRUdLZ1OMwQaFneHwwO9KCBJaYNx
FERzzQRTkybE4eFUilCQJx4t3y4YVYvT9gwvMyjDZyp86YSLpWyRaQJ1EYRc
EMcUu2oTSVrp+bj+sZ7obgw/Ra3Y45Bst639BTlrHJM1TOfzFgTfLXHPP8E2
FnawLc49EVfBCwrr/7g/vQYTAfSCBfXL+2Yxy1q1gcrgHMSAUEXB6lVQ0arm
mS6W2neruzelZwSsI1vaV2h7jPvXc+5qbhojfkGZ9fkOOwSHVjVkXZHeGUZj
iXZG4bogZHMSQgMLSwCrW+pTDI0RvY3lvKnzODwWG7KKs1WjFJxWWSUFjz6W
riHupjmhPJwk4ueSHO0zkhYu6WJZK/mUjtLBaSy7g3ntabWYvH+hE7JvZ5V2
WkQSMMt9Iqv0FuyoG7817azSrjerdORJIL2j+MFjskrDlrnZcNbNKt2spicU
qsoqHZ4IUmqn6qzSdb3Vus4qTeqKf0uFCvGxOKt09aPNTcgq3XzMVjWzStO3
2kQKucQzB2WVjpuBt7pSWaVdJ6u0urFORAoFxW2sskrHXd3KKk31hkNDlVU6
+qkMffQWk6nYnu0j1tUOk0pJrrK3xb1J3xbXAyc8pZSzqTxcbWWDbenEKe2C
JD6m25Qy0qd8NOAPXrVjrilvddtHA1exPh+NUkmT326z230+GlXpho+Gt2qk
j0ZVvuujgWh4ykfDGtUpXfloICdV+GggitHMKSI7PhqVguCj4WzN6QohEj4a
ygryAczMLZcG4IbQA2UVeawmvT8CNNWmy40zbbo875gAU4Go02neH1KMiuYm
w/29X9n7AzOkuhTW1x6HIeySC5aDliV5AFRPdYz8MX/3ORnhc6JcCLI1CPC1
hmsKwNcaGi+VzsLkzqd3gMG31Cujk7uZ790BuiwGz7IYksc7gGZwEp/msQOH
F23TEfhCNpWpHjswq5NLEG9naR+/BD3BY0fR69p22aEJ3XDZodql07SrN800
7apn6mpM5s2zS76cTiFBMxVLrluyf93qmhMuZ05wEYc91xx6N0dStGow5VVs
PU1CK/UohycQtdxnHJ4if6e0u9OLq7s7aQXGtGm7OynhI3cnbmzk7wR/qq+i
8v67qKKq6Iuopi8+Gef6pKxRcS2dxTt91oI5P+z6BDaiRC/7Ptcn+LtDZHqE
6xN0lMUpPOT6pJ2jm52DLxCcjJKrsRqK3qSdFzxBVHWUxSSfa2/8tp0Xt/MC
QUdH138N49Q9mQVBp/MgDO0uhkkuUsRbW1nEKUveXBBktz3StF5RTat29VSB
7sXZ8VHJBW64PQLWt0R0rY6yaHwUb+V1KBjxod0So51E7YEVW+bPfyzpw6D4
UHs0pxtE3fFhvT4MXVI5T5JrxeL5Zrjiubts0NFpknzoPGuQHUuOj+k9m0tv
JrdHGBG3x4KdorPtsWnrbGhDNTbEjOq2xw6sB23rzLQPAt0NVbnIQIBjGN3G
zMw3npxvg4yycZa8ubrzjffOt6dhJ3Acpss4mbFx09lx4zUdtbtj42bCgSxT
lPZouC38AgcJi9k9Um1pK7teW7hRMvvO8LQf03BbuOMsgWl1lF2vLXgNM/e+
wEJzQVtg85OptrSVTXH6GW4LbMAuPy7pnEjDbVFCy8ThoKPseuOilWX5tqR9
/4bbojVlfum2pd/374njAlapybdFXzDHbMiu2G2LnmuOWeVk5sDWfvqFzlEW
AxDmfMrAQktvzUOmk3XS+mS39UPnMiDl0XT2WVOd0+mofqqhq/PDXdeswaSz
bvNp3pPPe6b3XPIFGjRsHON0h7Xbe27gBWr1HpP53nOx8ywmV816ZyrBki/R
oHem45y2s0572sqe6p0ZD48TsCawbHNEeniGJreDmZncd9rKnngu4DJGOZ1k
TmXPbTztDDy4xjnMtZhAOTvKrrb3OHR/zNsEF9hqDt5vnojX0VF2tfXaKevw
fDO46LCrOLM6RLrzU4BNNz9gIWAI2HenAOs1P57YbYYpkYNVlODJtgyvNoZT
2ITu68knmFKdqwed19OJRnOc95nNAG+LfXxcl60Y8s93lpGXR6sNlYa66kY0
R4Hz1rLvhOsfBIe+MdlBkGkDQA41wGmefA/byqasKYklX7AYu4WThrL5NV9N
t2kdnJRTTvIdZRFWxzrYyZQXxGPytewaye30/cvDRoJ8Wfdlt737V3tsZDES
dVuUarXFxSgqHAF5/rQh0lc/BkfGSyGTrWkri1vTQlEnjozUGv2IB1d8cfm9
j8ajnMoGtoKj4/RN30tPuRq73TbXwcYr+HPm1kf76Zd2mwaLJrNRknVTXvQt
+2xoX/HkFtHpsZaeqrs4ky3uoQ01DtTfOIr+nRl2kzbFB999y5hIrsvmclsv
sS5zEbNV3kmdGw84IqQx0+H2gPklUtO4rWzYFs8flXh8VPLo2plvj7hgNfPK
JrGTtrIrvZbmC7w3n70hpWT6htSADQCahTIqtTK3lV3RBoCnwsnCZEENqafa
AKiZq6SR3FZ2vbFRjhyDM+uAm3pOQs1epfw0O8qu1xajbL4tssee6V+YUbP2
SQugreypaxpjUXvgtREqe4BR6Xmm+o1/1OzIiaLTnrayuj1C2JatKTs8apd3
NM5F7dHWi/w6kAYD1dA6wLXnSbykrSwGA3WrPSMcX7Ty0TrADTpMZtuT9t1U
Q/MNqsJMag9V/Q6Isj3figEb9+5waykQ3gxtASPQpeZaW9mgh1vHx7nD2avo
NABP9Uzl1wKVBjIGOG7UjIlyUmPTD2RwnfXZ7sYdiE7/5gtYCYXIzjWVPncO
XNRHzZhAK9We3nPnRVhjzNkbjOct8vaaSts3w+2BY2ByLWgrG1irtWvZa6b4
os8kgMWduxyl0qpA6+Qx+ZlSWZNNYqd0Gk03/SYvaoZXNmUitpUNv7JZ/2cu
ZW3zwmO1oLtqg53YqsIkcqX1OG/pQnqm/9JHBuWH+s97lqT02sriKeha7Erx
Ag31n43crgxe3SGHiOHua9ZgSve1nsadyQNhOg2w66EFFo67TqQMx7ayuPfa
QFjxxeDsY6wOfwGPFRhoOdd9l6Psncc5b7NwlU4T/QNOjKBZYpaHVP/1E/1c
doyh7AZlPYsWdIW7XH7DTQO9g8aqwhtfSWOoH+i9ZDVCt9K4PVKh49Lwii4v
ng7tpymfp6t02lVC9TO9qNmkt8O2sghW5m1T34wwv5SNVwdrhM1u78Ym9yY5
tLYqmNvJ9rSVDZorKuuSJ72JZ7cz5KQx3J6eMFaD5jFstTxpHg+EsbrkCiCc
xaPVR4MV6/LwUk/cp6GjmBYi7ULdVnZVSAaO75xnj8q2h+sbgjG05JKnjv5t
ZYNxrPIux1LG6wEcd23exd32vD9DuwOmtk7dEekoG1pNWcdvptseG0MZWoe7
bZn1rcfleHC+walWpyCztrLrzjdYhPK0plXJ3W54fBzXSfi8raxhO7bGZ4Tt
2FzftFcjuHLXc1y2Q+3BXOGp9a2trEFrtsmzEeu1aKxv3tHZaHD3btVg2vXA
+GmGW50/nLu0LTc4Gwx3NrmatpXFFx7atjC32cO5dLFtajBZVXZ3sCa52w2+
rQZv0idXUzNht5v6thojRwCPVqff1sH2GM2TfmdtZU89KVN48+qpGIkoP9/S
TvWDb6uxlpxMOu3x/YRKx6tSstGOWvBEJ3X+HHRRW1yIh9Z9d/ovCHTaIvIB
QjFGQNQeL02eWLU9ToFDlrzxysnku9PvFChY22dzxLlYq2iuWRDIX+DwPWvb
0LtjGdjyqZ27rWzY8h1xuSZeqy20OO/04tKX7cTQycSCBZq8LNRW9kQfVBUv
bRbftuzBpOeu0OB0s0Lp5FI9eFeoAyNMHR6wxvPD43uW6qHlwGowfJPTrXep
LmM4RO3J8/hwzoqWN2vG8Pjep1+fIZAW1japUstbW9lTfYSFa7TH+axnUqsG
0y57N56GIUnys7vHAX7o2G2t4zZlZreVPdlhPEJFrJcsT+i6ntsQQxgZaPYy
RUq1lT1xLRUNBB1vEbDs8LjJF69Is094p3aVXclhHJ4opZa5fVuzHvxy6EV1
UlEuinZbOsqeivAYG20MTkmVRax0zyX5QQLUYZLBxELaUfZEBE64eKNzGud4
dilIIwjDcw3sG5XcGJ6AIAzPNSuMyp1OW0+/yE8RH+UpsXGm29I+McPd5jgB
5N1uG/KJadsHk7rNg/WaM0U1m+yqipq5M4ljT0fZ1aaAx0h3+bak76wPtsXD
0imSr2f/nfUntoVbn22LaqSzHTkuHta9ZLyHtrKr+ZDBBBMsR2PpxlXmkcum
N9KloIKOsqdu0Sa2p71lPGt/at4TbGjI5PCW65TJ0VE22J7OcVSZjskhRdwe
SYnjhpbOdg1aS+clD8XLS9lOvOBM763hNtmJA2d61b7FOuKQJWLnKG9Dks7h
TmzWYJoR33iagzbmLZEebmYIQfAOzgfJpW4KNzPiCKRrV3P7BazcXOS2VM3S
R7qB5Q41G5VyZ+4ou9LSDU8UjGddGDVPXwMQ/cdt1MyT8EFH2fXaopzyudOV
5j25X/rnGWqGNyb5lg5cALrgvh9Ck1F7tLQu357Jt79Rs06G6OgoG7w7P6Y9
In5vrJAuO9dEz93SJPJWq5Y2BVt3tF0PeoOHwiE13x7WcxWwn/VBzZwus3TX
gX6XzI77L++csLpIL4bGqjsRE2olIBHde0lbOt72Wpv0xnLoYp1fSdOXDwbA
MdQMzU8a9FMuH4y4tBPhIfBUwcYYj2lWeHBngA1H88Rhq6Psaqspl6MMx7R3
6XBbJBepSy4dZVcy6vGJVpvMBfr20y86b+OjnM+6wWkx+d4WaFbc2AS90FF2
tW6DOSdN9vUUk53SULPRqThkHWVPhJB05FQDTxUhE9Fwe2Q65tWAExdqDjmI
Ou1pK4tfzw63kI8bqZSK2yN9Pu6d7rnxPOD0BJoVZya13AzceE44CeWpU+Gj
DVVoJrMO7VqmcYRBAw52GZ26w9lRNkgFiywEK1gw4DA56z8wVbJmi9vz9ki5
2k5fLP7+p+cY11QsfnqucQT+8h0e1/U/qno6kXcD1aKHDB8cUacob1l3RPvJ
cNUK/IDvT3ZEuY02RMw7kL2Tr/tuGQ+OqLecJ1eQ/uPFRbdWuIjeODCQnMui
drInsunQCiLB5ktFZ+soeyI6pHi8IsJo8axjjBY9bmxD44PpP22qPW1lT7TI
BYsNMFhPlMiOj+oJMDV0nJUwQEmTvK3sifMNs+VF7ZHWZh3L8Gw0fXzgKJbi
PzvKhq+oZN1auW/MN+iurGOZVj1o5GB7dMj31h2fJ0RqzM83WFPzR0DZswMP
WUjSeJk0+NvKnszuy7g9jolslENkOycfyOCoqHnK6G8rG3QDHdEexSLIQcL+
k7eQZDpy8/D4eCuTkFBb2RNJ3SaEohhs49n51ndrcmj/gfeSYkJ2x2f8rcmp
N9zhqdz4bHhIrXrc3Afbw51MRZzrKBuKpiTzFnkDGVaweuenm+rx7xgy3xTm
3Ettp21lQ75/oxJFxeaOUiPcb7TqMUcHh0c5kTTI28oGkfv8AcPE5wvMI8qz
Lh66Z3Xrd/1DzdImrdG2sieu1krYuD1wvPDZ4em5Qjg8PN7IVGy1jrLB4cm7
nbt488EzWp7eVxfwKprDe5ncfObiVcDs8CYLNai0q8KgIQqFeHolGHBVaB/k
Rq0E8UEO03LYvKGTDkUyaBhoHZJ5dDfSKSFvRiC1Kn51tLP5uMRa97hlDhmi
2gUWqvvqTHHLHGOIxlCQ4WC3ZQ1r3WOIDo0P5opIuZl2lD3VS1vGhpsRegQz
oNOG2+BaYKCjkoZBW9nV1gIjpc6GdNfmAkjYSOWSPF5b2fXaojgX+bakIeHB
LccoQYlHu22ZAgnn1wEbn98MrLX55vQEMRgeGo1XUlPTbJ6MDvhETwjSIMnx
hPgF8aOM0tnA1yAxnRvCfToJG7WVXa/bPNgp+SnQA0kMGYXGI/iRmgJTIIkR
RqGOdwKLwR+yO4FJew0Mjo3lIs0Pt5VdjYCymo3wGDA9VsfQ8d2CSZj0YW4r
e6pHh1YRnGe9tXmrw/YEdBtaPa0P0UQ67Wkreyp8rHm0fCJkLbPwsemxOoas
XIe3plLLZ1tZw8rtEDb5W8MmhlecgE7JWu225zJVv/MnauYq5WPeUTZ4oBrh
M+/j7c1JY7OJq7XpoV+G3h9KvpE6v7eVPdUqFPHa5ozXKm+19wQQHBwfOL6r
lCXVVjaYD0NlT1VGxHiRs85l71Zq23PnZLA9jmmfnG/9d05Me76JvDVlGvCk
w6B7+fXNp9+foVOI89zw1Pi0lQ3Pt2yAxxD6pnyqR/+k7HrgJucrQc0YySzR
nrayofbY1vh43w7ErxutUYZnU35p0wMXDVkGGFE4CYa3lQ37q+VjpHAR7abo
gJ6H83pu8g6e4b0VNhVxqqPsilEK8KlO4Dmxns7PKQEqJis/rMmFYLFb3d49
HrfPofIbMPDV54v7w2b7nP2CvAdbs4///Kcfl//27cvvv/3r/14u8cM3P7z4
kez8zfZ+dXrz1cf7x7u7T+pnekry+s2PP2MC3R+/+9fn2Ey1+OZwf/88qsri
+8N5cV7d7s/QIeoLbr5gz45r/YwxeImevXI3O8v0ZvF/8EozWKF4g+8vq+Pm
3Qq6fL+6h3r/X9+++Hnx03m138D3ix+/WXx8qxT7078vPoOHf/fvny+49wbq
+8fvfvhpwb/g7AvxjC+Y+pLxLzFSZa1e0lbwDXTO4m/H1Xr7PPqTRwRmsXm8
fwipnD9jv9jNl+yXNauFlMZXewF12y+ph0GIOw9SQkZiYPDATFj8y+I/D/vt
8t3qvD3er45vloc3y9Nqt8VCgn1J/40KeQyfCIXOx/fL82G5Ptw/rNbnJeWz
hSJCrKCIVFERY4aLcGXbRSwl3V0sQ/WD5LIcaCiy0zusmIybE+L+wmOWy/vb
V6/Py93q8e4MwtqArIklyV8EJF/tHpYPO5iz4TH433fbzWfYm60u9RLZgjHK
YYAsSeK7tXx4PC/Xr1dHHCaUXNWSnmntC53H1eb2l+UZU2rfHQ5vHh+wW+QN
ttFGJbiQke5X2zNI719hrzusMPw3kvU+9Prt/cPheF7eHt5uaSLwLaqNGueF
wSVhQemPl6+Oh3fLm+2r2z3qNVhpGU0ALwXeEAC9p8P6zfLNfTnBFI57XFlJ
hzV4r+/ubmCiVjNxx/H5UZdh9gszSqXyeCcC+quWgYUGWx5NHq813jTIKjMc
t11Qtjy9Py1P2/3m/oR9KVf4PqltLGqLNq8PD++XIPZ6c1zujof75eNpi2Mr
OPU/j8pYSkSLZR6Px+3+vDzf3uM7RSMVD5RjTBTT4NV2vz3erikV/JJSvi/R
xwonpEP9cfUd5biBYseb5e0eqgET7XB3oNrgyyFjYS918QpCJY7/fNw+bper
Dc70jcLRYLEs7BEk+/pI0svj4355OuzOt8d/0ttKa0LZ4e4LWCeNLluwo0mJ
bwiI3qDuTSRYzd92n994ep1jUacEjU5OUCgRXvuf3v+0PL1+PG8O7/bdtQtF
JZOmEl3drY73qHHd1ii1D+/l5gBPPt9SL+DEoKGTLhJVohq7Zj1BYVutcrTc
otL3pzVMy6VRILmlwVpFgnAexsGCOQPr5U//8dM3X//1ryC7XO1gLixfv9sd
VzSTlICSN7YuaDiOw8vvfoQND6wQ2DsVWMXORxIGw8a8/IkkxM1zGDtmd7ut
UezGb5hbfPunv37955/wr7j9KbP44eV3f16+/Prfi6+qH7GttWIaddCKQrvG
z2a1ePnHRNHFy28a37ar6YiRefmvnaJMQ+W/i74VzuitYiD7XUsWdpVaIaIT
oPCPPwahusk3UJS5ZtGb9VrBt7798PWmUsgZYXkvOWsLbUEh561vsSNfctFp
jagVcos73ksuqxpatuZ2x7SDb1XcZLPaOImP0W1ZVs8iWCvQUngB9th3+93h
efQHjekRYQO+fQuLABh1z7Wx3C5u9/F33Eo4IN6eDndgF2zCd7KtpNSC69Vz
VmsoP5elw+dO6cf99u3t+ry6gb9qvHG0uT2e30NBWvpw04DfH/enINEtf7pb
3SyP2/Xd6vaeRDC+Z/j2cR9/DzZIt+73q4eH7QbDcnAeLNfnVniuyTKlR4JZ
ztji5vC4X6cev4PtGo5V0tNvy4f1Ax6ywof1/SoqoZlFc762r7PmL4/NX540
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
T+W6FNiYTLe5LqdFLEGu7R2ua4155labXZvrcr1cF4/WU8O8HplEgvsN3+xY
l+tqVNNgCqp2EgkOUgpqWHFddb036ybXpYp/a4WS4wyouK7qx0jXivRMj9m2
k0jgtzradQwYJa4T6RnmBJzTUlyX63Bd6sa6aHXEgOHxDZG4q1tcV6i3irku
tdvpG99ssvG4SHS4LlgzFeIgLa7L8SlcV6nkMq6rKn0h11WVnxCUyJlO6Yrq
gg24l+pyXaqrUlBQXTymuniC6lJWELbSE6VapKPg/mpUl6VHfZhUF155MPJ3
qmsU1QVGjEdfmQlUF9hvpnlZoaa66NrE5KDOTFwtxtZMF0RUq9N5mCxJqku0
ojqLdFRn7EgjVA/N2KK6FCaMFR8e1aWc82jRtKguzuKozi6iuqSIqS4W6vg0
lsvG9cGceXIUywWing9cDlFekBPXCJZLeXRuG2a5QMbOeTkErVrhZ2G5lDcE
xs/AcinvmNKzsFzKe2n8nCwXnMLsjCyXZnipfz6WSzNp7awRiZDKd2xOlksz
Y4SfheWCncILPgvLpZkXBVV0bZZLw/Zl3XwsFywyQvghlivQUQspDaodyUJF
+qXhfD4WSnPlrZ6PhYIJLJWdj4XS3PqKpbOxfpus//TLJ5ocIIsnuPgJLt2C
yZdPNCbtKdsQzyHvr/YEwX0+sYNPpzsf4uo0GLYumXrF96Y776ZeCfdRhhI7
eBNdedVSU27r0/v9+fUiQM/PF18GkPf05V+///ef/uOnv714zlj4/Y8//4S/
//j9j+xrJvHXIPocT/+P+zf7w7t9oYbs68MegV0wlasHgkmOXuGr9cPtIi5b
PBqzF27RbllgCtRQr+35dl0I1Gq49HoaxSgcW6+IYvzLd3/+y88/ffty+eKH
//vrP/7124Js/B/fvvyhn2xkA2SjVlKh/XJ9slErZdGSn4ls1MpwfGESZCP8
idw8BslGrawIOOIg2QhiXo4jG5EaIqB6DNmoEdVWU+/QaI1p5sfcoQFJz0bx
iLpEtMfyiBre9yJr+jCPCILeTEl2oLW0ZExP4RG1VrpIAz2WR9TwINZswWr/
fnnzSF2O7IiJZb3XvawwXzVZYTgJ2gJy3909nl4vz3c3y3s4yCKfRA2gXMub
qIBVKujfr8Ihvip3gBXkSMNLqHmjp5woyOfQViQCHuhCj9zQAMfj5bwaHa1J
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
/wCpzhBH/CwDAA==

--------------A3949C00DD8EFFA86862B870
Content-Type: text/plain; charset="UTF-8"; name=
	"reproduce-yocto-lkp-hsw01-10020180625072952x86_64-randconfig-s1-062315204.16.0-rc5-00029-ga35353b1"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename*0="reproduce-yocto-lkp-hsw01-10020180625072952x86_64-randconfig";
	filename*1="-s1-062315204.16.0-rc5-00029-ga35353b1"

#!/bin/bash

kernel=$1
initrd=yocto-trinity-x86_64.cgz

wget --no-clobber https://github.com/fengguang/reproduce-kernel-bug/raw/master/yocto/$initrd

kvm=(
	qemu-system-x86_64
	-enable-kvm
	-cpu Haswell,+smep
	-kernel $kernel
	-initrd $initrd
	-m 512
	-smp 1
	-device e1000,netdev=net0
	-netdev user,id=net0
	-boot order=nc
	-no-reboot
	-watchdog i6300esb
	-watchdog-action debug
	-rtc base=localtime
	-serial stdio
	-display none
	-monitor null
)

append=(
	root=/dev/ram0
	hung_task_panic=1
	debug
	apic=debug
	sysrq_always_enabled
	rcupdate.rcu_cpu_stall_timeout=100
	net.ifnames=0
	printk.devkmsg=on
	panic=-1
	softlockup_panic=1
	nmi_watchdog=panic
	oops=panic
	load_ramdisk=2
	prompt_ramdisk=0
	drbd.minor_count=8
	systemd.log_level=err
	ignore_loglevel
	console=tty0
	earlyprintk=ttyS0,115200
	console=ttyS0,115200
	vga=normal
	rw
	drbd.minor_count=8
	rcuperf.shutdown=0
)

"${kvm[@]}" -append "${append[*]}"

--------------A3949C00DD8EFFA86862B870
Content-Type: text/plain; charset="UTF-8";
	name="config-4.16.0-rc5-00029-ga35353b"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename="config-4.16.0-rc5-00029-ga35353b"

#
# Automatically generated file; DO NOT EDIT.
# Linux/x86_64 4.16.0-rc5 Kernel Configuration
#
CONFIG_64BIT=y
CONFIG_X86_64=y
CONFIG_X86=y
CONFIG_INSTRUCTION_DECODER=y
CONFIG_OUTPUT_FORMAT="elf64-x86-64"
CONFIG_ARCH_DEFCONFIG="arch/x86/configs/x86_64_defconfig"
CONFIG_LOCKDEP_SUPPORT=y
CONFIG_STACKTRACE_SUPPORT=y
CONFIG_MMU=y
CONFIG_ARCH_MMAP_RND_BITS_MIN=28
CONFIG_ARCH_MMAP_RND_BITS_MAX=32
CONFIG_ARCH_MMAP_RND_COMPAT_BITS_MIN=8
CONFIG_ARCH_MMAP_RND_COMPAT_BITS_MAX=16
CONFIG_NEED_DMA_MAP_STATE=y
CONFIG_NEED_SG_DMA_LENGTH=y
CONFIG_GENERIC_ISA_DMA=y
CONFIG_GENERIC_BUG=y
CONFIG_GENERIC_BUG_RELATIVE_POINTERS=y
CONFIG_GENERIC_HWEIGHT=y
CONFIG_ARCH_MAY_HAVE_PC_FDC=y
CONFIG_RWSEM_XCHGADD_ALGORITHM=y
CONFIG_GENERIC_CALIBRATE_DELAY=y
CONFIG_ARCH_HAS_CPU_RELAX=y
CONFIG_ARCH_HAS_CACHE_LINE_SIZE=y
CONFIG_HAVE_SETUP_PER_CPU_AREA=y
CONFIG_NEED_PER_CPU_EMBED_FIRST_CHUNK=y
CONFIG_NEED_PER_CPU_PAGE_FIRST_CHUNK=y
CONFIG_ARCH_HIBERNATION_POSSIBLE=y
CONFIG_ARCH_SUSPEND_POSSIBLE=y
CONFIG_ARCH_WANT_HUGE_PMD_SHARE=y
CONFIG_ARCH_WANT_GENERAL_HUGETLB=y
CONFIG_ZONE_DMA32=y
CONFIG_AUDIT_ARCH=y
CONFIG_ARCH_SUPPORTS_OPTIMIZED_INLINING=y
CONFIG_ARCH_SUPPORTS_DEBUG_PAGEALLOC=y
CONFIG_KASAN_SHADOW_OFFSET=0xdffffc0000000000
CONFIG_X86_64_SMP=y
CONFIG_ARCH_SUPPORTS_UPROBES=y
CONFIG_FIX_EARLYCON_MEM=y
CONFIG_PGTABLE_LEVELS=4
CONFIG_CONSTRUCTORS=y
CONFIG_IRQ_WORK=y
CONFIG_BUILDTIME_EXTABLE_SORT=y
CONFIG_THREAD_INFO_IN_TASK=y

#
# General setup
#
CONFIG_INIT_ENV_ARG_LIMIT=32
CONFIG_CROSS_COMPILE=""
# CONFIG_COMPILE_TEST is not set
CONFIG_LOCALVERSION=""
CONFIG_LOCALVERSION_AUTO=y
CONFIG_HAVE_KERNEL_GZIP=y
CONFIG_HAVE_KERNEL_BZIP2=y
CONFIG_HAVE_KERNEL_LZMA=y
CONFIG_HAVE_KERNEL_XZ=y
CONFIG_HAVE_KERNEL_LZO=y
CONFIG_HAVE_KERNEL_LZ4=y
CONFIG_KERNEL_GZIP=y
# CONFIG_KERNEL_BZIP2 is not set
# CONFIG_KERNEL_LZMA is not set
# CONFIG_KERNEL_XZ is not set
# CONFIG_KERNEL_LZO is not set
# CONFIG_KERNEL_LZ4 is not set
CONFIG_DEFAULT_HOSTNAME="(none)"
# CONFIG_SWAP is not set
CONFIG_SYSVIPC=y
CONFIG_SYSVIPC_SYSCTL=y
# CONFIG_POSIX_MQUEUE is not set
# CONFIG_CROSS_MEMORY_ATTACH is not set
CONFIG_USELIB=y
# CONFIG_AUDIT is not set
CONFIG_HAVE_ARCH_AUDITSYSCALL=y

#
# IRQ subsystem
#
CONFIG_GENERIC_IRQ_PROBE=y
CONFIG_GENERIC_IRQ_SHOW=y
CONFIG_GENERIC_IRQ_EFFECTIVE_AFF_MASK=y
CONFIG_GENERIC_PENDING_IRQ=y
CONFIG_GENERIC_IRQ_MIGRATION=y
CONFIG_GENERIC_IRQ_CHIP=y
CONFIG_IRQ_DOMAIN=y
CONFIG_IRQ_SIM=y
CONFIG_IRQ_DOMAIN_HIERARCHY=y
CONFIG_GENERIC_IRQ_MATRIX_ALLOCATOR=y
CONFIG_GENERIC_IRQ_RESERVATION_MODE=y
CONFIG_IRQ_FORCED_THREADING=y
CONFIG_SPARSE_IRQ=y
CONFIG_GENERIC_IRQ_DEBUGFS=y
CONFIG_CLOCKSOURCE_WATCHDOG=y
CONFIG_ARCH_CLOCKSOURCE_DATA=y
CONFIG_CLOCKSOURCE_VALIDATE_LAST_CYCLE=y
CONFIG_GENERIC_TIME_VSYSCALL=y
CONFIG_GENERIC_CLOCKEVENTS=y
CONFIG_GENERIC_CLOCKEVENTS_BROADCAST=y
CONFIG_GENERIC_CLOCKEVENTS_MIN_ADJUST=y
CONFIG_GENERIC_CMOS_UPDATE=y

#
# Timers subsystem
#
CONFIG_TICK_ONESHOT=y
CONFIG_NO_HZ_COMMON=y
# CONFIG_HZ_PERIODIC is not set
CONFIG_NO_HZ_IDLE=y
# CONFIG_NO_HZ_FULL is not set
CONFIG_NO_HZ=y
# CONFIG_HIGH_RES_TIMERS is not set

#
# CPU/Task time and stats accounting
#
CONFIG_TICK_CPU_ACCOUNTING=y
# CONFIG_VIRT_CPU_ACCOUNTING_GEN is not set
CONFIG_IRQ_TIME_ACCOUNTING=y
CONFIG_BSD_PROCESS_ACCT=y
CONFIG_BSD_PROCESS_ACCT_V3=y
# CONFIG_TASKSTATS is not set
# CONFIG_CPU_ISOLATION is not set

#
# RCU Subsystem
#
CONFIG_PREEMPT_RCU=y
# CONFIG_RCU_EXPERT is not set
CONFIG_SRCU=y
CONFIG_TREE_SRCU=y
CONFIG_TASKS_RCU=y
CONFIG_RCU_STALL_COMMON=y
CONFIG_RCU_NEED_SEGCBLIST=y
CONFIG_BUILD_BIN2C=y
CONFIG_IKCONFIG=y
CONFIG_IKCONFIG_PROC=y
CONFIG_LOG_BUF_SHIFT=20
CONFIG_LOG_CPU_MAX_BUF_SHIFT=12
CONFIG_PRINTK_SAFE_LOG_BUF_SHIFT=13
CONFIG_HAVE_UNSTABLE_SCHED_CLOCK=y
CONFIG_ARCH_SUPPORTS_NUMA_BALANCING=y
CONFIG_ARCH_WANT_BATCHED_UNMAP_TLB_FLUSH=y
CONFIG_ARCH_SUPPORTS_INT128=y
# CONFIG_NUMA_BALANCING is not set
CONFIG_CGROUPS=y
# CONFIG_MEMCG is not set
# CONFIG_BLK_CGROUP is not set
# CONFIG_CGROUP_SCHED is not set
# CONFIG_CGROUP_PIDS is not set
# CONFIG_CGROUP_RDMA is not set
# CONFIG_CGROUP_FREEZER is not set
# CONFIG_CPUSETS is not set
# CONFIG_CGROUP_DEVICE is not set
# CONFIG_CGROUP_CPUACCT is not set
# CONFIG_CGROUP_PERF is not set
# CONFIG_CGROUP_BPF is not set
# CONFIG_CGROUP_DEBUG is not set
# CONFIG_SOCK_CGROUP_DATA is not set
CONFIG_NAMESPACES=y
# CONFIG_UTS_NS is not set
# CONFIG_IPC_NS is not set
CONFIG_USER_NS=y
CONFIG_PID_NS=y
CONFIG_NET_NS=y
# CONFIG_SCHED_AUTOGROUP is not set
# CONFIG_SYSFS_DEPRECATED is not set
# CONFIG_RELAY is not set
CONFIG_BLK_DEV_INITRD=y
CONFIG_INITRAMFS_SOURCE=""
CONFIG_RD_GZIP=y
# CONFIG_RD_BZIP2 is not set
# CONFIG_RD_LZMA is not set
CONFIG_RD_XZ=y
# CONFIG_RD_LZO is not set
# CONFIG_RD_LZ4 is not set
CONFIG_CC_OPTIMIZE_FOR_PERFORMANCE=y
# CONFIG_CC_OPTIMIZE_FOR_SIZE is not set
CONFIG_SYSCTL=y
CONFIG_ANON_INODES=y
CONFIG_SYSCTL_EXCEPTION_TRACE=y
CONFIG_HAVE_PCSPKR_PLATFORM=y
CONFIG_BPF=y
# CONFIG_EXPERT is not set
CONFIG_MULTIUSER=y
CONFIG_SGETMASK_SYSCALL=y
CONFIG_SYSFS_SYSCALL=y
# CONFIG_SYSCTL_SYSCALL is not set
CONFIG_FHANDLE=y
CONFIG_POSIX_TIMERS=y
CONFIG_PRINTK=y
CONFIG_PRINTK_NMI=y
CONFIG_BUG=y
CONFIG_ELF_CORE=y
CONFIG_PCSPKR_PLATFORM=y
CONFIG_BASE_FULL=y
CONFIG_FUTEX=y
CONFIG_FUTEX_PI=y
CONFIG_EPOLL=y
CONFIG_SIGNALFD=y
CONFIG_TIMERFD=y
CONFIG_EVENTFD=y
CONFIG_SHMEM=y
CONFIG_AIO=y
CONFIG_ADVISE_SYSCALLS=y
CONFIG_MEMBARRIER=y
# CONFIG_CHECKPOINT_RESTORE is not set
CONFIG_KALLSYMS=y
# CONFIG_KALLSYMS_ALL is not set
CONFIG_KALLSYMS_ABSOLUTE_PERCPU=y
CONFIG_KALLSYMS_BASE_RELATIVE=y
CONFIG_BPF_SYSCALL=y
# CONFIG_USERFAULTFD is not set
CONFIG_ARCH_HAS_MEMBARRIER_SYNC_CORE=y
# CONFIG_EMBEDDED is not set
CONFIG_HAVE_PERF_EVENTS=y
# CONFIG_PC104 is not set

#
# Kernel Performance Events And Counters
#
CONFIG_PERF_EVENTS=y
# CONFIG_DEBUG_PERF_USE_VMALLOC is not set
CONFIG_VM_EVENT_COUNTERS=y
# CONFIG_COMPAT_BRK is not set
CONFIG_SLAB=y
# CONFIG_SLUB is not set
# CONFIG_SLAB_MERGE_DEFAULT is not set
# CONFIG_SLAB_FREELIST_RANDOM is not set
# CONFIG_SYSTEM_DATA_VERIFICATION is not set
CONFIG_PROFILING=y
CONFIG_TRACEPOINTS=y
CONFIG_CRASH_CORE=y
CONFIG_KEXEC_CORE=y
# CONFIG_OPROFILE is not set
CONFIG_HAVE_OPROFILE=y
CONFIG_OPROFILE_NMI_TIMER=y
CONFIG_KPROBES=y
# CONFIG_JUMP_LABEL is not set
CONFIG_OPTPROBES=y
CONFIG_KPROBES_ON_FTRACE=y
CONFIG_UPROBES=y
# CONFIG_HAVE_64BIT_ALIGNED_ACCESS is not set
CONFIG_HAVE_EFFICIENT_UNALIGNED_ACCESS=y
CONFIG_ARCH_USE_BUILTIN_BSWAP=y
CONFIG_KRETPROBES=y
CONFIG_HAVE_IOREMAP_PROT=y
CONFIG_HAVE_KPROBES=y
CONFIG_HAVE_KRETPROBES=y
CONFIG_HAVE_OPTPROBES=y
CONFIG_HAVE_KPROBES_ON_FTRACE=y
CONFIG_HAVE_FUNCTION_ERROR_INJECTION=y
CONFIG_HAVE_NMI=y
CONFIG_HAVE_ARCH_TRACEHOOK=y
CONFIG_HAVE_DMA_CONTIGUOUS=y
CONFIG_GENERIC_SMP_IDLE_THREAD=y
CONFIG_ARCH_HAS_FORTIFY_SOURCE=y
CONFIG_ARCH_HAS_SET_MEMORY=y
CONFIG_HAVE_ARCH_THREAD_STRUCT_WHITELIST=y
CONFIG_ARCH_WANTS_DYNAMIC_TASK_STRUCT=y
CONFIG_HAVE_REGS_AND_STACK_ACCESS_API=y
CONFIG_HAVE_CLK=y
CONFIG_HAVE_DMA_API_DEBUG=y
CONFIG_HAVE_HW_BREAKPOINT=y
CONFIG_HAVE_MIXED_BREAKPOINTS_REGS=y
CONFIG_HAVE_USER_RETURN_NOTIFIER=y
CONFIG_HAVE_PERF_EVENTS_NMI=y
CONFIG_HAVE_HARDLOCKUP_DETECTOR_PERF=y
CONFIG_HAVE_PERF_REGS=y
CONFIG_HAVE_PERF_USER_STACK_DUMP=y
CONFIG_HAVE_ARCH_JUMP_LABEL=y
CONFIG_HAVE_RCU_TABLE_FREE=y
CONFIG_ARCH_HAVE_NMI_SAFE_CMPXCHG=y
CONFIG_HAVE_CMPXCHG_LOCAL=y
CONFIG_HAVE_CMPXCHG_DOUBLE=y
CONFIG_HAVE_ARCH_SECCOMP_FILTER=y
CONFIG_HAVE_GCC_PLUGINS=y
# CONFIG_GCC_PLUGINS is not set
CONFIG_HAVE_CC_STACKPROTECTOR=y
# CONFIG_CC_STACKPROTECTOR_NONE is not set
# CONFIG_CC_STACKPROTECTOR_REGULAR is not set
# CONFIG_CC_STACKPROTECTOR_STRONG is not set
CONFIG_CC_STACKPROTECTOR_AUTO=y
CONFIG_THIN_ARCHIVES=y
CONFIG_HAVE_ARCH_WITHIN_STACK_FRAMES=y
CONFIG_HAVE_CONTEXT_TRACKING=y
CONFIG_HAVE_VIRT_CPU_ACCOUNTING_GEN=y
CONFIG_HAVE_IRQ_TIME_ACCOUNTING=y
CONFIG_HAVE_ARCH_TRANSPARENT_HUGEPAGE=y
CONFIG_HAVE_ARCH_TRANSPARENT_HUGEPAGE_PUD=y
CONFIG_HAVE_ARCH_HUGE_VMAP=y
CONFIG_HAVE_ARCH_SOFT_DIRTY=y
CONFIG_HAVE_MOD_ARCH_SPECIFIC=y
CONFIG_MODULES_USE_ELF_RELA=y
CONFIG_HAVE_IRQ_EXIT_ON_IRQ_STACK=y
CONFIG_ARCH_HAS_ELF_RANDOMIZE=y
CONFIG_HAVE_ARCH_MMAP_RND_BITS=y
CONFIG_HAVE_EXIT_THREAD=y
CONFIG_ARCH_MMAP_RND_BITS=28
CONFIG_HAVE_ARCH_MMAP_RND_COMPAT_BITS=y
CONFIG_ARCH_MMAP_RND_COMPAT_BITS=8
CONFIG_HAVE_ARCH_COMPAT_MMAP_BASES=y
CONFIG_HAVE_COPY_THREAD_TLS=y
CONFIG_HAVE_STACK_VALIDATION=y
# CONFIG_HAVE_ARCH_HASH is not set
# CONFIG_ISA_BUS_API is not set
# CONFIG_CPU_NO_EFFICIENT_FFS is not set
CONFIG_HAVE_ARCH_VMAP_STACK=y
# CONFIG_ARCH_OPTIONAL_KERNEL_RWX is not set
# CONFIG_ARCH_OPTIONAL_KERNEL_RWX_DEFAULT is not set
CONFIG_ARCH_HAS_STRICT_KERNEL_RWX=y
CONFIG_STRICT_KERNEL_RWX=y
CONFIG_ARCH_HAS_STRICT_MODULE_RWX=y
CONFIG_STRICT_MODULE_RWX=y
CONFIG_ARCH_HAS_PHYS_TO_DMA=y
CONFIG_ARCH_HAS_REFCOUNT=y
# CONFIG_REFCOUNT_FULL is not set

#
# GCOV-based kernel profiling
#
CONFIG_GCOV_KERNEL=y
CONFIG_ARCH_HAS_GCOV_PROFILE_ALL=y
# CONFIG_GCOV_PROFILE_ALL is not set
CONFIG_GCOV_FORMAT_AUTODETECT=y
# CONFIG_GCOV_FORMAT_3_4 is not set
# CONFIG_GCOV_FORMAT_4_7 is not set
# CONFIG_HAVE_GENERIC_DMA_COHERENT is not set
CONFIG_RT_MUTEXES=y
CONFIG_BASE_SMALL=0
CONFIG_MODULES=y
# CONFIG_MODULE_FORCE_LOAD is not set
# CONFIG_MODULE_UNLOAD is not set
# CONFIG_MODVERSIONS is not set
# CONFIG_MODULE_SRCVERSION_ALL is not set
# CONFIG_MODULE_SIG is not set
CONFIG_MODULE_COMPRESS=y
# CONFIG_MODULE_COMPRESS_GZIP is not set
CONFIG_MODULE_COMPRESS_XZ=y
CONFIG_MODULES_TREE_LOOKUP=y
CONFIG_BLOCK=y
CONFIG_BLK_SCSI_REQUEST=y
CONFIG_BLK_DEV_BSG=y
CONFIG_BLK_DEV_BSGLIB=y
CONFIG_BLK_DEV_INTEGRITY=y
CONFIG_BLK_DEV_ZONED=y
CONFIG_BLK_CMDLINE_PARSER=y
CONFIG_BLK_WBT=y
# CONFIG_BLK_WBT_SQ is not set
# CONFIG_BLK_WBT_MQ is not set
CONFIG_BLK_DEBUG_FS=y
# CONFIG_BLK_SED_OPAL is not set

#
# Partition Types
#
CONFIG_PARTITION_ADVANCED=y
CONFIG_ACORN_PARTITION=y
# CONFIG_ACORN_PARTITION_CUMANA is not set
CONFIG_ACORN_PARTITION_EESOX=y
# CONFIG_ACORN_PARTITION_ICS is not set
# CONFIG_ACORN_PARTITION_ADFS is not set
CONFIG_ACORN_PARTITION_POWERTEC=y
# CONFIG_ACORN_PARTITION_RISCIX is not set
# CONFIG_AIX_PARTITION is not set
# CONFIG_OSF_PARTITION is not set
# CONFIG_AMIGA_PARTITION is not set
CONFIG_ATARI_PARTITION=y
CONFIG_MAC_PARTITION=y
# CONFIG_MSDOS_PARTITION is not set
CONFIG_LDM_PARTITION=y
# CONFIG_LDM_DEBUG is not set
CONFIG_SGI_PARTITION=y
# CONFIG_ULTRIX_PARTITION is not set
# CONFIG_SUN_PARTITION is not set
CONFIG_KARMA_PARTITION=y
CONFIG_EFI_PARTITION=y
# CONFIG_SYSV68_PARTITION is not set
CONFIG_CMDLINE_PARTITION=y
CONFIG_BLOCK_COMPAT=y
CONFIG_BLK_MQ_PCI=y
CONFIG_BLK_MQ_VIRTIO=y

#
# IO Schedulers
#
CONFIG_IOSCHED_NOOP=y
CONFIG_IOSCHED_DEADLINE=y
CONFIG_IOSCHED_CFQ=y
CONFIG_DEFAULT_DEADLINE=y
# CONFIG_DEFAULT_CFQ is not set
# CONFIG_DEFAULT_NOOP is not set
CONFIG_DEFAULT_IOSCHED="deadline"
CONFIG_MQ_IOSCHED_DEADLINE=m
# CONFIG_MQ_IOSCHED_KYBER is not set
CONFIG_IOSCHED_BFQ=m
CONFIG_PADATA=y
CONFIG_ASN1=y
CONFIG_UNINLINE_SPIN_UNLOCK=y
CONFIG_ARCH_SUPPORTS_ATOMIC_RMW=y
CONFIG_MUTEX_SPIN_ON_OWNER=y
CONFIG_RWSEM_SPIN_ON_OWNER=y
CONFIG_LOCK_SPIN_ON_OWNER=y
CONFIG_ARCH_USE_QUEUED_SPINLOCKS=y
CONFIG_QUEUED_SPINLOCKS=y
CONFIG_ARCH_USE_QUEUED_RWLOCKS=y
CONFIG_QUEUED_RWLOCKS=y
CONFIG_ARCH_HAS_SYNC_CORE_BEFORE_USERMODE=y
# CONFIG_FREEZER is not set

#
# Processor type and features
#
CONFIG_ZONE_DMA=y
CONFIG_SMP=y
CONFIG_X86_FEATURE_NAMES=y
CONFIG_X86_FAST_FEATURE_TESTS=y
# CONFIG_X86_X2APIC is not set
CONFIG_X86_MPPARSE=y
CONFIG_GOLDFISH=y
CONFIG_RETPOLINE=y
CONFIG_INTEL_RDT=y
CONFIG_X86_EXTENDED_PLATFORM=y
# CONFIG_X86_VSMP is not set
# CONFIG_X86_GOLDFISH is not set
# CONFIG_X86_INTEL_LPSS is not set
# CONFIG_X86_AMD_PLATFORM_DEVICE is not set
# CONFIG_IOSF_MBI is not set
# CONFIG_SCHED_OMIT_FRAME_POINTER is not set
CONFIG_HYPERVISOR_GUEST=y
CONFIG_PARAVIRT=y
# CONFIG_PARAVIRT_DEBUG is not set
# CONFIG_PARAVIRT_SPINLOCKS is not set
# CONFIG_XEN is not set
CONFIG_KVM_GUEST=y
# CONFIG_KVM_DEBUG_FS is not set
# CONFIG_PARAVIRT_TIME_ACCOUNTING is not set
CONFIG_PARAVIRT_CLOCK=y
# CONFIG_JAILHOUSE_GUEST is not set
CONFIG_NO_BOOTMEM=y
# CONFIG_MK8 is not set
# CONFIG_MPSC is not set
# CONFIG_MCORE2 is not set
# CONFIG_MATOM is not set
CONFIG_GENERIC_CPU=y
CONFIG_X86_INTERNODE_CACHE_SHIFT=6
CONFIG_X86_L1_CACHE_SHIFT=6
CONFIG_X86_TSC=y
CONFIG_X86_CMPXCHG64=y
CONFIG_X86_CMOV=y
CONFIG_X86_MINIMUM_CPU_FAMILY=64
CONFIG_X86_DEBUGCTLMSR=y
CONFIG_CPU_SUP_INTEL=y
CONFIG_CPU_SUP_AMD=y
CONFIG_CPU_SUP_CENTAUR=y
CONFIG_HPET_TIMER=y
CONFIG_DMI=y
# CONFIG_GART_IOMMU is not set
# CONFIG_CALGARY_IOMMU is not set
CONFIG_SWIOTLB=y
CONFIG_IOMMU_HELPER=y
# CONFIG_MAXSMP is not set
CONFIG_NR_CPUS_RANGE_BEGIN=2
CONFIG_NR_CPUS_RANGE_END=512
CONFIG_NR_CPUS_DEFAULT=64
CONFIG_NR_CPUS=64
# CONFIG_SCHED_SMT is not set
# CONFIG_SCHED_MC is not set
# CONFIG_PREEMPT_NONE is not set
# CONFIG_PREEMPT_VOLUNTARY is not set
CONFIG_PREEMPT=y
CONFIG_PREEMPT_COUNT=y
CONFIG_X86_LOCAL_APIC=y
CONFIG_X86_IO_APIC=y
CONFIG_X86_REROUTE_FOR_BROKEN_BOOT_IRQS=y
# CONFIG_X86_MCE is not set

#
# Performance monitoring
#
CONFIG_PERF_EVENTS_INTEL_UNCORE=y
CONFIG_PERF_EVENTS_INTEL_RAPL=y
CONFIG_PERF_EVENTS_INTEL_CSTATE=y
# CONFIG_PERF_EVENTS_AMD_POWER is not set
# CONFIG_VM86 is not set
CONFIG_X86_16BIT=y
CONFIG_X86_ESPFIX64=y
CONFIG_X86_VSYSCALL_EMULATION=y
CONFIG_I8K=m
# CONFIG_MICROCODE is not set
CONFIG_X86_MSR=y
CONFIG_X86_CPUID=m
# CONFIG_X86_5LEVEL is not set
CONFIG_ARCH_PHYS_ADDR_T_64BIT=y
CONFIG_ARCH_DMA_ADDR_T_64BIT=y
CONFIG_X86_DIRECT_GBPAGES=y
CONFIG_ARCH_HAS_MEM_ENCRYPT=y
# CONFIG_AMD_MEM_ENCRYPT is not set
CONFIG_NUMA=y
CONFIG_AMD_NUMA=y
CONFIG_X86_64_ACPI_NUMA=y
CONFIG_NODES_SPAN_OTHER_NODES=y
CONFIG_NUMA_EMU=y
CONFIG_NODES_SHIFT=6
CONFIG_ARCH_SPARSEMEM_ENABLE=y
CONFIG_ARCH_SPARSEMEM_DEFAULT=y
CONFIG_ARCH_SELECT_MEMORY_MODEL=y
# CONFIG_ARCH_MEMORY_PROBE is not set
CONFIG_ILLEGAL_POINTER_VALUE=0xdead000000000000
CONFIG_SELECT_MEMORY_MODEL=y
CONFIG_SPARSEMEM_MANUAL=y
CONFIG_SPARSEMEM=y
CONFIG_NEED_MULTIPLE_NODES=y
CONFIG_HAVE_MEMORY_PRESENT=y
CONFIG_SPARSEMEM_EXTREME=y
CONFIG_SPARSEMEM_VMEMMAP_ENABLE=y
CONFIG_SPARSEMEM_ALLOC_MEM_MAP_TOGETHER=y
CONFIG_SPARSEMEM_VMEMMAP=y
CONFIG_HAVE_MEMBLOCK=y
CONFIG_HAVE_MEMBLOCK_NODE_MAP=y
CONFIG_HAVE_GENERIC_GUP=y
CONFIG_ARCH_DISCARD_MEMBLOCK=y
CONFIG_MEMORY_ISOLATION=y
CONFIG_HAVE_BOOTMEM_INFO_NODE=y
CONFIG_MEMORY_HOTPLUG=y
CONFIG_MEMORY_HOTPLUG_SPARSE=y
CONFIG_MEMORY_HOTPLUG_DEFAULT_ONLINE=y
CONFIG_MEMORY_HOTREMOVE=y
CONFIG_SPLIT_PTLOCK_CPUS=4
CONFIG_ARCH_ENABLE_SPLIT_PMD_PTLOCK=y
CONFIG_COMPACTION=y
CONFIG_MIGRATION=y
CONFIG_ARCH_ENABLE_THP_MIGRATION=y
CONFIG_PHYS_ADDR_T_64BIT=y
CONFIG_BOUNCE=y
CONFIG_VIRT_TO_BUS=y
CONFIG_MMU_NOTIFIER=y
CONFIG_KSM=y
CONFIG_DEFAULT_MMAP_MIN_ADDR=4096
CONFIG_TRANSPARENT_HUGEPAGE=y
CONFIG_TRANSPARENT_HUGEPAGE_ALWAYS=y
# CONFIG_TRANSPARENT_HUGEPAGE_MADVISE is not set
CONFIG_ARCH_WANTS_THP_SWAP=y
CONFIG_THP_SWAP=y
CONFIG_TRANSPARENT_HUGE_PAGECACHE=y
CONFIG_CLEANCACHE=y
# CONFIG_CMA is not set
# CONFIG_ZPOOL is not set
CONFIG_ZBUD=m
CONFIG_ZSMALLOC=m
CONFIG_PGTABLE_MAPPING=y
# CONFIG_ZSMALLOC_STAT is not set
CONFIG_GENERIC_EARLY_IOREMAP=y
CONFIG_DEFERRED_STRUCT_PAGE_INIT=y
# CONFIG_IDLE_PAGE_TRACKING is not set
CONFIG_ARCH_HAS_ZONE_DEVICE=y
CONFIG_ZONE_DEVICE=y
CONFIG_ARCH_HAS_HMM=y
CONFIG_MIGRATE_VMA_HELPER=y
CONFIG_HMM=y
CONFIG_HMM_MIRROR=y
# CONFIG_DEVICE_PRIVATE is not set
CONFIG_DEVICE_PUBLIC=y
CONFIG_FRAME_VECTOR=y
CONFIG_PERCPU_STATS=y
CONFIG_GUP_BENCHMARK=y
# CONFIG_X86_PMEM_LEGACY is not set
# CONFIG_X86_CHECK_BIOS_CORRUPTION is not set
CONFIG_X86_RESERVE_LOW=64
CONFIG_MTRR=y
CONFIG_MTRR_SANITIZER=y
CONFIG_MTRR_SANITIZER_ENABLE_DEFAULT=0
CONFIG_MTRR_SANITIZER_SPARE_REG_NR_DEFAULT=1
CONFIG_X86_PAT=y
CONFIG_ARCH_USES_PG_UNCACHED=y
CONFIG_ARCH_RANDOM=y
CONFIG_X86_SMAP=y
CONFIG_X86_INTEL_UMIP=y
# CONFIG_X86_INTEL_MPX is not set
# CONFIG_X86_INTEL_MEMORY_PROTECTION_KEYS is not set
# CONFIG_EFI is not set
# CONFIG_SECCOMP is not set
# CONFIG_HZ_100 is not set
# CONFIG_HZ_250 is not set
CONFIG_HZ_300=y
# CONFIG_HZ_1000 is not set
CONFIG_HZ=300
# CONFIG_SCHED_HRTICK is not set
CONFIG_KEXEC=y
CONFIG_KEXEC_FILE=y
CONFIG_KEXEC_VERIFY_SIG=y
# CONFIG_CRASH_DUMP is not set
CONFIG_PHYSICAL_START=0x1000000
# CONFIG_RELOCATABLE is not set
CONFIG_PHYSICAL_ALIGN=0x200000
# CONFIG_HOTPLUG_CPU is not set
CONFIG_LEGACY_VSYSCALL_EMULATE=y
# CONFIG_LEGACY_VSYSCALL_NONE is not set
# CONFIG_CMDLINE_BOOL is not set
CONFIG_MODIFY_LDT_SYSCALL=y
CONFIG_HAVE_LIVEPATCH=y
CONFIG_ARCH_HAS_ADD_PAGES=y
CONFIG_ARCH_ENABLE_MEMORY_HOTPLUG=y
CONFIG_ARCH_ENABLE_MEMORY_HOTREMOVE=y
CONFIG_USE_PERCPU_NUMA_NODE_ID=y

#
# Power management and ACPI options
#
# CONFIG_SUSPEND is not set
# CONFIG_PM is not set
CONFIG_ACPI=y
CONFIG_ACPI_LEGACY_TABLES_LOOKUP=y
CONFIG_ARCH_MIGHT_HAVE_ACPI_PDC=y
CONFIG_ACPI_SYSTEM_POWER_STATES_SUPPORT=y
# CONFIG_ACPI_DEBUGGER is not set
CONFIG_ACPI_SPCR_TABLE=y
CONFIG_ACPI_LPIT=y
# CONFIG_ACPI_PROCFS_POWER is not set
CONFIG_ACPI_REV_OVERRIDE_POSSIBLE=y
# CONFIG_ACPI_EC_DEBUGFS is not set
CONFIG_ACPI_AC=y
CONFIG_ACPI_BATTERY=y
CONFIG_ACPI_BUTTON=y
# CONFIG_ACPI_VIDEO is not set
CONFIG_ACPI_FAN=y
# CONFIG_ACPI_DOCK is not set
CONFIG_ACPI_CPU_FREQ_PSS=y
CONFIG_ACPI_PROCESSOR_CSTATE=y
CONFIG_ACPI_PROCESSOR_IDLE=y
CONFIG_ACPI_PROCESSOR=y
# CONFIG_ACPI_IPMI is not set
# CONFIG_ACPI_PROCESSOR_AGGREGATOR is not set
CONFIG_ACPI_THERMAL=y
CONFIG_ACPI_NUMA=y
# CONFIG_ACPI_CUSTOM_DSDT is not set
CONFIG_ARCH_HAS_ACPI_TABLE_UPGRADE=y
CONFIG_ACPI_TABLE_UPGRADE=y
# CONFIG_ACPI_DEBUG is not set
# CONFIG_ACPI_PCI_SLOT is not set
# CONFIG_ACPI_CONTAINER is not set
# CONFIG_ACPI_HOTPLUG_MEMORY is not set
CONFIG_ACPI_HOTPLUG_IOAPIC=y
# CONFIG_ACPI_SBS is not set
# CONFIG_ACPI_HED is not set
# CONFIG_ACPI_CUSTOM_METHOD is not set
# CONFIG_ACPI_REDUCED_HARDWARE_ONLY is not set
# CONFIG_ACPI_NFIT is not set
CONFIG_HAVE_ACPI_APEI=y
CONFIG_HAVE_ACPI_APEI_NMI=y
# CONFIG_ACPI_APEI is not set
# CONFIG_DPTF_POWER is not set
# CONFIG_PMIC_OPREGION is not set
# CONFIG_ACPI_CONFIGFS is not set
CONFIG_X86_PM_TIMER=y
CONFIG_SFI=y

#
# CPU Frequency scaling
#
# CONFIG_CPU_FREQ is not set

#
# CPU Idle
#
CONFIG_CPU_IDLE=y
# CONFIG_CPU_IDLE_GOV_LADDER is not set
CONFIG_CPU_IDLE_GOV_MENU=y
# CONFIG_ARCH_NEEDS_CPU_IDLE_COUPLED is not set
# CONFIG_INTEL_IDLE is not set

#
# Bus options (PCI etc.)
#
CONFIG_PCI=y
CONFIG_PCI_DIRECT=y
CONFIG_PCI_MMCONFIG=y
CONFIG_PCI_DOMAINS=y
# CONFIG_PCIEPORTBUS is not set
CONFIG_PCI_BUS_ADDR_T_64BIT=y
# CONFIG_PCI_MSI is not set
CONFIG_PCI_QUIRKS=y
# CONFIG_PCI_DEBUG is not set
# CONFIG_PCI_STUB is not set
CONFIG_PCI_LOCKLESS_CONFIG=y
# CONFIG_PCI_IOV is not set
# CONFIG_PCI_PRI is not set
# CONFIG_PCI_PASID is not set
CONFIG_PCI_LABEL=y
# CONFIG_HOTPLUG_PCI is not set

#
# Cadence PCIe controllers support
#
# CONFIG_PCIE_CADENCE_HOST is not set

#
# DesignWare PCI Core Support
#

#
# PCI host controller drivers
#

#
# PCI Endpoint
#
# CONFIG_PCI_ENDPOINT is not set

#
# PCI switch controller drivers
#
# CONFIG_PCI_SW_SWITCHTEC is not set
CONFIG_ISA_DMA_API=y
CONFIG_AMD_NB=y
CONFIG_PCCARD=m
CONFIG_PCMCIA=m
# CONFIG_PCMCIA_LOAD_CIS is not set
CONFIG_CARDBUS=y

#
# PC-card bridges
#
# CONFIG_YENTA is not set
# CONFIG_PD6729 is not set
# CONFIG_I82092 is not set
# CONFIG_RAPIDIO is not set
# CONFIG_X86_SYSFB is not set

#
# Executable file formats / Emulations
#
CONFIG_BINFMT_ELF=y
CONFIG_ELFCORE=y
CONFIG_CORE_DUMP_DEFAULT_ELF_HEADERS=y
CONFIG_BINFMT_SCRIPT=y
# CONFIG_HAVE_AOUT is not set
# CONFIG_BINFMT_MISC is not set
CONFIG_COREDUMP=y
# CONFIG_IA32_EMULATION is not set
CONFIG_X86_X32=y
CONFIG_COMPAT=y
CONFIG_COMPAT_FOR_U64_ALIGNMENT=y
CONFIG_SYSVIPC_COMPAT=y
CONFIG_X86_DEV_DMA_OPS=y
CONFIG_NET=y

#
# Networking options
#
# CONFIG_PACKET is not set
CONFIG_UNIX=y
# CONFIG_UNIX_DIAG is not set
# CONFIG_TLS is not set
CONFIG_XFRM=y
# CONFIG_XFRM_USER is not set
# CONFIG_XFRM_SUB_POLICY is not set
# CONFIG_XFRM_MIGRATE is not set
# CONFIG_XFRM_STATISTICS is not set
# CONFIG_NET_KEY is not set
CONFIG_INET=y
# CONFIG_IP_MULTICAST is not set
# CONFIG_IP_ADVANCED_ROUTER is not set
CONFIG_IP_PNP=y
CONFIG_IP_PNP_DHCP=y
# CONFIG_IP_PNP_BOOTP is not set
# CONFIG_IP_PNP_RARP is not set
# CONFIG_NET_IPIP is not set
# CONFIG_NET_IPGRE_DEMUX is not set
CONFIG_NET_IP_TUNNEL=y
# CONFIG_SYN_COOKIES is not set
# CONFIG_NET_IPVTI is not set
# CONFIG_NET_UDP_TUNNEL is not set
# CONFIG_NET_FOU is not set
# CONFIG_NET_FOU_IP_TUNNELS is not set
# CONFIG_INET_AH is not set
# CONFIG_INET_ESP is not set
# CONFIG_INET_IPCOMP is not set
# CONFIG_INET_XFRM_TUNNEL is not set
CONFIG_INET_TUNNEL=y
CONFIG_INET_XFRM_MODE_TRANSPORT=y
CONFIG_INET_XFRM_MODE_TUNNEL=y
CONFIG_INET_XFRM_MODE_BEET=y
CONFIG_INET_DIAG=y
CONFIG_INET_TCP_DIAG=y
# CONFIG_INET_UDP_DIAG is not set
# CONFIG_INET_RAW_DIAG is not set
# CONFIG_INET_DIAG_DESTROY is not set
# CONFIG_TCP_CONG_ADVANCED is not set
CONFIG_TCP_CONG_CUBIC=y
CONFIG_DEFAULT_TCP_CONG="cubic"
# CONFIG_TCP_MD5SIG is not set
CONFIG_IPV6=y
# CONFIG_IPV6_ROUTER_PREF is not set
# CONFIG_IPV6_OPTIMISTIC_DAD is not set
# CONFIG_INET6_AH is not set
# CONFIG_INET6_ESP is not set
# CONFIG_INET6_IPCOMP is not set
# CONFIG_IPV6_MIP6 is not set
# CONFIG_INET6_XFRM_TUNNEL is not set
# CONFIG_INET6_TUNNEL is not set
CONFIG_INET6_XFRM_MODE_TRANSPORT=y
CONFIG_INET6_XFRM_MODE_TUNNEL=y
CONFIG_INET6_XFRM_MODE_BEET=y
# CONFIG_INET6_XFRM_MODE_ROUTEOPTIMIZATION is not set
# CONFIG_IPV6_VTI is not set
CONFIG_IPV6_SIT=y
# CONFIG_IPV6_SIT_6RD is not set
CONFIG_IPV6_NDISC_NODETYPE=y
# CONFIG_IPV6_TUNNEL is not set
# CONFIG_IPV6_FOU is not set
# CONFIG_IPV6_FOU_TUNNEL is not set
# CONFIG_IPV6_MULTIPLE_TABLES is not set
# CONFIG_IPV6_MROUTE is not set
# CONFIG_IPV6_SEG6_LWTUNNEL is not set
# CONFIG_IPV6_SEG6_HMAC is not set
# CONFIG_NETWORK_SECMARK is not set
CONFIG_NET_PTP_CLASSIFY=y
# CONFIG_NETWORK_PHY_TIMESTAMPING is not set
# CONFIG_NETFILTER is not set
# CONFIG_IP_DCCP is not set
# CONFIG_IP_SCTP is not set
# CONFIG_RDS is not set
# CONFIG_TIPC is not set
# CONFIG_ATM is not set
# CONFIG_L2TP is not set
# CONFIG_BRIDGE is not set
CONFIG_HAVE_NET_DSA=y
# CONFIG_NET_DSA is not set
# CONFIG_VLAN_8021Q is not set
# CONFIG_DECNET is not set
# CONFIG_LLC2 is not set
# CONFIG_ATALK is not set
# CONFIG_X25 is not set
# CONFIG_LAPB is not set
# CONFIG_PHONET is not set
# CONFIG_6LOWPAN is not set
# CONFIG_IEEE802154 is not set
# CONFIG_NET_SCHED is not set
# CONFIG_DCB is not set
CONFIG_DNS_RESOLVER=m
# CONFIG_BATMAN_ADV is not set
# CONFIG_OPENVSWITCH is not set
# CONFIG_VSOCKETS is not set
# CONFIG_NETLINK_DIAG is not set
# CONFIG_MPLS is not set
# CONFIG_NET_NSH is not set
# CONFIG_HSR is not set
# CONFIG_NET_SWITCHDEV is not set
# CONFIG_NET_L3_MASTER_DEV is not set
# CONFIG_NET_NCSI is not set
CONFIG_RPS=y
CONFIG_RFS_ACCEL=y
CONFIG_XPS=y
# CONFIG_CGROUP_NET_PRIO is not set
# CONFIG_CGROUP_NET_CLASSID is not set
CONFIG_NET_RX_BUSY_POLL=y
CONFIG_BQL=y
# CONFIG_BPF_JIT is not set
# CONFIG_BPF_STREAM_PARSER is not set
CONFIG_NET_FLOW_LIMIT=y

#
# Network testing
#
# CONFIG_NET_PKTGEN is not set
# CONFIG_NET_DROP_MONITOR is not set
# CONFIG_HAMRADIO is not set
# CONFIG_CAN is not set
# CONFIG_BT is not set
# CONFIG_AF_RXRPC is not set
# CONFIG_AF_KCM is not set
# CONFIG_STREAM_PARSER is not set
CONFIG_WIRELESS=y
# CONFIG_CFG80211 is not set
# CONFIG_LIB80211 is not set

#
# CFG80211 needs to be enabled for MAC80211
#
CONFIG_MAC80211_STA_HASH_MAX_SIZE=0
# CONFIG_WIMAX is not set
# CONFIG_RFKILL is not set
# CONFIG_NET_9P is not set
# CONFIG_CAIF is not set
# CONFIG_CEPH_LIB is not set
# CONFIG_NFC is not set
# CONFIG_PSAMPLE is not set
# CONFIG_NET_IFE is not set
# CONFIG_LWTUNNEL is not set
CONFIG_DST_CACHE=y
CONFIG_GRO_CELLS=y
# CONFIG_NET_DEVLINK is not set
CONFIG_MAY_USE_DEVLINK=y
CONFIG_HAVE_EBPF_JIT=y

#
# Device Drivers
#

#
# Generic Driver Options
#
CONFIG_UEVENT_HELPER=y
CONFIG_UEVENT_HELPER_PATH=""
CONFIG_DEVTMPFS=y
# CONFIG_DEVTMPFS_MOUNT is not set
CONFIG_STANDALONE=y
CONFIG_PREVENT_FIRMWARE_BUILD=y
CONFIG_FW_LOADER=y
CONFIG_EXTRA_FIRMWARE=""
CONFIG_FW_LOADER_USER_HELPER=y
CONFIG_FW_LOADER_USER_HELPER_FALLBACK=y
CONFIG_ALLOW_DEV_COREDUMP=y
# CONFIG_DEBUG_DRIVER is not set
# CONFIG_DEBUG_DEVRES is not set
# CONFIG_DEBUG_TEST_DRIVER_REMOVE is not set
CONFIG_TEST_ASYNC_DRIVER_PROBE=m
# CONFIG_SYS_HYPERVISOR is not set
# CONFIG_GENERIC_CPU_DEVICES is not set
CONFIG_GENERIC_CPU_AUTOPROBE=y
CONFIG_GENERIC_CPU_VULNERABILITIES=y
CONFIG_REGMAP=y
CONFIG_REGMAP_I2C=y
CONFIG_REGMAP_SPI=y
CONFIG_REGMAP_SPMI=m
CONFIG_REGMAP_MMIO=y
CONFIG_REGMAP_IRQ=y
CONFIG_DMA_SHARED_BUFFER=y
CONFIG_DMA_FENCE_TRACE=y

#
# Bus devices
#
# CONFIG_CONNECTOR is not set
CONFIG_MTD=m
# CONFIG_MTD_TESTS is not set
# CONFIG_MTD_REDBOOT_PARTS is not set
# CONFIG_MTD_CMDLINE_PARTS is not set
# CONFIG_MTD_OF_PARTS is not set
CONFIG_MTD_AR7_PARTS=m

#
# Partition parsers
#

#
# User Modules And Translation Layers
#
CONFIG_MTD_BLKDEVS=m
# CONFIG_MTD_BLOCK is not set
# CONFIG_MTD_BLOCK_RO is not set
CONFIG_FTL=m
CONFIG_NFTL=m
# CONFIG_NFTL_RW is not set
CONFIG_INFTL=m
CONFIG_RFD_FTL=m
CONFIG_SSFDC=m
CONFIG_SM_FTL=m
CONFIG_MTD_OOPS=m
# CONFIG_MTD_PARTITIONED_MASTER is not set

#
# RAM/ROM/Flash chip drivers
#
CONFIG_MTD_CFI=m
# CONFIG_MTD_JEDECPROBE is not set
CONFIG_MTD_GEN_PROBE=m
CONFIG_MTD_CFI_ADV_OPTIONS=y
# CONFIG_MTD_CFI_NOSWAP is not set
CONFIG_MTD_CFI_BE_BYTE_SWAP=y
# CONFIG_MTD_CFI_LE_BYTE_SWAP is not set
CONFIG_MTD_CFI_GEOMETRY=y
CONFIG_MTD_MAP_BANK_WIDTH_1=y
# CONFIG_MTD_MAP_BANK_WIDTH_2 is not set
CONFIG_MTD_MAP_BANK_WIDTH_4=y
CONFIG_MTD_MAP_BANK_WIDTH_8=y
CONFIG_MTD_MAP_BANK_WIDTH_16=y
# CONFIG_MTD_MAP_BANK_WIDTH_32 is not set
# CONFIG_MTD_CFI_I1 is not set
CONFIG_MTD_CFI_I2=y
# CONFIG_MTD_CFI_I4 is not set
# CONFIG_MTD_CFI_I8 is not set
CONFIG_MTD_OTP=y
CONFIG_MTD_CFI_INTELEXT=m
CONFIG_MTD_CFI_AMDSTD=m
CONFIG_MTD_CFI_STAA=m
CONFIG_MTD_CFI_UTIL=m
CONFIG_MTD_RAM=m
CONFIG_MTD_ROM=m
# CONFIG_MTD_ABSENT is not set

#
# Mapping drivers for chip access
#
CONFIG_MTD_COMPLEX_MAPPINGS=y
CONFIG_MTD_PHYSMAP=m
# CONFIG_MTD_PHYSMAP_COMPAT is not set
CONFIG_MTD_PHYSMAP_OF=m
# CONFIG_MTD_PHYSMAP_OF_VERSATILE is not set
CONFIG_MTD_PHYSMAP_OF_GEMINI=y
CONFIG_MTD_SBC_GXX=m
# CONFIG_MTD_PCI is not set
CONFIG_MTD_PCMCIA=m
CONFIG_MTD_PCMCIA_ANONYMOUS=y
CONFIG_MTD_GPIO_ADDR=m
# CONFIG_MTD_INTEL_VR_NOR is not set
CONFIG_MTD_PLATRAM=m
CONFIG_MTD_LATCH_ADDR=m

#
# Self-contained MTD device drivers
#
# CONFIG_MTD_PMC551 is not set
# CONFIG_MTD_DATAFLASH is not set
# CONFIG_MTD_MCHP23K256 is not set
CONFIG_MTD_SST25L=m
# CONFIG_MTD_SLRAM is not set
CONFIG_MTD_PHRAM=m
CONFIG_MTD_MTDRAM=m
CONFIG_MTDRAM_TOTAL_SIZE=4096
CONFIG_MTDRAM_ERASE_SIZE=128
CONFIG_MTD_BLOCK2MTD=m

#
# Disk-On-Chip Device Drivers
#
# CONFIG_MTD_DOCG3 is not set
CONFIG_MTD_NAND_ECC=m
CONFIG_MTD_NAND_ECC_SMC=y
CONFIG_MTD_NAND=m
CONFIG_MTD_NAND_BCH=m
CONFIG_MTD_NAND_ECC_BCH=y
# CONFIG_MTD_SM_COMMON is not set
# CONFIG_MTD_NAND_DENALI_PCI is not set
# CONFIG_MTD_NAND_DENALI_DT is not set
CONFIG_MTD_NAND_GPIO=m
# CONFIG_MTD_NAND_OMAP_BCH_BUILD is not set
# CONFIG_MTD_NAND_RICOH is not set
CONFIG_MTD_NAND_DISKONCHIP=m
# CONFIG_MTD_NAND_DISKONCHIP_PROBE_ADVANCED is not set
CONFIG_MTD_NAND_DISKONCHIP_PROBE_ADDRESS=0
CONFIG_MTD_NAND_DISKONCHIP_BBTWRITE=y
CONFIG_MTD_NAND_DOCG4=m
# CONFIG_MTD_NAND_CAFE is not set
# CONFIG_MTD_NAND_NANDSIM is not set
CONFIG_MTD_NAND_PLATFORM=m
CONFIG_MTD_ONENAND=m
CONFIG_MTD_ONENAND_VERIFY_WRITE=y
CONFIG_MTD_ONENAND_GENERIC=m
CONFIG_MTD_ONENAND_OTP=y
CONFIG_MTD_ONENAND_2X_PROGRAM=y

#
# LPDDR & LPDDR2 PCM memory drivers
#
CONFIG_MTD_LPDDR=m
CONFIG_MTD_QINFO_PROBE=m
# CONFIG_MTD_SPI_NOR is not set
# CONFIG_MTD_UBI is not set
CONFIG_OF=y
# CONFIG_OF_UNITTEST is not set
CONFIG_OF_KOBJ=y
CONFIG_OF_ADDRESS=y
CONFIG_OF_IRQ=y
CONFIG_OF_NET=y
# CONFIG_OF_OVERLAY is not set
CONFIG_ARCH_MIGHT_HAVE_PC_PARPORT=y
CONFIG_PARPORT=y
# CONFIG_PARPORT_PC is not set
# CONFIG_PARPORT_GSC is not set
CONFIG_PARPORT_AX88796=y
CONFIG_PARPORT_1284=y
CONFIG_PARPORT_NOT_PC=y
CONFIG_PNP=y
CONFIG_PNP_DEBUG_MESSAGES=y

#
# Protocols
#
CONFIG_PNPACPI=y
CONFIG_BLK_DEV=y
CONFIG_BLK_DEV_NULL_BLK=m
# CONFIG_BLK_DEV_FD is not set
CONFIG_CDROM=y
# CONFIG_BLK_DEV_PCIESSD_MTIP32XX is not set
# CONFIG_ZRAM is not set
# CONFIG_BLK_DEV_DAC960 is not set
# CONFIG_BLK_DEV_UMEM is not set
# CONFIG_BLK_DEV_COW_COMMON is not set
CONFIG_BLK_DEV_LOOP=y
CONFIG_BLK_DEV_LOOP_MIN_COUNT=8
CONFIG_BLK_DEV_CRYPTOLOOP=m
# CONFIG_BLK_DEV_DRBD is not set
# CONFIG_BLK_DEV_NBD is not set
# CONFIG_BLK_DEV_SKD is not set
# CONFIG_BLK_DEV_SX8 is not set
CONFIG_BLK_DEV_RAM=m
CONFIG_BLK_DEV_RAM_COUNT=16
CONFIG_BLK_DEV_RAM_SIZE=4096
CONFIG_CDROM_PKTCDVD=y
CONFIG_CDROM_PKTCDVD_BUFFERS=8
CONFIG_CDROM_PKTCDVD_WCACHE=y
# CONFIG_ATA_OVER_ETH is not set
CONFIG_VIRTIO_BLK=m
CONFIG_VIRTIO_BLK_SCSI=y
# CONFIG_BLK_DEV_RBD is not set
# CONFIG_BLK_DEV_RSXX is not set

#
# NVME Support
#
CONFIG_NVME_CORE=y
# CONFIG_BLK_DEV_NVME is not set
# CONFIG_NVME_MULTIPATH is not set
CONFIG_NVME_FABRICS=y
CONFIG_NVME_FC=y
# CONFIG_NVME_TARGET is not set

#
# Misc devices
#
# CONFIG_SENSORS_LIS3LV02D is not set
CONFIG_AD525X_DPOT=m
# CONFIG_AD525X_DPOT_I2C is not set
# CONFIG_AD525X_DPOT_SPI is not set
# CONFIG_DUMMY_IRQ is not set
# CONFIG_IBM_ASM is not set
# CONFIG_PHANTOM is not set
# CONFIG_SGI_IOC4 is not set
# CONFIG_TIFM_CORE is not set
# CONFIG_ICS932S401 is not set
# CONFIG_ENCLOSURE_SERVICES is not set
# CONFIG_HP_ILO is not set
# CONFIG_APDS9802ALS is not set
CONFIG_ISL29003=m
CONFIG_ISL29020=y
CONFIG_SENSORS_TSL2550=y
CONFIG_SENSORS_BH1770=y
CONFIG_SENSORS_APDS990X=y
# CONFIG_HMC6352 is not set
CONFIG_DS1682=y
CONFIG_USB_SWITCH_FSA9480=y
# CONFIG_LATTICE_ECP3_CONFIG is not set
CONFIG_SRAM=y
# CONFIG_PCI_ENDPOINT_TEST is not set
CONFIG_MISC_RTSX=m
CONFIG_C2PORT=m
CONFIG_C2PORT_DURAMAR_2150=m

#
# EEPROM support
#
CONFIG_EEPROM_AT24=m
CONFIG_EEPROM_AT25=m
# CONFIG_EEPROM_LEGACY is not set
CONFIG_EEPROM_MAX6875=m
CONFIG_EEPROM_93CX6=y
CONFIG_EEPROM_93XX46=m
CONFIG_EEPROM_IDT_89HPESX=m
# CONFIG_CB710_CORE is not set

#
# Texas Instruments shared transport line discipline
#
# CONFIG_TI_ST is not set
# CONFIG_SENSORS_LIS3_I2C is not set
# CONFIG_ALTERA_STAPL is not set
# CONFIG_INTEL_MEI is not set
# CONFIG_INTEL_MEI_ME is not set
# CONFIG_INTEL_MEI_TXE is not set
# CONFIG_VMWARE_VMCI is not set

#
# Intel MIC & related support
#

#
# Intel MIC Bus Driver
#
# CONFIG_INTEL_MIC_BUS is not set

#
# SCIF Bus Driver
#
# CONFIG_SCIF_BUS is not set

#
# VOP Bus Driver
#
# CONFIG_VOP_BUS is not set

#
# Intel MIC Host Driver
#

#
# Intel MIC Card Driver
#

#
# SCIF Driver
#

#
# Intel MIC Coprocessor State Management (COSM) Drivers
#

#
# VOP Driver
#
# CONFIG_GENWQE is not set
CONFIG_ECHO=y
# CONFIG_CXL_BASE is not set
# CONFIG_CXL_AFU_DRIVER_OPS is not set
# CONFIG_CXL_LIB is not set
# CONFIG_OCXL_BASE is not set
# CONFIG_MISC_RTSX_PCI is not set
CONFIG_MISC_RTSX_USB=m
CONFIG_HAVE_IDE=y
CONFIG_IDE=m

#
# Please see Documentation/ide/ide.txt for help/info on IDE drives
#
CONFIG_IDE_ATAPI=y
# CONFIG_BLK_DEV_IDE_SATA is not set
# CONFIG_IDE_GD is not set
CONFIG_BLK_DEV_IDECS=m
# CONFIG_BLK_DEV_DELKIN is not set
CONFIG_BLK_DEV_IDECD=m
CONFIG_BLK_DEV_IDECD_VERBOSE_ERRORS=y
CONFIG_BLK_DEV_IDETAPE=m
# CONFIG_BLK_DEV_IDEACPI is not set
# CONFIG_IDE_TASK_IOCTL is not set
# CONFIG_IDE_PROC_FS is not set

#
# IDE chipset support/bugfixes
#
CONFIG_IDE_GENERIC=m
# CONFIG_BLK_DEV_PLATFORM is not set
# CONFIG_BLK_DEV_CMD640 is not set
# CONFIG_BLK_DEV_IDEPNP is not set

#
# PCI IDE chipsets support
#
# CONFIG_BLK_DEV_GENERIC is not set
# CONFIG_BLK_DEV_OPTI621 is not set
# CONFIG_BLK_DEV_RZ1000 is not set
# CONFIG_BLK_DEV_AEC62XX is not set
# CONFIG_BLK_DEV_ALI15X3 is not set
# CONFIG_BLK_DEV_AMD74XX is not set
# CONFIG_BLK_DEV_ATIIXP is not set
# CONFIG_BLK_DEV_CMD64X is not set
# CONFIG_BLK_DEV_TRIFLEX is not set
# CONFIG_BLK_DEV_HPT366 is not set
# CONFIG_BLK_DEV_JMICRON is not set
# CONFIG_BLK_DEV_PIIX is not set
# CONFIG_BLK_DEV_IT8172 is not set
# CONFIG_BLK_DEV_IT8213 is not set
# CONFIG_BLK_DEV_IT821X is not set
# CONFIG_BLK_DEV_NS87415 is not set
# CONFIG_BLK_DEV_PDC202XX_OLD is not set
# CONFIG_BLK_DEV_PDC202XX_NEW is not set
# CONFIG_BLK_DEV_SVWKS is not set
# CONFIG_BLK_DEV_SIIMAGE is not set
# CONFIG_BLK_DEV_SIS5513 is not set
# CONFIG_BLK_DEV_SLC90E66 is not set
# CONFIG_BLK_DEV_TRM290 is not set
# CONFIG_BLK_DEV_VIA82CXXX is not set
# CONFIG_BLK_DEV_TC86C001 is not set
# CONFIG_BLK_DEV_IDEDMA is not set

#
# SCSI device support
#
CONFIG_SCSI_MOD=y
CONFIG_RAID_ATTRS=m
CONFIG_SCSI=y
CONFIG_SCSI_DMA=y
# CONFIG_SCSI_NETLINK is not set
# CONFIG_SCSI_MQ_DEFAULT is not set
# CONFIG_SCSI_PROC_FS is not set

#
# SCSI support type (disk, tape, CD-ROM)
#
CONFIG_BLK_DEV_SD=m
CONFIG_CHR_DEV_ST=y
# CONFIG_CHR_DEV_OSST is not set
CONFIG_BLK_DEV_SR=m
CONFIG_BLK_DEV_SR_VENDOR=y
# CONFIG_CHR_DEV_SG is not set
CONFIG_CHR_DEV_SCH=m
# CONFIG_SCSI_CONSTANTS is not set
CONFIG_SCSI_LOGGING=y
# CONFIG_SCSI_SCAN_ASYNC is not set

#
# SCSI Transports
#
CONFIG_SCSI_SPI_ATTRS=m
# CONFIG_SCSI_FC_ATTRS is not set
# CONFIG_SCSI_ISCSI_ATTRS is not set
CONFIG_SCSI_SAS_ATTRS=m
CONFIG_SCSI_SAS_LIBSAS=m
CONFIG_SCSI_SAS_ATA=y
# CONFIG_SCSI_SAS_HOST_SMP is not set
# CONFIG_SCSI_SRP_ATTRS is not set
CONFIG_SCSI_LOWLEVEL=y
# CONFIG_ISCSI_TCP is not set
# CONFIG_ISCSI_BOOT_SYSFS is not set
# CONFIG_SCSI_CXGB3_ISCSI is not set
# CONFIG_SCSI_CXGB4_ISCSI is not set
# CONFIG_SCSI_BNX2_ISCSI is not set
# CONFIG_BE2ISCSI is not set
# CONFIG_BLK_DEV_3W_XXXX_RAID is not set
# CONFIG_SCSI_HPSA is not set
# CONFIG_SCSI_3W_9XXX is not set
# CONFIG_SCSI_3W_SAS is not set
# CONFIG_SCSI_ACARD is not set
# CONFIG_SCSI_AACRAID is not set
# CONFIG_SCSI_AIC7XXX is not set
# CONFIG_SCSI_AIC79XX is not set
# CONFIG_SCSI_AIC94XX is not set
# CONFIG_SCSI_MVSAS is not set
# CONFIG_SCSI_MVUMI is not set
# CONFIG_SCSI_DPT_I2O is not set
# CONFIG_SCSI_ADVANSYS is not set
# CONFIG_SCSI_ARCMSR is not set
# CONFIG_SCSI_ESAS2R is not set
# CONFIG_MEGARAID_NEWGEN is not set
# CONFIG_MEGARAID_LEGACY is not set
# CONFIG_MEGARAID_SAS is not set
# CONFIG_SCSI_MPT3SAS is not set
# CONFIG_SCSI_MPT2SAS is not set
# CONFIG_SCSI_SMARTPQI is not set
CONFIG_SCSI_UFSHCD=m
# CONFIG_SCSI_UFSHCD_PCI is not set
CONFIG_SCSI_UFSHCD_PLATFORM=m
CONFIG_SCSI_UFS_DWC_TC_PLATFORM=m
# CONFIG_SCSI_HPTIOP is not set
# CONFIG_SCSI_BUSLOGIC is not set
# CONFIG_VMWARE_PVSCSI is not set
# CONFIG_SCSI_SNIC is not set
# CONFIG_SCSI_DMX3191D is not set
# CONFIG_SCSI_EATA is not set
# CONFIG_SCSI_FUTURE_DOMAIN is not set
# CONFIG_SCSI_GDTH is not set
# CONFIG_SCSI_ISCI is not set
# CONFIG_SCSI_IPS is not set
# CONFIG_SCSI_INITIO is not set
# CONFIG_SCSI_INIA100 is not set
# CONFIG_SCSI_STEX is not set
# CONFIG_SCSI_SYM53C8XX_2 is not set
# CONFIG_SCSI_IPR is not set
# CONFIG_SCSI_QLOGIC_1280 is not set
# CONFIG_SCSI_QLA_ISCSI is not set
# CONFIG_SCSI_DC395x is not set
# CONFIG_SCSI_AM53C974 is not set
# CONFIG_SCSI_WD719X is not set
CONFIG_SCSI_DEBUG=y
# CONFIG_SCSI_PMCRAID is not set
# CONFIG_SCSI_PM8001 is not set
CONFIG_SCSI_VIRTIO=y
CONFIG_SCSI_LOWLEVEL_PCMCIA=y
CONFIG_PCMCIA_AHA152X=m
# CONFIG_PCMCIA_FDOMAIN is not set
CONFIG_PCMCIA_QLOGIC=m
CONFIG_PCMCIA_SYM53C500=m
# CONFIG_SCSI_DH is not set
# CONFIG_SCSI_OSD_INITIATOR is not set
CONFIG_ATA=y
# CONFIG_ATA_NONSTANDARD is not set
CONFIG_ATA_VERBOSE_ERROR=y
CONFIG_ATA_ACPI=y
CONFIG_SATA_PMP=y

#
# Controllers with non-SFF native interface
#
# CONFIG_SATA_AHCI is not set
CONFIG_SATA_AHCI_PLATFORM=y
# CONFIG_AHCI_CEVA is not set
CONFIG_AHCI_QORIQ=y
# CONFIG_SATA_INIC162X is not set
# CONFIG_SATA_ACARD_AHCI is not set
# CONFIG_SATA_SIL24 is not set
CONFIG_ATA_SFF=y

#
# SFF controllers with custom DMA interface
#
# CONFIG_PDC_ADMA is not set
# CONFIG_SATA_QSTOR is not set
# CONFIG_SATA_SX4 is not set
# CONFIG_ATA_BMDMA is not set

#
# PIO-only SFF controllers
#
# CONFIG_PATA_CMD640_PCI is not set
# CONFIG_PATA_MPIIX is not set
# CONFIG_PATA_NS87410 is not set
# CONFIG_PATA_OPTI is not set
# CONFIG_PATA_PCMCIA is not set
# CONFIG_PATA_RZ1000 is not set

#
# Generic fallback / legacy drivers
#
# CONFIG_PATA_LEGACY is not set
CONFIG_MD=y
CONFIG_BLK_DEV_MD=m
CONFIG_MD_LINEAR=m
CONFIG_MD_RAID0=m
CONFIG_MD_RAID1=m
# CONFIG_MD_RAID10 is not set
# CONFIG_MD_RAID456 is not set
CONFIG_MD_MULTIPATH=m
# CONFIG_MD_FAULTY is not set
CONFIG_BCACHE=m
# CONFIG_BCACHE_DEBUG is not set
# CONFIG_BCACHE_CLOSURES_DEBUG is not set
CONFIG_BLK_DEV_DM_BUILTIN=y
CONFIG_BLK_DEV_DM=y
# CONFIG_DM_MQ_DEFAULT is not set
# CONFIG_DM_DEBUG is not set
CONFIG_DM_BUFIO=y
CONFIG_DM_DEBUG_BLOCK_MANAGER_LOCKING=y
CONFIG_DM_DEBUG_BLOCK_STACK_TRACING=y
CONFIG_DM_BIO_PRISON=y
CONFIG_DM_PERSISTENT_DATA=y
CONFIG_DM_UNSTRIPED=y
CONFIG_DM_CRYPT=y
CONFIG_DM_SNAPSHOT=m
CONFIG_DM_THIN_PROVISIONING=y
# CONFIG_DM_CACHE is not set
CONFIG_DM_ERA=y
CONFIG_DM_MIRROR=y
# CONFIG_DM_LOG_USERSPACE is not set
# CONFIG_DM_RAID is not set
CONFIG_DM_ZERO=y
CONFIG_DM_MULTIPATH=m
CONFIG_DM_MULTIPATH_QL=m
CONFIG_DM_MULTIPATH_ST=m
CONFIG_DM_DELAY=y
# CONFIG_DM_UEVENT is not set
CONFIG_DM_FLAKEY=m
# CONFIG_DM_VERITY is not set
# CONFIG_DM_SWITCH is not set
CONFIG_DM_LOG_WRITES=m
# CONFIG_DM_INTEGRITY is not set
# CONFIG_DM_ZONED is not set
CONFIG_TARGET_CORE=m
CONFIG_TCM_IBLOCK=m
# CONFIG_TCM_FILEIO is not set
CONFIG_TCM_PSCSI=m
# CONFIG_TCM_USER2 is not set
CONFIG_LOOPBACK_TARGET=m
# CONFIG_ISCSI_TARGET is not set
CONFIG_SBP_TARGET=m
# CONFIG_FUSION is not set

#
# IEEE 1394 (FireWire) support
#
CONFIG_FIREWIRE=y
# CONFIG_FIREWIRE_OHCI is not set
CONFIG_FIREWIRE_SBP2=y
# CONFIG_FIREWIRE_NET is not set
# CONFIG_FIREWIRE_NOSY is not set
CONFIG_MACINTOSH_DRIVERS=y
CONFIG_MAC_EMUMOUSEBTN=y
CONFIG_NETDEVICES=y
CONFIG_NET_CORE=y
# CONFIG_BONDING is not set
# CONFIG_DUMMY is not set
# CONFIG_EQUALIZER is not set
# CONFIG_NET_FC is not set
# CONFIG_NET_TEAM is not set
# CONFIG_MACVLAN is not set
# CONFIG_VXLAN is not set
# CONFIG_MACSEC is not set
# CONFIG_NETCONSOLE is not set
# CONFIG_NETPOLL is not set
# CONFIG_NET_POLL_CONTROLLER is not set
# CONFIG_TUN is not set
# CONFIG_TUN_VNET_CROSS_LE is not set
# CONFIG_VETH is not set
# CONFIG_VIRTIO_NET is not set
# CONFIG_NLMON is not set
# CONFIG_ARCNET is not set

#
# CAIF transport drivers
#

#
# Distributed Switch Architecture drivers
#
CONFIG_ETHERNET=y
CONFIG_MDIO=m
CONFIG_NET_VENDOR_3COM=y
# CONFIG_PCMCIA_3C574 is not set
# CONFIG_PCMCIA_3C589 is not set
# CONFIG_VORTEX is not set
# CONFIG_TYPHOON is not set
CONFIG_NET_VENDOR_ADAPTEC=y
# CONFIG_ADAPTEC_STARFIRE is not set
CONFIG_NET_VENDOR_AGERE=y
# CONFIG_ET131X is not set
CONFIG_NET_VENDOR_ALACRITECH=y
# CONFIG_SLICOSS is not set
CONFIG_NET_VENDOR_ALTEON=y
# CONFIG_ACENIC is not set
# CONFIG_ALTERA_TSE is not set
CONFIG_NET_VENDOR_AMAZON=y
CONFIG_NET_VENDOR_AMD=y
# CONFIG_AMD8111_ETH is not set
# CONFIG_PCNET32 is not set
# CONFIG_PCMCIA_NMCLAN is not set
# CONFIG_AMD_XGBE is not set
# CONFIG_AMD_XGBE_HAVE_ECC is not set
CONFIG_NET_VENDOR_AQUANTIA=y
# CONFIG_AQTION is not set
CONFIG_NET_VENDOR_ARC=y
CONFIG_NET_VENDOR_ATHEROS=y
# CONFIG_ATL2 is not set
# CONFIG_ATL1 is not set
# CONFIG_ATL1E is not set
# CONFIG_ATL1C is not set
# CONFIG_ALX is not set
# CONFIG_NET_VENDOR_AURORA is not set
CONFIG_NET_CADENCE=y
# CONFIG_MACB is not set
CONFIG_NET_VENDOR_BROADCOM=y
# CONFIG_B44 is not set
# CONFIG_BCMGENET is not set
# CONFIG_BNX2 is not set
# CONFIG_CNIC is not set
# CONFIG_TIGON3 is not set
# CONFIG_BNX2X is not set
# CONFIG_SYSTEMPORT is not set
# CONFIG_BNXT is not set
CONFIG_NET_VENDOR_BROCADE=y
# CONFIG_BNA is not set
CONFIG_NET_VENDOR_CAVIUM=y
# CONFIG_THUNDER_NIC_PF is not set
# CONFIG_THUNDER_NIC_VF is not set
# CONFIG_THUNDER_NIC_BGX is not set
# CONFIG_THUNDER_NIC_RGX is not set
CONFIG_CAVIUM_PTP=y
# CONFIG_LIQUIDIO is not set
CONFIG_NET_VENDOR_CHELSIO=y
# CONFIG_CHELSIO_T1 is not set
# CONFIG_CHELSIO_T3 is not set
# CONFIG_CHELSIO_T4 is not set
# CONFIG_CHELSIO_T4VF is not set
CONFIG_NET_VENDOR_CISCO=y
# CONFIG_ENIC is not set
CONFIG_NET_VENDOR_CORTINA=y
# CONFIG_GEMINI_ETHERNET is not set
# CONFIG_CX_ECAT is not set
# CONFIG_DNET is not set
CONFIG_NET_VENDOR_DEC=y
# CONFIG_NET_TULIP is not set
CONFIG_NET_VENDOR_DLINK=y
# CONFIG_DL2K is not set
# CONFIG_SUNDANCE is not set
CONFIG_NET_VENDOR_EMULEX=y
# CONFIG_BE2NET is not set
CONFIG_NET_VENDOR_EZCHIP=y
# CONFIG_EZCHIP_NPS_MANAGEMENT_ENET is not set
CONFIG_NET_VENDOR_EXAR=y
# CONFIG_S2IO is not set
# CONFIG_VXGE is not set
CONFIG_NET_VENDOR_FUJITSU=y
# CONFIG_PCMCIA_FMVJ18X is not set
CONFIG_NET_VENDOR_HP=y
# CONFIG_HP100 is not set
CONFIG_NET_VENDOR_HUAWEI=y
CONFIG_NET_VENDOR_INTEL=y
# CONFIG_E100 is not set
CONFIG_E1000=y
CONFIG_E1000E=m
CONFIG_E1000E_HWTS=y
CONFIG_IGB=m
CONFIG_IGB_HWMON=y
# CONFIG_IGBVF is not set
# CONFIG_IXGB is not set
CONFIG_IXGBE=m
CONFIG_IXGBE_HWMON=y
# CONFIG_I40E is not set
CONFIG_NET_VENDOR_I825XX=y
# CONFIG_JME is not set
CONFIG_NET_VENDOR_MARVELL=y
# CONFIG_MVMDIO is not set
# CONFIG_SKGE is not set
# CONFIG_SKY2 is not set
CONFIG_NET_VENDOR_MELLANOX=y
# CONFIG_MLX4_EN is not set
# CONFIG_MLX4_CORE is not set
# CONFIG_MLX5_CORE is not set
# CONFIG_MLXSW_CORE is not set
# CONFIG_MLXFW is not set
CONFIG_NET_VENDOR_MICREL=y
# CONFIG_KS8842 is not set
# CONFIG_KS8851 is not set
# CONFIG_KS8851_MLL is not set
# CONFIG_KSZ884X_PCI is not set
CONFIG_NET_VENDOR_MICROCHIP=y
# CONFIG_ENC28J60 is not set
# CONFIG_ENCX24J600 is not set
CONFIG_NET_VENDOR_MYRI=y
# CONFIG_MYRI10GE is not set
# CONFIG_FEALNX is not set
CONFIG_NET_VENDOR_NATSEMI=y
# CONFIG_NATSEMI is not set
# CONFIG_NS83820 is not set
CONFIG_NET_VENDOR_NETRONOME=y
CONFIG_NET_VENDOR_8390=y
# CONFIG_PCMCIA_AXNET is not set
# CONFIG_NE2K_PCI is not set
# CONFIG_PCMCIA_PCNET is not set
CONFIG_NET_VENDOR_NVIDIA=y
# CONFIG_FORCEDETH is not set
CONFIG_NET_VENDOR_OKI=y
# CONFIG_ETHOC is not set
CONFIG_NET_PACKET_ENGINE=y
# CONFIG_HAMACHI is not set
# CONFIG_YELLOWFIN is not set
CONFIG_NET_VENDOR_QLOGIC=y
# CONFIG_QLA3XXX is not set
# CONFIG_QLCNIC is not set
# CONFIG_QLGE is not set
# CONFIG_NETXEN_NIC is not set
# CONFIG_QED is not set
CONFIG_NET_VENDOR_QUALCOMM=y
# CONFIG_QCA7000_SPI is not set
# CONFIG_QCOM_EMAC is not set
# CONFIG_RMNET is not set
CONFIG_NET_VENDOR_REALTEK=y
# CONFIG_ATP is not set
# CONFIG_8139CP is not set
# CONFIG_8139TOO is not set
# CONFIG_R8169 is not set
CONFIG_NET_VENDOR_RENESAS=y
CONFIG_NET_VENDOR_RDC=y
# CONFIG_R6040 is not set
CONFIG_NET_VENDOR_ROCKER=y
CONFIG_NET_VENDOR_SAMSUNG=y
# CONFIG_SXGBE_ETH is not set
CONFIG_NET_VENDOR_SEEQ=y
CONFIG_NET_VENDOR_SILAN=y
# CONFIG_SC92031 is not set
CONFIG_NET_VENDOR_SIS=y
# CONFIG_SIS900 is not set
# CONFIG_SIS190 is not set
CONFIG_NET_VENDOR_SOLARFLARE=y
# CONFIG_SFC is not set
# CONFIG_SFC_FALCON is not set
CONFIG_NET_VENDOR_SMSC=y
# CONFIG_PCMCIA_SMC91C92 is not set
# CONFIG_EPIC100 is not set
# CONFIG_SMSC911X is not set
# CONFIG_SMSC9420 is not set
CONFIG_NET_VENDOR_SOCIONEXT=y
CONFIG_NET_VENDOR_STMICRO=y
# CONFIG_STMMAC_ETH is not set
CONFIG_NET_VENDOR_SUN=y
# CONFIG_HAPPYMEAL is not set
# CONFIG_SUNGEM is not set
# CONFIG_CASSINI is not set
# CONFIG_NIU is not set
CONFIG_NET_VENDOR_TEHUTI=y
# CONFIG_TEHUTI is not set
CONFIG_NET_VENDOR_TI=y
# CONFIG_TI_CPSW_ALE is not set
# CONFIG_TLAN is not set
CONFIG_NET_VENDOR_VIA=y
# CONFIG_VIA_RHINE is not set
# CONFIG_VIA_VELOCITY is not set
CONFIG_NET_VENDOR_WIZNET=y
# CONFIG_WIZNET_W5100 is not set
# CONFIG_WIZNET_W5300 is not set
CONFIG_NET_VENDOR_XIRCOM=y
# CONFIG_PCMCIA_XIRC2PS is not set
CONFIG_NET_VENDOR_SYNOPSYS=y
# CONFIG_DWC_XLGMAC is not set
# CONFIG_FDDI is not set
# CONFIG_HIPPI is not set
# CONFIG_NET_SB1000 is not set
# CONFIG_MDIO_DEVICE is not set
# CONFIG_MDIO_BUS is not set
# CONFIG_PHYLIB is not set
# CONFIG_MICREL_KS8995MA is not set
# CONFIG_PLIP is not set
# CONFIG_PPP is not set
# CONFIG_SLIP is not set
CONFIG_USB_NET_DRIVERS=y
# CONFIG_USB_CATC is not set
# CONFIG_USB_KAWETH is not set
# CONFIG_USB_PEGASUS is not set
# CONFIG_USB_RTL8150 is not set
# CONFIG_USB_RTL8152 is not set
# CONFIG_USB_LAN78XX is not set
# CONFIG_USB_USBNET is not set
# CONFIG_USB_IPHETH is not set
CONFIG_WLAN=y
CONFIG_WLAN_VENDOR_ADMTEK=y
CONFIG_WLAN_VENDOR_ATH=y
# CONFIG_ATH_DEBUG is not set
# CONFIG_ATH5K_PCI is not set
CONFIG_WLAN_VENDOR_ATMEL=y
CONFIG_WLAN_VENDOR_BROADCOM=y
CONFIG_WLAN_VENDOR_CISCO=y
CONFIG_WLAN_VENDOR_INTEL=y
CONFIG_WLAN_VENDOR_INTERSIL=y
# CONFIG_HOSTAP is not set
# CONFIG_PRISM54 is not set
CONFIG_WLAN_VENDOR_MARVELL=y
CONFIG_WLAN_VENDOR_MEDIATEK=y
CONFIG_WLAN_VENDOR_RALINK=y
CONFIG_WLAN_VENDOR_REALTEK=y
CONFIG_WLAN_VENDOR_RSI=y
CONFIG_WLAN_VENDOR_ST=y
CONFIG_WLAN_VENDOR_TI=y
CONFIG_WLAN_VENDOR_ZYDAS=y
CONFIG_WLAN_VENDOR_QUANTENNA=y
# CONFIG_PCMCIA_RAYCS is not set

#
# Enable WiMAX (Networking options) to see the WiMAX drivers
#
# CONFIG_WAN is not set
# CONFIG_VMXNET3 is not set
# CONFIG_FUJITSU_ES is not set
# CONFIG_NETDEVSIM is not set
# CONFIG_ISDN is not set
# CONFIG_NVM is not set

#
# Input device support
#
CONFIG_INPUT=y
CONFIG_INPUT_LEDS=m
CONFIG_INPUT_FF_MEMLESS=y
CONFIG_INPUT_POLLDEV=y
CONFIG_INPUT_SPARSEKMAP=m
# CONFIG_INPUT_MATRIXKMAP is not set

#
# Userland interfaces
#
# CONFIG_INPUT_MOUSEDEV is not set
# CONFIG_INPUT_JOYDEV is not set
CONFIG_INPUT_EVDEV=y
CONFIG_INPUT_EVBUG=y

#
# Input Device Drivers
#
CONFIG_INPUT_KEYBOARD=y
# CONFIG_KEYBOARD_ADC is not set
# CONFIG_KEYBOARD_ADP5520 is not set
# CONFIG_KEYBOARD_ADP5588 is not set
# CONFIG_KEYBOARD_ADP5589 is not set
CONFIG_KEYBOARD_ATKBD=y
# CONFIG_KEYBOARD_QT1070 is not set
# CONFIG_KEYBOARD_QT2160 is not set
# CONFIG_KEYBOARD_DLINK_DIR685 is not set
# CONFIG_KEYBOARD_LKKBD is not set
# CONFIG_KEYBOARD_GPIO is not set
# CONFIG_KEYBOARD_GPIO_POLLED is not set
# CONFIG_KEYBOARD_TCA6416 is not set
# CONFIG_KEYBOARD_TCA8418 is not set
# CONFIG_KEYBOARD_MATRIX is not set
# CONFIG_KEYBOARD_LM8323 is not set
# CONFIG_KEYBOARD_LM8333 is not set
# CONFIG_KEYBOARD_MAX7359 is not set
# CONFIG_KEYBOARD_MCS is not set
# CONFIG_KEYBOARD_MPR121 is not set
# CONFIG_KEYBOARD_NEWTON is not set
# CONFIG_KEYBOARD_OPENCORES is not set
# CONFIG_KEYBOARD_SAMSUNG is not set
# CONFIG_KEYBOARD_GOLDFISH_EVENTS is not set
# CONFIG_KEYBOARD_STOWAWAY is not set
# CONFIG_KEYBOARD_SUNKBD is not set
# CONFIG_KEYBOARD_OMAP4 is not set
# CONFIG_KEYBOARD_TM2_TOUCHKEY is not set
# CONFIG_KEYBOARD_TWL4030 is not set
# CONFIG_KEYBOARD_XTKBD is not set
# CONFIG_KEYBOARD_CROS_EC is not set
# CONFIG_KEYBOARD_CAP11XX is not set
# CONFIG_KEYBOARD_BCM is not set
# CONFIG_INPUT_MOUSE is not set
# CONFIG_INPUT_JOYSTICK is not set
CONFIG_INPUT_TABLET=y
CONFIG_TABLET_USB_ACECAD=y
# CONFIG_TABLET_USB_AIPTEK is not set
CONFIG_TABLET_USB_GTCO=y
CONFIG_TABLET_USB_HANWANG=m
CONFIG_TABLET_USB_KBTAB=y
# CONFIG_TABLET_USB_PEGASUS is not set
CONFIG_TABLET_SERIAL_WACOM4=m
# CONFIG_INPUT_TOUCHSCREEN is not set
CONFIG_INPUT_MISC=y
# CONFIG_INPUT_88PM860X_ONKEY is not set
CONFIG_INPUT_88PM80X_ONKEY=y
# CONFIG_INPUT_AD714X is not set
# CONFIG_INPUT_ATMEL_CAPTOUCH is not set
# CONFIG_INPUT_BMA150 is not set
# CONFIG_INPUT_E3X0_BUTTON is not set
CONFIG_INPUT_PCSPKR=y
# CONFIG_INPUT_MAX77693_HAPTIC is not set
# CONFIG_INPUT_MAX8925_ONKEY is not set
CONFIG_INPUT_MC13783_PWRBUTTON=y
CONFIG_INPUT_MMA8450=y
CONFIG_INPUT_APANEL=y
CONFIG_INPUT_GP2A=y
CONFIG_INPUT_GPIO_BEEPER=y
CONFIG_INPUT_GPIO_DECODER=m
# CONFIG_INPUT_CPCAP_PWRBUTTON is not set
# CONFIG_INPUT_ATLAS_BTNS is not set
CONFIG_INPUT_ATI_REMOTE2=y
CONFIG_INPUT_KEYSPAN_REMOTE=y
CONFIG_INPUT_KXTJ9=m
# CONFIG_INPUT_KXTJ9_POLLED_MODE is not set
CONFIG_INPUT_POWERMATE=m
CONFIG_INPUT_YEALINK=m
# CONFIG_INPUT_CM109 is not set
CONFIG_INPUT_REGULATOR_HAPTIC=y
CONFIG_INPUT_TPS65218_PWRBUTTON=m
CONFIG_INPUT_AXP20X_PEK=m
CONFIG_INPUT_TWL4030_PWRBUTTON=y
CONFIG_INPUT_TWL4030_VIBRA=m
CONFIG_INPUT_TWL6040_VIBRA=y
# CONFIG_INPUT_UINPUT is not set
# CONFIG_INPUT_PALMAS_PWRBUTTON is not set
CONFIG_INPUT_PCF8574=m
CONFIG_INPUT_PWM_BEEPER=m
# CONFIG_INPUT_PWM_VIBRA is not set
# CONFIG_INPUT_RK805_PWRKEY is not set
CONFIG_INPUT_GPIO_ROTARY_ENCODER=m
# CONFIG_INPUT_DA9052_ONKEY is not set
CONFIG_INPUT_DA9063_ONKEY=y
# CONFIG_INPUT_WM831X_ON is not set
CONFIG_INPUT_ADXL34X=y
# CONFIG_INPUT_ADXL34X_I2C is not set
CONFIG_INPUT_ADXL34X_SPI=m
CONFIG_INPUT_IMS_PCU=m
CONFIG_INPUT_CMA3000=m
CONFIG_INPUT_CMA3000_I2C=m
# CONFIG_INPUT_IDEAPAD_SLIDEBAR is not set
# CONFIG_INPUT_DRV260X_HAPTICS is not set
CONFIG_INPUT_DRV2665_HAPTICS=m
# CONFIG_INPUT_DRV2667_HAPTICS is not set
CONFIG_RMI4_CORE=m
CONFIG_RMI4_I2C=m
# CONFIG_RMI4_SPI is not set
CONFIG_RMI4_SMB=m
CONFIG_RMI4_F03=y
CONFIG_RMI4_F03_SERIO=m
CONFIG_RMI4_2D_SENSOR=y
CONFIG_RMI4_F11=y
CONFIG_RMI4_F12=y
CONFIG_RMI4_F30=y
# CONFIG_RMI4_F34 is not set
CONFIG_RMI4_F54=y
CONFIG_RMI4_F55=y

#
# Hardware I/O ports
#
CONFIG_SERIO=y
CONFIG_ARCH_MIGHT_HAVE_PC_SERIO=y
CONFIG_SERIO_I8042=y
CONFIG_SERIO_SERPORT=m
# CONFIG_SERIO_CT82C710 is not set
# CONFIG_SERIO_PARKBD is not set
# CONFIG_SERIO_PCIPS2 is not set
CONFIG_SERIO_LIBPS2=y
CONFIG_SERIO_RAW=m
# CONFIG_SERIO_ALTERA_PS2 is not set
CONFIG_SERIO_PS2MULT=m
CONFIG_SERIO_ARC_PS2=m
CONFIG_SERIO_APBPS2=m
# CONFIG_SERIO_GPIO_PS2 is not set
CONFIG_USERIO=m
CONFIG_GAMEPORT=m
CONFIG_GAMEPORT_NS558=m
# CONFIG_GAMEPORT_L4 is not set
# CONFIG_GAMEPORT_EMU10K1 is not set
# CONFIG_GAMEPORT_FM801 is not set

#
# Character devices
#
CONFIG_TTY=y
CONFIG_VT=y
CONFIG_CONSOLE_TRANSLATIONS=y
CONFIG_VT_CONSOLE=y
CONFIG_HW_CONSOLE=y
# CONFIG_VT_HW_CONSOLE_BINDING is not set
CONFIG_UNIX98_PTYS=y
CONFIG_LEGACY_PTYS=y
CONFIG_LEGACY_PTY_COUNT=256
CONFIG_SERIAL_NONSTANDARD=y
# CONFIG_ROCKETPORT is not set
# CONFIG_CYCLADES is not set
# CONFIG_MOXA_INTELLIO is not set
# CONFIG_MOXA_SMARTIO is not set
# CONFIG_SYNCLINK is not set
# CONFIG_SYNCLINKMP is not set
# CONFIG_SYNCLINK_GT is not set
# CONFIG_NOZOMI is not set
# CONFIG_ISI is not set
# CONFIG_N_HDLC is not set
# CONFIG_N_GSM is not set
# CONFIG_TRACE_ROUTER is not set
CONFIG_TRACE_SINK=y
CONFIG_GOLDFISH_TTY=m
CONFIG_DEVMEM=y
# CONFIG_DEVKMEM is not set

#
# Serial drivers
#
CONFIG_SERIAL_EARLYCON=y
CONFIG_SERIAL_8250=y
# CONFIG_SERIAL_8250_DEPRECATED_OPTIONS is not set
CONFIG_SERIAL_8250_PNP=y
# CONFIG_SERIAL_8250_FINTEK is not set
CONFIG_SERIAL_8250_CONSOLE=y
CONFIG_SERIAL_8250_DMA=y
CONFIG_SERIAL_8250_PCI=y
CONFIG_SERIAL_8250_EXAR=y
# CONFIG_SERIAL_8250_CS is not set
CONFIG_SERIAL_8250_MEN_MCB=m
CONFIG_SERIAL_8250_NR_UARTS=4
CONFIG_SERIAL_8250_RUNTIME_UARTS=4
# CONFIG_SERIAL_8250_EXTENDED is not set
# CONFIG_SERIAL_8250_ASPEED_VUART is not set
# CONFIG_SERIAL_8250_FSL is not set
CONFIG_SERIAL_8250_DW=y
CONFIG_SERIAL_8250_RT288X=y
CONFIG_SERIAL_8250_LPSS=y
CONFIG_SERIAL_8250_MID=y
# CONFIG_SERIAL_8250_MOXA is not set
CONFIG_SERIAL_OF_PLATFORM=m

#
# Non-8250 serial port support
#
# CONFIG_SERIAL_MAX3100 is not set
CONFIG_SERIAL_MAX310X=m
# CONFIG_SERIAL_UARTLITE is not set
CONFIG_SERIAL_CORE=y
CONFIG_SERIAL_CORE_CONSOLE=y
# CONFIG_SERIAL_JSM is not set
CONFIG_SERIAL_SCCNXP=y
CONFIG_SERIAL_SCCNXP_CONSOLE=y
CONFIG_SERIAL_SC16IS7XX_CORE=m
CONFIG_SERIAL_SC16IS7XX=m
CONFIG_SERIAL_SC16IS7XX_I2C=y
CONFIG_SERIAL_SC16IS7XX_SPI=y
CONFIG_SERIAL_ALTERA_JTAGUART=m
# CONFIG_SERIAL_ALTERA_UART is not set
# CONFIG_SERIAL_IFX6X60 is not set
CONFIG_SERIAL_XILINX_PS_UART=y
# CONFIG_SERIAL_XILINX_PS_UART_CONSOLE is not set
# CONFIG_SERIAL_ARC is not set
# CONFIG_SERIAL_RP2 is not set
# CONFIG_SERIAL_FSL_LPUART is not set
CONFIG_SERIAL_CONEXANT_DIGICOLOR=m
CONFIG_SERIAL_MEN_Z135=m
# CONFIG_SERIAL_DEV_BUS is not set
CONFIG_PRINTER=y
CONFIG_LP_CONSOLE=y
CONFIG_PPDEV=y
CONFIG_HVC_DRIVER=y
CONFIG_VIRTIO_CONSOLE=m
CONFIG_IPMI_HANDLER=m
CONFIG_IPMI_DMI_DECODE=y
CONFIG_IPMI_PROC_INTERFACE=y
CONFIG_IPMI_PANIC_EVENT=y
CONFIG_IPMI_PANIC_STRING=y
# CONFIG_IPMI_DEVICE_INTERFACE is not set
CONFIG_IPMI_SI=m
CONFIG_IPMI_SSIF=m
# CONFIG_IPMI_WATCHDOG is not set
CONFIG_IPMI_POWEROFF=m
# CONFIG_HW_RANDOM is not set
# CONFIG_NVRAM is not set
CONFIG_R3964=m
# CONFIG_APPLICOM is not set

#
# PCMCIA character devices
#
CONFIG_SYNCLINK_CS=m
CONFIG_CARDMAN_4000=m
# CONFIG_CARDMAN_4040 is not set
CONFIG_SCR24X=m
# CONFIG_IPWIRELESS is not set
CONFIG_MWAVE=m
CONFIG_RAW_DRIVER=m
CONFIG_MAX_RAW_DEVS=256
# CONFIG_HPET is not set
CONFIG_HANGCHECK_TIMER=m
CONFIG_TCG_TPM=y
CONFIG_TCG_TIS_CORE=y
CONFIG_TCG_TIS=y
CONFIG_TCG_TIS_SPI=m
# CONFIG_TCG_TIS_I2C_ATMEL is not set
# CONFIG_TCG_TIS_I2C_INFINEON is not set
CONFIG_TCG_TIS_I2C_NUVOTON=y
CONFIG_TCG_NSC=m
# CONFIG_TCG_ATMEL is not set
# CONFIG_TCG_INFINEON is not set
# CONFIG_TCG_CRB is not set
# CONFIG_TCG_VTPM_PROXY is not set
CONFIG_TCG_TIS_ST33ZP24=y
CONFIG_TCG_TIS_ST33ZP24_I2C=y
# CONFIG_TCG_TIS_ST33ZP24_SPI is not set
# CONFIG_TELCLOCK is not set
CONFIG_DEVPORT=y
CONFIG_XILLYBUS=y
# CONFIG_XILLYBUS_OF is not set

#
# I2C support
#
CONFIG_I2C=y
CONFIG_ACPI_I2C_OPREGION=y
CONFIG_I2C_BOARDINFO=y
CONFIG_I2C_COMPAT=y
CONFIG_I2C_CHARDEV=m
# CONFIG_I2C_MUX is not set
CONFIG_I2C_HELPER_AUTO=y
CONFIG_I2C_SMBUS=y
CONFIG_I2C_ALGOBIT=y
CONFIG_I2C_ALGOPCA=m

#
# I2C Hardware Bus support
#

#
# PC SMBus host controller drivers
#
# CONFIG_I2C_ALI1535 is not set
# CONFIG_I2C_ALI1563 is not set
# CONFIG_I2C_ALI15X3 is not set
# CONFIG_I2C_AMD756 is not set
# CONFIG_I2C_AMD8111 is not set
# CONFIG_I2C_I801 is not set
# CONFIG_I2C_ISCH is not set
# CONFIG_I2C_ISMT is not set
# CONFIG_I2C_PIIX4 is not set
# CONFIG_I2C_NFORCE2 is not set
# CONFIG_I2C_SIS5595 is not set
# CONFIG_I2C_SIS630 is not set
# CONFIG_I2C_SIS96X is not set
# CONFIG_I2C_VIA is not set
# CONFIG_I2C_VIAPRO is not set

#
# ACPI drivers
#
# CONFIG_I2C_SCMI is not set

#
# I2C system bus drivers (mostly embedded / system-on-chip)
#
# CONFIG_I2C_CBUS_GPIO is not set
# CONFIG_I2C_DESIGNWARE_PLATFORM is not set
# CONFIG_I2C_DESIGNWARE_PCI is not set
# CONFIG_I2C_EMEV2 is not set
CONFIG_I2C_GPIO=m
# CONFIG_I2C_GPIO_FAULT_INJECTOR is not set
# CONFIG_I2C_KEMPLD is not set
CONFIG_I2C_OCORES=m
CONFIG_I2C_PCA_PLATFORM=m
# CONFIG_I2C_PXA_PCI is not set
# CONFIG_I2C_RK3X is not set
CONFIG_I2C_SIMTEC=m
CONFIG_I2C_XILINX=y

#
# External I2C/SMBus adapter drivers
#
CONFIG_I2C_DIOLAN_U2C=y
CONFIG_I2C_DLN2=m
CONFIG_I2C_PARPORT=m
CONFIG_I2C_PARPORT_LIGHT=y
CONFIG_I2C_ROBOTFUZZ_OSIF=y
CONFIG_I2C_TAOS_EVM=m
# CONFIG_I2C_TINY_USB is not set
CONFIG_I2C_VIPERBOARD=m

#
# Other I2C/SMBus bus drivers
#
# CONFIG_I2C_MLXCPLD is not set
CONFIG_I2C_CROS_EC_TUNNEL=y
CONFIG_I2C_STUB=m
CONFIG_I2C_SLAVE=y
CONFIG_I2C_SLAVE_EEPROM=y
# CONFIG_I2C_DEBUG_CORE is not set
# CONFIG_I2C_DEBUG_ALGO is not set
# CONFIG_I2C_DEBUG_BUS is not set
CONFIG_SPI=y
# CONFIG_SPI_DEBUG is not set
CONFIG_SPI_MASTER=y

#
# SPI Master Controller Drivers
#
# CONFIG_SPI_ALTERA is not set
CONFIG_SPI_AXI_SPI_ENGINE=m
CONFIG_SPI_BITBANG=y
# CONFIG_SPI_BUTTERFLY is not set
# CONFIG_SPI_CADENCE is not set
CONFIG_SPI_DESIGNWARE=y
# CONFIG_SPI_DW_PCI is not set
CONFIG_SPI_DW_MMIO=y
CONFIG_SPI_DLN2=m
# CONFIG_SPI_GPIO is not set
# CONFIG_SPI_LM70_LLP is not set
CONFIG_SPI_FSL_LIB=y
CONFIG_SPI_FSL_SPI=y
CONFIG_SPI_OC_TINY=y
# CONFIG_SPI_PXA2XX is not set
# CONFIG_SPI_PXA2XX_PCI is not set
# CONFIG_SPI_ROCKCHIP is not set
# CONFIG_SPI_SC18IS602 is not set
CONFIG_SPI_XCOMM=m
CONFIG_SPI_XILINX=y
# CONFIG_SPI_ZYNQMP_GQSPI is not set

#
# SPI Protocol Masters
#
CONFIG_SPI_SPIDEV=m
CONFIG_SPI_LOOPBACK_TEST=m
CONFIG_SPI_TLE62X0=m
# CONFIG_SPI_SLAVE is not set
CONFIG_SPMI=y
# CONFIG_HSI is not set
CONFIG_PPS=y
# CONFIG_PPS_DEBUG is not set

#
# PPS clients support
#
# CONFIG_PPS_CLIENT_KTIMER is not set
# CONFIG_PPS_CLIENT_LDISC is not set
# CONFIG_PPS_CLIENT_PARPORT is not set
# CONFIG_PPS_CLIENT_GPIO is not set

#
# PPS generators support
#

#
# PTP clock support
#
CONFIG_PTP_1588_CLOCK=y

#
# Enable PHYLIB and NETWORK_PHY_TIMESTAMPING to see the additional clocks.
#
CONFIG_PTP_1588_CLOCK_KVM=y
# CONFIG_PINCTRL is not set
CONFIG_GPIOLIB=y
CONFIG_OF_GPIO=y
CONFIG_GPIO_ACPI=y
CONFIG_GPIOLIB_IRQCHIP=y
# CONFIG_DEBUG_GPIO is not set
CONFIG_GPIO_SYSFS=y
CONFIG_GPIO_GENERIC=y
CONFIG_GPIO_MAX730X=m

#
# Memory mapped GPIO drivers
#
# CONFIG_GPIO_74XX_MMIO is not set
CONFIG_GPIO_ALTERA=y
# CONFIG_GPIO_AMDPT is not set
CONFIG_GPIO_DWAPB=y
# CONFIG_GPIO_EXAR is not set
CONFIG_GPIO_FTGPIO010=y
CONFIG_GPIO_GENERIC_PLATFORM=m
CONFIG_GPIO_GRGPIO=m
# CONFIG_GPIO_ICH is not set
# CONFIG_GPIO_LYNXPOINT is not set
CONFIG_GPIO_MB86S7X=y
CONFIG_GPIO_MENZ127=m
CONFIG_GPIO_MOCKUP=y
CONFIG_GPIO_SYSCON=y
# CONFIG_GPIO_VX855 is not set
CONFIG_GPIO_XILINX=y

#
# Port-mapped I/O GPIO drivers
#
CONFIG_GPIO_F7188X=y
# CONFIG_GPIO_IT87 is not set
# CONFIG_GPIO_SCH is not set
CONFIG_GPIO_SCH311X=y

#
# I2C GPIO expanders
#
CONFIG_GPIO_ADP5588=m
# CONFIG_GPIO_ADNP is not set
CONFIG_GPIO_MAX7300=m
CONFIG_GPIO_MAX732X=m
CONFIG_GPIO_PCA953X=y
CONFIG_GPIO_PCA953X_IRQ=y
CONFIG_GPIO_PCF857X=m
# CONFIG_GPIO_TPIC2810 is not set

#
# MFD GPIO expanders
#
CONFIG_GPIO_ADP5520=m
# CONFIG_GPIO_ARIZONA is not set
# CONFIG_GPIO_DA9052 is not set
# CONFIG_GPIO_DLN2 is not set
# CONFIG_GPIO_KEMPLD is not set
# CONFIG_GPIO_LP3943 is not set
# CONFIG_GPIO_LP87565 is not set
# CONFIG_GPIO_MAX77620 is not set
# CONFIG_GPIO_PALMAS is not set
# CONFIG_GPIO_TPS65218 is not set
# CONFIG_GPIO_TPS6586X is not set
# CONFIG_GPIO_TPS65910 is not set
CONFIG_GPIO_TPS65912=m
CONFIG_GPIO_TWL4030=m
CONFIG_GPIO_TWL6040=m
CONFIG_GPIO_WM831X=m
CONFIG_GPIO_WM8350=m
# CONFIG_GPIO_WM8994 is not set

#
# PCI GPIO expanders
#
# CONFIG_GPIO_AMD8111 is not set
# CONFIG_GPIO_BT8XX is not set
# CONFIG_GPIO_ML_IOH is not set
# CONFIG_GPIO_PCI_IDIO_16 is not set
# CONFIG_GPIO_PCIE_IDIO_24 is not set
# CONFIG_GPIO_RDC321X is not set
# CONFIG_GPIO_SODAVILLE is not set

#
# SPI GPIO expanders
#
CONFIG_GPIO_74X164=m
# CONFIG_GPIO_MAX3191X is not set
CONFIG_GPIO_MAX7301=m
CONFIG_GPIO_MC33880=m
# CONFIG_GPIO_PISOSR is not set
CONFIG_GPIO_XRA1403=y

#
# USB GPIO expanders
#
# CONFIG_GPIO_VIPERBOARD is not set
CONFIG_W1=y

#
# 1-wire Bus Masters
#
# CONFIG_W1_MASTER_MATROX is not set
# CONFIG_W1_MASTER_DS2490 is not set
CONFIG_W1_MASTER_DS2482=y
# CONFIG_W1_MASTER_DS1WM is not set
CONFIG_W1_MASTER_GPIO=m

#
# 1-wire Slaves
#
CONFIG_W1_SLAVE_THERM=y
CONFIG_W1_SLAVE_SMEM=y
# CONFIG_W1_SLAVE_DS2405 is not set
# CONFIG_W1_SLAVE_DS2408 is not set
CONFIG_W1_SLAVE_DS2413=m
CONFIG_W1_SLAVE_DS2406=y
# CONFIG_W1_SLAVE_DS2423 is not set
# CONFIG_W1_SLAVE_DS2805 is not set
# CONFIG_W1_SLAVE_DS2431 is not set
CONFIG_W1_SLAVE_DS2433=y
CONFIG_W1_SLAVE_DS2433_CRC=y
# CONFIG_W1_SLAVE_DS2438 is not set
CONFIG_W1_SLAVE_DS2760=m
# CONFIG_W1_SLAVE_DS2780 is not set
CONFIG_W1_SLAVE_DS2781=y
CONFIG_W1_SLAVE_DS28E04=y
# CONFIG_W1_SLAVE_DS28E17 is not set
CONFIG_POWER_AVS=y
CONFIG_POWER_RESET=y
# CONFIG_POWER_RESET_AS3722 is not set
CONFIG_POWER_RESET_GPIO=y
CONFIG_POWER_RESET_GPIO_RESTART=y
# CONFIG_POWER_RESET_LTC2952 is not set
CONFIG_POWER_RESET_RESTART=y
CONFIG_POWER_RESET_SYSCON=y
CONFIG_POWER_RESET_SYSCON_POWEROFF=y
# CONFIG_SYSCON_REBOOT_MODE is not set
CONFIG_POWER_SUPPLY=y
CONFIG_POWER_SUPPLY_DEBUG=y
CONFIG_PDA_POWER=y
# CONFIG_GENERIC_ADC_BATTERY is not set
CONFIG_MAX8925_POWER=m
# CONFIG_WM831X_BACKUP is not set
# CONFIG_WM831X_POWER is not set
CONFIG_WM8350_POWER=y
# CONFIG_TEST_POWER is not set
CONFIG_BATTERY_88PM860X=m
CONFIG_BATTERY_ACT8945A=m
# CONFIG_BATTERY_CPCAP is not set
CONFIG_BATTERY_DS2760=m
# CONFIG_BATTERY_DS2780 is not set
CONFIG_BATTERY_DS2781=y
CONFIG_BATTERY_DS2782=y
# CONFIG_BATTERY_LEGO_EV3 is not set
CONFIG_BATTERY_SBS=y
CONFIG_CHARGER_SBS=y
CONFIG_BATTERY_BQ27XXX=m
CONFIG_BATTERY_BQ27XXX_I2C=m
CONFIG_BATTERY_BQ27XXX_HDQ=m
# CONFIG_BATTERY_BQ27XXX_DT_UPDATES_NVM is not set
CONFIG_BATTERY_DA9030=y
# CONFIG_BATTERY_DA9052 is not set
CONFIG_BATTERY_DA9150=m
# CONFIG_CHARGER_AXP20X is not set
# CONFIG_BATTERY_AXP20X is not set
# CONFIG_AXP20X_POWER is not set
# CONFIG_AXP288_CHARGER is not set
CONFIG_AXP288_FUEL_GAUGE=m
# CONFIG_BATTERY_MAX17040 is not set
# CONFIG_BATTERY_MAX17042 is not set
# CONFIG_BATTERY_MAX1721X is not set
CONFIG_CHARGER_88PM860X=m
# CONFIG_CHARGER_ISP1704 is not set
CONFIG_CHARGER_MAX8903=y
CONFIG_CHARGER_TWL4030=m
CONFIG_CHARGER_LP8727=y
CONFIG_CHARGER_GPIO=y
# CONFIG_CHARGER_MANAGER is not set
# CONFIG_CHARGER_LTC3651 is not set
CONFIG_CHARGER_DETECTOR_MAX14656=y
CONFIG_CHARGER_BQ2415X=y
# CONFIG_CHARGER_BQ24190 is not set
CONFIG_CHARGER_BQ24257=y
CONFIG_CHARGER_BQ24735=m
CONFIG_CHARGER_BQ25890=m
CONFIG_CHARGER_SMB347=m
# CONFIG_CHARGER_TPS65090 is not set
CONFIG_CHARGER_TPS65217=m
CONFIG_BATTERY_GAUGE_LTC2941=m
CONFIG_BATTERY_GOLDFISH=m
# CONFIG_BATTERY_RT5033 is not set
# CONFIG_CHARGER_RT9455 is not set
CONFIG_HWMON=m
CONFIG_HWMON_VID=m
# CONFIG_HWMON_DEBUG_CHIP is not set

#
# Native drivers
#
CONFIG_SENSORS_ABITUGURU=m
CONFIG_SENSORS_ABITUGURU3=m
# CONFIG_SENSORS_AD7314 is not set
# CONFIG_SENSORS_AD7414 is not set
CONFIG_SENSORS_AD7418=m
CONFIG_SENSORS_ADM1021=m
CONFIG_SENSORS_ADM1025=m
CONFIG_SENSORS_ADM1026=m
# CONFIG_SENSORS_ADM1029 is not set
CONFIG_SENSORS_ADM1031=m
CONFIG_SENSORS_ADM9240=m
CONFIG_SENSORS_ADT7X10=m
CONFIG_SENSORS_ADT7310=m
CONFIG_SENSORS_ADT7410=m
# CONFIG_SENSORS_ADT7411 is not set
# CONFIG_SENSORS_ADT7462 is not set
CONFIG_SENSORS_ADT7470=m
# CONFIG_SENSORS_ADT7475 is not set
CONFIG_SENSORS_ASC7621=m
# CONFIG_SENSORS_K8TEMP is not set
# CONFIG_SENSORS_K10TEMP is not set
# CONFIG_SENSORS_FAM15H_POWER is not set
CONFIG_SENSORS_APPLESMC=m
# CONFIG_SENSORS_ASB100 is not set
CONFIG_SENSORS_ASPEED=m
CONFIG_SENSORS_ATXP1=m
CONFIG_SENSORS_DS620=m
CONFIG_SENSORS_DS1621=m
CONFIG_SENSORS_DELL_SMM=m
CONFIG_SENSORS_DA9052_ADC=m
# CONFIG_SENSORS_I5K_AMB is not set
# CONFIG_SENSORS_F71805F is not set
# CONFIG_SENSORS_F71882FG is not set
# CONFIG_SENSORS_F75375S is not set
# CONFIG_SENSORS_MC13783_ADC is not set
CONFIG_SENSORS_FSCHMD=m
CONFIG_SENSORS_FTSTEUTATES=m
# CONFIG_SENSORS_GL518SM is not set
CONFIG_SENSORS_GL520SM=m
CONFIG_SENSORS_G760A=m
CONFIG_SENSORS_G762=m
CONFIG_SENSORS_GPIO_FAN=m
CONFIG_SENSORS_HIH6130=m
# CONFIG_SENSORS_IBMAEM is not set
CONFIG_SENSORS_IBMPEX=m
CONFIG_SENSORS_IIO_HWMON=m
# CONFIG_SENSORS_I5500 is not set
CONFIG_SENSORS_CORETEMP=m
CONFIG_SENSORS_IT87=m
# CONFIG_SENSORS_JC42 is not set
CONFIG_SENSORS_POWR1220=m
CONFIG_SENSORS_LINEAGE=m
# CONFIG_SENSORS_LTC2945 is not set
CONFIG_SENSORS_LTC2990=m
# CONFIG_SENSORS_LTC4151 is not set
CONFIG_SENSORS_LTC4215=m
# CONFIG_SENSORS_LTC4222 is not set
CONFIG_SENSORS_LTC4245=m
# CONFIG_SENSORS_LTC4260 is not set
# CONFIG_SENSORS_LTC4261 is not set
# CONFIG_SENSORS_MAX1111 is not set
CONFIG_SENSORS_MAX16065=m
CONFIG_SENSORS_MAX1619=m
CONFIG_SENSORS_MAX1668=m
CONFIG_SENSORS_MAX197=m
CONFIG_SENSORS_MAX31722=m
CONFIG_SENSORS_MAX6621=m
# CONFIG_SENSORS_MAX6639 is not set
CONFIG_SENSORS_MAX6642=m
CONFIG_SENSORS_MAX6650=m
CONFIG_SENSORS_MAX6697=m
CONFIG_SENSORS_MAX31790=m
CONFIG_SENSORS_MCP3021=m
CONFIG_SENSORS_TC654=m
CONFIG_SENSORS_MENF21BMC_HWMON=m
CONFIG_SENSORS_ADCXX=m
CONFIG_SENSORS_LM63=m
CONFIG_SENSORS_LM70=m
CONFIG_SENSORS_LM73=m
CONFIG_SENSORS_LM75=m
CONFIG_SENSORS_LM77=m
# CONFIG_SENSORS_LM78 is not set
# CONFIG_SENSORS_LM80 is not set
CONFIG_SENSORS_LM83=m
CONFIG_SENSORS_LM85=m
CONFIG_SENSORS_LM87=m
CONFIG_SENSORS_LM90=m
CONFIG_SENSORS_LM92=m
CONFIG_SENSORS_LM93=m
# CONFIG_SENSORS_LM95234 is not set
# CONFIG_SENSORS_LM95241 is not set
CONFIG_SENSORS_LM95245=m
CONFIG_SENSORS_PC87360=m
CONFIG_SENSORS_PC87427=m
CONFIG_SENSORS_NTC_THERMISTOR=m
CONFIG_SENSORS_NCT6683=m
# CONFIG_SENSORS_NCT6775 is not set
CONFIG_SENSORS_NCT7802=m
CONFIG_SENSORS_NCT7904=m
# CONFIG_SENSORS_PCF8591 is not set
# CONFIG_PMBUS is not set
CONFIG_SENSORS_PWM_FAN=m
CONFIG_SENSORS_SHT15=m
CONFIG_SENSORS_SHT21=m
# CONFIG_SENSORS_SHT3x is not set
CONFIG_SENSORS_SHTC1=m
# CONFIG_SENSORS_SIS5595 is not set
CONFIG_SENSORS_DME1737=m
CONFIG_SENSORS_EMC1403=m
# CONFIG_SENSORS_EMC2103 is not set
CONFIG_SENSORS_EMC6W201=m
CONFIG_SENSORS_SMSC47M1=m
CONFIG_SENSORS_SMSC47M192=m
CONFIG_SENSORS_SMSC47B397=m
CONFIG_SENSORS_SCH56XX_COMMON=m
# CONFIG_SENSORS_SCH5627 is not set
CONFIG_SENSORS_SCH5636=m
CONFIG_SENSORS_STTS751=m
CONFIG_SENSORS_SMM665=m
# CONFIG_SENSORS_ADC128D818 is not set
CONFIG_SENSORS_ADS1015=m
# CONFIG_SENSORS_ADS7828 is not set
# CONFIG_SENSORS_ADS7871 is not set
CONFIG_SENSORS_AMC6821=m
# CONFIG_SENSORS_INA209 is not set
# CONFIG_SENSORS_INA2XX is not set
CONFIG_SENSORS_INA3221=m
CONFIG_SENSORS_TC74=m
# CONFIG_SENSORS_THMC50 is not set
CONFIG_SENSORS_TMP102=m
CONFIG_SENSORS_TMP103=m
# CONFIG_SENSORS_TMP108 is not set
# CONFIG_SENSORS_TMP401 is not set
CONFIG_SENSORS_TMP421=m
CONFIG_SENSORS_VIA_CPUTEMP=m
# CONFIG_SENSORS_VIA686A is not set
# CONFIG_SENSORS_VT1211 is not set
# CONFIG_SENSORS_VT8231 is not set
# CONFIG_SENSORS_W83773G is not set
CONFIG_SENSORS_W83781D=m
# CONFIG_SENSORS_W83791D is not set
CONFIG_SENSORS_W83792D=m
# CONFIG_SENSORS_W83793 is not set
CONFIG_SENSORS_W83795=m
# CONFIG_SENSORS_W83795_FANCTRL is not set
# CONFIG_SENSORS_W83L785TS is not set
CONFIG_SENSORS_W83L786NG=m
CONFIG_SENSORS_W83627HF=m
# CONFIG_SENSORS_W83627EHF is not set
CONFIG_SENSORS_WM831X=m
CONFIG_SENSORS_WM8350=m

#
# ACPI drivers
#
# CONFIG_SENSORS_ACPI_POWER is not set
# CONFIG_SENSORS_ATK0110 is not set
CONFIG_THERMAL=y
CONFIG_THERMAL_EMERGENCY_POWEROFF_DELAY_MS=0
# CONFIG_THERMAL_OF is not set
# CONFIG_THERMAL_WRITABLE_TRIPS is not set
# CONFIG_THERMAL_DEFAULT_GOV_STEP_WISE is not set
# CONFIG_THERMAL_DEFAULT_GOV_FAIR_SHARE is not set
CONFIG_THERMAL_DEFAULT_GOV_USER_SPACE=y
# CONFIG_THERMAL_DEFAULT_GOV_POWER_ALLOCATOR is not set
# CONFIG_THERMAL_GOV_FAIR_SHARE is not set
# CONFIG_THERMAL_GOV_STEP_WISE is not set
CONFIG_THERMAL_GOV_BANG_BANG=y
CONFIG_THERMAL_GOV_USER_SPACE=y
CONFIG_THERMAL_GOV_POWER_ALLOCATOR=y
# CONFIG_CLOCK_THERMAL is not set
# CONFIG_DEVFREQ_THERMAL is not set
CONFIG_THERMAL_EMULATION=y
CONFIG_MAX77620_THERMAL=m
CONFIG_DA9062_THERMAL=m
CONFIG_INTEL_POWERCLAMP=m
# CONFIG_INTEL_SOC_DTS_THERMAL is not set

#
# ACPI INT340X thermal drivers
#
# CONFIG_INT340X_THERMAL is not set
# CONFIG_INTEL_PCH_THERMAL is not set
CONFIG_QCOM_SPMI_TEMP_ALARM=m
# CONFIG_GENERIC_ADC_THERMAL is not set
CONFIG_WATCHDOG=y
CONFIG_WATCHDOG_CORE=y
CONFIG_WATCHDOG_NOWAYOUT=y
# CONFIG_WATCHDOG_HANDLE_BOOT_ENABLED is not set
CONFIG_WATCHDOG_SYSFS=y

#
# Watchdog Device Drivers
#
CONFIG_SOFT_WATCHDOG=m
CONFIG_DA9052_WATCHDOG=m
CONFIG_DA9062_WATCHDOG=m
CONFIG_GPIO_WATCHDOG=m
CONFIG_MENF21BMC_WATCHDOG=m
# CONFIG_WDAT_WDT is not set
CONFIG_WM831X_WATCHDOG=m
# CONFIG_WM8350_WATCHDOG is not set
CONFIG_XILINX_WATCHDOG=m
# CONFIG_ZIIRAVE_WATCHDOG is not set
# CONFIG_CADENCE_WATCHDOG is not set
# CONFIG_DW_WATCHDOG is not set
# CONFIG_RN5T618_WATCHDOG is not set
CONFIG_TWL4030_WATCHDOG=y
CONFIG_MAX63XX_WATCHDOG=m
CONFIG_MAX77620_WATCHDOG=y
CONFIG_ACQUIRE_WDT=y
CONFIG_ADVANTECH_WDT=y
# CONFIG_ALIM1535_WDT is not set
# CONFIG_ALIM7101_WDT is not set
CONFIG_F71808E_WDT=m
# CONFIG_SP5100_TCO is not set
CONFIG_SBC_FITPC2_WATCHDOG=m
# CONFIG_EUROTECH_WDT is not set
# CONFIG_IB700_WDT is not set
CONFIG_IBMASR=y
# CONFIG_WAFER_WDT is not set
# CONFIG_I6300ESB_WDT is not set
# CONFIG_IE6XX_WDT is not set
# CONFIG_ITCO_WDT is not set
CONFIG_IT8712F_WDT=m
CONFIG_IT87_WDT=y
# CONFIG_HP_WATCHDOG is not set
CONFIG_KEMPLD_WDT=y
# CONFIG_SC1200_WDT is not set
CONFIG_PC87413_WDT=m
# CONFIG_NV_TCO is not set
CONFIG_60XX_WDT=y
CONFIG_CPU5_WDT=m
CONFIG_SMSC_SCH311X_WDT=m
# CONFIG_SMSC37B787_WDT is not set
# CONFIG_VIA_WDT is not set
CONFIG_W83627HF_WDT=m
# CONFIG_W83877F_WDT is not set
# CONFIG_W83977F_WDT is not set
# CONFIG_MACHZ_WDT is not set
CONFIG_SBC_EPX_C3_WATCHDOG=m
# CONFIG_NI903X_WDT is not set
# CONFIG_NIC7018_WDT is not set
# CONFIG_MEN_A21_WDT is not set

#
# PCI-based Watchdog Cards
#
# CONFIG_PCIPCWATCHDOG is not set
# CONFIG_WDTPCI is not set

#
# USB-based Watchdog Cards
#
# CONFIG_USBPCWATCHDOG is not set

#
# Watchdog Pretimeout Governors
#
# CONFIG_WATCHDOG_PRETIMEOUT_GOV is not set
CONFIG_SSB_POSSIBLE=y
CONFIG_SSB=m
CONFIG_SSB_SPROM=y
CONFIG_SSB_PCIHOST_POSSIBLE=y
CONFIG_SSB_PCIHOST=y
# CONFIG_SSB_B43_PCI_BRIDGE is not set
CONFIG_SSB_PCMCIAHOST_POSSIBLE=y
# CONFIG_SSB_PCMCIAHOST is not set
# CONFIG_SSB_DEBUG is not set
CONFIG_SSB_DRIVER_PCICORE_POSSIBLE=y
# CONFIG_SSB_DRIVER_PCICORE is not set
CONFIG_SSB_DRIVER_GPIO=y
CONFIG_BCMA_POSSIBLE=y
# CONFIG_BCMA is not set

#
# Multifunction device drivers
#
CONFIG_MFD_CORE=y
CONFIG_MFD_ACT8945A=y
CONFIG_MFD_AS3711=y
CONFIG_MFD_AS3722=m
CONFIG_PMIC_ADP5520=y
# CONFIG_MFD_AAT2870_CORE is not set
CONFIG_MFD_ATMEL_FLEXCOM=m
CONFIG_MFD_ATMEL_HLCDC=m
CONFIG_MFD_BCM590XX=y
# CONFIG_MFD_BD9571MWV is not set
CONFIG_MFD_AXP20X=m
CONFIG_MFD_AXP20X_I2C=m
CONFIG_MFD_CROS_EC=y
# CONFIG_MFD_CROS_EC_I2C is not set
CONFIG_MFD_CROS_EC_SPI=m
CONFIG_MFD_CROS_EC_CHARDEV=y
CONFIG_PMIC_DA903X=y
CONFIG_PMIC_DA9052=y
# CONFIG_MFD_DA9052_SPI is not set
CONFIG_MFD_DA9052_I2C=y
# CONFIG_MFD_DA9055 is not set
CONFIG_MFD_DA9062=y
# CONFIG_MFD_DA9063 is not set
CONFIG_MFD_DA9150=m
CONFIG_MFD_DLN2=m
CONFIG_MFD_MC13XXX=y
CONFIG_MFD_MC13XXX_SPI=m
CONFIG_MFD_MC13XXX_I2C=y
CONFIG_MFD_HI6421_PMIC=m
CONFIG_HTC_PASIC3=m
# CONFIG_HTC_I2CPLD is not set
# CONFIG_MFD_INTEL_QUARK_I2C_GPIO is not set
# CONFIG_LPC_ICH is not set
# CONFIG_LPC_SCH is not set
# CONFIG_INTEL_SOC_PMIC is not set
# CONFIG_INTEL_SOC_PMIC_CHTWC is not set
# CONFIG_INTEL_SOC_PMIC_CHTDC_TI is not set
# CONFIG_MFD_INTEL_LPSS_ACPI is not set
# CONFIG_MFD_INTEL_LPSS_PCI is not set
# CONFIG_MFD_JANZ_CMODIO is not set
CONFIG_MFD_KEMPLD=y
CONFIG_MFD_88PM800=y
CONFIG_MFD_88PM805=y
CONFIG_MFD_88PM860X=y
# CONFIG_MFD_MAX14577 is not set
CONFIG_MFD_MAX77620=y
# CONFIG_MFD_MAX77686 is not set
# CONFIG_MFD_MAX77693 is not set
CONFIG_MFD_MAX77843=y
CONFIG_MFD_MAX8907=y
CONFIG_MFD_MAX8925=y
# CONFIG_MFD_MAX8997 is not set
# CONFIG_MFD_MAX8998 is not set
CONFIG_MFD_MT6397=m
CONFIG_MFD_MENF21BMC=m
# CONFIG_EZX_PCAP is not set
CONFIG_MFD_CPCAP=m
CONFIG_MFD_VIPERBOARD=y
# CONFIG_MFD_RETU is not set
# CONFIG_MFD_PCF50633 is not set
# CONFIG_MFD_RDC321X is not set
CONFIG_MFD_RT5033=y
# CONFIG_MFD_RC5T583 is not set
CONFIG_MFD_RK808=y
CONFIG_MFD_RN5T618=m
# CONFIG_MFD_SEC_CORE is not set
# CONFIG_MFD_SI476X_CORE is not set
CONFIG_MFD_SM501=y
CONFIG_MFD_SM501_GPIO=y
# CONFIG_MFD_SKY81452 is not set
# CONFIG_MFD_SMSC is not set
CONFIG_ABX500_CORE=y
CONFIG_AB3100_CORE=y
CONFIG_AB3100_OTP=m
# CONFIG_MFD_STMPE is not set
CONFIG_MFD_SYSCON=y
CONFIG_MFD_TI_AM335X_TSCADC=y
CONFIG_MFD_LP3943=y
CONFIG_MFD_LP8788=y
# CONFIG_MFD_TI_LMU is not set
CONFIG_MFD_PALMAS=y
# CONFIG_TPS6105X is not set
# CONFIG_TPS65010 is not set
# CONFIG_TPS6507X is not set
# CONFIG_MFD_TPS65086 is not set
CONFIG_MFD_TPS65090=y
CONFIG_MFD_TPS65217=m
# CONFIG_MFD_TPS68470 is not set
# CONFIG_MFD_TI_LP873X is not set
CONFIG_MFD_TI_LP87565=m
CONFIG_MFD_TPS65218=m
CONFIG_MFD_TPS6586X=y
CONFIG_MFD_TPS65910=y
CONFIG_MFD_TPS65912=m
CONFIG_MFD_TPS65912_I2C=m
CONFIG_MFD_TPS65912_SPI=m
CONFIG_MFD_TPS80031=y
CONFIG_TWL4030_CORE=y
CONFIG_MFD_TWL4030_AUDIO=y
CONFIG_TWL6040_CORE=y
CONFIG_MFD_WL1273_CORE=m
CONFIG_MFD_LM3533=y
# CONFIG_MFD_TC3589X is not set
# CONFIG_MFD_TMIO is not set
# CONFIG_MFD_VX855 is not set
CONFIG_MFD_ARIZONA=y
# CONFIG_MFD_ARIZONA_I2C is not set
CONFIG_MFD_ARIZONA_SPI=m
CONFIG_MFD_CS47L24=y
CONFIG_MFD_WM5102=y
CONFIG_MFD_WM5110=y
CONFIG_MFD_WM8997=y
# CONFIG_MFD_WM8998 is not set
CONFIG_MFD_WM8400=y
CONFIG_MFD_WM831X=y
CONFIG_MFD_WM831X_I2C=y
CONFIG_MFD_WM831X_SPI=y
CONFIG_MFD_WM8350=y
CONFIG_MFD_WM8350_I2C=y
CONFIG_MFD_WM8994=y
CONFIG_REGULATOR=y
# CONFIG_REGULATOR_DEBUG is not set
CONFIG_REGULATOR_FIXED_VOLTAGE=y
CONFIG_REGULATOR_VIRTUAL_CONSUMER=m
CONFIG_REGULATOR_USERSPACE_CONSUMER=y
CONFIG_REGULATOR_88PM800=m
# CONFIG_REGULATOR_88PM8607 is not set
# CONFIG_REGULATOR_ACT8865 is not set
CONFIG_REGULATOR_ACT8945A=y
CONFIG_REGULATOR_AD5398=y
CONFIG_REGULATOR_ANATOP=y
CONFIG_REGULATOR_AB3100=y
CONFIG_REGULATOR_AS3711=y
# CONFIG_REGULATOR_AS3722 is not set
CONFIG_REGULATOR_AXP20X=m
CONFIG_REGULATOR_BCM590XX=y
CONFIG_REGULATOR_CPCAP=m
CONFIG_REGULATOR_DA903X=m
CONFIG_REGULATOR_DA9052=m
CONFIG_REGULATOR_DA9062=m
CONFIG_REGULATOR_DA9210=m
# CONFIG_REGULATOR_DA9211 is not set
CONFIG_REGULATOR_FAN53555=m
# CONFIG_REGULATOR_GPIO is not set
CONFIG_REGULATOR_HI6421=m
# CONFIG_REGULATOR_HI6421V530 is not set
CONFIG_REGULATOR_ISL9305=y
CONFIG_REGULATOR_ISL6271A=m
CONFIG_REGULATOR_LP3971=y
CONFIG_REGULATOR_LP3972=y
CONFIG_REGULATOR_LP872X=y
CONFIG_REGULATOR_LP8755=m
# CONFIG_REGULATOR_LP87565 is not set
CONFIG_REGULATOR_LP8788=y
CONFIG_REGULATOR_LTC3589=m
CONFIG_REGULATOR_LTC3676=m
CONFIG_REGULATOR_MAX1586=y
CONFIG_REGULATOR_MAX77620=y
CONFIG_REGULATOR_MAX8649=y
# CONFIG_REGULATOR_MAX8660 is not set
CONFIG_REGULATOR_MAX8907=m
CONFIG_REGULATOR_MAX8925=m
CONFIG_REGULATOR_MAX8952=m
CONFIG_REGULATOR_MAX77693=m
CONFIG_REGULATOR_MC13XXX_CORE=y
CONFIG_REGULATOR_MC13783=y
CONFIG_REGULATOR_MC13892=m
CONFIG_REGULATOR_MT6311=y
CONFIG_REGULATOR_MT6323=m
# CONFIG_REGULATOR_MT6397 is not set
CONFIG_REGULATOR_PALMAS=m
CONFIG_REGULATOR_PFUZE100=y
CONFIG_REGULATOR_PV88060=y
# CONFIG_REGULATOR_PV88080 is not set
CONFIG_REGULATOR_PV88090=m
CONFIG_REGULATOR_PWM=y
CONFIG_REGULATOR_QCOM_SPMI=m
CONFIG_REGULATOR_RK808=y
CONFIG_REGULATOR_RN5T618=m
CONFIG_REGULATOR_RT5033=y
CONFIG_REGULATOR_TPS51632=m
CONFIG_REGULATOR_TPS62360=y
CONFIG_REGULATOR_TPS65023=m
# CONFIG_REGULATOR_TPS6507X is not set
CONFIG_REGULATOR_TPS65090=m
CONFIG_REGULATOR_TPS65132=m
# CONFIG_REGULATOR_TPS65217 is not set
CONFIG_REGULATOR_TPS65218=m
# CONFIG_REGULATOR_TPS6524X is not set
# CONFIG_REGULATOR_TPS6586X is not set
CONFIG_REGULATOR_TPS65910=m
CONFIG_REGULATOR_TPS65912=m
# CONFIG_REGULATOR_TPS80031 is not set
CONFIG_REGULATOR_TWL4030=y
# CONFIG_REGULATOR_VCTRL is not set
CONFIG_REGULATOR_WM831X=y
CONFIG_REGULATOR_WM8350=m
CONFIG_REGULATOR_WM8400=y
CONFIG_REGULATOR_WM8994=y
CONFIG_CEC_CORE=m
CONFIG_CEC_PIN=y
CONFIG_RC_CORE=m
CONFIG_RC_MAP=m
CONFIG_LIRC=y
CONFIG_RC_DECODERS=y
CONFIG_IR_NEC_DECODER=m
CONFIG_IR_RC5_DECODER=m
# CONFIG_IR_RC6_DECODER is not set
# CONFIG_IR_JVC_DECODER is not set
CONFIG_IR_SONY_DECODER=m
# CONFIG_IR_SANYO_DECODER is not set
CONFIG_IR_SHARP_DECODER=m
CONFIG_IR_MCE_KBD_DECODER=m
CONFIG_IR_XMP_DECODER=m
CONFIG_RC_DEVICES=y
# CONFIG_RC_ATI_REMOTE is not set
# CONFIG_IR_ENE is not set
CONFIG_IR_HIX5HD2=m
# CONFIG_IR_IMON is not set
CONFIG_IR_MCEUSB=m
CONFIG_IR_ITE_CIR=m
CONFIG_IR_FINTEK=m
CONFIG_IR_NUVOTON=m
# CONFIG_IR_REDRAT3 is not set
CONFIG_IR_SPI=m
CONFIG_IR_STREAMZAP=m
CONFIG_IR_WINBOND_CIR=m
CONFIG_IR_IGORPLUGUSB=m
CONFIG_IR_IGUANA=m
# CONFIG_IR_TTUSBIR is not set
CONFIG_RC_LOOPBACK=m
CONFIG_IR_GPIO_CIR=m
# CONFIG_IR_GPIO_TX is not set
CONFIG_IR_PWM_TX=m
CONFIG_IR_SERIAL=m
# CONFIG_IR_SERIAL_TRANSMITTER is not set
CONFIG_IR_SIR=m
CONFIG_MEDIA_SUPPORT=m

#
# Multimedia core support
#
# CONFIG_MEDIA_CAMERA_SUPPORT is not set
# CONFIG_MEDIA_ANALOG_TV_SUPPORT is not set
# CONFIG_MEDIA_DIGITAL_TV_SUPPORT is not set
# CONFIG_MEDIA_RADIO_SUPPORT is not set
CONFIG_MEDIA_SDR_SUPPORT=y
CONFIG_MEDIA_CEC_SUPPORT=y
CONFIG_MEDIA_CEC_RC=y
CONFIG_VIDEO_DEV=m
CONFIG_VIDEO_V4L2=m
CONFIG_VIDEO_ADV_DEBUG=y
CONFIG_VIDEO_FIXED_MINOR_RANGES=y
CONFIG_V4L2_FWNODE=m
# CONFIG_TTPCI_EEPROM is not set

#
# Media drivers
#
# CONFIG_MEDIA_USB_SUPPORT is not set
# CONFIG_MEDIA_PCI_SUPPORT is not set
CONFIG_CEC_PLATFORM_DRIVERS=y
CONFIG_CEC_GPIO=m
# CONFIG_SDR_PLATFORM_DRIVERS is not set

#
# Supported MMC/SDIO adapters
#
CONFIG_CYPRESS_FIRMWARE=m
CONFIG_VIDEOBUF2_CORE=m
CONFIG_VIDEOBUF2_V4L2=m
CONFIG_VIDEOBUF2_MEMOPS=m
CONFIG_VIDEOBUF2_VMALLOC=m

#
# Media ancillary drivers (tuners, sensors, i2c, spi, frontends)
#
# CONFIG_MEDIA_SUBDRV_AUTOSELECT is not set
CONFIG_VIDEO_IR_I2C=m

#
# I2C Encoders, decoders, sensors and other helper chips
#

#
# Audio decoders, processors and mixers
#
# CONFIG_VIDEO_TVAUDIO is not set
CONFIG_VIDEO_TDA7432=m
CONFIG_VIDEO_TDA9840=m
CONFIG_VIDEO_TEA6415C=m
# CONFIG_VIDEO_TEA6420 is not set
CONFIG_VIDEO_MSP3400=m
CONFIG_VIDEO_CS3308=m
# CONFIG_VIDEO_CS5345 is not set
# CONFIG_VIDEO_CS53L32A is not set
CONFIG_VIDEO_TLV320AIC23B=m
# CONFIG_VIDEO_UDA1342 is not set
# CONFIG_VIDEO_WM8775 is not set
# CONFIG_VIDEO_WM8739 is not set
CONFIG_VIDEO_VP27SMPX=m
CONFIG_VIDEO_SONY_BTF_MPX=m

#
# RDS decoders
#
CONFIG_VIDEO_SAA6588=m

#
# Video decoders
#
CONFIG_VIDEO_ADV7183=m
CONFIG_VIDEO_BT819=m
CONFIG_VIDEO_BT856=m
CONFIG_VIDEO_BT866=m
CONFIG_VIDEO_KS0127=m
CONFIG_VIDEO_ML86V7667=m
CONFIG_VIDEO_SAA7110=m
CONFIG_VIDEO_SAA711X=m
# CONFIG_VIDEO_TVP514X is not set
# CONFIG_VIDEO_TVP5150 is not set
CONFIG_VIDEO_TVP7002=m
CONFIG_VIDEO_TW2804=m
# CONFIG_VIDEO_TW9903 is not set
CONFIG_VIDEO_TW9906=m
CONFIG_VIDEO_VPX3220=m

#
# Video and audio decoders
#
CONFIG_VIDEO_SAA717X=m
CONFIG_VIDEO_CX25840=m

#
# Video encoders
#
CONFIG_VIDEO_SAA7127=m
CONFIG_VIDEO_SAA7185=m
CONFIG_VIDEO_ADV7170=m
CONFIG_VIDEO_ADV7175=m
CONFIG_VIDEO_ADV7343=m
CONFIG_VIDEO_ADV7393=m
CONFIG_VIDEO_AK881X=m
CONFIG_VIDEO_THS8200=m

#
# Camera sensor devices
#
CONFIG_VIDEO_MT9M111=m

#
# Flash devices
#

#
# Video improvement chips
#
CONFIG_VIDEO_UPD64031A=m
CONFIG_VIDEO_UPD64083=m

#
# Audio/Video compression chips
#
CONFIG_VIDEO_SAA6752HS=m

#
# SDR tuner chips
#
# CONFIG_SDR_MAX2175 is not set

#
# Miscellaneous helper chips
#
CONFIG_VIDEO_THS7303=m
CONFIG_VIDEO_M52790=m

#
# Sensors used on soc_camera driver
#

#
# SPI helper chips
#
CONFIG_MEDIA_TUNER=m

#
# Customize TV tuners
#
CONFIG_MEDIA_TUNER_SIMPLE=m
CONFIG_MEDIA_TUNER_TDA18250=m
CONFIG_MEDIA_TUNER_TDA8290=m
CONFIG_MEDIA_TUNER_TDA827X=m
CONFIG_MEDIA_TUNER_TDA18271=m
CONFIG_MEDIA_TUNER_TDA9887=m
# CONFIG_MEDIA_TUNER_TEA5761 is not set
CONFIG_MEDIA_TUNER_TEA5767=m
CONFIG_MEDIA_TUNER_MSI001=m
CONFIG_MEDIA_TUNER_MT20XX=m
# CONFIG_MEDIA_TUNER_MT2060 is not set
CONFIG_MEDIA_TUNER_MT2063=m
CONFIG_MEDIA_TUNER_MT2266=m
CONFIG_MEDIA_TUNER_MT2131=m
CONFIG_MEDIA_TUNER_QT1010=m
CONFIG_MEDIA_TUNER_XC2028=m
CONFIG_MEDIA_TUNER_XC5000=m
CONFIG_MEDIA_TUNER_XC4000=m
CONFIG_MEDIA_TUNER_MXL5005S=m
CONFIG_MEDIA_TUNER_MXL5007T=m
CONFIG_MEDIA_TUNER_MC44S803=m
CONFIG_MEDIA_TUNER_MAX2165=m
CONFIG_MEDIA_TUNER_TDA18218=m
CONFIG_MEDIA_TUNER_FC0011=m
CONFIG_MEDIA_TUNER_FC0012=m
# CONFIG_MEDIA_TUNER_FC0013 is not set
CONFIG_MEDIA_TUNER_TDA18212=m
# CONFIG_MEDIA_TUNER_E4000 is not set
# CONFIG_MEDIA_TUNER_FC2580 is not set
CONFIG_MEDIA_TUNER_M88RS6000T=m
CONFIG_MEDIA_TUNER_TUA9001=m
# CONFIG_MEDIA_TUNER_SI2157 is not set
# CONFIG_MEDIA_TUNER_IT913X is not set
# CONFIG_MEDIA_TUNER_R820T is not set
CONFIG_MEDIA_TUNER_MXL301RF=m
CONFIG_MEDIA_TUNER_QM1D1C0042=m

#
# Customise DVB Frontends
#

#
# Tools to develop new frontends
#

#
# Graphics support
#
# CONFIG_AGP is not set
CONFIG_VGA_ARB=y
CONFIG_VGA_ARB_MAX_GPUS=16
# CONFIG_VGA_SWITCHEROO is not set
# CONFIG_DRM is not set

#
# ACP (Audio CoProcessor) Configuration
#

#
# AMD Library routines
#
# CONFIG_CHASH is not set
# CONFIG_DRM_LIB_RANDOM is not set

#
# Frame buffer Devices
#
# CONFIG_FB is not set
CONFIG_BACKLIGHT_LCD_SUPPORT=y
# CONFIG_LCD_CLASS_DEVICE is not set
CONFIG_BACKLIGHT_CLASS_DEVICE=y
# CONFIG_BACKLIGHT_GENERIC is not set
# CONFIG_BACKLIGHT_LM3533 is not set
# CONFIG_BACKLIGHT_PWM is not set
CONFIG_BACKLIGHT_DA903X=y
CONFIG_BACKLIGHT_DA9052=y
CONFIG_BACKLIGHT_MAX8925=y
# CONFIG_BACKLIGHT_APPLE is not set
CONFIG_BACKLIGHT_PM8941_WLED=m
# CONFIG_BACKLIGHT_SAHARA is not set
# CONFIG_BACKLIGHT_WM831X is not set
# CONFIG_BACKLIGHT_ADP5520 is not set
CONFIG_BACKLIGHT_ADP8860=y
CONFIG_BACKLIGHT_ADP8870=y
# CONFIG_BACKLIGHT_88PM860X is not set
CONFIG_BACKLIGHT_LM3630A=m
# CONFIG_BACKLIGHT_LM3639 is not set
CONFIG_BACKLIGHT_LP855X=m
CONFIG_BACKLIGHT_LP8788=y
# CONFIG_BACKLIGHT_PANDORA is not set
CONFIG_BACKLIGHT_TPS65217=m
CONFIG_BACKLIGHT_AS3711=y
CONFIG_BACKLIGHT_GPIO=m
# CONFIG_BACKLIGHT_LV5207LP is not set
CONFIG_BACKLIGHT_BD6107=m
CONFIG_BACKLIGHT_ARCXCNN=m
# CONFIG_VGASTATE is not set

#
# Console display driver support
#
CONFIG_VGA_CONSOLE=y
# CONFIG_VGACON_SOFT_SCROLLBACK is not set
CONFIG_DUMMY_CONSOLE=y
CONFIG_DUMMY_CONSOLE_COLUMNS=80
CONFIG_DUMMY_CONSOLE_ROWS=25
# CONFIG_SOUND is not set

#
# HID support
#
CONFIG_HID=m
CONFIG_HID_BATTERY_STRENGTH=y
# CONFIG_HIDRAW is not set
CONFIG_UHID=m
CONFIG_HID_GENERIC=m

#
# Special HID drivers
#
CONFIG_HID_A4TECH=m
CONFIG_HID_ACCUTOUCH=m
CONFIG_HID_ACRUX=m
# CONFIG_HID_ACRUX_FF is not set
CONFIG_HID_APPLE=m
CONFIG_HID_APPLEIR=m
CONFIG_HID_ASUS=m
CONFIG_HID_AUREAL=m
CONFIG_HID_BELKIN=m
CONFIG_HID_BETOP_FF=m
# CONFIG_HID_CHERRY is not set
# CONFIG_HID_CHICONY is not set
CONFIG_HID_CORSAIR=m
# CONFIG_HID_CMEDIA is not set
CONFIG_HID_CYPRESS=m
CONFIG_HID_DRAGONRISE=m
# CONFIG_DRAGONRISE_FF is not set
CONFIG_HID_EMS_FF=m
CONFIG_HID_ELECOM=m
CONFIG_HID_ELO=m
# CONFIG_HID_EZKEY is not set
# CONFIG_HID_GEMBIRD is not set
CONFIG_HID_GFRM=m
CONFIG_HID_HOLTEK=m
# CONFIG_HOLTEK_FF is not set
# CONFIG_HID_GT683R is not set
# CONFIG_HID_KEYTOUCH is not set
CONFIG_HID_KYE=m
CONFIG_HID_UCLOGIC=m
# CONFIG_HID_WALTOP is not set
CONFIG_HID_GYRATION=m
CONFIG_HID_ICADE=m
CONFIG_HID_ITE=m
# CONFIG_HID_JABRA is not set
# CONFIG_HID_TWINHAN is not set
CONFIG_HID_KENSINGTON=m
# CONFIG_HID_LCPOWER is not set
CONFIG_HID_LED=m
CONFIG_HID_LENOVO=m
# CONFIG_HID_LOGITECH is not set
# CONFIG_HID_MAGICMOUSE is not set
CONFIG_HID_MAYFLASH=m
CONFIG_HID_MICROSOFT=m
# CONFIG_HID_MONTEREY is not set
CONFIG_HID_MULTITOUCH=m
# CONFIG_HID_NTI is not set
CONFIG_HID_NTRIG=m
CONFIG_HID_ORTEK=m
CONFIG_HID_PANTHERLORD=m
CONFIG_PANTHERLORD_FF=y
# CONFIG_HID_PENMOUNT is not set
CONFIG_HID_PETALYNX=m
CONFIG_HID_PICOLCD=m
CONFIG_HID_PICOLCD_BACKLIGHT=y
CONFIG_HID_PICOLCD_LEDS=y
CONFIG_HID_PICOLCD_CIR=y
CONFIG_HID_PLANTRONICS=m
# CONFIG_HID_PRIMAX is not set
CONFIG_HID_RETRODE=m
CONFIG_HID_ROCCAT=m
CONFIG_HID_SAITEK=m
CONFIG_HID_SAMSUNG=m
CONFIG_HID_SONY=m
# CONFIG_SONY_FF is not set
CONFIG_HID_SPEEDLINK=m
CONFIG_HID_STEELSERIES=m
CONFIG_HID_SUNPLUS=m
CONFIG_HID_RMI=m
CONFIG_HID_GREENASIA=m
CONFIG_GREENASIA_FF=y
# CONFIG_HID_SMARTJOYPLUS is not set
CONFIG_HID_TIVO=m
# CONFIG_HID_TOPSEED is not set
CONFIG_HID_THINGM=m
# CONFIG_HID_THRUSTMASTER is not set
# CONFIG_HID_UDRAW_PS3 is not set
CONFIG_HID_WACOM=m
CONFIG_HID_WIIMOTE=m
CONFIG_HID_XINMO=m
CONFIG_HID_ZEROPLUS=m
# CONFIG_ZEROPLUS_FF is not set
CONFIG_HID_ZYDACRON=m
# CONFIG_HID_SENSOR_HUB is not set
CONFIG_HID_ALPS=m

#
# USB HID support
#
CONFIG_USB_HID=m
# CONFIG_HID_PID is not set
CONFIG_USB_HIDDEV=y

#
# I2C HID support
#
CONFIG_I2C_HID=m

#
# Intel ISH HID support
#
# CONFIG_INTEL_ISH_HID is not set
CONFIG_USB_OHCI_LITTLE_ENDIAN=y
CONFIG_USB_SUPPORT=y
CONFIG_USB_COMMON=y
CONFIG_USB_ARCH_HAS_HCD=y
CONFIG_USB=y
CONFIG_USB_PCI=y
CONFIG_USB_ANNOUNCE_NEW_DEVICES=y

#
# Miscellaneous USB options
#
# CONFIG_USB_DEFAULT_PERSIST is not set
CONFIG_USB_DYNAMIC_MINORS=y
# CONFIG_USB_OTG_WHITELIST is not set
# CONFIG_USB_LEDS_TRIGGER_USBPORT is not set
CONFIG_USB_MON=m
CONFIG_USB_WUSB=m
# CONFIG_USB_WUSB_CBAF is not set

#
# USB Host Controller Drivers
#
CONFIG_USB_C67X00_HCD=y
# CONFIG_USB_XHCI_HCD is not set
# CONFIG_USB_EHCI_HCD is not set
CONFIG_USB_OXU210HP_HCD=y
CONFIG_USB_ISP116X_HCD=m
# CONFIG_USB_ISP1362_HCD is not set
# CONFIG_USB_FOTG210_HCD is not set
CONFIG_USB_MAX3421_HCD=y
CONFIG_USB_OHCI_HCD=m
CONFIG_USB_OHCI_HCD_PCI=m
CONFIG_USB_OHCI_HCD_SSB=y
CONFIG_USB_OHCI_HCD_PLATFORM=m
# CONFIG_USB_UHCI_HCD is not set
CONFIG_USB_U132_HCD=m
# CONFIG_USB_SL811_HCD is not set
# CONFIG_USB_R8A66597_HCD is not set
# CONFIG_USB_WHCI_HCD is not set
# CONFIG_USB_HWA_HCD is not set
CONFIG_USB_HCD_SSB=m
CONFIG_USB_HCD_TEST_MODE=y

#
# USB Device Class drivers
#
CONFIG_USB_ACM=m
CONFIG_USB_PRINTER=y
CONFIG_USB_WDM=y
CONFIG_USB_TMC=y

#
# NOTE: USB_STORAGE depends on SCSI but BLK_DEV_SD may
#

#
# also be needed; see USB_STORAGE Help for more info
#
CONFIG_USB_STORAGE=y
CONFIG_USB_STORAGE_DEBUG=y
CONFIG_USB_STORAGE_REALTEK=m
CONFIG_USB_STORAGE_DATAFAB=y
CONFIG_USB_STORAGE_FREECOM=m
CONFIG_USB_STORAGE_ISD200=m
CONFIG_USB_STORAGE_USBAT=m
CONFIG_USB_STORAGE_SDDR09=m
# CONFIG_USB_STORAGE_SDDR55 is not set
CONFIG_USB_STORAGE_JUMPSHOT=m
# CONFIG_USB_STORAGE_ALAUDA is not set
CONFIG_USB_STORAGE_ONETOUCH=m
CONFIG_USB_STORAGE_KARMA=y
CONFIG_USB_STORAGE_CYPRESS_ATACB=m
CONFIG_USB_STORAGE_ENE_UB6250=m
CONFIG_USB_UAS=m

#
# USB Imaging devices
#
CONFIG_USB_MDC800=y
CONFIG_USB_MICROTEK=m
# CONFIG_USBIP_CORE is not set
CONFIG_USB_MUSB_HDRC=m
CONFIG_USB_MUSB_HOST=y
# CONFIG_USB_MUSB_GADGET is not set
# CONFIG_USB_MUSB_DUAL_ROLE is not set

#
# Platform Glue Layer
#

#
# MUSB DMA mode
#
# CONFIG_MUSB_PIO_ONLY is not set
# CONFIG_USB_DWC3 is not set
CONFIG_USB_DWC2=y
CONFIG_USB_DWC2_HOST=y

#
# Gadget/Dual-role mode requires USB Gadget support to be enabled
#
# CONFIG_USB_DWC2_PCI is not set
CONFIG_USB_DWC2_DEBUG=y
# CONFIG_USB_DWC2_VERBOSE is not set
# CONFIG_USB_DWC2_TRACK_MISSED_SOFS is not set
CONFIG_USB_DWC2_DEBUG_PERIODIC=y
# CONFIG_USB_CHIPIDEA is not set
CONFIG_USB_ISP1760=y
CONFIG_USB_ISP1760_HCD=y
CONFIG_USB_ISP1760_HOST_ROLE=y

#
# USB port drivers
#
# CONFIG_USB_USS720 is not set
# CONFIG_USB_SERIAL is not set

#
# USB Miscellaneous drivers
#
CONFIG_USB_EMI62=m
CONFIG_USB_EMI26=m
CONFIG_USB_ADUTUX=y
CONFIG_USB_SEVSEG=m
# CONFIG_USB_RIO500 is not set
CONFIG_USB_LEGOTOWER=m
CONFIG_USB_LCD=y
# CONFIG_USB_CYPRESS_CY7C63 is not set
CONFIG_USB_CYTHERM=m
# CONFIG_USB_IDMOUSE is not set
CONFIG_USB_FTDI_ELAN=m
CONFIG_USB_APPLEDISPLAY=y
# CONFIG_USB_SISUSBVGA is not set
# CONFIG_USB_LD is not set
CONFIG_USB_TRANCEVIBRATOR=m
CONFIG_USB_IOWARRIOR=y
CONFIG_USB_TEST=y
CONFIG_USB_EHSET_TEST_FIXTURE=y
CONFIG_USB_ISIGHTFW=m
CONFIG_USB_YUREX=m
CONFIG_USB_EZUSB_FX2=m
CONFIG_USB_HUB_USB251XB=y
CONFIG_USB_HSIC_USB3503=y
CONFIG_USB_HSIC_USB4604=m
# CONFIG_USB_LINK_LAYER_TEST is not set

#
# USB Physical Layer drivers
#
CONFIG_USB_PHY=y
# CONFIG_NOP_USB_XCEIV is not set
CONFIG_USB_GPIO_VBUS=m
CONFIG_USB_ISP1301=m
CONFIG_USB_GADGET=m
# CONFIG_USB_GADGET_DEBUG is not set
# CONFIG_USB_GADGET_DEBUG_FILES is not set
# CONFIG_USB_GADGET_DEBUG_FS is not set
CONFIG_USB_GADGET_VBUS_DRAW=2
CONFIG_USB_GADGET_STORAGE_NUM_BUFFERS=2

#
# USB Peripheral Controller
#
# CONFIG_USB_FOTG210_UDC is not set
CONFIG_USB_GR_UDC=m
# CONFIG_USB_R8A66597 is not set
CONFIG_USB_PXA27X=m
CONFIG_USB_MV_UDC=m
CONFIG_USB_MV_U3D=m
# CONFIG_USB_SNP_UDC_PLAT is not set
CONFIG_USB_M66592=m
# CONFIG_USB_BDC_UDC is not set
# CONFIG_USB_AMD5536UDC is not set
CONFIG_USB_NET2272=m
# CONFIG_USB_NET2272_DMA is not set
# CONFIG_USB_NET2280 is not set
# CONFIG_USB_GOKU is not set
# CONFIG_USB_EG20T is not set
CONFIG_USB_GADGET_XILINX=m
CONFIG_USB_DUMMY_HCD=m
CONFIG_USB_LIBCOMPOSITE=m
CONFIG_USB_F_SS_LB=m
CONFIG_USB_F_MASS_STORAGE=m
CONFIG_USB_F_PRINTER=m
CONFIG_USB_CONFIGFS=m
# CONFIG_USB_CONFIGFS_SERIAL is not set
# CONFIG_USB_CONFIGFS_ACM is not set
# CONFIG_USB_CONFIGFS_OBEX is not set
# CONFIG_USB_CONFIGFS_NCM is not set
# CONFIG_USB_CONFIGFS_ECM is not set
# CONFIG_USB_CONFIGFS_ECM_SUBSET is not set
# CONFIG_USB_CONFIGFS_RNDIS is not set
# CONFIG_USB_CONFIGFS_EEM is not set
CONFIG_USB_CONFIGFS_MASS_STORAGE=y
CONFIG_USB_CONFIGFS_F_LB_SS=y
# CONFIG_USB_CONFIGFS_F_FS is not set
# CONFIG_USB_CONFIGFS_F_HID is not set
# CONFIG_USB_CONFIGFS_F_UVC is not set
CONFIG_USB_CONFIGFS_F_PRINTER=y
# CONFIG_USB_CONFIGFS_F_TCM is not set
CONFIG_TYPEC=m
CONFIG_TYPEC_TCPM=m
# CONFIG_TYPEC_FUSB302 is not set
CONFIG_TYPEC_UCSI=m
# CONFIG_UCSI_ACPI is not set
# CONFIG_TYPEC_TPS6598X is not set
# CONFIG_USB_LED_TRIG is not set
CONFIG_USB_ULPI_BUS=y
CONFIG_UWB=y
# CONFIG_UWB_HWA is not set
# CONFIG_UWB_WHCI is not set
# CONFIG_MMC is not set
CONFIG_MEMSTICK=m
# CONFIG_MEMSTICK_DEBUG is not set

#
# MemoryStick drivers
#
CONFIG_MEMSTICK_UNSAFE_RESUME=y
CONFIG_MSPRO_BLOCK=m
CONFIG_MS_BLOCK=m

#
# MemoryStick Host Controller Drivers
#
# CONFIG_MEMSTICK_TIFM_MS is not set
# CONFIG_MEMSTICK_JMICRON_38X is not set
# CONFIG_MEMSTICK_R592 is not set
# CONFIG_MEMSTICK_REALTEK_USB is not set
CONFIG_NEW_LEDS=y
CONFIG_LEDS_CLASS=y
# CONFIG_LEDS_CLASS_FLASH is not set
# CONFIG_LEDS_BRIGHTNESS_HW_CHANGED is not set

#
# LED drivers
#
CONFIG_LEDS_88PM860X=y
CONFIG_LEDS_APU=y
# CONFIG_LEDS_BCM6328 is not set
# CONFIG_LEDS_BCM6358 is not set
CONFIG_LEDS_CPCAP=m
CONFIG_LEDS_LM3530=m
CONFIG_LEDS_LM3533=y
# CONFIG_LEDS_LM3642 is not set
CONFIG_LEDS_LM3692X=m
CONFIG_LEDS_MT6323=m
# CONFIG_LEDS_PCA9532 is not set
# CONFIG_LEDS_GPIO is not set
# CONFIG_LEDS_LP3944 is not set
CONFIG_LEDS_LP3952=y
CONFIG_LEDS_LP55XX_COMMON=y
CONFIG_LEDS_LP5521=m
CONFIG_LEDS_LP5523=y
CONFIG_LEDS_LP5562=m
CONFIG_LEDS_LP8501=m
# CONFIG_LEDS_LP8788 is not set
# CONFIG_LEDS_LP8860 is not set
CONFIG_LEDS_CLEVO_MAIL=m
# CONFIG_LEDS_PCA955X is not set
CONFIG_LEDS_PCA963X=m
CONFIG_LEDS_WM831X_STATUS=y
CONFIG_LEDS_WM8350=y
CONFIG_LEDS_DA903X=m
CONFIG_LEDS_DA9052=m
CONFIG_LEDS_DAC124S085=y
# CONFIG_LEDS_PWM is not set
CONFIG_LEDS_REGULATOR=m
CONFIG_LEDS_BD2802=y
# CONFIG_LEDS_INTEL_SS4200 is not set
CONFIG_LEDS_LT3593=m
CONFIG_LEDS_ADP5520=m
# CONFIG_LEDS_MC13783 is not set
CONFIG_LEDS_TCA6507=m
CONFIG_LEDS_TLC591XX=m
# CONFIG_LEDS_LM355x is not set
CONFIG_LEDS_MENF21BMC=m
# CONFIG_LEDS_IS31FL319X is not set
# CONFIG_LEDS_IS31FL32XX is not set

#
# LED driver for blink(1) USB RGB LED is under Special HID drivers (HID_THINGM)
#
CONFIG_LEDS_BLINKM=y
# CONFIG_LEDS_SYSCON is not set
CONFIG_LEDS_MLXCPLD=y
CONFIG_LEDS_USER=y
# CONFIG_LEDS_NIC78BX is not set

#
# LED Triggers
#
CONFIG_LEDS_TRIGGERS=y
CONFIG_LEDS_TRIGGER_TIMER=y
CONFIG_LEDS_TRIGGER_ONESHOT=y
# CONFIG_LEDS_TRIGGER_DISK is not set
# CONFIG_LEDS_TRIGGER_MTD is not set
CONFIG_LEDS_TRIGGER_HEARTBEAT=m
CONFIG_LEDS_TRIGGER_BACKLIGHT=m
CONFIG_LEDS_TRIGGER_CPU=y
# CONFIG_LEDS_TRIGGER_ACTIVITY is not set
# CONFIG_LEDS_TRIGGER_GPIO is not set
CONFIG_LEDS_TRIGGER_DEFAULT_ON=m

#
# iptables trigger is under Netfilter config (LED target)
#
CONFIG_LEDS_TRIGGER_TRANSIENT=y
CONFIG_LEDS_TRIGGER_CAMERA=m
CONFIG_LEDS_TRIGGER_PANIC=y
# CONFIG_LEDS_TRIGGER_NETDEV is not set
CONFIG_ACCESSIBILITY=y
CONFIG_A11Y_BRAILLE_CONSOLE=y
# CONFIG_INFINIBAND is not set
CONFIG_EDAC_ATOMIC_SCRUB=y
CONFIG_EDAC_SUPPORT=y
CONFIG_RTC_LIB=y
CONFIG_RTC_MC146818_LIB=y
# CONFIG_RTC_CLASS is not set
CONFIG_DMADEVICES=y
CONFIG_DMADEVICES_DEBUG=y
CONFIG_DMADEVICES_VDEBUG=y

#
# DMA Devices
#
CONFIG_DMA_ENGINE=y
CONFIG_DMA_VIRTUAL_CHANNELS=y
CONFIG_DMA_ACPI=y
CONFIG_DMA_OF=y
# CONFIG_ALTERA_MSGDMA is not set
CONFIG_FSL_EDMA=m
CONFIG_INTEL_IDMA64=m
# CONFIG_INTEL_IOATDMA is not set
CONFIG_QCOM_HIDMA_MGMT=m
CONFIG_QCOM_HIDMA=y
CONFIG_DW_DMAC_CORE=y
CONFIG_DW_DMAC=m
# CONFIG_DW_DMAC_PCI is not set
CONFIG_HSU_DMA=y

#
# DMA Clients
#
CONFIG_ASYNC_TX_DMA=y
CONFIG_DMATEST=m
CONFIG_DMA_ENGINE_RAID=y

#
# DMABUF options
#
# CONFIG_SYNC_FILE is not set
CONFIG_AUXDISPLAY=y
CONFIG_CHARLCD=y
# CONFIG_HD44780 is not set
CONFIG_IMG_ASCII_LCD=y
CONFIG_PANEL=y
CONFIG_PANEL_PARPORT=0
CONFIG_PANEL_PROFILE=5
CONFIG_PANEL_CHANGE_MESSAGE=y
CONFIG_PANEL_BOOT_MESSAGE=""
CONFIG_UIO=m
# CONFIG_UIO_CIF is not set
CONFIG_UIO_PDRV_GENIRQ=m
CONFIG_UIO_DMEM_GENIRQ=m
# CONFIG_UIO_AEC is not set
# CONFIG_UIO_SERCOS3 is not set
# CONFIG_UIO_PCI_GENERIC is not set
# CONFIG_UIO_NETX is not set
CONFIG_UIO_PRUSS=m
# CONFIG_UIO_MF624 is not set
# CONFIG_VIRT_DRIVERS is not set
CONFIG_VIRTIO=y
CONFIG_VIRTIO_MENU=y
# CONFIG_VIRTIO_PCI is not set
# CONFIG_VIRTIO_BALLOON is not set
# CONFIG_VIRTIO_INPUT is not set
CONFIG_VIRTIO_MMIO=y
# CONFIG_VIRTIO_MMIO_CMDLINE_DEVICES is not set

#
# Microsoft Hyper-V guest support
#
# CONFIG_HYPERV is not set
# CONFIG_HYPERV_TSCPAGE is not set
CONFIG_STAGING=y
# CONFIG_IRDA is not set
# CONFIG_IPX is not set
# CONFIG_NCP_FS is not set
CONFIG_COMEDI=m
CONFIG_COMEDI_DEBUG=y
CONFIG_COMEDI_DEFAULT_BUF_SIZE_KB=2048
CONFIG_COMEDI_DEFAULT_BUF_MAXSIZE_KB=20480
# CONFIG_COMEDI_MISC_DRIVERS is not set
CONFIG_COMEDI_ISA_DRIVERS=y
# CONFIG_COMEDI_PCL711 is not set
CONFIG_COMEDI_PCL724=m
# CONFIG_COMEDI_PCL726 is not set
CONFIG_COMEDI_PCL730=m
CONFIG_COMEDI_PCL812=m
CONFIG_COMEDI_PCL816=m
# CONFIG_COMEDI_PCL818 is not set
CONFIG_COMEDI_PCM3724=m
CONFIG_COMEDI_AMPLC_DIO200_ISA=m
# CONFIG_COMEDI_AMPLC_PC236_ISA is not set
# CONFIG_COMEDI_AMPLC_PC263_ISA is not set
CONFIG_COMEDI_RTI800=m
CONFIG_COMEDI_RTI802=m
CONFIG_COMEDI_DAC02=m
# CONFIG_COMEDI_DAS16M1 is not set
CONFIG_COMEDI_DAS08_ISA=m
CONFIG_COMEDI_DAS16=m
CONFIG_COMEDI_DAS800=m
CONFIG_COMEDI_DAS1800=m
CONFIG_COMEDI_DAS6402=m
CONFIG_COMEDI_DT2801=m
CONFIG_COMEDI_DT2811=m
CONFIG_COMEDI_DT2814=m
# CONFIG_COMEDI_DT2815 is not set
CONFIG_COMEDI_DT2817=m
CONFIG_COMEDI_DT282X=m
# CONFIG_COMEDI_DMM32AT is not set
# CONFIG_COMEDI_FL512 is not set
CONFIG_COMEDI_AIO_AIO12_8=m
CONFIG_COMEDI_AIO_IIRO_16=m
CONFIG_COMEDI_II_PCI20KC=m
CONFIG_COMEDI_C6XDIGIO=m
CONFIG_COMEDI_MPC624=m
CONFIG_COMEDI_ADQ12B=m
CONFIG_COMEDI_NI_AT_A2150=m
CONFIG_COMEDI_NI_AT_AO=m
# CONFIG_COMEDI_NI_ATMIO is not set
CONFIG_COMEDI_NI_ATMIO16D=m
CONFIG_COMEDI_NI_LABPC_ISA=m
CONFIG_COMEDI_PCMAD=m
CONFIG_COMEDI_PCMDA12=m
CONFIG_COMEDI_PCMMIO=m
CONFIG_COMEDI_PCMUIO=m
CONFIG_COMEDI_MULTIQ3=m
# CONFIG_COMEDI_S526 is not set
# CONFIG_COMEDI_PCI_DRIVERS is not set
# CONFIG_COMEDI_PCMCIA_DRIVERS is not set
# CONFIG_COMEDI_USB_DRIVERS is not set
CONFIG_COMEDI_8254=m
CONFIG_COMEDI_8255=m
# CONFIG_COMEDI_8255_SA is not set
CONFIG_COMEDI_KCOMEDILIB=m
CONFIG_COMEDI_AMPLC_DIO200=m
CONFIG_COMEDI_DAS08=m
CONFIG_COMEDI_ISADMA=m
CONFIG_COMEDI_NI_LABPC=m
CONFIG_COMEDI_NI_LABPC_ISADMA=m
# CONFIG_RTL8192U is not set
# CONFIG_RTLLIB is not set
# CONFIG_R8712U is not set
# CONFIG_RTS5208 is not set

#
# IIO staging drivers
#

#
# Accelerometers
#
# CONFIG_ADIS16201 is not set
CONFIG_ADIS16203=m
CONFIG_ADIS16209=m
# CONFIG_ADIS16240 is not set

#
# Analog to digital converters
#
CONFIG_AD7606=m
# CONFIG_AD7606_IFACE_PARALLEL is not set
CONFIG_AD7606_IFACE_SPI=m
CONFIG_AD7780=y
# CONFIG_AD7816 is not set
# CONFIG_AD7192 is not set
# CONFIG_AD7280 is not set

#
# Analog digital bi-direction converters
#
CONFIG_ADT7316=m
CONFIG_ADT7316_SPI=m
CONFIG_ADT7316_I2C=m

#
# Capacitance to digital converters
#
# CONFIG_AD7150 is not set
# CONFIG_AD7152 is not set
# CONFIG_AD7746 is not set

#
# Direct Digital Synthesis
#
CONFIG_AD9832=m
CONFIG_AD9834=m

#
# Digital gyroscope sensors
#
# CONFIG_ADIS16060 is not set

#
# Network Analyzer, Impedance Converters
#
# CONFIG_AD5933 is not set

#
# Light sensors
#
# CONFIG_TSL2x7x is not set

#
# Active energy metering IC
#
# CONFIG_ADE7753 is not set
# CONFIG_ADE7754 is not set
# CONFIG_ADE7758 is not set
# CONFIG_ADE7759 is not set
CONFIG_ADE7854=m
# CONFIG_ADE7854_I2C is not set
CONFIG_ADE7854_SPI=m

#
# Resolver to digital converters
#
CONFIG_AD2S90=y
CONFIG_AD2S1200=y
CONFIG_AD2S1210=y

#
# Triggers - standalone
#

#
# Speakup console speech
#
CONFIG_SPEAKUP=y
CONFIG_SPEAKUP_SYNTH_ACNTSA=m
CONFIG_SPEAKUP_SYNTH_APOLLO=y
# CONFIG_SPEAKUP_SYNTH_AUDPTR is not set
# CONFIG_SPEAKUP_SYNTH_BNS is not set
CONFIG_SPEAKUP_SYNTH_DECTLK=m
CONFIG_SPEAKUP_SYNTH_DECEXT=m
CONFIG_SPEAKUP_SYNTH_LTLK=m
# CONFIG_SPEAKUP_SYNTH_SOFT is not set
# CONFIG_SPEAKUP_SYNTH_SPKOUT is not set
# CONFIG_SPEAKUP_SYNTH_TXPRT is not set
CONFIG_SPEAKUP_SYNTH_DUMMY=y
# CONFIG_STAGING_MEDIA is not set

#
# Android
#
# CONFIG_STAGING_BOARD is not set
# CONFIG_LTE_GDM724X is not set
CONFIG_FIREWIRE_SERIAL=m
CONFIG_FWTTY_MAX_TOTAL_PORTS=64
CONFIG_FWTTY_MAX_CARD_PORTS=32
CONFIG_GOLDFISH_AUDIO=m
# CONFIG_MTD_GOLDFISH_NAND is not set
CONFIG_MTD_SPINAND_MT29F=m
# CONFIG_MTD_SPINAND_ONDIEECC is not set
# CONFIG_LNET is not set
# CONFIG_DGNC is not set
# CONFIG_GS_FPGABOOT is not set
# CONFIG_CRYPTO_SKEIN is not set
CONFIG_UNISYSSPAR=y
# CONFIG_COMMON_CLK_XLNX_CLKWZRD is not set
# CONFIG_MOST is not set
CONFIG_GREYBUS=m
CONFIG_GREYBUS_ES2=m
CONFIG_GREYBUS_BOOTROM=m
# CONFIG_GREYBUS_FIRMWARE is not set
CONFIG_GREYBUS_HID=m
# CONFIG_GREYBUS_LIGHT is not set
# CONFIG_GREYBUS_LOG is not set
CONFIG_GREYBUS_LOOPBACK=m
CONFIG_GREYBUS_POWER=m
CONFIG_GREYBUS_RAW=m
CONFIG_GREYBUS_VIBRATOR=m
CONFIG_GREYBUS_BRIDGED_PHY=m
CONFIG_GREYBUS_GPIO=m
CONFIG_GREYBUS_I2C=m
# CONFIG_GREYBUS_PWM is not set
CONFIG_GREYBUS_SPI=m
CONFIG_GREYBUS_UART=m
CONFIG_GREYBUS_USB=m

#
# USB Power Delivery and Type-C drivers
#
CONFIG_TYPEC_TCPCI=m
CONFIG_PI433=y
# CONFIG_X86_PLATFORM_DEVICES is not set
CONFIG_PMC_ATOM=y
# CONFIG_GOLDFISH_BUS is not set
CONFIG_GOLDFISH_PIPE=y
CONFIG_CHROME_PLATFORMS=y
CONFIG_CHROMEOS_LAPTOP=m
CONFIG_CHROMEOS_PSTORE=y
CONFIG_CROS_EC_CTL=y
# CONFIG_CROS_EC_LPC is not set
CONFIG_CROS_EC_PROTO=y
# CONFIG_CROS_KBD_LED_BACKLIGHT is not set
# CONFIG_MELLANOX_PLATFORM is not set
CONFIG_CLKDEV_LOOKUP=y
CONFIG_HAVE_CLK_PREPARE=y
CONFIG_COMMON_CLK=y

#
# Common Clock Framework
#
# CONFIG_COMMON_CLK_WM831X is not set
# CONFIG_CLK_HSDK is not set
# CONFIG_COMMON_CLK_MAX77686 is not set
# CONFIG_COMMON_CLK_RK808 is not set
# CONFIG_COMMON_CLK_SI5351 is not set
# CONFIG_COMMON_CLK_SI514 is not set
# CONFIG_COMMON_CLK_SI570 is not set
# CONFIG_COMMON_CLK_CDCE706 is not set
# CONFIG_COMMON_CLK_CDCE925 is not set
# CONFIG_COMMON_CLK_CS2000_CP is not set
# CONFIG_CLK_TWL6040 is not set
# CONFIG_COMMON_CLK_NXP is not set
# CONFIG_COMMON_CLK_PALMAS is not set
# CONFIG_COMMON_CLK_PWM is not set
# CONFIG_COMMON_CLK_PXA is not set
# CONFIG_COMMON_CLK_PIC32 is not set
# CONFIG_COMMON_CLK_VC5 is not set
# CONFIG_HWSPINLOCK is not set

#
# Clock Source drivers
#
CONFIG_CLKEVT_I8253=y
CONFIG_I8253_LOCK=y
CONFIG_CLKBLD_I8253=y
# CONFIG_ATMEL_PIT is not set
# CONFIG_SH_TIMER_CMT is not set
# CONFIG_SH_TIMER_MTU2 is not set
# CONFIG_SH_TIMER_TMU is not set
# CONFIG_EM_TIMER_STI is not set
# CONFIG_MAILBOX is not set
CONFIG_IOMMU_SUPPORT=y

#
# Generic IOMMU Pagetable Support
#
# CONFIG_AMD_IOMMU is not set

#
# Remoteproc drivers
#
CONFIG_REMOTEPROC=y

#
# Rpmsg drivers
#
# CONFIG_RPMSG_VIRTIO is not set
CONFIG_SOUNDWIRE=y

#
# SoundWire Devices
#
# CONFIG_SOUNDWIRE_INTEL is not set

#
# SOC (System On Chip) specific Drivers
#

#
# Amlogic SoC drivers
#

#
# Broadcom SoC drivers
#

#
# i.MX SoC drivers
#

#
# Qualcomm SoC drivers
#
# CONFIG_SUNXI_SRAM is not set
CONFIG_SOC_TI=y

#
# Xilinx SoC drivers
#
CONFIG_XILINX_VCU=y
CONFIG_PM_DEVFREQ=y

#
# DEVFREQ Governors
#
CONFIG_DEVFREQ_GOV_SIMPLE_ONDEMAND=m
CONFIG_DEVFREQ_GOV_PERFORMANCE=y
# CONFIG_DEVFREQ_GOV_POWERSAVE is not set
CONFIG_DEVFREQ_GOV_USERSPACE=y
CONFIG_DEVFREQ_GOV_PASSIVE=y

#
# DEVFREQ Drivers
#
CONFIG_PM_DEVFREQ_EVENT=y
CONFIG_EXTCON=y

#
# Extcon Device Drivers
#
CONFIG_EXTCON_ADC_JACK=y
CONFIG_EXTCON_AXP288=m
CONFIG_EXTCON_GPIO=m
# CONFIG_EXTCON_INTEL_INT3496 is not set
CONFIG_EXTCON_MAX3355=y
CONFIG_EXTCON_MAX77843=m
CONFIG_EXTCON_PALMAS=m
CONFIG_EXTCON_RT8973A=m
CONFIG_EXTCON_SM5502=m
# CONFIG_EXTCON_USB_GPIO is not set
# CONFIG_EXTCON_USBC_CROS_EC is not set
CONFIG_MEMORY=y
CONFIG_IIO=y
CONFIG_IIO_BUFFER=y
CONFIG_IIO_BUFFER_CB=m
CONFIG_IIO_BUFFER_HW_CONSUMER=y
CONFIG_IIO_KFIFO_BUF=y
CONFIG_IIO_TRIGGERED_BUFFER=y
CONFIG_IIO_CONFIGFS=y
CONFIG_IIO_TRIGGER=y
CONFIG_IIO_CONSUMERS_PER_TRIGGER=2
# CONFIG_IIO_SW_DEVICE is not set
CONFIG_IIO_SW_TRIGGER=m
CONFIG_IIO_TRIGGERED_EVENT=y

#
# Accelerometers
#
CONFIG_BMA180=y
CONFIG_BMA220=m
CONFIG_BMC150_ACCEL=y
CONFIG_BMC150_ACCEL_I2C=y
CONFIG_BMC150_ACCEL_SPI=y
CONFIG_DA280=m
CONFIG_DA311=y
CONFIG_DMARD06=m
CONFIG_DMARD09=y
# CONFIG_DMARD10 is not set
CONFIG_IIO_CROS_EC_ACCEL_LEGACY=m
# CONFIG_IIO_ST_ACCEL_3AXIS is not set
CONFIG_KXSD9=y
# CONFIG_KXSD9_SPI is not set
CONFIG_KXSD9_I2C=m
CONFIG_KXCJK1013=y
CONFIG_MC3230=m
# CONFIG_MMA7455_I2C is not set
# CONFIG_MMA7455_SPI is not set
# CONFIG_MMA7660 is not set
# CONFIG_MMA8452 is not set
CONFIG_MMA9551_CORE=m
CONFIG_MMA9551=m
# CONFIG_MMA9553 is not set
# CONFIG_MXC4005 is not set
CONFIG_MXC6255=m
CONFIG_SCA3000=m
CONFIG_STK8312=m
CONFIG_STK8BA50=y

#
# Analog to digital converters
#
CONFIG_AD_SIGMA_DELTA=y
CONFIG_AD7266=y
CONFIG_AD7291=y
CONFIG_AD7298=m
CONFIG_AD7476=y
CONFIG_AD7766=m
# CONFIG_AD7791 is not set
CONFIG_AD7793=y
# CONFIG_AD7887 is not set
CONFIG_AD7923=y
CONFIG_AD799X=m
CONFIG_AXP20X_ADC=m
CONFIG_AXP288_ADC=m
# CONFIG_CC10001_ADC is not set
# CONFIG_CPCAP_ADC is not set
# CONFIG_DA9150_GPADC is not set
CONFIG_DLN2_ADC=m
CONFIG_ENVELOPE_DETECTOR=m
CONFIG_HI8435=y
# CONFIG_HX711 is not set
# CONFIG_INA2XX_ADC is not set
# CONFIG_LP8788_ADC is not set
CONFIG_LTC2471=y
# CONFIG_LTC2485 is not set
CONFIG_LTC2497=m
# CONFIG_MAX1027 is not set
CONFIG_MAX11100=y
# CONFIG_MAX1118 is not set
# CONFIG_MAX1363 is not set
# CONFIG_MAX9611 is not set
CONFIG_MCP320X=m
# CONFIG_MCP3422 is not set
# CONFIG_MEN_Z188_ADC is not set
# CONFIG_NAU7802 is not set
CONFIG_PALMAS_GPADC=m
CONFIG_QCOM_VADC_COMMON=m
# CONFIG_QCOM_SPMI_IADC is not set
CONFIG_QCOM_SPMI_VADC=m
# CONFIG_SD_ADC_MODULATOR is not set
# CONFIG_TI_ADC081C is not set
CONFIG_TI_ADC0832=y
CONFIG_TI_ADC084S021=m
CONFIG_TI_ADC12138=m
# CONFIG_TI_ADC108S102 is not set
CONFIG_TI_ADC128S052=m
CONFIG_TI_ADC161S626=y
CONFIG_TI_ADS1015=m
CONFIG_TI_ADS7950=m
# CONFIG_TI_ADS8688 is not set
CONFIG_TI_AM335X_ADC=m
CONFIG_TI_TLC4541=m
# CONFIG_TWL4030_MADC is not set
CONFIG_TWL6030_GPADC=y
CONFIG_VF610_ADC=m
CONFIG_VIPERBOARD_ADC=y

#
# Amplifiers
#
# CONFIG_AD8366 is not set

#
# Chemical Sensors
#
CONFIG_ATLAS_PH_SENSOR=y
# CONFIG_CCS811 is not set
CONFIG_IAQCORE=m
CONFIG_VZ89X=y
CONFIG_IIO_CROS_EC_SENSORS_CORE=y
# CONFIG_IIO_CROS_EC_SENSORS is not set

#
# Hid Sensor IIO Common
#
CONFIG_IIO_MS_SENSORS_I2C=y

#
# SSP Sensor Common
#
CONFIG_IIO_SSP_SENSORS_COMMONS=m
CONFIG_IIO_SSP_SENSORHUB=m
CONFIG_IIO_ST_SENSORS_I2C=m
CONFIG_IIO_ST_SENSORS_SPI=m
CONFIG_IIO_ST_SENSORS_CORE=m

#
# Counters
#

#
# Digital to analog converters
#
# CONFIG_AD5064 is not set
# CONFIG_AD5360 is not set
CONFIG_AD5380=y
CONFIG_AD5421=y
CONFIG_AD5446=y
CONFIG_AD5449=y
CONFIG_AD5592R_BASE=m
CONFIG_AD5592R=m
CONFIG_AD5593R=m
CONFIG_AD5504=y
CONFIG_AD5624R_SPI=y
# CONFIG_LTC2632 is not set
CONFIG_AD5686=y
CONFIG_AD5755=m
CONFIG_AD5761=y
CONFIG_AD5764=y
# CONFIG_AD5791 is not set
# CONFIG_AD7303 is not set
# CONFIG_AD8801 is not set
CONFIG_DPOT_DAC=y
# CONFIG_DS4424 is not set
CONFIG_M62332=y
CONFIG_MAX517=m
CONFIG_MAX5821=y
# CONFIG_MCP4725 is not set
CONFIG_MCP4922=m
CONFIG_TI_DAC082S085=m
CONFIG_VF610_DAC=m

#
# IIO dummy driver
#

#
# Frequency Synthesizers DDS/PLL
#

#
# Clock Generator/Distribution
#
CONFIG_AD9523=m

#
# Phase-Locked Loop (PLL) frequency synthesizers
#
# CONFIG_ADF4350 is not set

#
# Digital gyroscope sensors
#
CONFIG_ADIS16080=y
CONFIG_ADIS16130=y
# CONFIG_ADIS16136 is not set
CONFIG_ADIS16260=m
CONFIG_ADXRS450=y
CONFIG_BMG160=y
CONFIG_BMG160_I2C=y
CONFIG_BMG160_SPI=y
# CONFIG_MPU3050_I2C is not set
CONFIG_IIO_ST_GYRO_3AXIS=m
CONFIG_IIO_ST_GYRO_I2C_3AXIS=m
CONFIG_IIO_ST_GYRO_SPI_3AXIS=m
CONFIG_ITG3200=m

#
# Health Sensors
#

#
# Heart Rate Monitors
#
# CONFIG_AFE4403 is not set
CONFIG_AFE4404=y
CONFIG_MAX30100=m
# CONFIG_MAX30102 is not set

#
# Humidity sensors
#
CONFIG_AM2315=m
# CONFIG_DHT11 is not set
CONFIG_HDC100X=m
# CONFIG_HTS221 is not set
CONFIG_HTU21=m
# CONFIG_SI7005 is not set
# CONFIG_SI7020 is not set

#
# Inertial measurement units
#
CONFIG_ADIS16400=y
CONFIG_ADIS16480=m
CONFIG_BMI160=m
# CONFIG_BMI160_I2C is not set
CONFIG_BMI160_SPI=m
CONFIG_KMX61=y
# CONFIG_INV_MPU6050_SPI is not set
# CONFIG_IIO_ST_LSM6DSX is not set
CONFIG_IIO_ADIS_LIB=y
CONFIG_IIO_ADIS_LIB_BUFFER=y

#
# Light sensors
#
# CONFIG_ACPI_ALS is not set
# CONFIG_ADJD_S311 is not set
CONFIG_AL3320A=y
CONFIG_APDS9300=y
CONFIG_APDS9960=m
CONFIG_BH1750=y
# CONFIG_BH1780 is not set
# CONFIG_CM32181 is not set
# CONFIG_CM3232 is not set
CONFIG_CM3323=m
# CONFIG_CM3605 is not set
# CONFIG_CM36651 is not set
# CONFIG_IIO_CROS_EC_LIGHT_PROX is not set
CONFIG_GP2AP020A00F=m
# CONFIG_SENSORS_ISL29018 is not set
CONFIG_SENSORS_ISL29028=m
CONFIG_ISL29125=y
CONFIG_JSA1212=y
CONFIG_RPR0521=m
CONFIG_SENSORS_LM3533=m
CONFIG_LTR501=m
# CONFIG_MAX44000 is not set
# CONFIG_OPT3001 is not set
CONFIG_PA12203001=m
CONFIG_SI1145=y
# CONFIG_STK3310 is not set
CONFIG_ST_UVIS25=m
CONFIG_ST_UVIS25_I2C=m
CONFIG_ST_UVIS25_SPI=m
CONFIG_TCS3414=m
# CONFIG_TCS3472 is not set
CONFIG_SENSORS_TSL2563=y
CONFIG_TSL2583=y
# CONFIG_TSL4531 is not set
CONFIG_US5182D=y
CONFIG_VCNL4000=y
# CONFIG_VEML6070 is not set
# CONFIG_VL6180 is not set
CONFIG_ZOPT2201=m

#
# Magnetometer sensors
#
# CONFIG_AK8974 is not set
CONFIG_AK8975=y
CONFIG_AK09911=y
CONFIG_BMC150_MAGN=y
CONFIG_BMC150_MAGN_I2C=y
CONFIG_BMC150_MAGN_SPI=m
# CONFIG_MAG3110 is not set
# CONFIG_MMC35240 is not set
# CONFIG_IIO_ST_MAGN_3AXIS is not set
CONFIG_SENSORS_HMC5843=m
CONFIG_SENSORS_HMC5843_I2C=m
# CONFIG_SENSORS_HMC5843_SPI is not set

#
# Multiplexers
#
CONFIG_IIO_MUX=m

#
# Inclinometer sensors
#

#
# Triggers - standalone
#
CONFIG_IIO_HRTIMER_TRIGGER=m
CONFIG_IIO_INTERRUPT_TRIGGER=m
CONFIG_IIO_TIGHTLOOP_TRIGGER=m
CONFIG_IIO_SYSFS_TRIGGER=m

#
# Digital potentiometers
#
# CONFIG_DS1803 is not set
CONFIG_MAX5481=m
CONFIG_MAX5487=y
# CONFIG_MCP4131 is not set
CONFIG_MCP4531=y
CONFIG_TPL0102=m

#
# Digital potentiostats
#
CONFIG_LMP91000=m

#
# Pressure sensors
#
# CONFIG_ABP060MG is not set
CONFIG_BMP280=m
CONFIG_BMP280_I2C=m
CONFIG_BMP280_SPI=m
CONFIG_IIO_CROS_EC_BARO=m
# CONFIG_HP03 is not set
CONFIG_MPL115=y
CONFIG_MPL115_I2C=y
CONFIG_MPL115_SPI=y
# CONFIG_MPL3115 is not set
CONFIG_MS5611=y
CONFIG_MS5611_I2C=y
# CONFIG_MS5611_SPI is not set
CONFIG_MS5637=m
# CONFIG_IIO_ST_PRESS is not set
# CONFIG_T5403 is not set
CONFIG_HP206C=y
# CONFIG_ZPA2326 is not set

#
# Lightning sensors
#
# CONFIG_AS3935 is not set

#
# Proximity and distance sensors
#
# CONFIG_LIDAR_LITE_V2 is not set
CONFIG_RFD77402=y
CONFIG_SRF04=m
CONFIG_SX9500=y
CONFIG_SRF08=m

#
# Temperature sensors
#
CONFIG_MAXIM_THERMOCOUPLE=y
CONFIG_MLX90614=m
CONFIG_TMP006=m
CONFIG_TMP007=y
CONFIG_TSYS01=y
CONFIG_TSYS02D=y
# CONFIG_NTB is not set
# CONFIG_VME_BUS is not set
CONFIG_PWM=y
CONFIG_PWM_SYSFS=y
# CONFIG_PWM_ATMEL_HLCDC_PWM is not set
CONFIG_PWM_CROS_EC=m
CONFIG_PWM_FSL_FTM=m
# CONFIG_PWM_LP3943 is not set
# CONFIG_PWM_LPSS_PCI is not set
# CONFIG_PWM_LPSS_PLATFORM is not set
CONFIG_PWM_PCA9685=m
CONFIG_PWM_TWL=m
CONFIG_PWM_TWL_LED=m

#
# IRQ chip support
#
CONFIG_IRQCHIP=y
CONFIG_ARM_GIC_MAX_NR=1
# CONFIG_ARM_GIC_V3_ITS is not set
CONFIG_IPACK_BUS=y
# CONFIG_BOARD_TPCI200 is not set
CONFIG_SERIAL_IPOCTAL=m
CONFIG_RESET_CONTROLLER=y
# CONFIG_RESET_ATH79 is not set
# CONFIG_RESET_AXS10X is not set
# CONFIG_RESET_BERLIN is not set
# CONFIG_RESET_IMX7 is not set
# CONFIG_RESET_LANTIQ is not set
# CONFIG_RESET_LPC18XX is not set
# CONFIG_RESET_MESON is not set
# CONFIG_RESET_PISTACHIO is not set
# CONFIG_RESET_SIMPLE is not set
# CONFIG_RESET_SUNXI is not set
# CONFIG_RESET_TI_SYSCON is not set
# CONFIG_RESET_ZYNQ is not set
# CONFIG_RESET_TEGRA_BPMP is not set
# CONFIG_FMC is not set

#
# PHY Subsystem
#
CONFIG_GENERIC_PHY=y
# CONFIG_BCM_KONA_USB2_PHY is not set
CONFIG_PHY_PXA_28NM_HSIC=m
CONFIG_PHY_PXA_28NM_USB2=y
CONFIG_PHY_CPCAP_USB=m
CONFIG_PHY_QCOM_USB_HS=m
CONFIG_PHY_QCOM_USB_HSIC=y
CONFIG_PHY_SAMSUNG_USB2=y
# CONFIG_PHY_EXYNOS4210_USB2 is not set
# CONFIG_PHY_EXYNOS4X12_USB2 is not set
# CONFIG_PHY_EXYNOS5250_USB2 is not set
CONFIG_PHY_TUSB1210=m
# CONFIG_POWERCAP is not set
CONFIG_MCB=m
# CONFIG_MCB_PCI is not set
# CONFIG_MCB_LPC is not set

#
# Performance monitor support
#
# CONFIG_RAS is not set
# CONFIG_THUNDERBOLT is not set

#
# Android
#
# CONFIG_ANDROID is not set
CONFIG_LIBNVDIMM=y
CONFIG_BLK_DEV_PMEM=y
CONFIG_ND_BLK=m
CONFIG_ND_CLAIM=y
CONFIG_ND_BTT=y
CONFIG_BTT=y
CONFIG_ND_PFN=y
CONFIG_NVDIMM_PFN=y
CONFIG_NVDIMM_DAX=y
CONFIG_DAX=y
# CONFIG_DEV_DAX is not set
CONFIG_NVMEM=y
# CONFIG_STM is not set
CONFIG_INTEL_TH=m
# CONFIG_INTEL_TH_PCI is not set
# CONFIG_INTEL_TH_GTH is not set
CONFIG_INTEL_TH_MSU=m
CONFIG_INTEL_TH_PTI=m
# CONFIG_INTEL_TH_DEBUG is not set
# CONFIG_FPGA is not set
# CONFIG_FSI is not set
CONFIG_MULTIPLEXER=m

#
# Multiplexer drivers
#
CONFIG_MUX_ADG792A=m
# CONFIG_MUX_GPIO is not set
CONFIG_MUX_MMIO=m
CONFIG_PM_OPP=y
# CONFIG_UNISYS_VISORBUS is not set
CONFIG_SIOX=y
CONFIG_SIOX_BUS_GPIO=m
# CONFIG_SLIMBUS is not set

#
# Firmware Drivers
#
CONFIG_EDD=m
CONFIG_EDD_OFF=y
CONFIG_FIRMWARE_MEMMAP=y
CONFIG_DELL_RBU=m
# CONFIG_DCDBAS is not set
CONFIG_DMIID=y
# CONFIG_DMI_SYSFS is not set
CONFIG_DMI_SCAN_MACHINE_NON_EFI_FALLBACK=y
# CONFIG_ISCSI_IBFT_FIND is not set
# CONFIG_FW_CFG_SYSFS is not set
CONFIG_GOOGLE_FIRMWARE=y
# CONFIG_GOOGLE_COREBOOT_TABLE_ACPI is not set
# CONFIG_GOOGLE_COREBOOT_TABLE_OF is not set
# CONFIG_GOOGLE_MEMCONSOLE_X86_LEGACY is not set
# CONFIG_EFI_DEV_PATH_PARSER is not set

#
# Tegra firmware driver
#

#
# File systems
#
CONFIG_DCACHE_WORD_ACCESS=y
CONFIG_FS_IOMAP=y
CONFIG_EXT2_FS=m
# CONFIG_EXT2_FS_XATTR is not set
CONFIG_EXT3_FS=m
# CONFIG_EXT3_FS_POSIX_ACL is not set
# CONFIG_EXT3_FS_SECURITY is not set
CONFIG_EXT4_FS=m
# CONFIG_EXT4_FS_POSIX_ACL is not set
# CONFIG_EXT4_FS_SECURITY is not set
CONFIG_EXT4_ENCRYPTION=y
CONFIG_EXT4_FS_ENCRYPTION=y
# CONFIG_EXT4_DEBUG is not set
CONFIG_JBD2=m
CONFIG_JBD2_DEBUG=y
CONFIG_FS_MBCACHE=m
CONFIG_REISERFS_FS=y
CONFIG_REISERFS_CHECK=y
CONFIG_REISERFS_PROC_INFO=y
# CONFIG_REISERFS_FS_XATTR is not set
# CONFIG_JFS_FS is not set
CONFIG_XFS_FS=y
CONFIG_XFS_QUOTA=y
# CONFIG_XFS_POSIX_ACL is not set
# CONFIG_XFS_RT is not set
# CONFIG_XFS_ONLINE_SCRUB is not set
CONFIG_XFS_DEBUG=y
CONFIG_XFS_ASSERT_FATAL=y
CONFIG_GFS2_FS=m
# CONFIG_OCFS2_FS is not set
CONFIG_BTRFS_FS=y
# CONFIG_BTRFS_FS_POSIX_ACL is not set
# CONFIG_BTRFS_FS_CHECK_INTEGRITY is not set
# CONFIG_BTRFS_FS_RUN_SANITY_TESTS is not set
CONFIG_BTRFS_DEBUG=y
CONFIG_BTRFS_ASSERT=y
# CONFIG_BTRFS_FS_REF_VERIFY is not set
# CONFIG_NILFS2_FS is not set
# CONFIG_F2FS_FS is not set
CONFIG_FS_DAX=y
CONFIG_FS_DAX_PMD=y
CONFIG_FS_POSIX_ACL=y
CONFIG_EXPORTFS=y
# CONFIG_EXPORTFS_BLOCK_OPS is not set
CONFIG_FILE_LOCKING=y
# CONFIG_MANDATORY_FILE_LOCKING is not set
CONFIG_FS_ENCRYPTION=m
CONFIG_FSNOTIFY=y
# CONFIG_DNOTIFY is not set
CONFIG_INOTIFY_USER=y
CONFIG_FANOTIFY=y
# CONFIG_QUOTA is not set
# CONFIG_QUOTA_NETLINK_INTERFACE is not set
CONFIG_QUOTACTL=y
CONFIG_QUOTACTL_COMPAT=y
CONFIG_AUTOFS4_FS=y
CONFIG_FUSE_FS=y
# CONFIG_CUSE is not set
CONFIG_OVERLAY_FS=m
CONFIG_OVERLAY_FS_REDIRECT_DIR=y
CONFIG_OVERLAY_FS_REDIRECT_ALWAYS_FOLLOW=y
# CONFIG_OVERLAY_FS_INDEX is not set

#
# Caches
#
CONFIG_FSCACHE=m
# CONFIG_FSCACHE_STATS is not set
# CONFIG_FSCACHE_HISTOGRAM is not set
CONFIG_FSCACHE_DEBUG=y
CONFIG_FSCACHE_OBJECT_LIST=y
CONFIG_CACHEFILES=m
CONFIG_CACHEFILES_DEBUG=y
CONFIG_CACHEFILES_HISTOGRAM=y

#
# CD-ROM/DVD Filesystems
#
CONFIG_ISO9660_FS=m
CONFIG_JOLIET=y
CONFIG_ZISOFS=y
CONFIG_UDF_FS=m
CONFIG_UDF_NLS=y

#
# DOS/FAT/NT Filesystems
#
CONFIG_FAT_FS=y
# CONFIG_MSDOS_FS is not set
CONFIG_VFAT_FS=y
CONFIG_FAT_DEFAULT_CODEPAGE=437
CONFIG_FAT_DEFAULT_IOCHARSET="iso8859-1"
CONFIG_FAT_DEFAULT_UTF8=y
CONFIG_NTFS_FS=m
# CONFIG_NTFS_DEBUG is not set
CONFIG_NTFS_RW=y

#
# Pseudo filesystems
#
CONFIG_PROC_FS=y
# CONFIG_PROC_KCORE is not set
CONFIG_PROC_SYSCTL=y
CONFIG_PROC_PAGE_MONITOR=y
CONFIG_PROC_CHILDREN=y
CONFIG_KERNFS=y
CONFIG_SYSFS=y
CONFIG_TMPFS=y
# CONFIG_TMPFS_POSIX_ACL is not set
# CONFIG_TMPFS_XATTR is not set
# CONFIG_HUGETLBFS is not set
# CONFIG_HUGETLB_PAGE is not set
CONFIG_ARCH_HAS_GIGANTIC_PAGE=y
CONFIG_CONFIGFS_FS=y
# CONFIG_MISC_FILESYSTEMS is not set
CONFIG_NETWORK_FILESYSTEMS=y
CONFIG_NFS_FS=y
CONFIG_NFS_V2=y
CONFIG_NFS_V3=y
# CONFIG_NFS_V3_ACL is not set
CONFIG_NFS_V4=m
# CONFIG_NFS_SWAP is not set
# CONFIG_NFS_V4_1 is not set
# CONFIG_ROOT_NFS is not set
# CONFIG_NFS_USE_LEGACY_DNS is not set
CONFIG_NFS_USE_KERNEL_DNS=y
# CONFIG_NFSD is not set
CONFIG_GRACE_PERIOD=y
CONFIG_LOCKD=y
CONFIG_LOCKD_V4=y
CONFIG_NFS_COMMON=y
CONFIG_SUNRPC=y
CONFIG_SUNRPC_GSS=m
CONFIG_RPCSEC_GSS_KRB5=m
# CONFIG_SUNRPC_DEBUG is not set
# CONFIG_CEPH_FS is not set
CONFIG_CIFS=m
# CONFIG_CIFS_STATS is not set
# CONFIG_CIFS_WEAK_PW_HASH is not set
# CONFIG_CIFS_UPCALL is not set
# CONFIG_CIFS_XATTR is not set
CONFIG_CIFS_DEBUG=y
# CONFIG_CIFS_DEBUG2 is not set
# CONFIG_CIFS_DEBUG_DUMP_KEYS is not set
# CONFIG_CIFS_DFS_UPCALL is not set
# CONFIG_CIFS_SMB311 is not set
# CONFIG_CIFS_FSCACHE is not set
# CONFIG_CODA_FS is not set
# CONFIG_AFS_FS is not set
CONFIG_NLS=y
CONFIG_NLS_DEFAULT="iso8859-1"
# CONFIG_NLS_CODEPAGE_437 is not set
CONFIG_NLS_CODEPAGE_737=m
CONFIG_NLS_CODEPAGE_775=m
# CONFIG_NLS_CODEPAGE_850 is not set
CONFIG_NLS_CODEPAGE_852=y
# CONFIG_NLS_CODEPAGE_855 is not set
CONFIG_NLS_CODEPAGE_857=m
CONFIG_NLS_CODEPAGE_860=y
# CONFIG_NLS_CODEPAGE_861 is not set
CONFIG_NLS_CODEPAGE_862=y
CONFIG_NLS_CODEPAGE_863=y
CONFIG_NLS_CODEPAGE_864=y
CONFIG_NLS_CODEPAGE_865=m
# CONFIG_NLS_CODEPAGE_866 is not set
CONFIG_NLS_CODEPAGE_869=m
CONFIG_NLS_CODEPAGE_936=y
CONFIG_NLS_CODEPAGE_950=y
CONFIG_NLS_CODEPAGE_932=m
# CONFIG_NLS_CODEPAGE_949 is not set
# CONFIG_NLS_CODEPAGE_874 is not set
# CONFIG_NLS_ISO8859_8 is not set
CONFIG_NLS_CODEPAGE_1250=y
CONFIG_NLS_CODEPAGE_1251=m
CONFIG_NLS_ASCII=y
CONFIG_NLS_ISO8859_1=y
CONFIG_NLS_ISO8859_2=y
# CONFIG_NLS_ISO8859_3 is not set
# CONFIG_NLS_ISO8859_4 is not set
CONFIG_NLS_ISO8859_5=m
CONFIG_NLS_ISO8859_6=y
CONFIG_NLS_ISO8859_7=m
CONFIG_NLS_ISO8859_9=m
# CONFIG_NLS_ISO8859_13 is not set
CONFIG_NLS_ISO8859_14=m
CONFIG_NLS_ISO8859_15=m
CONFIG_NLS_KOI8_R=m
# CONFIG_NLS_KOI8_U is not set
CONFIG_NLS_MAC_ROMAN=m
# CONFIG_NLS_MAC_CELTIC is not set
CONFIG_NLS_MAC_CENTEURO=y
# CONFIG_NLS_MAC_CROATIAN is not set
CONFIG_NLS_MAC_CYRILLIC=y
CONFIG_NLS_MAC_GAELIC=m
CONFIG_NLS_MAC_GREEK=y
CONFIG_NLS_MAC_ICELAND=m
# CONFIG_NLS_MAC_INUIT is not set
# CONFIG_NLS_MAC_ROMANIAN is not set
# CONFIG_NLS_MAC_TURKISH is not set
CONFIG_NLS_UTF8=m
# CONFIG_DLM is not set

#
# Kernel hacking
#
CONFIG_TRACE_IRQFLAGS_SUPPORT=y

#
# printk and dmesg options
#
CONFIG_PRINTK_TIME=y
CONFIG_CONSOLE_LOGLEVEL_DEFAULT=7
CONFIG_MESSAGE_LOGLEVEL_DEFAULT=4
# CONFIG_BOOT_PRINTK_DELAY is not set
# CONFIG_DYNAMIC_DEBUG is not set

#
# Compile-time checks and compiler options
#
CONFIG_DEBUG_INFO=y
CONFIG_DEBUG_INFO_REDUCED=y
# CONFIG_DEBUG_INFO_SPLIT is not set
# CONFIG_DEBUG_INFO_DWARF4 is not set
# CONFIG_GDB_SCRIPTS is not set
# CONFIG_ENABLE_WARN_DEPRECATED is not set
# CONFIG_ENABLE_MUST_CHECK is not set
CONFIG_FRAME_WARN=8192
CONFIG_STRIP_ASM_SYMS=y
# CONFIG_READABLE_ASM is not set
CONFIG_UNUSED_SYMBOLS=y
# CONFIG_PAGE_OWNER is not set
CONFIG_DEBUG_FS=y
CONFIG_HEADERS_CHECK=y
# CONFIG_DEBUG_SECTION_MISMATCH is not set
CONFIG_SECTION_MISMATCH_WARN_ONLY=y
CONFIG_STACK_VALIDATION=y
# CONFIG_DEBUG_FORCE_WEAK_PER_CPU is not set
CONFIG_MAGIC_SYSRQ=y
CONFIG_MAGIC_SYSRQ_DEFAULT_ENABLE=0x1
CONFIG_MAGIC_SYSRQ_SERIAL=y
CONFIG_DEBUG_KERNEL=y

#
# Memory Debugging
#
CONFIG_PAGE_EXTENSION=y
# CONFIG_DEBUG_PAGEALLOC is not set
CONFIG_PAGE_POISONING=y
# CONFIG_PAGE_POISONING_NO_SANITY is not set
CONFIG_PAGE_POISONING_ZERO=y
# CONFIG_DEBUG_PAGE_REF is not set
CONFIG_DEBUG_RODATA_TEST=y
# CONFIG_DEBUG_OBJECTS is not set
# CONFIG_DEBUG_SLAB is not set
CONFIG_HAVE_DEBUG_KMEMLEAK=y
# CONFIG_DEBUG_KMEMLEAK is not set
# CONFIG_DEBUG_STACK_USAGE is not set
# CONFIG_DEBUG_VM is not set
CONFIG_ARCH_HAS_DEBUG_VIRTUAL=y
# CONFIG_DEBUG_VIRTUAL is not set
CONFIG_DEBUG_MEMORY_INIT=y
# CONFIG_DEBUG_PER_CPU_MAPS is not set
CONFIG_HAVE_DEBUG_STACKOVERFLOW=y
# CONFIG_DEBUG_STACKOVERFLOW is not set
CONFIG_HAVE_ARCH_KASAN=y
CONFIG_KASAN=y
# CONFIG_KASAN_EXTRA is not set
CONFIG_KASAN_OUTLINE=y
# CONFIG_KASAN_INLINE is not set
CONFIG_TEST_KASAN=m
CONFIG_ARCH_HAS_KCOV=y
# CONFIG_KCOV is not set
# CONFIG_DEBUG_SHIRQ is not set

#
# Debug Lockups and Hangs
#
# CONFIG_SOFTLOCKUP_DETECTOR is not set
CONFIG_HARDLOCKUP_CHECK_TIMESTAMP=y
# CONFIG_HARDLOCKUP_DETECTOR is not set
# CONFIG_DETECT_HUNG_TASK is not set
# CONFIG_WQ_WATCHDOG is not set
# CONFIG_PANIC_ON_OOPS is not set
CONFIG_PANIC_ON_OOPS_VALUE=0
CONFIG_PANIC_TIMEOUT=0
CONFIG_SCHED_DEBUG=y
# CONFIG_SCHED_INFO is not set
# CONFIG_SCHEDSTATS is not set
# CONFIG_SCHED_STACK_END_CHECK is not set
CONFIG_DEBUG_TIMEKEEPING=y
CONFIG_DEBUG_PREEMPT=y

#
# Lock Debugging (spinlocks, mutexes, etc...)
#
# CONFIG_DEBUG_RT_MUTEXES is not set
# CONFIG_DEBUG_SPINLOCK is not set
# CONFIG_DEBUG_MUTEXES is not set
# CONFIG_DEBUG_WW_MUTEX_SLOWPATH is not set
# CONFIG_DEBUG_LOCK_ALLOC is not set
# CONFIG_PROVE_LOCKING is not set
# CONFIG_LOCK_STAT is not set
CONFIG_DEBUG_ATOMIC_SLEEP=y
# CONFIG_DEBUG_LOCKING_API_SELFTESTS is not set
# CONFIG_LOCK_TORTURE_TEST is not set
CONFIG_WW_MUTEX_SELFTEST=m
CONFIG_TRACE_IRQFLAGS=y
CONFIG_STACKTRACE=y
CONFIG_WARN_ALL_UNSEEDED_RANDOM=y
# CONFIG_DEBUG_KOBJECT is not set
CONFIG_DEBUG_BUGVERBOSE=y
CONFIG_DEBUG_LIST=y
# CONFIG_DEBUG_PI_LIST is not set
# CONFIG_DEBUG_SG is not set
# CONFIG_DEBUG_NOTIFIERS is not set
# CONFIG_DEBUG_CREDENTIALS is not set

#
# RCU Debugging
#
# CONFIG_PROVE_RCU is not set
# CONFIG_TORTURE_TEST is not set
# CONFIG_RCU_PERF_TEST is not set
# CONFIG_RCU_TORTURE_TEST is not set
CONFIG_RCU_CPU_STALL_TIMEOUT=21
# CONFIG_RCU_TRACE is not set
# CONFIG_RCU_EQS_DEBUG is not set
# CONFIG_DEBUG_WQ_FORCE_RR_CPU is not set
# CONFIG_DEBUG_BLOCK_EXT_DEVT is not set
# CONFIG_NOTIFIER_ERROR_INJECTION is not set
# CONFIG_FAULT_INJECTION is not set
CONFIG_FUNCTION_ERROR_INJECTION=y
# CONFIG_LATENCYTOP is not set
CONFIG_USER_STACKTRACE_SUPPORT=y
CONFIG_NOP_TRACER=y
CONFIG_HAVE_FUNCTION_TRACER=y
CONFIG_HAVE_FUNCTION_GRAPH_TRACER=y
CONFIG_HAVE_DYNAMIC_FTRACE=y
CONFIG_HAVE_DYNAMIC_FTRACE_WITH_REGS=y
CONFIG_HAVE_FTRACE_MCOUNT_RECORD=y
CONFIG_HAVE_SYSCALL_TRACEPOINTS=y
CONFIG_HAVE_FENTRY=y
CONFIG_HAVE_C_RECORDMCOUNT=y
CONFIG_TRACER_MAX_TRACE=y
CONFIG_TRACE_CLOCK=y
CONFIG_RING_BUFFER=y
CONFIG_EVENT_TRACING=y
CONFIG_CONTEXT_SWITCH_TRACER=y
CONFIG_RING_BUFFER_ALLOW_SWAP=y
CONFIG_TRACING=y
CONFIG_GENERIC_TRACER=y
CONFIG_TRACING_SUPPORT=y
CONFIG_FTRACE=y
CONFIG_FUNCTION_TRACER=y
# CONFIG_FUNCTION_GRAPH_TRACER is not set
CONFIG_PREEMPTIRQ_EVENTS=y
CONFIG_IRQSOFF_TRACER=y
CONFIG_PREEMPT_TRACER=y
CONFIG_SCHED_TRACER=y
# CONFIG_HWLAT_TRACER is not set
# CONFIG_FTRACE_SYSCALLS is not set
CONFIG_TRACER_SNAPSHOT=y
CONFIG_TRACER_SNAPSHOT_PER_CPU_SWAP=y
CONFIG_BRANCH_PROFILE_NONE=y
# CONFIG_PROFILE_ANNOTATED_BRANCHES is not set
# CONFIG_STACK_TRACER is not set
# CONFIG_BLK_DEV_IO_TRACE is not set
CONFIG_KPROBE_EVENTS=y
CONFIG_UPROBE_EVENTS=y
CONFIG_BPF_EVENTS=y
CONFIG_PROBE_EVENTS=y
CONFIG_DYNAMIC_FTRACE=y
CONFIG_DYNAMIC_FTRACE_WITH_REGS=y
# CONFIG_FUNCTION_PROFILER is not set
# CONFIG_BPF_KPROBE_OVERRIDE is not set
CONFIG_FTRACE_MCOUNT_RECORD=y
# CONFIG_FTRACE_STARTUP_TEST is not set
# CONFIG_MMIOTRACE is not set
# CONFIG_HIST_TRIGGERS is not set
# CONFIG_TRACEPOINT_BENCHMARK is not set
# CONFIG_RING_BUFFER_BENCHMARK is not set
# CONFIG_RING_BUFFER_STARTUP_TEST is not set
CONFIG_TRACE_EVAL_MAP_FILE=y
# CONFIG_TRACING_EVENTS_GPIO is not set
# CONFIG_PROVIDE_OHCI1394_DMA_INIT is not set
# CONFIG_DMA_API_DEBUG is not set
# CONFIG_RUNTIME_TESTING_MENU is not set
# CONFIG_MEMTEST is not set
CONFIG_BUG_ON_DATA_CORRUPTION=y
# CONFIG_SAMPLES is not set
CONFIG_HAVE_ARCH_KGDB=y
# CONFIG_KGDB is not set
CONFIG_ARCH_HAS_UBSAN_SANITIZE_ALL=y
# CONFIG_ARCH_WANTS_UBSAN_NO_NULL is not set
# CONFIG_UBSAN is not set
CONFIG_ARCH_HAS_DEVMEM_IS_ALLOWED=y
CONFIG_STRICT_DEVMEM=y
CONFIG_IO_STRICT_DEVMEM=y
CONFIG_X86_VERBOSE_BOOTUP=y
CONFIG_EARLY_PRINTK=y
# CONFIG_EARLY_PRINTK_DBGP is not set
# CONFIG_EARLY_PRINTK_USB_XDBC is not set
# CONFIG_X86_PTDUMP_CORE is not set
# CONFIG_X86_PTDUMP is not set
# CONFIG_DEBUG_WX is not set
CONFIG_DOUBLEFAULT=y
# CONFIG_DEBUG_TLBFLUSH is not set
CONFIG_HAVE_MMIOTRACE_SUPPORT=y
# CONFIG_X86_DECODER_SELFTEST is not set
CONFIG_IO_DELAY_TYPE_0X80=0
CONFIG_IO_DELAY_TYPE_0XED=1
CONFIG_IO_DELAY_TYPE_UDELAY=2
CONFIG_IO_DELAY_TYPE_NONE=3
# CONFIG_IO_DELAY_0X80 is not set
CONFIG_IO_DELAY_0XED=y
# CONFIG_IO_DELAY_UDELAY is not set
# CONFIG_IO_DELAY_NONE is not set
CONFIG_DEFAULT_IO_DELAY_TYPE=1
# CONFIG_DEBUG_BOOT_PARAMS is not set
# CONFIG_CPA_DEBUG is not set
# CONFIG_OPTIMIZE_INLINING is not set
# CONFIG_DEBUG_ENTRY is not set
# CONFIG_DEBUG_NMI_SELFTEST is not set
CONFIG_X86_DEBUG_FPU=y
# CONFIG_PUNIT_ATOM_DEBUG is not set
CONFIG_UNWINDER_ORC=y
# CONFIG_UNWINDER_FRAME_POINTER is not set

#
# Security options
#
CONFIG_KEYS=y
CONFIG_KEYS_COMPAT=y
# CONFIG_PERSISTENT_KEYRINGS is not set
# CONFIG_BIG_KEYS is not set
CONFIG_TRUSTED_KEYS=y
CONFIG_ENCRYPTED_KEYS=y
CONFIG_KEY_DH_OPERATIONS=y
# CONFIG_SECURITY_DMESG_RESTRICT is not set
# CONFIG_SECURITY is not set
CONFIG_SECURITYFS=y
CONFIG_PAGE_TABLE_ISOLATION=y
CONFIG_HAVE_HARDENED_USERCOPY_ALLOCATOR=y
# CONFIG_HARDENED_USERCOPY is not set
CONFIG_FORTIFY_SOURCE=y
CONFIG_STATIC_USERMODEHELPER=y
CONFIG_STATIC_USERMODEHELPER_PATH="/sbin/usermode-helper"
CONFIG_DEFAULT_SECURITY_DAC=y
CONFIG_DEFAULT_SECURITY=""
CONFIG_XOR_BLOCKS=y
CONFIG_CRYPTO=y

#
# Crypto core or helper
#
CONFIG_CRYPTO_ALGAPI=y
CONFIG_CRYPTO_ALGAPI2=y
CONFIG_CRYPTO_AEAD=y
CONFIG_CRYPTO_AEAD2=y
CONFIG_CRYPTO_BLKCIPHER=y
CONFIG_CRYPTO_BLKCIPHER2=y
CONFIG_CRYPTO_HASH=y
CONFIG_CRYPTO_HASH2=y
CONFIG_CRYPTO_RNG=y
CONFIG_CRYPTO_RNG2=y
CONFIG_CRYPTO_RNG_DEFAULT=y
CONFIG_CRYPTO_AKCIPHER2=y
CONFIG_CRYPTO_AKCIPHER=y
CONFIG_CRYPTO_KPP2=y
CONFIG_CRYPTO_KPP=y
CONFIG_CRYPTO_ACOMP2=y
CONFIG_CRYPTO_RSA=y
CONFIG_CRYPTO_DH=y
CONFIG_CRYPTO_ECDH=y
CONFIG_CRYPTO_MANAGER=y
CONFIG_CRYPTO_MANAGER2=y
# CONFIG_CRYPTO_USER is not set
CONFIG_CRYPTO_MANAGER_DISABLE_TESTS=y
CONFIG_CRYPTO_GF128MUL=y
CONFIG_CRYPTO_NULL=y
CONFIG_CRYPTO_NULL2=y
CONFIG_CRYPTO_PCRYPT=y
CONFIG_CRYPTO_WORKQUEUE=y
CONFIG_CRYPTO_CRYPTD=y
CONFIG_CRYPTO_MCRYPTD=m
CONFIG_CRYPTO_AUTHENC=y
CONFIG_CRYPTO_TEST=m
CONFIG_CRYPTO_ABLK_HELPER=y
CONFIG_CRYPTO_SIMD=m
CONFIG_CRYPTO_GLUE_HELPER_X86=y

#
# Authenticated Encryption with Associated Data
#
CONFIG_CRYPTO_CCM=m
CONFIG_CRYPTO_GCM=m
CONFIG_CRYPTO_CHACHA20POLY1305=y
CONFIG_CRYPTO_SEQIV=y
CONFIG_CRYPTO_ECHAINIV=y

#
# Block modes
#
CONFIG_CRYPTO_CBC=y
CONFIG_CRYPTO_CTR=m
CONFIG_CRYPTO_CTS=m
CONFIG_CRYPTO_ECB=y
CONFIG_CRYPTO_LRW=y
CONFIG_CRYPTO_PCBC=m
CONFIG_CRYPTO_XTS=y
# CONFIG_CRYPTO_KEYWRAP is not set

#
# Hash modes
#
CONFIG_CRYPTO_CMAC=y
CONFIG_CRYPTO_HMAC=y
# CONFIG_CRYPTO_XCBC is not set
CONFIG_CRYPTO_VMAC=y

#
# Digest
#
CONFIG_CRYPTO_CRC32C=y
CONFIG_CRYPTO_CRC32C_INTEL=m
# CONFIG_CRYPTO_CRC32 is not set
CONFIG_CRYPTO_CRC32_PCLMUL=m
CONFIG_CRYPTO_CRCT10DIF=y
# CONFIG_CRYPTO_CRCT10DIF_PCLMUL is not set
CONFIG_CRYPTO_GHASH=m
CONFIG_CRYPTO_POLY1305=y
CONFIG_CRYPTO_POLY1305_X86_64=m
CONFIG_CRYPTO_MD4=m
CONFIG_CRYPTO_MD5=y
# CONFIG_CRYPTO_MICHAEL_MIC is not set
CONFIG_CRYPTO_RMD128=y
# CONFIG_CRYPTO_RMD160 is not set
# CONFIG_CRYPTO_RMD256 is not set
CONFIG_CRYPTO_RMD320=m
CONFIG_CRYPTO_SHA1=y
CONFIG_CRYPTO_SHA1_SSSE3=y
CONFIG_CRYPTO_SHA256_SSSE3=m
CONFIG_CRYPTO_SHA512_SSSE3=m
CONFIG_CRYPTO_SHA1_MB=m
# CONFIG_CRYPTO_SHA256_MB is not set
CONFIG_CRYPTO_SHA512_MB=m
CONFIG_CRYPTO_SHA256=y
CONFIG_CRYPTO_SHA512=m
CONFIG_CRYPTO_SHA3=y
CONFIG_CRYPTO_SM3=y
# CONFIG_CRYPTO_TGR192 is not set
CONFIG_CRYPTO_WP512=m
CONFIG_CRYPTO_GHASH_CLMUL_NI_INTEL=m

#
# Ciphers
#
CONFIG_CRYPTO_AES=y
# CONFIG_CRYPTO_AES_TI is not set
CONFIG_CRYPTO_AES_X86_64=m
CONFIG_CRYPTO_AES_NI_INTEL=m
CONFIG_CRYPTO_ANUBIS=m
CONFIG_CRYPTO_ARC4=m
CONFIG_CRYPTO_BLOWFISH=y
CONFIG_CRYPTO_BLOWFISH_COMMON=y
# CONFIG_CRYPTO_BLOWFISH_X86_64 is not set
CONFIG_CRYPTO_CAMELLIA=y
CONFIG_CRYPTO_CAMELLIA_X86_64=y
CONFIG_CRYPTO_CAMELLIA_AESNI_AVX_X86_64=y
CONFIG_CRYPTO_CAMELLIA_AESNI_AVX2_X86_64=y
CONFIG_CRYPTO_CAST_COMMON=y
CONFIG_CRYPTO_CAST5=y
CONFIG_CRYPTO_CAST5_AVX_X86_64=y
CONFIG_CRYPTO_CAST6=m
CONFIG_CRYPTO_CAST6_AVX_X86_64=m
CONFIG_CRYPTO_DES=y
# CONFIG_CRYPTO_DES3_EDE_X86_64 is not set
# CONFIG_CRYPTO_FCRYPT is not set
CONFIG_CRYPTO_KHAZAD=y
CONFIG_CRYPTO_SALSA20=m
# CONFIG_CRYPTO_SALSA20_X86_64 is not set
CONFIG_CRYPTO_CHACHA20=y
# CONFIG_CRYPTO_CHACHA20_X86_64 is not set
# CONFIG_CRYPTO_SEED is not set
CONFIG_CRYPTO_SERPENT=y
CONFIG_CRYPTO_SERPENT_SSE2_X86_64=y
CONFIG_CRYPTO_SERPENT_AVX_X86_64=y
CONFIG_CRYPTO_SERPENT_AVX2_X86_64=y
CONFIG_CRYPTO_TEA=m
CONFIG_CRYPTO_TWOFISH=y
CONFIG_CRYPTO_TWOFISH_COMMON=y
CONFIG_CRYPTO_TWOFISH_X86_64=y
CONFIG_CRYPTO_TWOFISH_X86_64_3WAY=y
CONFIG_CRYPTO_TWOFISH_AVX_X86_64=y

#
# Compression
#
CONFIG_CRYPTO_DEFLATE=m
CONFIG_CRYPTO_LZO=m
CONFIG_CRYPTO_842=y
CONFIG_CRYPTO_LZ4=m
CONFIG_CRYPTO_LZ4HC=m

#
# Random Number Generation
#
# CONFIG_CRYPTO_ANSI_CPRNG is not set
CONFIG_CRYPTO_DRBG_MENU=y
CONFIG_CRYPTO_DRBG_HMAC=y
CONFIG_CRYPTO_DRBG_HASH=y
# CONFIG_CRYPTO_DRBG_CTR is not set
CONFIG_CRYPTO_DRBG=y
CONFIG_CRYPTO_JITTERENTROPY=y
# CONFIG_CRYPTO_USER_API_HASH is not set
# CONFIG_CRYPTO_USER_API_SKCIPHER is not set
# CONFIG_CRYPTO_USER_API_RNG is not set
# CONFIG_CRYPTO_USER_API_AEAD is not set
CONFIG_CRYPTO_HASH_INFO=y
# CONFIG_CRYPTO_HW is not set
CONFIG_ASYMMETRIC_KEY_TYPE=y
CONFIG_ASYMMETRIC_PUBLIC_KEY_SUBTYPE=y
CONFIG_X509_CERTIFICATE_PARSER=y
CONFIG_PKCS7_MESSAGE_PARSER=y

#
# Certificates for signature checking
#
CONFIG_SYSTEM_TRUSTED_KEYRING=y
CONFIG_SYSTEM_TRUSTED_KEYS=""
# CONFIG_SYSTEM_EXTRA_CERTIFICATE is not set
# CONFIG_SECONDARY_TRUSTED_KEYRING is not set
CONFIG_SYSTEM_BLACKLIST_KEYRING=y
CONFIG_SYSTEM_BLACKLIST_HASH_LIST=""
CONFIG_HAVE_KVM=y
CONFIG_VIRTUALIZATION=y
# CONFIG_VHOST_NET is not set
CONFIG_VHOST_SCSI=m
CONFIG_VHOST=m
# CONFIG_VHOST_CROSS_ENDIAN_LEGACY is not set
CONFIG_BINARY_PRINTF=y

#
# Library routines
#
CONFIG_RAID6_PQ=y
CONFIG_BITREVERSE=y
# CONFIG_HAVE_ARCH_BITREVERSE is not set
CONFIG_RATIONAL=y
CONFIG_GENERIC_STRNCPY_FROM_USER=y
CONFIG_GENERIC_STRNLEN_USER=y
CONFIG_GENERIC_NET_UTILS=y
CONFIG_GENERIC_FIND_FIRST_BIT=y
CONFIG_GENERIC_PCI_IOMAP=y
CONFIG_GENERIC_IOMAP=y
CONFIG_ARCH_USE_CMPXCHG_LOCKREF=y
CONFIG_ARCH_HAS_FAST_MULTIPLIER=y
CONFIG_CRC_CCITT=m
CONFIG_CRC16=y
CONFIG_CRC_T10DIF=y
CONFIG_CRC_ITU_T=y
CONFIG_CRC32=y
CONFIG_CRC32_SELFTEST=y
# CONFIG_CRC32_SLICEBY8 is not set
# CONFIG_CRC32_SLICEBY4 is not set
# CONFIG_CRC32_SARWATE is not set
CONFIG_CRC32_BIT=y
# CONFIG_CRC4 is not set
CONFIG_CRC7=y
CONFIG_LIBCRC32C=y
# CONFIG_CRC8 is not set
CONFIG_XXHASH=y
# CONFIG_AUDIT_ARCH_COMPAT_GENERIC is not set
CONFIG_RANDOM32_SELFTEST=y
CONFIG_842_COMPRESS=y
CONFIG_842_DECOMPRESS=y
CONFIG_ZLIB_INFLATE=y
CONFIG_ZLIB_DEFLATE=y
CONFIG_LZO_COMPRESS=y
CONFIG_LZO_DECOMPRESS=y
CONFIG_LZ4_COMPRESS=m
CONFIG_LZ4HC_COMPRESS=m
CONFIG_LZ4_DECOMPRESS=m
CONFIG_ZSTD_COMPRESS=y
CONFIG_ZSTD_DECOMPRESS=y
CONFIG_XZ_DEC=y
CONFIG_XZ_DEC_X86=y
CONFIG_XZ_DEC_POWERPC=y
CONFIG_XZ_DEC_IA64=y
CONFIG_XZ_DEC_ARM=y
CONFIG_XZ_DEC_ARMTHUMB=y
CONFIG_XZ_DEC_SPARC=y
CONFIG_XZ_DEC_BCJ=y
CONFIG_XZ_DEC_TEST=m
CONFIG_DECOMPRESS_GZIP=y
CONFIG_DECOMPRESS_XZ=y
CONFIG_GENERIC_ALLOCATOR=y
CONFIG_REED_SOLOMON=m
CONFIG_REED_SOLOMON_DEC16=y
CONFIG_BCH=m
CONFIG_RADIX_TREE_MULTIORDER=y
CONFIG_ASSOCIATIVE_ARRAY=y
CONFIG_HAS_IOMEM=y
CONFIG_HAS_IOPORT_MAP=y
CONFIG_HAS_DMA=y
CONFIG_SGL_ALLOC=y
# CONFIG_DMA_DIRECT_OPS is not set
# CONFIG_DMA_VIRT_OPS is not set
CONFIG_CHECK_SIGNATURE=y
CONFIG_CPU_RMAP=y
CONFIG_DQL=y
CONFIG_GLOB=y
# CONFIG_GLOB_SELFTEST is not set
CONFIG_NLATTR=y
CONFIG_CLZ_TAB=y
CONFIG_CORDIC=y
# CONFIG_DDR is not set
CONFIG_IRQ_POLL=y
CONFIG_MPILIB=y
CONFIG_OID_REGISTRY=y
# CONFIG_SG_SPLIT is not set
CONFIG_SG_POOL=y
CONFIG_ARCH_HAS_SG_CHAIN=y
CONFIG_ARCH_HAS_PMEM_API=y
CONFIG_ARCH_HAS_UACCESS_FLUSHCACHE=y
CONFIG_STACKDEPOT=y
CONFIG_SBITMAP=y
CONFIG_STRING_SELFTEST=y

--------------A3949C00DD8EFFA86862B870--
