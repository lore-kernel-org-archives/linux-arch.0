From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH v3 5/6] mips: add system call table generation support
Date: Thu, 29 Nov 2018 15:15:58 +0100
Message-ID: <CAK8P3a1KcUQEbavu1eZaoKXTmbdbxiKgVqt6XF-PeeSSbpVEVg@mail.gmail.com>
References: <1543481016-18500-1-git-send-email-firoz.khan@linaro.org> <1543481016-18500-6-git-send-email-firoz.khan@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1543481016-18500-6-git-send-email-firoz.khan@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Firoz Khan <firoz.khan@linaro.org>
Cc: "open list:RALINK MIPS ARCHITECTURE" <linux-mips@linux-mips.org>, Ralf Baechle <ralf@linux-mips.org>, Paul Burton <paul.burton@mips.com>, James Hogan <jhogan@kernel.org>, gregkh <gregkh@linuxfoundation.org>, Philippe Ombredanne <pombredanne@nexb.com>, Thomas Gleixner <tglx@linutronix.de>, Kate Stewart <kstewart@linuxfoundation.org>, y2038 Mailman List <y2038@lists.linaro.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-arch <linux-arch@vger.kernel.org>, Deepa Dinamani <deepa.kernel@gmail.com>, Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>
List-Id: linux-arch.vger.kernel.org

On Thu, Nov 29, 2018 at 9:44 AM Firoz Khan <firoz.khan@linaro.org> wrote:
>
> The system call tables are in different format in all
> architecture and it will be difficult to manually add,
> modify or delete the syscall table entries in the res-
> pective files. To make it easy by keeping a script and
> which will generate the uapi header and syscall table
> file. This change will also help to unify the implemen-
> tation across all architectures.
>
> The system call table generation script is added in
> kernel/syscalls directory which contain the scripts to
> generate both uapi header file and system call table
> files. The syscall.tbl will be input for the scripts.
>
> syscall.tbl contains the list of available system calls
> along with system call number and corresponding entry
> point. Add a new system call in this architecture will
> be possible by adding new entry in the syscall.tbl file.
>
> Adding a new table entry consisting of:
>         - System call number.
>         - ABI.
>         - System call name.
>         - Entry point name.
>         - Compat entry name, if required.
>
> syscallhdr.sh and syscalltbl.sh will generate uapi
> header unistd_64/n32/o32.h and syscall_table_32_o32/-
> 64_64/64-n32/64-o32.h files respectively. Both .sh files
> will parse the content syscall.tbl to generate the header
> and table files. unistd_64/n32/o32.h will be included by
> uapi/asm/unistd.h and syscall_table_32_o32/64_64/64-n32-
> /64-o32.h is included by kernel/syscall_table32_o32/64-
> _64/64-n32/64-o32.S - the real system call table.
>
> ARM, s390 and x86 architecuture does have similar support.
> I leverage their implementation to come up with a generic
> solution.
>
> Signed-off-by: Firoz Khan <firoz.khan@linaro.org>

Ah, I see you added the syscallnr.sh script from ARM.  I guess
that is one way to handle it, and the implementation seems
fine. It would be good to mention it in the changelog text above
though.

      Arnd
