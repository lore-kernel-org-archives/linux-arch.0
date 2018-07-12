Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-wr1-f67.google.com ([209.85.221.67]:34170 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727002AbeGLONP (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 12 Jul 2018 10:13:15 -0400
Date: Thu, 12 Jul 2018 16:03:27 +0200
From: Ingo Molnar <mingo@kernel.org>
Subject: Re: [RFC PATCH v2 25/27] x86/cet: Add PTRACE interface for CET
Message-ID: <20180712140327.GA7810@gmail.com>
References: <20180710222639.8241-1-yu-cheng.yu@intel.com>
 <20180710222639.8241-26-yu-cheng.yu@intel.com>
 <20180711102035.GB8574@gmail.com>
 <1531323638.13297.24.camel@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1531323638.13297.24.camel@intel.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Yu-cheng Yu <yu-cheng.yu@intel.com>
Cc: x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, linux-mm@kvack.org, linux-arch@vger.kernel.org, linux-api@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>, Andy Lutomirski <luto@amacapital.net>, Balbir Singh <bsingharora@gmail.com>, Cyrill Gorcunov <gorcunov@gmail.com>, Dave Hansen <dave.hansen@linux.intel.com>, Florian Weimer <fweimer@redhat.com>, "H.J. Lu" <hjl.tools@gmail.com>, Jann Horn <jannh@google.com>, Jonathan Corbet <corbet@lwn.net>, Kees Cook <keescook@chromiun.org>, Mike Kravetz <mike.kravetz@oracle.com>, Nadav Amit <nadav.amit@gmail.com>, Oleg Nesterov <oleg@redhat.com>, Pavel Machek <pavel@ucw.cz>, Peter Zijlstra <peterz@infradead.org>, "Ravi V. Shankar" <ravi.v.shankar@intel.com>, Vedvyas Shanbhogue <vedvyas.shanbhogue@intel.com>
Message-ID: <20180712140327.CUihe8blFT9BDzuTitg5VrPXTSILBrISUv3mlT911CU@z>


* Yu-cheng Yu <yu-cheng.yu@intel.com> wrote:

> > > diff --git a/arch/x86/kernel/ptrace.c b/arch/x86/kernel/ptrace.c
> > > index e2ee403865eb..ac2bc3a18427 100644
> > > --- a/arch/x86/kernel/ptrace.c
> > > +++ b/arch/x86/kernel/ptrace.c
> > > @@ -49,7 +49,9 @@ enum x86_regset {
> > >  	REGSET_IOPERM64 = REGSET_XFP,
> > >  	REGSET_XSTATE,
> > >  	REGSET_TLS,
> > > +	REGSET_CET64 = REGSET_TLS,
> > >  	REGSET_IOPERM32,
> > > +	REGSET_CET32,
> > >  };
> > Why does REGSET_CET64 alias on REGSET_TLS?
> 
> In x86_64_regsets[], there is no [REGSET_TLS].  The core dump code
> cannot handle holes in the array.

Is there a fundamental (ABI) reason for that?

> > to "CET" (which is a well-known acronym for "Central European Time"),
> > not to CFE?
> > 
> 
> I don't know if I can change that, will find out.

So what I'd suggest is something pretty simple: to use CFT/cft in kernel internal 
names, except for the Intel feature bit and any MSR enumeration which can be CET 
if Intel named it that way, and a short comment explaining the acronym difference.

Or something like that.

Thanks,

	Ingo
