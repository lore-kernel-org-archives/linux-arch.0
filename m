From: Firoz Khan <firoz.khan@linaro.org>
Subject: Re: [PATCH 0/3] System call table generation support
Date: Tue, 18 Sep 2018 19:43:06 +0530
Message-ID: <CALxhOngEqaA6sNKG_eRTTgnjj94vM2OftbpgHPEXMZ0Yv_nC2w@mail.gmail.com>
References: <1536914314-5026-1-git-send-email-firoz.khan@linaro.org> <20180917171720.wda5qrl7hyyacmwl@pburton-laptop>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180917171720.wda5qrl7hyyacmwl@pburton-laptop>
Sender: linux-kernel-owner@vger.kernel.org
To: Paul Burton <paul.burton@mips.com>
Cc: Hauke Mehrtens <hauke@hauke-m.de>, =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>, "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>, Ralf Baechle <ralf@linux-mips.org>, James Hogan <jhogan@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Philippe Ombredanne <pombredanne@nexb.com>, Thomas Gleixner <tglx@linutronix.de>, Kate Stewart <kstewart@linuxfoundation.org>, "y2038@lists.linaro.org" <y2038@lists.linaro.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, "arnd@arndb.de" <arnd@arndb.de>, "deepa.kernel@gmail.com" <deepa.kernel@gmail.com>, "marcin.juszkiewicz@linaro.org" <marcin.juszkiewicz@linaro.org>
List-Id: linux-arch.vger.kernel.org

On 17 September 2018 at 22:47, Paul Burton <paul.burton@mips.com> wrote:
> Hi Firoz,
>
> On Fri, Sep 14, 2018 at 02:08:31PM +0530, Firoz Khan wrote:
>> The purpose of this patch series is:
>> 1. We can easily add/modify/delete system call by changing entry
>> in syscall.tbl file. No need to manually edit many files.
>>
>> 2. It is easy to unify the system call implementation across all
>> the architectures.
>>
>> The system call tables are in different format in all architecture
>> and it will be difficult to manually add or modify the system calls
>> in the respective files manually. To make it easy by keeping a script
>> and which'll generate the header file and syscall table file so this
>> change will unify them across all architectures.
>
> Interesting :)
>
> I actually started on something similar recently with the goals of
> reducing the need to adjust both asm/unistd.h & the syscall entry tables
> when adding syscalls, clean up asm/unistd.h a bit & make it
> easier/cleaner to add support for nanoMIPS & the P32 ABI.
>
> My branch still needed some work but it's here if you're interested:
>
>     git://git.kernel.org/pub/scm/linux/kernel/git/mips/linux.git wip-mips-syscalls
>
>     https://git.kernel.org/pub/scm/linux/kernel/git/mips/linux.git/log/?h=wip-mips-syscalls
>
> There are some differences:
>
>   - I'd placed syscall numbers the 3 current MIPS ABIs in one table,
>     rather than splitting it up. I can see pros & cons to both though so
>     I'm not tied to having a single all-encompassing table.
>
>   - I'd mostly inferred the entry point names from the syscall names,
>     only specifying them where they differ. Again I'm not particularly
>     tied to this.
>
>   - I'd made asm/unistd.h behave like asm-generic/unistd.h with the
>     __SYSCALL() macro, where you generate separate syscall_table_*
>     headers. I'm fine with that too.
>
> So I'm pretty happy to go with your series, though I agree with Arnd on
> the ABI/file naming & the missing syscalls that were added in the 4.18
> cycle. We probably need to provide mipsmt_sys_sched_[gs]etaffinity as
> aliases to sys_sched_[gs]etaffinity when CONFIG_MIPS_MT_FPAFF isn't
> enabled in order to fix the issue the kbuild test robot reported.
>
> But I'm looking forward to v2 :)
>
> Thanks,
>     Paul

Thanks for your comments :)

We're planning to come up with a generic script for system call table
generation across all the architecture. So certain things I have to keep
same across  all the architecture.

Having a single script is always our plan for long run. But I have to keep a
separate versions for the start so each architecture can be handled  in one
series. Which would make easier to merge in the initial version.

we could probably add it to scripts/*.sh first, but that requires more
coordination between the architectures.

- Firoz
