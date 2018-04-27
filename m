From: Masami Hiramatsu <mhiramat@kernel.org>
Subject: Re: [PATCH -tip v2 4/7] kprobes: Replace %p with other pointer
 types
Date: Fri, 27 Apr 2018 14:07:57 +0900
Message-ID: <20180427140757.39c937eea546ccfdafb38332@kernel.org>
References: <152473007907.8819.10449983839199591406.stgit@devbox>
        <152473020349.8819.11597612324633031612.stgit@devbox>
        <20180426211351.419d3502@vmware.local.home>
        <20180427113951.8e3192af570c0bae925b2a71@kernel.org>
        <20180426224824.3492232e@vmware.local.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <stable-owner@vger.kernel.org>
In-Reply-To: <20180426224824.3492232e@vmware.local.home>
Sender: stable-owner@vger.kernel.org
To: Steven Rostedt <rostedt@goodmis.org>
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, Ingo Molnar <mingo@redhat.com>, "H . Peter Anvin" <hpa@zytor.com>, x86@kernel.org, Ananth N Mavinakayanahalli <ananth@in.ibm.com>, Anil S Keshavamurthy <anil.s.keshavamurthy@intel.com>, "David S . Miller" <davem@davemloft.net>, Jon Medhurst <tixy@linaro.org>, Will Deacon <will.deacon@arm.com>, Arnd Bergmann <arnd@arndb.de>, David Howells <dhowells@redhat.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, "Tobin C . Harding" <me@tobin.cc>, Linus Torvalds <torvalds@linux-foundation.org>, Thomas Richter <tmricht@linux.ibm.com>, akpm@linux-foundation.org, acme@kernel.org, brueckner@linux.vnet.ibm.com, schwidefsky@de.ibm.com, stable@vger.kernel.org
List-Id: linux-arch.vger.kernel.org

On Thu, 26 Apr 2018 22:48:24 -0400
Steven Rostedt <rostedt@goodmis.org> wrote:

> On Fri, 27 Apr 2018 11:39:51 +0900
> Masami Hiramatsu <mhiramat@kernel.org> wrote:
> 
> > On Thu, 26 Apr 2018 21:13:51 -0400
> > Steven Rostedt <rostedt@goodmis.org> wrote:
> > 
> > > On Thu, 26 Apr 2018 17:10:03 +0900
> > > Masami Hiramatsu <mhiramat@kernel.org> wrote:
> > >   
> > > > Replace %p with appropriate pointer types (or just remove it)
> > > >  - Use %pS if possible
> > > >  - Use %px only for the function right before BUG().
> > > >  - Remove unneeded error message.  
> > > 
> > > I'm not sure "right before BUG()" is legitimate for using %px. Why not
> > > still use %pS?  
> > 
> > Since BUG() will dump all registers and stacks which includes
> > raw address information and reboot the system (means reset the
> > kaslr base offset), I thought it may not add additional damage.
> 
> BUG() has been changed to print out %pS and not the address while doing
> the stack dump. It only prints the address if it doesn't find a
> function name. For example:
> 
> CPU: 0 PID: 0 Comm: swapper/0 Not tainted 4.11.0-rc3-test+ #48
> Hardware name: MSI MS-7823/CSM-H87M-G43 (MS-7823), BIOS V1.6 02/22/2014
> Call Trace:
>  dump_stack+0x68/0x92
>  lockdep_rcu_suspicious+0xf7/0x100
>  rcu_read_lock+0x5f/0x61
>  __is_insn_slot_addr+0x23/0x5c
>  __kernel_text_address+0x4a/0x80
>  show_trace_log_lvl+0x157/0x296
>  ? module_assert_mutex_or_preempt+0x4f/0x51
>  show_stack+0x3d/0x3f
>  dump_stack+0x68/0x92
>  __warn+0xc2/0xdd
>  ? 0xffffffffa0026077
>  warn_slowpath_null+0x1d/0x1f
>  module_assert_mutex_or_preempt+0x4f/0x51
>  __module_address+0x2a/0xac
>  ? 0xffffffffa0026077
>  __module_text_address+0x12/0x59
>  ? 0xffffffffa0026077
>  is_module_text_address+0xe/0x16
>  __kernel_text_address+0x2b/0x80
>  ? 0xffffffffa0026077
>  unwind_get_return_address+0x50/0x5c
> 

Ah...
OK, I'll fix that.

> 
> > 
> > Anyway, for this patch we can use %pS. For the next [5/7] patch,
> > I'm not sure %pS is good for dumping a stack address...
> 
> Although it now is.

Got it.

Thank you!


-- 
Masami Hiramatsu <mhiramat@kernel.org>
