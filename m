From: Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [tip: x86/asm] x86/asm/ftrace: Mark function_hook as function
Date: Fri, 18 Oct 2019 12:49:56 -0400
Message-ID: <20191018124956.764ac42e@gandalf.local.home>
References: <20191011115108.12392-22-jslaby@suse.cz>
        <157141622788.29376.4016565749507481510.tip-bot2@tip-bot2>
        <20191018124800.0a7006bb@gandalf.local.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20191018124800.0a7006bb@gandalf.local.home>
Sender: linux-kernel-owner@vger.kernel.org
To: tip-bot2 for Jiri Slaby <tip-bot2@linutronix.de>
Cc: linux-kernel@vger.kernel.org, linux-tip-commits@vger.kernel.org, Jiri Slaby <jslaby@suse.cz>, Borislav Petkov <bp@suse.de>, "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>, Josh Poimboeuf <jpoimboe@redhat.com>, linux-arch@vger.kernel.org, Masami Hiramatsu <mhiramat@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Thomas Gleixner <tglx@linutronix.de>, x86-ml <x86@kernel.org>, Ingo Molnar <mingo@kernel.org>, Borislav Petkov <bp@alien8.de>
List-Id: linux-arch.vger.kernel.org

On Fri, 18 Oct 2019 12:48:00 -0400
Steven Rostedt <rostedt@goodmis.org> wrote:

> > Relabel function_hook to be marked really as a function. It is called
> > from C and has the same expectations towards the stack etc.  
> 

And to go even further, it *does not* have the same expectations
towards the stack.

I think this patch should not be applied.

-- Steve
