From: Masami Hiramatsu <mhiramat@kernel.org>
Subject: Re: [RFC PATCH -tip v5 06/27] arm64: kprobes: Remove jprobe
 implementation
Date: Wed, 6 Jun 2018 13:42:58 +0900
Message-ID: <20180606134258.9f75aab9fa4bfd50d0cca96d@kernel.org>
References: <152812730943.10068.5166429445118734697.stgit@devbox>
        <152812748464.10068.10380156315388629319.stgit@devbox>
        <20180605153420.GA26352@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180605153420.GA26352@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Will Deacon <will.deacon@arm.com>
Cc: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@kernel.org>, Ingo Molnar <mingo@redhat.com>, "H . Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org, Ananth N Mavinakayanahalli <ananth@linux.vnet.ibm.com>, Andrew Morton <akpm@linux-foundation.org>, Steven Rostedt <rostedt@goodmis.org>, linux-arch@vger.kernel.org, Catalin Marinas <catalin.marinas@arm.com>, linux-arm-kernel@lists.infradead.org
List-Id: linux-arch.vger.kernel.org

On Tue, 5 Jun 2018 16:34:21 +0100
Will Deacon <will.deacon@arm.com> wrote:

> On Tue, Jun 05, 2018 at 12:51:24AM +0900, Masami Hiramatsu wrote:
> > Remove arch dependent setjump/longjump functions
> > and unused fields in kprobe_ctlblk for jprobes
> > from arch/arm64.
> > 
> > Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
> > Cc: Catalin Marinas <catalin.marinas@arm.com>
> > Cc: Will Deacon <will.deacon@arm.com>
> > Cc: linux-arm-kernel@lists.infradead.org
> > ---
> >  arch/arm64/include/asm/kprobes.h   |    1 -
> >  arch/arm64/kernel/probes/kprobes.c |   68 ------------------------------------
> >  2 files changed, 69 deletions(-)
> 
> Acked-by: Will Deacon <will.deacon@arm.com>

Thank you Will!


-- 
Masami Hiramatsu <mhiramat@kernel.org>
