From: Yury Norov <ynorov@caviumnetworks.com>
Subject: Re: ILP32 for ARM64 - testing with lmbench
Date: Fri, 28 Oct 2016 15:46:59 +0300
Message-ID: <20161028124659.GA24131@yury-N73SV>
References: <1477081997-4770-1-git-send-email-ynorov@caviumnetworks.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 8bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-sn1nam02on0042.outbound.protection.outlook.com ([104.47.36.42]:1484
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752126AbcJ1MrN (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Fri, 28 Oct 2016 08:47:13 -0400
Content-Disposition: inline
In-Reply-To: <1477081997-4770-1-git-send-email-ynorov@caviumnetworks.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: arnd@arndb.de, catalin.marinas@arm.com, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, linux-arch@vger.kernel.org
Cc: schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com, pinskia@gmail.com, broonie@kernel.org, joseph@codesourcery.com, christoph.muellner@theobroma-systems.com, bamvor.zhangjian@huawei.com, szabolcs.nagy@arm.com, klimov.linux@gmail.com, Nathan_Lynch@mentor.com, agraf@suse.de, Prasun.Kapoor@caviumnetworks.com, kilobyte@angband.pl, geert@linux-m68k.org, philipp.tomsich@theobroma-systems.com, manuel.montezelo@gmail.com, linyongting@huawei.com, maxim.kuvyrkov@linaro.org, davem@davemloft.net, zhouchengming1@huawei.com, cmetcalf@ezchip.com, sellcey@caviumnetworks.com

[Add Steve Ellcey, thanks for testing on ThunderX]

Lmbench-3.0-a9 testing is performed on ThunderX machine to check that
ILP32 series does not add performance regressions for LP64. Test
summary is in the table below. Our measurements doesn't show
significant performance regression of LP64 if ILP32 code is merged,
both enabled or disabled.

               ILP32 enabled   ILP32  disabled   Standard Kernel 
null syscall   0.1066          0.1121            0.1121
               95.09%          100.00%

stat           1.3947          1.3814            1.3864
               100.60%         99.64%

fstat          0.4459          0.4344            0.4524
               98.56%          96.02%

open/close     4.0606          4.0411            4.0453
               100.38%         99.90%

read           0.4819          0.5014            0.5014
               96.11%          100.00%

Tested with linux 4.8 because 4.9-rc1 is not fixed yet for ThunderX.
Other system details below.

Yury.

ubuntu@crb6:~$ uname -a
Linux crb6 4.8.0+ #3 SMP Thu Oct 27 11:01:32 PDT 2016 aarch64 aarch64 aarch64 GNU/Linux

ubuntu@crb6:~$ cat /proc/meminfo
MemTotal:       132011948 kB
MemFree:        131442672 kB
MemAvailable:   130695764 kB
Buffers:           15696 kB
Cached:            88088 kB
SwapCached:            0 kB
Active:            82760 kB
Inactive:          41336 kB
Active(anon):      20880 kB
Inactive(anon):     8576 kB
Active(file):      61880 kB
Inactive(file):    32760 kB
Unevictable:           0 kB
Mlocked:               0 kB
SwapTotal:      128920572 kB
SwapFree:       128920572 kB
Dirty:                 0 kB
Writeback:             0 kB
AnonPages:         20544 kB
Mapped:            19780 kB
Shmem:              9060 kB
Slab:              78804 kB
SReclaimable:      27372 kB
SUnreclaim:        51432 kB
KernelStack:        8336 kB
PageTables:          820 kB
NFS_Unstable:          0 kB
Bounce:                0 kB
WritebackTmp:          0 kB
CommitLimit:    194926544 kB
Committed_AS:     256324 kB
VmallocTotal:   135290290112 kB
VmallocUsed:           0 kB
VmallocChunk:          0 kB
AnonHugePages:         0 kB
ShmemHugePages:        0 kB
ShmemPmdMapped:        0 kB
CmaTotal:              0 kB
CmaFree:               0 kB
HugePages_Total:       0
HugePages_Free:        0
HugePages_Rsvd:        0
HugePages_Surp:        0
Hugepagesize:       2048 kB

ubuntu@crb6:~$ cat /proc/cpuinfo
processor	: 0
BogoMIPS	: 200.00
Features	: fp asimd evtstrm aes pmull sha1 sha2 crc32 atomics
CPU implementer	: 0x43
CPU architecture: 8
CPU variant	: 0x1
CPU part	: 0x0a1
CPU revision	: 0

processor	: 1
BogoMIPS	: 200.00
Features	: fp asimd evtstrm aes pmull sha1 sha2 crc32 atomics
CPU implementer	: 0x43
CPU architecture: 8
CPU variant	: 0x1
CPU part	: 0x0a1
CPU revision	: 0

processor	: 2
BogoMIPS	: 200.00
Features	: fp asimd evtstrm aes pmull sha1 sha2 crc32 atomics
CPU implementer	: 0x43
CPU architecture: 8
CPU variant	: 0x1
CPU part	: 0x0a1
CPU revision	: 0

processor	: 3
BogoMIPS	: 200.00
Features	: fp asimd evtstrm aes pmull sha1 sha2 crc32 atomics
CPU implementer	: 0x43
CPU architecture: 8
CPU variant	: 0x1
CPU part	: 0x0a1
CPU revision	: 0

processor	: 4
BogoMIPS	: 200.00
Features	: fp asimd evtstrm aes pmull sha1 sha2 crc32 atomics
CPU implementer	: 0x43
CPU architecture: 8
CPU variant	: 0x1
CPU part	: 0x0a1
CPU revision	: 0

processor	: 5
BogoMIPS	: 200.00
Features	: fp asimd evtstrm aes pmull sha1 sha2 crc32 atomics
CPU implementer	: 0x43
CPU architecture: 8
CPU variant	: 0x1
CPU part	: 0x0a1
CPU revision	: 0

processor	: 6
BogoMIPS	: 200.00
Features	: fp asimd evtstrm aes pmull sha1 sha2 crc32 atomics
CPU implementer	: 0x43
CPU architecture: 8
CPU variant	: 0x1
CPU part	: 0x0a1
CPU revision	: 0

processor	: 7
BogoMIPS	: 200.00
Features	: fp asimd evtstrm aes pmull sha1 sha2 crc32 atomics
CPU implementer	: 0x43
CPU architecture: 8
CPU variant	: 0x1
CPU part	: 0x0a1
CPU revision	: 0

processor	: 8
BogoMIPS	: 200.00
Features	: fp asimd evtstrm aes pmull sha1 sha2 crc32 atomics
CPU implementer	: 0x43
CPU architecture: 8
CPU variant	: 0x1
CPU part	: 0x0a1
CPU revision	: 0

processor	: 9
BogoMIPS	: 200.00
Features	: fp asimd evtstrm aes pmull sha1 sha2 crc32 atomics
CPU implementer	: 0x43
CPU architecture: 8
CPU variant	: 0x1
CPU part	: 0x0a1
CPU revision	: 0

processor	: 10
BogoMIPS	: 200.00
Features	: fp asimd evtstrm aes pmull sha1 sha2 crc32 atomics
CPU implementer	: 0x43
CPU architecture: 8
CPU variant	: 0x1
CPU part	: 0x0a1
CPU revision	: 0

processor	: 11
BogoMIPS	: 200.00
Features	: fp asimd evtstrm aes pmull sha1 sha2 crc32 atomics
CPU implementer	: 0x43
CPU architecture: 8
CPU variant	: 0x1
CPU part	: 0x0a1
CPU revision	: 0

processor	: 12
BogoMIPS	: 200.00
Features	: fp asimd evtstrm aes pmull sha1 sha2 crc32 atomics
CPU implementer	: 0x43
CPU architecture: 8
CPU variant	: 0x1
CPU part	: 0x0a1
CPU revision	: 0

processor	: 13
BogoMIPS	: 200.00
Features	: fp asimd evtstrm aes pmull sha1 sha2 crc32 atomics
CPU implementer	: 0x43
CPU architecture: 8
CPU variant	: 0x1
CPU part	: 0x0a1
CPU revision	: 0

processor	: 14
BogoMIPS	: 200.00
Features	: fp asimd evtstrm aes pmull sha1 sha2 crc32 atomics
CPU implementer	: 0x43
CPU architecture: 8
CPU variant	: 0x1
CPU part	: 0x0a1
CPU revision	: 0

processor	: 15
BogoMIPS	: 200.00
Features	: fp asimd evtstrm aes pmull sha1 sha2 crc32 atomics
CPU implementer	: 0x43
CPU architecture: 8
CPU variant	: 0x1
CPU part	: 0x0a1
CPU revision	: 0

processor	: 16
BogoMIPS	: 200.00
Features	: fp asimd evtstrm aes pmull sha1 sha2 crc32 atomics
CPU implementer	: 0x43
CPU architecture: 8
CPU variant	: 0x1
CPU part	: 0x0a1
CPU revision	: 0

processor	: 17
BogoMIPS	: 200.00
Features	: fp asimd evtstrm aes pmull sha1 sha2 crc32 atomics
CPU implementer	: 0x43
CPU architecture: 8
CPU variant	: 0x1
CPU part	: 0x0a1
CPU revision	: 0

processor	: 18
BogoMIPS	: 200.00
Features	: fp asimd evtstrm aes pmull sha1 sha2 crc32 atomics
CPU implementer	: 0x43
CPU architecture: 8
CPU variant	: 0x1
CPU part	: 0x0a1
CPU revision	: 0

processor	: 19
BogoMIPS	: 200.00
Features	: fp asimd evtstrm aes pmull sha1 sha2 crc32 atomics
CPU implementer	: 0x43
CPU architecture: 8
CPU variant	: 0x1
CPU part	: 0x0a1
CPU revision	: 0

processor	: 20
BogoMIPS	: 200.00
Features	: fp asimd evtstrm aes pmull sha1 sha2 crc32 atomics
CPU implementer	: 0x43
CPU architecture: 8
CPU variant	: 0x1
CPU part	: 0x0a1
CPU revision	: 0

processor	: 21
BogoMIPS	: 200.00
Features	: fp asimd evtstrm aes pmull sha1 sha2 crc32 atomics
CPU implementer	: 0x43
CPU architecture: 8
CPU variant	: 0x1
CPU part	: 0x0a1
CPU revision	: 0

processor	: 22
BogoMIPS	: 200.00
Features	: fp asimd evtstrm aes pmull sha1 sha2 crc32 atomics
CPU implementer	: 0x43
CPU architecture: 8
CPU variant	: 0x1
CPU part	: 0x0a1
CPU revision	: 0

processor	: 23
BogoMIPS	: 200.00
Features	: fp asimd evtstrm aes pmull sha1 sha2 crc32 atomics
CPU implementer	: 0x43
CPU architecture: 8
CPU variant	: 0x1
CPU part	: 0x0a1
CPU revision	: 0

processor	: 24
BogoMIPS	: 200.00
Features	: fp asimd evtstrm aes pmull sha1 sha2 crc32 atomics
CPU implementer	: 0x43
CPU architecture: 8
CPU variant	: 0x1
CPU part	: 0x0a1
CPU revision	: 0

processor	: 25
BogoMIPS	: 200.00
Features	: fp asimd evtstrm aes pmull sha1 sha2 crc32 atomics
CPU implementer	: 0x43
CPU architecture: 8
CPU variant	: 0x1
CPU part	: 0x0a1
CPU revision	: 0

processor	: 26
BogoMIPS	: 200.00
Features	: fp asimd evtstrm aes pmull sha1 sha2 crc32 atomics
CPU implementer	: 0x43
CPU architecture: 8
CPU variant	: 0x1
CPU part	: 0x0a1
CPU revision	: 0

processor	: 27
BogoMIPS	: 200.00
Features	: fp asimd evtstrm aes pmull sha1 sha2 crc32 atomics
CPU implementer	: 0x43
CPU architecture: 8
CPU variant	: 0x1
CPU part	: 0x0a1
CPU revision	: 0

processor	: 28
BogoMIPS	: 200.00
Features	: fp asimd evtstrm aes pmull sha1 sha2 crc32 atomics
CPU implementer	: 0x43
CPU architecture: 8
CPU variant	: 0x1
CPU part	: 0x0a1
CPU revision	: 0

processor	: 29
BogoMIPS	: 200.00
Features	: fp asimd evtstrm aes pmull sha1 sha2 crc32 atomics
CPU implementer	: 0x43
CPU architecture: 8
CPU variant	: 0x1
CPU part	: 0x0a1
CPU revision	: 0

processor	: 30
BogoMIPS	: 200.00
Features	: fp asimd evtstrm aes pmull sha1 sha2 crc32 atomics
CPU implementer	: 0x43
CPU architecture: 8
CPU variant	: 0x1
CPU part	: 0x0a1
CPU revision	: 0

processor	: 31
BogoMIPS	: 200.00
Features	: fp asimd evtstrm aes pmull sha1 sha2 crc32 atomics
CPU implementer	: 0x43
CPU architecture: 8
CPU variant	: 0x1
CPU part	: 0x0a1
CPU revision	: 0

processor	: 32
BogoMIPS	: 200.00
Features	: fp asimd evtstrm aes pmull sha1 sha2 crc32 atomics
CPU implementer	: 0x43
CPU architecture: 8
CPU variant	: 0x1
CPU part	: 0x0a1
CPU revision	: 0

processor	: 33
BogoMIPS	: 200.00
Features	: fp asimd evtstrm aes pmull sha1 sha2 crc32 atomics
CPU implementer	: 0x43
CPU architecture: 8
CPU variant	: 0x1
CPU part	: 0x0a1
CPU revision	: 0

processor	: 34
BogoMIPS	: 200.00
Features	: fp asimd evtstrm aes pmull sha1 sha2 crc32 atomics
CPU implementer	: 0x43
CPU architecture: 8
CPU variant	: 0x1
CPU part	: 0x0a1
CPU revision	: 0

processor	: 35
BogoMIPS	: 200.00
Features	: fp asimd evtstrm aes pmull sha1 sha2 crc32 atomics
CPU implementer	: 0x43
CPU architecture: 8
CPU variant	: 0x1
CPU part	: 0x0a1
CPU revision	: 0

processor	: 36
BogoMIPS	: 200.00
Features	: fp asimd evtstrm aes pmull sha1 sha2 crc32 atomics
CPU implementer	: 0x43
CPU architecture: 8
CPU variant	: 0x1
CPU part	: 0x0a1
CPU revision	: 0

processor	: 37
BogoMIPS	: 200.00
Features	: fp asimd evtstrm aes pmull sha1 sha2 crc32 atomics
CPU implementer	: 0x43
CPU architecture: 8
CPU variant	: 0x1
CPU part	: 0x0a1
CPU revision	: 0

processor	: 38
BogoMIPS	: 200.00
Features	: fp asimd evtstrm aes pmull sha1 sha2 crc32 atomics
CPU implementer	: 0x43
CPU architecture: 8
CPU variant	: 0x1
CPU part	: 0x0a1
CPU revision	: 0

processor	: 39
BogoMIPS	: 200.00
Features	: fp asimd evtstrm aes pmull sha1 sha2 crc32 atomics
CPU implementer	: 0x43
CPU architecture: 8
CPU variant	: 0x1
CPU part	: 0x0a1
CPU revision	: 0

processor	: 40
BogoMIPS	: 200.00
Features	: fp asimd evtstrm aes pmull sha1 sha2 crc32 atomics
CPU implementer	: 0x43
CPU architecture: 8
CPU variant	: 0x1
CPU part	: 0x0a1
CPU revision	: 0

processor	: 41
BogoMIPS	: 200.00
Features	: fp asimd evtstrm aes pmull sha1 sha2 crc32 atomics
CPU implementer	: 0x43
CPU architecture: 8
CPU variant	: 0x1
CPU part	: 0x0a1
CPU revision	: 0

processor	: 42
BogoMIPS	: 200.00
Features	: fp asimd evtstrm aes pmull sha1 sha2 crc32 atomics
CPU implementer	: 0x43
CPU architecture: 8
CPU variant	: 0x1
CPU part	: 0x0a1
CPU revision	: 0

processor	: 43
BogoMIPS	: 200.00
Features	: fp asimd evtstrm aes pmull sha1 sha2 crc32 atomics
CPU implementer	: 0x43
CPU architecture: 8
CPU variant	: 0x1
CPU part	: 0x0a1
CPU revision	: 0

processor	: 44
BogoMIPS	: 200.00
Features	: fp asimd evtstrm aes pmull sha1 sha2 crc32 atomics
CPU implementer	: 0x43
CPU architecture: 8
CPU variant	: 0x1
CPU part	: 0x0a1
CPU revision	: 0

processor	: 45
BogoMIPS	: 200.00
Features	: fp asimd evtstrm aes pmull sha1 sha2 crc32 atomics
CPU implementer	: 0x43
CPU architecture: 8
CPU variant	: 0x1
CPU part	: 0x0a1
CPU revision	: 0

processor	: 46
BogoMIPS	: 200.00
Features	: fp asimd evtstrm aes pmull sha1 sha2 crc32 atomics
CPU implementer	: 0x43
CPU architecture: 8
CPU variant	: 0x1
CPU part	: 0x0a1
CPU revision	: 0

processor	: 47
BogoMIPS	: 200.00
Features	: fp asimd evtstrm aes pmull sha1 sha2 crc32 atomics
CPU implementer	: 0x43
CPU architecture: 8
CPU variant	: 0x1
CPU part	: 0x0a1
CPU revision	: 0
