Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:46880 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2634360AbfJRQuA (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Fri, 18 Oct 2019 12:50:00 -0400
Date: Fri, 18 Oct 2019 12:49:56 -0400
From: Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [tip: x86/asm] x86/asm/ftrace: Mark function_hook as function
Message-ID: <20191018124956.764ac42e@gandalf.local.home>
In-Reply-To: <20191018124800.0a7006bb@gandalf.local.home>
References: <20191011115108.12392-22-jslaby@suse.cz>
        <157141622788.29376.4016565749507481510.tip-bot2@tip-bot2>
        <20191018124800.0a7006bb@gandalf.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: tip-bot2 for Jiri Slaby <tip-bot2@linutronix.de>
Cc: linux-kernel@vger.kernel.org, linux-tip-commits@vger.kernel.org, Jiri Slaby <jslaby@suse.cz>, Borislav Petkov <bp@suse.de>, "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>, Josh Poimboeuf <jpoimboe@redhat.com>, linux-arch@vger.kernel.org, Masami Hiramatsu <mhiramat@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Thomas Gleixner <tglx@linutronix.de>, x86-ml <x86@kernel.org>, Ingo Molnar <mingo@kernel.org>, Borislav Petkov <bp@alien8.de>
Message-ID: <20191018164956.S46MtmL1M6efXp1s2UYZ1kCZgZN_H_T4hvp_Fq0ex9A@z>

On Fri, 18 Oct 2019 12:48:00 -0400
Steven Rostedt <rostedt@goodmis.org> wrote:

> > Relabel function_hook to be marked really as a function. It is called
> > from C and has the same expectations towards the stack etc.  
> 

And to go even further, it *does not* have the same expectations
towards the stack.

I think this patch should not be applied.

-- Steve
