From: Andrea Arcangeli <aarcange@redhat.com>
Subject: Re: [PATCH 06/18] x86, barrier: stop speculation for failed access_ok
Date: Mon, 8 Jan 2018 11:02:51 +0100
Message-ID: <20180108100251.GJ25546@redhat.com>
References: <151520099201.32271.4677179499894422956.stgit@dwillia2-desk3.amr.corp.intel.com>
 <151520102670.32271.8447983009852138826.stgit@dwillia2-desk3.amr.corp.intel.com>
 <CA+55aFzeCHgAtz4vCR9YaUxkuesCNEht56dKJmpytx2A-JmJkg@mail.gmail.com>
 <20180106123242.77f4d860@alans-desktop>
 <20180106181331.mmrqwwbu2jcjj2si@ast-mbp>
 <CAPcyv4jqKmnkL1CfHVccHvocmSD4PamqOy4bPsO1789D+107FQ@mail.gmail.com>
 <20180106183937.vkseldf4arkdlkum@ast-mbp>
 <CAPcyv4hyRfPhnnS=aDf=jMMP+-EJM3ojPC0gX9ChawT3vidkJQ@mail.gmail.com>
 <20180106192517.ykvlcq4564cqy4u6@ast-mbp>
 <alpine.DEB.2.20.1801062038510.2376@nanos>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <netdev-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.20.1801062038510.2376@nanos>
Sender: netdev-owner@vger.kernel.org
To: Thomas Gleixner <tglx@linutronix.de>
Cc: Alexei Starovoitov <alexei.starovoitov@gmail.com>, Dan Williams <dan.j.williams@intel.com>, Alan Cox <gnomes@lxorguk.ukuu.org.uk>, Linus Torvalds <torvalds@linux-foundation.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-arch@vger.kernel.org, Andi Kleen <ak@linux.intel.com>, Arnd Bergmann <arnd@arndb.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Peter Zijlstra <peterz@infradead.org>, Netdev <netdev@vger.kernel.org>, Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>
List-Id: linux-arch.vger.kernel.org

On Sat, Jan 06, 2018 at 08:41:34PM +0100, Thomas Gleixner wrote:
> optimized argumentation. We need to make sure that we have a solution which
> kills the problem safely and then take it from there. Correctness first,
> optimization later is the rule for this. Better safe than sorry.

Agreed, assuming the objective here is to achieve a complete spectre
fix fast.

Also note there's a whole set of stuff to do in addition of IBRS:
IBPB, stuff_RSB() and the register hygiene in kernel entry points and
vmexists, that alters the whole syscall stackframe to be able to clear
callee saved registers.

That register hygiene was one of the most tedious pieces to get right
along with the PTI "rep movsb" (no C) stack trampoline that never
calls into C code with zero stack available because it's very bad to
do so, consdering C is free to use some stack for register spillage.

I suggest to discuss how important register hygiene is on top of IBRS,
IBPB and stuff_RSB() to fix spectre, not future optimizations that
only matter for old CPUS and are irrelevant for future silicon.

I also suggest to discuss how to automate the other parts of variant#1
lfence/mfence across the bound checks, depending on arch with a open
source scanner, or if to pretend developers think about it like we
think about mb() (except no regression test will ever notice a bounds
check speculation memory barrier missing).

Reptolines alone are leaving a whole set of stuff unfixed: register
hygiene still missing, bios/firmware calls still require ibrs, all asm
has to be audited by hand as there's no sure asm scanner I know of
(grep can go somewhere though) and the gcc dependency isn't very
flexible to begin with, and they don't help with lfence/mfence across
bound checks, they still require IBPB and stuff_RSB() to avoid
guest/user mode against guest/user spectre variant#2 attacks.

I don't see why we should talk about pure performance optimization at
this point instead of focusing on the above.

Not to tell if you want to guarantee mathematically that guest
userland cannot read the guest kernel memory by starting a spectre
variant#2 attack from guest userland to host userland (David Gilbert's
new attack discovery). For that you'll have to set ibrs_enabled 2
ibpb_enabled 1 mode or ibrs_enabled 0 ibpb_enabled 2 mode in the host
kernel or alternatively ibrs_enabled 0 ibpb_enabled 2 in the guest
kernel.

ibrs 2 bpbp 1 will prevent qemu userland to use the IBP so guest
userland cannot probe it. ibrs 0 ibpb 2 will flush the IBP state at
vmexit so qemu userland won't be affected by it. ibrs 0 ibpb 2 in
guest will flush the IBP state at kernel entry so guest userland won't
be able to affect anything.

Of course such an attack from guest user -> guest kernel -> host
kernel -> host user -> host kernel -> guest kernel -> guest user and
probing IBP (RSB is fixed for good with unconditional stuff_RSB in
vmexit even when SMEP is set, precisely because SMEP won't stop guest
ring 3 to probe host ring 3 RSB and same for ring 0) is far fetched,
but reptolines alone cannot solve it unless you also build qemu
userland with reptolines (which then means the whole userland has to
be built with reptolines because the qemu dependency chain is endless,
includes glibc etc..).

As a reminder (for lkml): if you use KVM, spectre variant#2 is the
only attack that can affect guest/host memory isolation. spectre
variant#1 and meltdown (aka variant#3) always have been impossible
through KVM guest/user isolation. spectre variant#2 is the one that is
harder to fix and it's the most theoretical of them all and it may be
impossible to mount as an attack depending on host kernel code that
has to play against itself to achieve it. The setup for such an attack
is very tedious, takes half an hour or several hours depending on the
amounts of memory and you may have to know already accurately the
kernel that is running on the host. As opposed to spectre variant#1
and meltdown (aka variant#3), it's very unlikely anybody gets attacked
through spectre variant#2. It's also the side channel with the lowest
amount of kbytes/sec of bandwidth if mounted successfully in the first
place. However if it can be mounted successfully it becomes almost a
concern as the other two variants, which is why it needs fixing too.

Thanks,
Andrea
