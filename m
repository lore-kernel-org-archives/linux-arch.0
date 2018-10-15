Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from alln-iport-5.cisco.com ([173.37.142.92]:9115 "EHLO
        alln-iport-5.cisco.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726704AbeJPCDC (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 15 Oct 2018 22:03:02 -0400
Subject: Re: [PATCH] kernel/signal: Signal-based pre-coredump notification
References: <e7ed306f-8992-9d00-bcab-5131159e8d89@cisco.com>
 <20181013064023.GA28177@kroah.com>
From: Enke Chen <enkechen@cisco.com>
Message-ID: <37401cea-5a37-2cd9-8595-8b07dfc4de7d@cisco.com>
Date: Mon, 15 Oct 2018 11:16:36 -0700
MIME-Version: 1.0
In-Reply-To: <20181013064023.GA28177@kroah.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org, Peter Zijlstra <peterz@infradead.org>, Arnd Bergmann <arnd@arndb.de>, "Eric W. Biederman" <ebiederm@xmission.com>, Khalid Aziz <khalid.aziz@oracle.com>, Kate Stewart <kstewart@linuxfoundation.org>, Helge Deller <deller@gmx.de>, Al Viro <viro@zeniv.linux.org.uk>, Andrew Morton <akpm@linux-foundation.org>, Christian Brauner <christian@brauner.io>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, Dave Martin <Dave.Martin@arm.com>, Mauro Carvalho Chehab <mchehab+samsung@kernel.org>, Michal Hocko <mhocko@kernel.org>, Rik van Riel <riel@surriel.com>, "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>, Roman Gushchin <guro@fb.com>, Marcos Paulo de Souza <marcos.souza.org@gmail.com>, Oleg Nesterov <oleg@redhat.com>, Dominik Brodowski <linux@dominikbrodowski.net>, Cyrill Gorcunov <gorcunov@openvz.org>, Yang Shi <yang.shi@linux.alibaba.com>, Jann Horn <jannh@google.com>, Kees Cook <keescook@chromium.org>, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, "Victor Kamensky (kamensky)" <kamensky@cisco.com>, xe-linux-external@cisco.com, Stefan Strogin <sstrogin@cisco.com>, Enke Chen <enkechen@cisco.com>
Message-ID: <20181015181636.TmhRvNj58l9AKy2njd0XmGAgdqmxgfpR65r70bXuN50@z>

Hi, Greg:

> Shouldn't there also be a manpage update, and a kselftest added for this
> new user/kernel api that is being created?
> 

I will submit a patch for manpage update once the code is accepted.

Regarding the kselftest, I am not sure.  Once the prctl() is limited to
self (which I will do), the logic would be pretty straightforward. Not
sure if the selftest would add much value.

Thanks.  -- Enke

On 10/12/18 11:40 PM, Greg Kroah-Hartman wrote:
> On Fri, Oct 12, 2018 at 05:33:35PM -0700, Enke Chen wrote:
>> For simplicity and consistency, this patch provides an implementation
>> for signal-based fault notification prior to the coredump of a child
>> process. A new prctl command, PR_SET_PREDUMP_SIG, is defined that can
>> be used by an application to express its interest and to specify the
>> signal (SIGCHLD or SIGUSR1 or SIGUSR2) for such a notification. A new
>> signal code (si_code), CLD_PREDUMP, is also defined for SIGCHLD.
>>
>> Background:
>>
>> As the coredump of a process may take time, in certain time-sensitive
>> applications it is necessary for a parent process (e.g., a process
>> manager) to be notified of a child's imminent death before the coredump
>> so that the parent process can act sooner, such as re-spawning an
>> application process, or initiating a control-plane fail-over.
>>
>> Currently there are two ways for a parent process to be notified of a
>> child process's state change. One is to use the POSIX signal, and
>> another is to use the kernel connector module. The specific events and
>> actions are summarized as follows:
>>
>> Process Event    POSIX Signal                Connector-based
>> ----------------------------------------------------------------------
>> ptrace_attach()  do_notify_parent_cldstop()  proc_ptrace_connector()
>>                  SIGCHLD / CLD_STOPPED
>>
>> ptrace_detach()  do_notify_parent_cldstop()  proc_ptrace_connector()
>>                  SIGCHLD / CLD_CONTINUED
>>
>> pre_coredump/    N/A                         proc_coredump_connector()
>> get_signal()
>>
>> post_coredump/   do_notify_parent()          proc_exit_connector()
>> do_exit()        SIGCHLD / exit_signal
>> ----------------------------------------------------------------------
>>
>> As shown in the table, the signal-based pre-coredump notification is not
>> currently available. In some cases using a connector-based notification
>> can be quite complicated (e.g., when a process manager is written in shell
>> scripts and thus is subject to certain inherent limitations), and a
>> signal-based notification would be simpler and better suited.
>>
>> Signed-off-by: Enke Chen <enkechen@cisco.com>
>> ---
>>  arch/x86/kernel/signal_compat.c    |  2 +-
>>  include/linux/sched.h              |  4 ++
>>  include/linux/signal.h             |  5 +++
>>  include/uapi/asm-generic/siginfo.h |  3 +-
>>  include/uapi/linux/prctl.h         |  4 ++
>>  kernel/fork.c                      |  1 +
>>  kernel/signal.c                    | 51 +++++++++++++++++++++++++
>>  kernel/sys.c                       | 77 ++++++++++++++++++++++++++++++++++++++
>>  8 files changed, 145 insertions(+), 2 deletions(-)
> 
> Shouldn't there also be a manpage update, and a kselftest added for this
> new user/kernel api that is being created?
> 
> thanks,
> 
> greg k-h
> 
