From: Kees Cook <keescook@chromium.org>
Subject: Re: [PATCH v2 0/6] MIPS seccomp_bpf self test and fixups
Date: Tue, 29 Mar 2016 22:06:37 -0700
Message-ID: <CAGXu5jLJEHzB3ST63g0fApVP4-OWwCT5UcqguAMNoGy-aQXgew@mail.gmail.com>
References: <1459240534-8658-1-git-send-email-matt.redfearn@imgtec.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-ig0-f170.google.com ([209.85.213.170]:35833 "EHLO
	mail-ig0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751028AbcC3FGi (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Wed, 30 Mar 2016 01:06:38 -0400
Received: by mail-ig0-f170.google.com with SMTP id cl4so92806163igb.0
        for <linux-arch@vger.kernel.org>; Tue, 29 Mar 2016 22:06:38 -0700 (PDT)
In-Reply-To: <1459240534-8658-1-git-send-email-matt.redfearn@imgtec.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Matt Redfearn <matt.redfearn@imgtec.com>
Cc: IMG-MIPSLinuxKerneldevelopers@imgtec.com, Linux MIPS Mailing List <linux-mips@linux-mips.org>, Arnd Bergmann <arnd@arndb.de>, Andy Lutomirski <luto@amacapital.net>, LKML <linux-kernel@vger.kernel.org>, Shuah Khan <shuahkh@osg.samsung.com>, Eric B Munson <emunson@akamai.com>, James Hogan <james.hogan@imgtec.com>, Andrew Morton <akpm@linux-foundation.org>, linux-kselftest@vger.kernel.org, linux-arch <linux-arch@vger.kernel.org>, Markos Chandras <markos.chandras@imgtec.com>, Amanieu d'Antras <amanieu@gmail.com>, Ralf Baechle <ralf@linux-mips.org>, Alex Smith <alex.smith@imgtec.com>, Paul Burton <paul.burton@imgtec.com>, Will Drewry <wad@chromium.org>

On Tue, Mar 29, 2016 at 1:35 AM, Matt Redfearn <matt.redfearn@imgtec.com> wrote:
> These patches imporve seccomp support on MIPS.
>
> Firstly support is added for building the seccomp_bpf self test for
> MIPS. The
> initial results of these tests were:
>
> 32bit kernel O32 userspace before: 48 / 48 pass
> 64bit kernel O32 userspace before: 47 / 48 pass
>  Failures: TRAP.Handler
> 64bit kernel N32 userspace before: 44 / 48 pass
>  Failures: global.mode_strict_support, TRAP.handler,
> TRACE_syscall.syscall_redirected, TRACE_syscall.syscall_dropped
> 64bit kernel N64 userspace before: 46 / 48 pass
>  Failures: TRACE_syscall.syscall_redirected,
> TRACE_syscall.syscall_dropped
>
> The subsequent patches fix issues that were causing the above tests to
> fail. With
> these fixes, the results are:
> 32bit kernel O32 userspace after: 48 / 48
> 64bit kernel O32 userspace after: 48 / 48
> 64bit kernel N32 userspace after: 48 / 48
> 64bit kernel N64 userspace after: 48 / 48
>
> Thanks,
> Matt
>
> Changes in v2:
> - Tested on additional platforms
> - Replace __NR_syscall which isn't defined for N32 / N64 ABIs
>
> Matt Redfearn (6):
>   selftests/seccomp: add MIPS self-test support
>   MIPS: Support sending SIG_SYS to 32bit userspace from 64bit kernel
>   MIPS: scall: Handle seccomp filters which redirect syscalls
>   seccomp: Get compat syscalls from asm-generic header
>   MIPS: seccomp: Support compat with both O32 and N32
>   secomp: Constify mode1 syscall whitelist
>
>  arch/mips/include/asm/seccomp.h               | 47 +++++++++++++++------------
>  arch/mips/kernel/scall32-o32.S                | 11 +++----
>  arch/mips/kernel/scall64-64.S                 |  3 +-
>  arch/mips/kernel/scall64-n32.S                | 14 +++++---
>  arch/mips/kernel/scall64-o32.S                | 14 +++++---
>  arch/mips/kernel/signal32.c                   |  6 ++++
>  include/asm-generic/seccomp.h                 | 14 ++++++++
>  kernel/seccomp.c                              | 13 ++------
>  tools/testing/selftests/seccomp/seccomp_bpf.c | 30 +++++++++++++++--
>  9 files changed, 101 insertions(+), 51 deletions(-)

Thanks for digging into this! Consider all the seccomp pieces:

Acked-by: Kees Cook <keescook@chromium.org>

Probably best to carry it all in the MIPS tree, but if you want to me
take pieces of it into my seccomp tree, I can do that. Up to you. :)

-Kees

-- 
Kees Cook
Chrome OS & Brillo Security
