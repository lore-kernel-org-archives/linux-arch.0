From: Rich Felker <dalias@libc.org>
Subject: Re: [PATCH v3 0/3] sh: system call table generation support
Date: Mon, 10 Dec 2018 15:30:36 -0500
Message-ID: <20181210203036.GM23599@brightrain.aerifal.cx>
References: <1542169930-24118-1-git-send-email-firoz.khan@linaro.org>
 <CALxhOnis61eCGyS22e0_s5PLOimsNX+mhgMa_-enLWQ=EarBfg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CALxhOnis61eCGyS22e0_s5PLOimsNX+mhgMa_-enLWQ=EarBfg@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Firoz Khan <firoz.khan@linaro.org>
Cc: linux-sh@vger.kernel.org, Yoshinori Sato <ysato@users.sourceforge.jp>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Philippe Ombredanne <pombredanne@nexb.com>, Thomas Gleixner <tglx@linutronix.de>, Kate Stewart <kstewart@linuxfoundation.org>, y2038 Mailman List <y2038@lists.linaro.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux-Arch <linux-arch@vger.kernel.org>, Arnd Bergmann <arnd@arndb.de>, Deepa Dinamani <deepa.kernel@gmail.com>, Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>
List-Id: linux-arch.vger.kernel.org

On Mon, Nov 19, 2018 at 10:38:20AM +0530, Firoz Khan wrote:
> On Wed, 14 Nov 2018 at 10:02, Firoz Khan <firoz.khan@linaro.org> wrote:
> >
> > The purpose of this patch series is, we can easily
> > add/modify/delete system call table support by cha-
> > nging entry in syscall.tbl file instead of manually
> > changing many files. The other goal is to unify the
> > system call table generation support implementation
> > across all the architectures.
> >
> > The system call tables are in different format in
> > all architecture. It will be difficult to manually
> > add, modify or delete the system calls in the resp-
> > ective files manually. To make it easy by keeping a
> > script and which'll generate uapi header file and
> > syscall table file.
> >
> > syscall.tbl contains the list of available system
> > calls along with system call number and correspond-
> > ing entry point. Add a new system call in this arch-
> > itecture will be possible by adding new entry in
> > the syscall.tbl file.
> >
> > Adding a new table entry consisting of:
> >         - System call number.
> >         - ABI.
> >         - System call name.
> >         - Entry point name.
> >
> > Please note, this support is only available for 32-bit
> > kernel, not 64-bit kernel. As I came across the 64-bit
> > kernel is not active for long time.
> >
> > ARM, s390 and x86 architecuture does exist the sim-
> > ilar support. I leverage their implementation to come
> > up with a generic solution.
> >
> > I have done the same support for work for alpha, ia64,
> > m68k, microblaze, mips, parisc, powerpc, sparc, and
> > xtensa. Below mentioned git repository contains more
> > details about the workflow.
> >
> > https://github.com/frzkhn/system_call_table_generator/
> >
> > Finally, this is the ground work to solve the Y2038
> > issue. We need to add two dozen of system calls to solve
> > Y2038 issue. So this patch series will help to add new
> > system calls easily by adding new entry in the syscall-
> > .tbl.
> >
> > Changes since v2:
> >  - changed from generic-y to generated-y in Kbuild.
> >
> > Changes since v1:
> >  - optimized/updated the syscall table generation
> >    scripts.
> >  - fixed all mixed indentation issues in syscall.tbl.
> >  - added "comments" in syscall.tbl.
> >
> > Firoz Khan (3):
> >   sh: add __NR_syscalls along with NR_syscalls
> >   sh: add system call table generation support
> >   sh: generate uapi header and syscall table header files
> 
> Gentle reminder!
> 
> Could someone review this patch series. I haven't received any
> feedback till now.

I'm way behind, but fine with it going upstream via whatever tree is
appropriate. I think Arnd will take care of it.

Acked-by: Rich Felker <dalias@libc.org>

> FYI, this support is only available for 32-bit kernel, not 64-bit
> kernel. As I came across the 64-bit kernel is not active for long time.

Support for 64-bit, which AFAIK barely ever existed in hardware, was
removed from GCC a long time ago. At some point it needs to be removed
from the kernel too, and doing so should allow a lot of cleanup.

Rich
