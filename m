From: Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH 3/6 v3] riscv: Fix syscall_get_arguments() and
 syscall_set_arguments()
Date: Thu, 4 Apr 2019 10:26:53 -0400
Message-ID: <20190404102653.705456df@gandalf.local.home>
References: <20190401134104.676620247@goodmis.org>
 <20190401134420.958530155@goodmis.org>
 <20190404140210.GC4962@altlinux.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-riscv-bounces+glpr-linux-riscv=m.gmane.org@lists.infradead.org>
In-Reply-To: <20190404140210.GC4962@altlinux.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-riscv>,
 <mailto:linux-riscv-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-riscv/>
List-Post: <mailto:linux-riscv@lists.infradead.org>
List-Help: <mailto:linux-riscv-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-riscv>,
 <mailto:linux-riscv-request@lists.infradead.org?subject=subscribe>
Sender: "linux-riscv" <linux-riscv-bounces@lists.infradead.org>
Errors-To: linux-riscv-bounces+glpr-linux-riscv=m.gmane.org@lists.infradead.org
To: "Dmitry V. Levin" <ldv@altlinux.org>
Cc: "Gustavo A. R. Silva" <gustavo@embeddedor.com>, Peter Zijlstra <peterz@infradead.org>, Palmer Dabbelt <palmer@sifive.com>, Dominik Brodowski <linux@dominikbrodowski.net>, Oleg Nesterov <oleg@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>, linux-riscv@lists.infradead.org, Ingo Molnar <mingo@kernel.org>, linux-arch@vger.kernel.org, x86@kernel.org, Ingo Molnar <mingo@redhat.com>, Albert Ou <aou@eecs.berkeley.edu>, Kees Cook <keescook@chromium.org>, Roland McGrath <roland@hack.frob.com>, Borislav Petkov <bp@alien8.de>, Andy Lutomirski <luto@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Will Drewry <wad@chromium.org>, linux-kernel@vger.kernel.org, Andy Lutomirski <luto@amacapital.net>, "Eric W. Biederman" <ebiederm@xmission.com>, Andrew Morton <akpm@linux-foundation.org>, Linus Torvalds <torvalds@linux-foundation.org>
List-Id: linux-arch.vger.kernel.org

On Thu, 4 Apr 2019 17:02:10 +0300
"Dmitry V. Levin" <ldv@altlinux.org> wrote:

> On Mon, Apr 01, 2019 at 09:41:07AM -0400, Steven Rostedt wrote:
> > From: "Dmitry V. Levin" <ldv@altlinux.org>
> > 
> > RISC-V syscall arguments are located in orig_a0,a1..a5 fields
> > of struct pt_regs.
> > 
> > Due to an off-by-one bug and a bug in pointer arithmetic
> > syscall_get_arguments() was reading s3..s7 fields instead of a1..a5.
> > Likewise, syscall_set_arguments() was writing s3..s7 fields
> > instead of a1..a5.
> > 
> > Link: http://lkml.kernel.org/r/20190329171221.GA32456@altlinux.org
> > 
> > Fixes: e2c0cdfba7f69 ("RISC-V: User-facing API")
> > Cc: Ingo Molnar <mingo@redhat.com>
> > Cc: Kees Cook <keescook@chromium.org>
> > Cc: Andy Lutomirski <luto@amacapital.net>
> > Cc: Will Drewry <wad@chromium.org>
> > Cc: Palmer Dabbelt <palmer@sifive.com>
> > Cc: Albert Ou <aou@eecs.berkeley.edu>
> > Cc: linux-riscv@lists.infradead.org
> > Cc: stable@vger.kernel.org # v4.15+
> > Signed-off-by: Dmitry V. Levin <ldv@altlinux.org>
> > Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>  
> 
> According to
> https://lore.kernel.org/lkml/mhng-8e9b547b-7fe3-43d2-9dea-b217de923605@palmer-si-x1c4/
> the following tag could be added to this patch:
>  
> Acked-by: Palmer Dabbelt <palmer@sifive.com>

That link isn't actually an ack. Palmer, you OK if I add it?

-- Steve
