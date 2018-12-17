From: Michael Ellerman <mpe@ellerman.id.au>
Subject: Re: [PATCH v5 0/5] powerpc: system call table generation support
Date: Mon, 17 Dec 2018 21:30:58 +1100
Message-ID: <877eg8v40t.fsf@concordia.ellerman.id.au>
References: <1544691770-8938-1-git-send-email-firoz.khan@linaro.org> <20181217080846.GA28424@sathnaga86.in.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181217080846.GA28424@sathnaga86.in.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Satheesh Rajendran <sathnaga@linux.vnet.ibm.com>, Firoz Khan <firoz.khan@linaro.org>
Cc: linuxppc-dev@lists.ozlabs.org, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Paul Mackerras <paulus@samba.org>, Arnd Bergmann <arnd@arndb.de>, Geert Uytterhoeven <geert@linux-m68k.org>, Ram Pai <linuxram@us.ibm.com>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Boqun Feng <boqun.feng@gmail.com>, Breno Leitao <leitao@debian.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Philippe Ombredanne <pombredanne@nexb.com>, Thomas Gleixner <tglx@linutronix.de>, Kate Stewart <kstewart@linuxfoundation.org>, linux-arch@vger.kernel.org, y2038@lists.linaro.org, linux-kernel@vger.kernel.org, marcin.juszkiewicz@linaro.org, deepa.kernel@gmail.com
List-Id: linux-arch.vger.kernel.org

Satheesh Rajendran <sathnaga@linux.vnet.ibm.com> writes:
> Hi Firoz,
>
> On Thu, Dec 13, 2018 at 02:32:45PM +0530, Firoz Khan wrote:
>> The purpose of this patch series is, we can easily
>> add/modify/delete system call table support by cha-
>> nging entry in syscall.tbl file instead of manually
>> changing many files. The other goal is to unify the 
>> system call table generation support implementation 
>> across all the architectures. 
>> 
>> The system call tables are in different format in 
>> all architecture. It will be difficult to manually
>> add, modify or delete the system calls in the resp-
>> ective files manually. To make it easy by keeping a 
>> script and which'll generate uapi header file and 
>> syscall table file.
>> 
>> syscall.tbl contains the list of available system 
>> calls along with system call number and correspond-
>> ing entry point. Add a new system call in this arch-
>> itecture will be possible by adding new entry in 
>> the syscall.tbl file.
>> 
>> Adding a new table entry consisting of:
>>         - System call number.
>>         - ABI.
>>         - System call name.
>>         - Entry point name.
>> 	- Compat entry name, if required.
>> 	- spu entry name, if required.
>> 
>> ARM, s390 and x86 architecuture does exist the sim-
>> ilar support. I leverage their implementation to 
>> come up with a generic solution.
>> 
>> I have done the same support for work for alpha, 
>> ia64, m68k, microblaze, mips, parisc, sh, sparc, 
>> and xtensa. Below mentioned git repository contains
>> more details about the workflow.
>> 
>> https://github.com/frzkhn/system_call_table_generator/
>> 
>> Finally, this is the ground work to solve the Y2038
>> issue. We need to add two dozen of system calls to 
>> solve Y2038 issue. So this patch series will help to
>> add new system calls easily by adding new entry in the
>> syscall.tbl.
>> 
>> Changes since v4:
>>  - DOTSYM macro removed for ppc32, which was causing
>>    the compilation error.
>> 
>> Changes since v3:
>>  - split compat syscall table out from native table.
>>  - modified the script to add new line in the generated
>>    file.
>> 
>> Changes since v2:
>>  - modified/optimized the syscall.tbl to avoid duplicate
>>    for the spu entries.
>>  - updated the syscalltbl.sh to meet the above point.
>> 
>> Changes since v1:
>>  - optimized/updated the syscall table generation 
>>    scripts.
>>  - fixed all mixed indentation issues in syscall.tbl.
>>  - added "comments" in syscall_*.tbl.
>>  - changed from generic-y to generated-y in Kbuild.
>> 
>> Firoz Khan (5):
>>   powerpc: add __NR_syscalls along with NR_syscalls
>>   powerpc: move macro definition from asm/systbl.h
>>   powerpc: add system call table generation support
>>   powerpc: split compat syscall table out from native table
>>   powerpc: generate uapi header and system call table files
>
> Tried to apply on linus "master" and linuxppc-dev(https://git.kernel.org/pub/scm/linux/kernel/git/powerpc/linux.git) "merge" branch,
> both failed to apply series.
>
> # git am mbox
> Applying: powerpc: add __NR_syscalls along with NR_syscalls
> Applying: powerpc: move macro definition from asm/systbl.h
> Applying: powerpc: add system call table generation support
> Applying: powerpc: split compat syscall table out from native table
> Applying: powerpc: generate uapi header and system call table files
> error: patch failed: arch/powerpc/include/uapi/asm/Kbuild:1
> error: arch/powerpc/include/uapi/asm/Kbuild: patch does not apply
> Patch failed at 0005 powerpc: generate uapi header and system call table files
> Use 'git am --show-current-patch' to see the failed patch
> When you have resolved this problem, run "git am --continue".
> If you prefer to skip this patch, run "git am --skip" instead.
> To restore the original branch and stop patching, run "git am --abort".
>
> Then, tried with linuxppc-dev(https://git.kernel.org/pub/scm/linux/kernel/git/powerpc/linux.git) "next" branch,
> patch got applied, compiled with ppc64le_defconfig and booted on IBM Power8 box.
>
> # uname -r
> 4.20.0-rc2-gdd2690d2c
>
> Looks like patch series needs a rebase against the latest kernel versions.

No it's fine if it applies on next.

I can also fix up minor merge conflicts if there are any.

cheers
