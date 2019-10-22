Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail.skyhub.de ([5.9.137.197]:34370 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388090AbfJVM4X (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Tue, 22 Oct 2019 08:56:23 -0400
Date: Tue, 22 Oct 2019 14:56:15 +0200
From: Borislav Petkov <bp@alien8.de>
Subject: Re: [PATCH] x86/ftrace: Get rid of function_hook
Message-ID: <20191022125615.GE31700@zn.tnic>
References: <157141622788.29376.4016565749507481510.tip-bot2@tip-bot2>
 <20191018124800.0a7006bb@gandalf.local.home>
 <20191018124956.764ac42e@gandalf.local.home>
 <20191018171354.GB20368@zn.tnic>
 <20191018133735.77e90e36@gandalf.local.home>
 <20191018194856.GC20368@zn.tnic>
 <20191018163125.346e078d@gandalf.local.home>
 <20191019073424.GA27353@zn.tnic>
 <20191021141038.GC7014@zn.tnic>
 <f8dcb3dd-a8a6-5326-ea4a-bea2eb1c4651@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <f8dcb3dd-a8a6-5326-ea4a-bea2eb1c4651@suse.cz>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Jiri Slaby <jslaby@suse.cz>
Cc: Steven Rostedt <rostedt@goodmis.org>, tip-bot2 for Jiri Slaby <tip-bot2@linutronix.de>, linux-kernel@vger.kernel.org, linux-tip-commits@vger.kernel.org, "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>, Josh Poimboeuf <jpoimboe@redhat.com>, linux-arch@vger.kernel.org, Masami Hiramatsu <mhiramat@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Thomas Gleixner <tglx@linutronix.de>, x86-ml <x86@kernel.org>, Ingo Molnar <mingo@kernel.org>
Message-ID: <20191022125615.9uhdYX1cIK3Y7pBRL8GRuIZ4RjWwVcYXN3GrDzP-CeI@z>

On Tue, Oct 22, 2019 at 01:38:42PM +0200, Jiri Slaby wrote:
> On the top of Steven's comment:
> Acked-by: Jiri Slaby <jslaby@suse.cz>
> 
> Thanks for taking care of this while my tooth was causing me pain.

Sure, np. Toothache is yuck.

Ok, so after some back'n'forth yesterday on IRC, I think we agree on
only renaming function_hook but keeping its SYM_FUNC* annotation so
that ORC can unwind into it because we're fancy and we do all kinds of
unwinding from interrupts in ftrace handlers and all that other fun. So
it needs to know that that thing is a function.

So here it is as a proper patch as a reply to this message.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
