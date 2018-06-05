From: Will Deacon <will.deacon@arm.com>
Subject: Re: [RFC PATCH -tip v5 06/27] arm64: kprobes: Remove jprobe
 implementation
Date: Tue, 5 Jun 2018 16:34:21 +0100
Message-ID: <20180605153420.GA26352@arm.com>
References: <152812730943.10068.5166429445118734697.stgit@devbox>
 <152812748464.10068.10380156315388629319.stgit@devbox>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <152812748464.10068.10380156315388629319.stgit@devbox>
Sender: linux-kernel-owner@vger.kernel.org
To: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@kernel.org>, Ingo Molnar <mingo@redhat.com>, "H . Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org, Ananth N Mavinakayanahalli <ananth@linux.vnet.ibm.com>, Andrew Morton <akpm@linux-foundation.org>, Steven Rostedt <rostedt@goodmis.org>, linux-arch@vger.kernel.org, Catalin Marinas <catalin.marinas@arm.com>, linux-arm-kernel@lists.infradead.org
List-Id: linux-arch.vger.kernel.org

On Tue, Jun 05, 2018 at 12:51:24AM +0900, Masami Hiramatsu wrote:
> Remove arch dependent setjump/longjump functions
> and unused fields in kprobe_ctlblk for jprobes
> from arch/arm64.
> 
> Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Will Deacon <will.deacon@arm.com>
> Cc: linux-arm-kernel@lists.infradead.org
> ---
>  arch/arm64/include/asm/kprobes.h   |    1 -
>  arch/arm64/kernel/probes/kprobes.c |   68 ------------------------------------
>  2 files changed, 69 deletions(-)

Acked-by: Will Deacon <will.deacon@arm.com>

Will
