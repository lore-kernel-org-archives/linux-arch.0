Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:45410 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2404605AbfJRUb2 (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Fri, 18 Oct 2019 16:31:28 -0400
Date: Fri, 18 Oct 2019 16:31:25 -0400
From: Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [tip: x86/asm] x86/asm/ftrace: Mark function_hook as function
Message-ID: <20191018163125.346e078d@gandalf.local.home>
In-Reply-To: <20191018194856.GC20368@zn.tnic>
References: <20191011115108.12392-22-jslaby@suse.cz>
        <157141622788.29376.4016565749507481510.tip-bot2@tip-bot2>
        <20191018124800.0a7006bb@gandalf.local.home>
        <20191018124956.764ac42e@gandalf.local.home>
        <20191018171354.GB20368@zn.tnic>
        <20191018133735.77e90e36@gandalf.local.home>
        <20191018194856.GC20368@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Borislav Petkov <bp@suse.de>
Cc: tip-bot2 for Jiri Slaby <tip-bot2@linutronix.de>, linux-kernel@vger.kernel.org, linux-tip-commits@vger.kernel.org, Jiri Slaby <jslaby@suse.cz>, "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>, Josh Poimboeuf <jpoimboe@redhat.com>, linux-arch@vger.kernel.org, Masami Hiramatsu <mhiramat@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Thomas Gleixner <tglx@linutronix.de>, x86-ml <x86@kernel.org>, Ingo Molnar <mingo@kernel.org>, Borislav Petkov <bp@alien8.de>
Message-ID: <20191018203125.np9_JYcwoclPJp-f9UccE9i6UHJ1EtC5JZEiadNMyCE@z>

On Fri, 18 Oct 2019 21:48:56 +0200
Borislav Petkov <bp@suse.de> wrote:

> > The #define was because we use to support mcount or __fentry__, now we
> > just support __fentry__, and function_hook describes it better ;-)  
> 
> Well sorry but gcc documentation talks about __fentry__. I'd keep the
> same name to avoid confusion and explain above it what it is. Much
> better.

Still looks ugly ;-)

> 
> > Heh, I guess we could, which would probably be quite a long comment as
> > it's the key behind ftrace itself.  
> 
> Well, you can explain with a couple of sentences what it is and
> then point at the bigger document explaining ftrace. Provided, Mr.
> Rostedt, you'll stop doing talks and finally sit down and write that
> documentation!

I do the talks hoping someone else will finally sit down and write the
documentation!

-- Steve
