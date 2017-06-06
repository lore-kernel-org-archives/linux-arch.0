From: Babu Moger <babu.moger@oracle.com>
Subject: Re: [PATCH 0/4][V3] Improve watchdog config for arch watchdogs
Date: Tue, 6 Jun 2017 14:46:48 -0500
Message-ID: <d274b1a5-c8b3-9e3a-b45d-c63c9022be91@oracle.com>
References: <20170530012659.16791-1-npiggin@gmail.com>
 <20170606160847.izishwer3m5jirkb@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170606160847.izishwer3m5jirkb@redhat.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Don Zickus <dzickus@redhat.com>, Nicholas Piggin <npiggin@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
List-Id: linux-arch.vger.kernel.org

Hi Don, Nicholas,


On 6/6/2017 11:08 AM, Don Zickus wrote:
> (adding Babu)
>
> On Tue, May 30, 2017 at 11:26:55AM +1000, Nicholas Piggin wrote:
>> Since last time:
>>
>> - Have the perf based hardlockup detector use arch_touch_nmi_watchdog()
>>    rather than hld_touch_nmi_watchdog(). This changes direction slightly
>>    to make the perf-based hard lockup detector an alternative that an
>>    arch may select, rather than standalone. This better reflects how the
>>    code works in practice).
>>
>> - Hopefully fixed the Kconfig options. There's still a bit of ugliness
>>    that will require another pass or two over interfaces and config
>>    scheme, but the idea is to make a minimal change to get the powerpc
>>    HLD in, which gives a reasonable starting point to improve things
>>    further.
> Hi Babu,
>
> Does this patchset break sparc?  Specifically patch3 with all the config
Patches applies, compiles fine and also works fine for most part. 
However, there are few issues.

We need to enter 'N' or 'Y'  for SOFTLOCKUP_DETECTOR.

*
* Restart config...
*
*
* Debug Lockups and Hangs
*
Detect Hard and Soft Lockups (LOCKUP_DETECTOR) [Y/n/?] y
   Detect Soft Lockups (SOFTLOCKUP_DETECTOR) [N/y] (NEW)

For SPARC, softlockup is enabled by default earlier.   May be we need to 
submit another patch to enable this in

arch/sparc/configs/sparc64_defconfig.   Not  a big issue.


Another issue.
before that patch

# cat /proc/sys/kernel/watchdog
1
# cat /proc/sys/kernel/nmi_watchdog
1

After the patch

# cat /proc/sys/kernel/watchdog
1
# cat /proc/sys/kernel/nmi_watchdog
0

I think this is mostly due to change in this code below.

#ifdef CONFIG_HARDLOCKUP_DETECTOR
unsigned long __read_mostly watchdog_enabled = 
SOFT_WATCHDOG_ENABLED|NMI_WATCHDOG_ENABLED;

Old code was like this

#if defined(CONFIG_HAVE_NMI_WATCHDOG) || defined(CONFIG_HARDLOCKUP_DETECTOR)
unsigned long __read_mostly watchdog_enabled = 
SOFT_WATCHDOG_ENABLED|NMI_WATCHDOG_ENABLED;
#else
unsigned long __read_mostly watchdog_enabled = SOFT_WATCHDOG_ENABLED;
#endif

SPARC defines CONFIG_HAVE_NMI_WATCHDOG.

Thanks
Babu

> option changes?
>
> Cheers,
> Don
>
>> Nicholas Piggin (4):
>>    watchdog: remove unused declaration
>>    watchdog: Introduce arch_touch_nmi_watchdog()
>>    watchdog: Split up config options
>>    watchdog: Provide watchdog_reconfigure() for arch watchdogs
>>
>>   arch/blackfin/include/asm/nmi.h            |   2 +
>>   arch/blackfin/kernel/nmi.c                 |   2 +-
>>   arch/mn10300/include/asm/nmi.h             |   2 +
>>   arch/mn10300/kernel/mn10300-watchdog-low.S |   8 +-
>>   arch/mn10300/kernel/mn10300-watchdog.c     |   2 +-
>>   arch/powerpc/kernel/setup_64.c             |   2 +-
>>   arch/sparc/include/asm/nmi.h               |   1 +
>>   arch/sparc/kernel/nmi.c                    |   6 +-
>>   arch/x86/kernel/apic/hw_nmi.c              |   2 +-
>>   include/linux/nmi.h                        |  57 ++++---
>>   kernel/Makefile                            |   2 +-
>>   kernel/sysctl.c                            |  18 +-
>>   kernel/watchdog.c                          | 263 +++++++++++++++++++----------
>>   kernel/watchdog_hld.c                      |  37 +---
>>   lib/Kconfig.debug                          |  29 +++-
>>   15 files changed, 263 insertions(+), 170 deletions(-)
>>
>> -- 
>> 2.11.0
>>
