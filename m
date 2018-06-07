From: "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>
Subject: Re: [RFC PATCH -tip v5 07/27] powerpc/kprobes: Remove jprobe powerpc
 implementation
Date: Thu, 07 Jun 2018 17:01:23 +0530
Message-ID: <1528370755.shi1gq6h7g.naveen@linux.ibm.com>
References: <152812730943.10068.5166429445118734697.stgit@devbox>
        <152812751377.10068.6090934299713110701.stgit@devbox>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8BIT
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <152812751377.10068.6090934299713110701.stgit@devbox>
Sender: linux-kernel-owner@vger.kernel.org
To: Masami Hiramatsu <mhiramat@kernel.org>, Ingo Molnar <mingo@kernel.org>, Thomas Gleixner <tglx@linutronix.de>
Cc: Andrew Morton <akpm@linux-foundation.org>, Ananth N Mavinakayanahalli <ananth@linux.vnet.ibm.com>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, "H . Peter Anvin" <hpa@zytor.com>, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, Ingo Molnar <mingo@redhat.com>, Michael Ellerman <mpe@ellerman.id.au>, Paul Mackerras <paulus@samba.org>, Steven Rostedt <rostedt@goodmis.org>
List-Id: linux-arch.vger.kernel.org

Masami Hiramatsu wrote:
> Remove arch dependent setjump/longjump functions
> and unused fields in kprobe_ctlblk for jprobes
> from arch/powerpc. This also reverts commits
> related __is_active_jprobe() function.
> 
> Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
> 
> Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> Cc: Paul Mackerras <paulus@samba.org>
> Cc: Michael Ellerman <mpe@ellerman.id.au>
> Cc: "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>
> Cc: linuxppc-dev@lists.ozlabs.org
> ---
>  arch/powerpc/include/asm/kprobes.h             |    2 -
>  arch/powerpc/kernel/kprobes-ftrace.c           |   15 -------
>  arch/powerpc/kernel/kprobes.c                  |   54 ------------------------
>  arch/powerpc/kernel/trace/ftrace_64_mprofile.S |   39 ++---------------
>  4 files changed, 5 insertions(+), 105 deletions(-)

LGTM.

Acked-by: Naveen N. Rao <naveen.n.rao@linux.vnet.ibm.com>

- Naveen
