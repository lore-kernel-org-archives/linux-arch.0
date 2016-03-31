From: Matt Redfearn <matt.redfearn@imgtec.com>
Subject: Re: [PATCH v2 0/6] MIPS seccomp_bpf self test and fixups
Date: Thu, 31 Mar 2016 09:57:33 +0100
Message-ID: <56FCE67D.70800@imgtec.com>
References: <1459240534-8658-1-git-send-email-matt.redfearn@imgtec.com>
 <CAGXu5jLJEHzB3ST63g0fApVP4-OWwCT5UcqguAMNoGy-aQXgew@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mailapp01.imgtec.com ([195.59.15.196]:6564 "EHLO
	mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752720AbcCaI5g (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Thu, 31 Mar 2016 04:57:36 -0400
In-Reply-To: <CAGXu5jLJEHzB3ST63g0fApVP4-OWwCT5UcqguAMNoGy-aQXgew@mail.gmail.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Kees Cook <keescook@chromium.org>
Cc: Linux MIPS Mailing List <linux-mips@linux-mips.org>, Arnd Bergmann <arnd@arndb.de>, Andy Lutomirski <luto@amacapital.net>, LKML <linux-kernel@vger.kernel.org>, Shuah Khan <shuahkh@osg.samsung.com>, Eric B Munson <emunson@akamai.com>, James Hogan <james.hogan@imgtec.com>, Andrew Morton <akpm@linux-foundation.org>, linux-kselftest@vger.kernel.org, linux-arch <linux-arch@vger.kernel.org>, Markos Chandras <markos.chandras@imgtec.com>, Amanieu d'Antras <amanieu@gmail.com>, Ralf Baechle <ralf@linux-mips.org>, Alex Smith <alex.smith@imgtec.com>, Paul Burton <paul.burton@imgtec.com>, Will Drewry <wad@chromium.org>



On 30/03/16 06:06, Kees Cook wrote:
> On Tue, Mar 29, 2016 at 1:35 AM, Matt Redfearn <matt.redfearn@imgtec.com> wrote:
>> These patches imporve seccomp support on MIPS.
>>
>> Firstly support is added for building the seccomp_bpf self test for
>> MIPS. The
>> initial results of these tests were:
>>
>> 32bit kernel O32 userspace before: 48 / 48 pass
>> 64bit kernel O32 userspace before: 47 / 48 pass
>>   Failures: TRAP.Handler
>> 64bit kernel N32 userspace before: 44 / 48 pass
>>   Failures: global.mode_strict_support, TRAP.handler,
>> TRACE_syscall.syscall_redirected, TRACE_syscall.syscall_dropped
>> 64bit kernel N64 userspace before: 46 / 48 pass
>>   Failures: TRACE_syscall.syscall_redirected,
>> TRACE_syscall.syscall_dropped
>>
>> The subsequent patches fix issues that were causing the above tests to
>> fail. With
>> these fixes, the results are:
>> 32bit kernel O32 userspace after: 48 / 48
>> 64bit kernel O32 userspace after: 48 / 48
>> 64bit kernel N32 userspace after: 48 / 48
>> 64bit kernel N64 userspace after: 48 / 48
>>
>> Thanks,
>> Matt
>>
>> Changes in v2:
>> - Tested on additional platforms
>> - Replace __NR_syscall which isn't defined for N32 / N64 ABIs
>>
>> Matt Redfearn (6):
>>    selftests/seccomp: add MIPS self-test support
>>    MIPS: Support sending SIG_SYS to 32bit userspace from 64bit kernel
>>    MIPS: scall: Handle seccomp filters which redirect syscalls
>>    seccomp: Get compat syscalls from asm-generic header
>>    MIPS: seccomp: Support compat with both O32 and N32
>>    secomp: Constify mode1 syscall whitelist
>>
>>   arch/mips/include/asm/seccomp.h               | 47 +++++++++++++++------------
>>   arch/mips/kernel/scall32-o32.S                | 11 +++----
>>   arch/mips/kernel/scall64-64.S                 |  3 +-
>>   arch/mips/kernel/scall64-n32.S                | 14 +++++---
>>   arch/mips/kernel/scall64-o32.S                | 14 +++++---
>>   arch/mips/kernel/signal32.c                   |  6 ++++
>>   include/asm-generic/seccomp.h                 | 14 ++++++++
>>   kernel/seccomp.c                              | 13 ++------
>>   tools/testing/selftests/seccomp/seccomp_bpf.c | 30 +++++++++++++++--
>>   9 files changed, 101 insertions(+), 51 deletions(-)
> Thanks for digging into this! Consider all the seccomp pieces:
>
> Acked-by: Kees Cook <keescook@chromium.org>
>
> Probably best to carry it all in the MIPS tree, but if you want to me
> take pieces of it into my seccomp tree, I can do that. Up to you. :)
>
> -Kees
>
Thanks Kees. Ralf is going to take it via the MIPS tree.

Matt
