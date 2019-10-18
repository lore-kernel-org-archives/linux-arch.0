From: Borislav Petkov <bp@suse.de>
Subject: Re: [tip: x86/asm] x86/asm/ftrace: Mark function_hook as function
Date: Fri, 18 Oct 2019 21:48:56 +0200
Message-ID: <20191018194856.GC20368@zn.tnic>
References: <20191011115108.12392-22-jslaby@suse.cz>
 <157141622788.29376.4016565749507481510.tip-bot2@tip-bot2>
 <20191018124800.0a7006bb@gandalf.local.home>
 <20191018124956.764ac42e@gandalf.local.home>
 <20191018171354.GB20368@zn.tnic>
 <20191018133735.77e90e36@gandalf.local.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20191018133735.77e90e36@gandalf.local.home>
Sender: linux-kernel-owner@vger.kernel.org
To: Steven Rostedt <rostedt@goodmis.org>
Cc: tip-bot2 for Jiri Slaby <tip-bot2@linutronix.de>, linux-kernel@vger.kernel.org, linux-tip-commits@vger.kernel.org, Jiri Slaby <jslaby@suse.cz>, "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>, Josh Poimboeuf <jpoimboe@redhat.com>, linux-arch@vger.kernel.org, Masami Hiramatsu <mhiramat@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Thomas Gleixner <tglx@linutronix.de>, x86-ml <x86@kernel.org>, Ingo Molnar <mingo@kernel.org>, Borislav Petkov <bp@alien8.de>
List-Id: linux-arch.vger.kernel.org

On Fri, Oct 18, 2019 at 01:37:35PM -0400, Steven Rostedt wrote:
> It just needs to be visible by modules and what not, otherwise linking
> will fail.

And I assume all of them?

> The #define was because we use to support mcount or __fentry__, now we
> just support __fentry__, and function_hook describes it better ;-)

Well sorry but gcc documentation talks about __fentry__. I'd keep the
same name to avoid confusion and explain above it what it is. Much
better.

> Heh, I guess we could, which would probably be quite a long comment as
> it's the key behind ftrace itself.

Well, you can explain with a couple of sentences what it is and
then point at the bigger document explaining ftrace. Provided, Mr.
Rostedt, you'll stop doing talks and finally sit down and write that
documentation!

:-P

-- 
Regards/Gruss,
    Boris.

SUSE Software Solutions Germany GmbH, GF: Felix Imendörffer, HRB 36809, AG Nürnberg
