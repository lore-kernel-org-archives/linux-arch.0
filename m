From: James Morse <james.morse@arm.com>
Subject: Re: [PATCH 6/6] arm64: Use ftrace_graph_get_ret_stack() instead of
 curr_ret_stack
Date: Mon, 17 Dec 2018 13:30:57 +0000
Message-ID: <1fd00f16-24bf-11f1-a27a-4a7c8f23c11a@arm.com>
References: <20181210193007.655970639@goodmis.org>
 <20181210193335.417173167@goodmis.org>
 <f0613902-80ac-5865-26ee-f0aac4d3b906@arm.com>
 <20181214220054.101f9e4c@vmware.local.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181214220054.101f9e4c@vmware.local.home>
Content-Language: en-GB
Sender: linux-kernel-owner@vger.kernel.org
To: Steven Rostedt <rostedt@goodmis.org>
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, Ingo Molnar <mingo@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, linux-arm-kernel@lists.infradead.org, Will Deacon <will.deacon@arm.com>, Mark Rutland <mark.rutland@arm.com>, Catalin Marinas <catalin.marinas@arm.com>
List-Id: linux-arch.vger.kernel.org

Hi Steve,

On 15/12/2018 03:00, Steven Rostedt wrote:
> On Thu, 13 Dec 2018 17:09:35 +0000
> James Morse <james.morse@arm.com> wrote:
>> I gave this branch a spin, but I hit the WARN_ON() fairly easily:
> 
> Thanks for testing!
> 
> Can you see if this patch fixes it for you?

> diff --git a/kernel/trace/fgraph.c b/kernel/trace/fgraph.c
> index d4f04f0ca646..8dfd5021b933 100644
> --- a/kernel/trace/fgraph.c
> +++ b/kernel/trace/fgraph.c
> @@ -246,10 +246,10 @@ unsigned long ftrace_return_to_handler(unsigned long frame_pointer)
>  struct ftrace_ret_stack *
>  ftrace_graph_get_ret_stack(struct task_struct *task, int idx)
>  {
> -	idx = current->curr_ret_stack - idx;
> +	idx = task->curr_ret_stack - idx;
>  
>  	if (idx >= 0 && idx <= task->curr_ret_stack)
> -		return &current->ret_stack[idx];
> +		return &task->ret_stack[idx];
>  
>  	return NULL;
>  }
> 

Heh, yes that fixes it:

Tested-by: James Morse <james.morse@arm.com>


Thanks,

James
