From: Mike Frysinger <vapier.adi@gmail.com>
Subject: Re: [PATCH 1/2] Blackfin: initial tracehook support
Date: Thu, 11 Feb 2010 23:33:20 -0500
Message-ID: <8bd0f97a1002112033m5805d4eco3add4d5625e71e9@mail.gmail.com>
References: <20100202185907.GE3630@lst.de> <1265881389-26925-2-git-send-email-vapier@gentoo.org>
	<20100211204653.34BB3900@magilla.sf.frob.com> <8bd0f97a1002111554ib69bd48rc3c5f4af65058281@mail.gmail.com>
	<20100212032406.BE645C81B@magilla.sf.frob.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20100212032406.BE645C81B@magilla.sf.frob.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Roland McGrath <roland@redhat.com>
Cc: Christoph Hellwig <hch@lst.de>, oleg@redhat.com, Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, uclinux-dist-devel@blackfin.uclinux.org
List-Id: linux-arch.vger.kernel.org

On Thu, Feb 11, 2010 at 22:24, Roland McGrath wrote:
>> where is user_regset actually used ? =C2=A0i only see it in fs/binfm=
t_elf.c
>> and core dumps, neither of which work on nommu systems (or at least =
on
>> Blackfin systems).
>
> The core dump code in binfmt_elf_fdpic.c appears identical to an old
> version of the binfmt_elf.c code. =C2=A0That file appears to have bee=
n made with
> the "copy and paste" school of code sharing, of which I am a detracto=
r.
> The ELF core dump code can be shared between those two, and really sh=
ould
> be. =C2=A0Once that's done, you will want to use the CORE_DUMP_USE_RE=
GSET flavor
> of the code and clean out any old core-related cruft you had in asm/e=
lf.h.
> In the long run, the non-user_regset version of the core dump code wi=
ll go
> away after every arch has been cleaned up.

cant say we've had anything to do with this ;).  nor does Blackfin
support coredumps on FDPIC ELF (and FLAT has never supported
coredumps), and i'm pretty sure we havent looked at anything in gdb
along these lines.  no one has ever asked, so we've never looked.

> The "ptrace: Add support for generic PTRACE_GETREGSET/PTRACE_SETREGSE=
T"
> patch making its way through the obstacle course right now will make =
the
> generic ptrace code use user_regset. =C2=A0That use is conditional on
> CONFIG_HAVE_ARCH_TRACEHOOK and your kernel will stop building if you =
have
> set that without meeting its requirements.
>
> Moreover, the whole point of CONFIG_HAVE_ARCH_TRACEHOOK is to indicat=
e the
> minimum arch requirements that all future generic code can rely on. =C2=
=A0If you
> set it without meeting the documented requirements as arch/Kconfig te=
lls
> you to, then your arch will one day be broken by new generic code get=
ting
> merged in.

i dont have a problem with implementing user_regsets ... my point was
more that if there's no code using these interfaces, then i could slap
together a whole lot of crap and never know if it's correct since i
cant test it.  Blackfin doesnt currently implement
PTRACE_{G,S}ETREGSET, so even with that patch i dont think i have any
(straight forward) test vectors.

>> i dont see anyone calling syscall_get_arguments() with i!=3D0, and a=
 few
>> other arches are doing the BUG_ON(i) thing too.
>
> Someone will, and then they will crash. =C2=A0A few others being half=
-assed is
> no good reason for you to follow suit.

the original reason was like the comment said -- i had no idea what
the "i" was for and the few arches that did implement it didnt exactly
have clear code/documentation.  ive added some nice kerneldoc stuff to
the Blackfin version in case anyone looks at this.

>> this is unchanged from the previous Blackfin behavior, and it's how
>> most arches behaved in 2.6.32. =C2=A0but looking in latest mainline,=
 it
>> seems people are changing to:
>> if (test_thread_flag(TIF_SINGLESTEP) || test_thread_flag(TIF_SYSCALL=
_TRACE))
>> =C2=A0 =C2=A0 tracehook_report_syscall_exit(regs, 0);
>>
>> so changing Blackfin too should be straightforward i guess
>
> You can't blindly follow another arch. =C2=A0All the details that tel=
l you what
> is the right thing to do here are arch-specific. =C2=A0I see no arch =
that does
> what you say, and it seems certain they would be wrong if they did.

i missed the passing of TIF_SINGLESTEP in as the second arg.  i
thought you were taking issue with the if(...) portions.

the way we do it on Blackfin atm is that syscall_trace_{enter,leave}
are only called when TIF_SYSCALL_TRACE is set (in the low level
assembly), so any checking of thread_flags here is pointless.  i guess
the low level code needs updating to check a mask so that we can add
TIF_SYSCALL_TRACEPOINT easier.

> You should always call tracehook_report_syscall_exit() if TIF_SYSCALL=
_TRACE
> is set. =C2=A0Whether to call it otherwise depends on arch details.

this is all set for us

> On some machines, single-step into a syscall instruction is no differ=
ent
> from other user instructions, so the normal SIGTRAP will come afterwa=
rds
> anyway.
>
> On other machines, entering the kernel for the syscall instruction de=
feats
> the normal user-mode effects of single-step being enabled. =C2=A0In t=
hat event,
> you want to call tracehook_report_syscall_exit() if single-step is en=
abled.
> You must pass a nonzero second argument if your arch code is not goin=
g to
> generate the normal SIGTRAP associated with having single-stepped int=
o the
> syscall instruction.

so tracehook_report_syscall_exit() checking TIF_SINGLESTEP only makes
sense when the arch doesnt support hardware single stepping in user
mode ?  the Blackfin processor does support hardware single stepping
(and we utilize it in Linux).

also, in reading the kerneldocs for tracehook_report_syscall_exit(),
it says "an attempted system call".  should system calls greater than
NR_syscall (-ENOSYS) also get traced ?  we dont currently do this on
the Blackfin port, but going by `strace` differences between my
desktop and the board, i guess the answer is "the Blackfin code is
currently broken".
-mike
