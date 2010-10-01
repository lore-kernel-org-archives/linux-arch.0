From: Yinghai Lu <yinghai@kernel.org>
Subject: Re: [patch 00/47] Sparse irq rework
Date: Thu, 30 Sep 2010 22:54:29 -0700
Message-ID: <4CA57795.4040308@kernel.org>
References: <20100930221351.682772535@linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20100930221351.682772535@linutronix.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Thomas Gleixner <tglx@linutronix.de>
Cc: LKML <linux-kernel@vger.kernel.org>, linux-arch@vger.kernel.org, Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@linux-foundation.org>, x86@kernel.org, Peter Zijlstra <peterz@infradead.org>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Paul Mundt <lethal@linux-sh.org>, Russell King <linux@arm.linux.org.uk>, David Woodhouse <dwmw2@infradead.org>, Jesse Barnes <jbarnes@virtuousgeek.org>, Grant Likely <grant.likely@secretlab.ca>, "Eric W. Biederman" <ebiederm@xmission.com>
List-Id: linux-arch.vger.kernel.org

On 09/30/2010 04:14 PM, Thomas Gleixner wrote:
> The following patch series cleans up and mostly reimplements the core
> sparse irq implementation and sanitizes the most complex (ab)user:
> arch/x86
>=20
> The series is based on the previous rework of irq chip functions whic=
h
> is available at:
>=20
>   git://git.kernel.org/pub/scm/linux/kernel/git/tip/linux-2.6-tip.git=
 irq/core
>=20
> A combined throwaway git repository with all the following patches on=
 top of
> tip/irq/core is available at:
>=20
>   git://git.kernel.org/pub/scm/linux/kernel/git/tglx/linux-2.6-sparse=
-irq.git
>=20
> The overall changes are (full changelog below):
>     56 files changed, 1229 insertions(+), 1682 deletions(-)
>=20
> The series consists of 3 parts:
>=20
>     - cleanup of kernel/irq code and implementation of new allocator
>     - conversion of x86 to new irq_chip functions and new allocator
>     - trivial cleanup of the remaining users and removal of the old s=
tuff
>=20
> It's fully bisectable and survived a night of testing in my testfarm.

  CC      kernel/irq/irqdesc.o
kernel/irq/irqdesc.c:123: error: expected =91=3D=92, =91,=92, =91;=92, =
=91asm=92 or =91__attribute__=92 before =91static=92
kernel/irq/irqdesc.c: In function =91alloc_descs=92:
kernel/irq/irqdesc.c:176: error: implicit declaration of function =91al=
loc_desc=92
kernel/irq/irqdesc.c:176: warning: assignment makes pointer from intege=
r without a cast
kernel/irq/irqdesc.c: In function =91early_irq_init=92:
kernel/irq/irqdesc.c:207: warning: assignment makes pointer from intege=
r without a cast
kernel/irq/irqdesc.c: In function =91irq_get_next_irq=92:
kernel/irq/irqdesc.c:346: error: implicit declaration of function =91fi=
nd_next_bit_set=92
kernel/irq/irqdesc.c:347: error: implicit declaration of function =91ra=
w_spin_unlock_irqsave=92
kernel/irq/irqdesc.c: In function =91kstat_irqs_cpu=92:
kernel/irq/irqdesc.c:369: error: expected =91=3D=92, =91,=92, =91;=92, =
=91asm=92 or =91__attribute__=92 before =91{=92 token
kernel/irq/irqdesc.c:374: error: expected =91=3D=92, =91,=92, =91;=92, =
=91asm=92 or =91__attribute__=92 before =91{=92 token
kernel/irq/irqdesc.c:377: error: expected =91{=92 at end of input
make[1]: *** [kernel/irq/irqdesc.o] Error 1

Yinghai
