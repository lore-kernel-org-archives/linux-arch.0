From: Palmer Dabbelt <palmer@sifive.com>
Subject: Re: [for-next][PATCH 10/18] riscv/function_graph: Simplify with function_graph_entry()
Date: Mon, 26 Nov 2018 08:47:47 -0800 (PST)
Message-ID: <mhng-b0e40c1e-307d-47cd-aba9-f7d648a4f8bc@palmer-si-x1c4>
References: <20181122003332.793493004@goodmis.org>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181122003332.793493004@goodmis.org>
Sender: linux-kernel-owner@vger.kernel.org
To: rostedt@goodmis.org
Cc: linux-kernel@vger.kernel.org, Linus Torvalds <torvalds@linux-foundation.org>, mingo@kernel.org, akpm@linux-foundation.org, tglx@linutronix.de, peterz@infradead.org, linux-arch@vger.kernel.org, joel@joelfernandes.org, mhiramat@kernel.org, jpoimboe@redhat.com, luto@kernel.org, frederic@kernel.org, greentime@andestech.com, alankao@andestech.com, stable@kernel.org
List-Id: linux-arch.vger.kernel.org

On Wed, 21 Nov 2018 16:28:11 PST (-0800), rostedt@goodmis.org wrote:
> From: "Steven Rostedt (VMware)" <rostedt@goodmis.org>
>
> The function_graph_entry() function does the work of calling the function
> graph hook function and the management of the shadow stack, simplifying the
> work done in the architecture dependent prepare_ftrace_return().
>
> Have riscv use the new code, and remove the shadow stack management as well as
> having to set up the trace structure.
>
> This is needed to prepare for a fix of a design bug on how the curr_ret_stack
> is used.
>
> Cc: Greentime Hu <greentime@andestech.com>
> Cc: Alan Kao <alankao@andestech.com>
> Cc: Palmer Dabbelt <palmer@sifive.com>
> Cc: stable@kernel.org
> Fixes: 03274a3ffb449 ("tracing/fgraph: Adjust fgraph depth before calling trace return callback")
> Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
> ---
>  arch/riscv/kernel/ftrace.c | 14 ++------------
>  1 file changed, 2 insertions(+), 12 deletions(-)
>
> diff --git a/arch/riscv/kernel/ftrace.c b/arch/riscv/kernel/ftrace.c
> index 1157b6b52d25..c433f6d3dd64 100644
> --- a/arch/riscv/kernel/ftrace.c
> +++ b/arch/riscv/kernel/ftrace.c
> @@ -132,7 +132,6 @@ void prepare_ftrace_return(unsigned long *parent, unsigned long self_addr,
>  {
>  	unsigned long return_hooker = (unsigned long)&return_to_handler;
>  	unsigned long old;
> -	struct ftrace_graph_ent trace;
>  	int err;
>
>  	if (unlikely(atomic_read(&current->tracing_graph_pause)))
> @@ -144,17 +143,8 @@ void prepare_ftrace_return(unsigned long *parent, unsigned long self_addr,
>  	 */
>  	old = *parent;
>
> -	trace.func = self_addr;
> -	trace.depth = current->curr_ret_stack + 1;
> -
> -	if (!ftrace_graph_entry(&trace))
> -		return;
> -
> -	err = ftrace_push_return_trace(old, self_addr, &trace.depth,
> -				       frame_pointer, parent);
> -	if (err == -EBUSY)
> -		return;
> -	*parent = return_hooker;
> +	if (function_graph_enter(old, self_addr, frame_pointer, parent))
> +		*parent = return_hooker;
>  }
>
>  #ifdef CONFIG_DYNAMIC_FTRACE

Reviewed-by: Palmer Dabbelt <palmer@sifive.com>
