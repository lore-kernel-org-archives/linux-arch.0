From: Michal Simek <michal.simek@xilinx.com>
Subject: Re: [PATCH 1/3] microblaze: Replace NR_syscalls macro from
 asm/unistd.h
Date: Tue, 2 Oct 2018 09:07:25 +0200
Message-ID: <89533601-366f-ebf4-dc31-996bc649bc51@xilinx.com>
References: <1533792466-4227-1-git-send-email-firoz.khan@linaro.org>
 <1533792466-4227-2-git-send-email-firoz.khan@linaro.org>
 <f1e95c4d-4f02-263d-7f35-cc87bc657fbb@xilinx.com>
 <CALxhOnho6av7nZja_MN4akQuVj1hVq753ZYgRM8fbKkL2rHzQw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CALxhOnho6av7nZja_MN4akQuVj1hVq753ZYgRM8fbKkL2rHzQw@mail.gmail.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Firoz Khan <firoz.khan@linaro.org>, Michal Simek <michal.simek@xilinx.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Philippe Ombredanne <pombredanne@nexb.com>, Thomas Gleixner <tglx@linutronix.de>, Kate Stewart <kstewart@linuxfoundation.org>, y2038@lists.linaro.org, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>, Deepa Dinamani <deepa.kernel@gmail.com>, Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>
List-Id: linux-arch.vger.kernel.org

On 18.9.2018 08:37, Firoz Khan wrote:
> On 9 August 2018 at 12:18, Michal Simek <michal.simek@xilinx.com> wrote:
>> On 9.8.2018 07:27, Firoz Khan wrote:
>>> __NR_syscalls macro holds the number of system call exist in this
>>> architecture. This macro is currently the part of asm/unistd.h file.
>>> We have change the value of __NR_syscalls, if we add or delete a
>>> system call.
>>>
>>> One of the patch in this patch series has a script which will
>>> generate a uapi header based on syscall.tbl file. The syscall.tbl
>>> file contains the number of system call information. So we have
>>> two option to update __NR_syscalls value.
>>>
>>> 1. Update __NR_syscalls in asm/unistd.h manually by counting the
>>>    no.of system calls. No need to update __NR_syscalls untill
>>>    we either add a new system call or delete an existing system
>>>    call.
>>>
>>> 2. We can keep this feature it above mentioned script, that'll
>>>    count the number of syscalls and keep it in a generated file.
>>>    In this case we don't need to explicitly update __NR_syscalls
>>>    in asm/unistd.h file.
>>>
>>> The 2nd option will be the recommended one. For that, I moved the
>>> NR_syscalls macro from asm/unistd.h to uapi/asm/unistd.h. The macro
>>> name also changed form NR_syscalls to __NR_syscalls for making the
>>> name convention same across all architecture. While __NR_syscalls
>>> isn't strictly part of the uapi, having it as part of the generated
>>> header to simplifies the implementation.
>>
>> This macro was in unistd.h in past but it was moved out because it was
>> causing problem with strace.
>>
>> commit 40c2702a02b755e0183b702778331b351f3be20c
>> Author:     Michal Simek <michal.simek@xilinx.com>
>> AuthorDate: Mon Jul 8 09:50:24 2013 +0200
>> Commit:     Michal Simek <michal.simek@xilinx.com>
>> CommitDate: Wed Jul 10 07:32:09 2013 +0200
>>
>>     microblaze: Move __NR_syscalls from uapi
>>
>>
>> That's why I don't think this is the right thing to do.
>> I have grepped strace and glibc and none is using this macro that's why
>> I think it shouldn't be exported via uapi.
> 
> 
> Thanks for you reply :)
> Sorry for the delayed response :(
> 
> I would like to keep __NR_syscalls macro to uapi header in order to simplify
> the system call table generation script. Otherwise the __NR_syscalls
> macro need to update manually. That become a problem.
> 
> Please check the below implementation in uapi file make sense?
> It is an easy workaround to leave __NR_syscalls macro in uapi/asm/unistd.h
> and enclose it in #ifdef __KERNEL__
> 
> ...
> ...
> #define __NR_pkey_free  397
> #define __NR_statx      398
> 
> #ifdef __KERNEL__
> #define __NR_syscalls   399
> #endif
> ...
> ...

This should be fine.

M
