From: Ingo Molnar <mingo@kernel.org>
Subject: Re: [PATCH v6 17/28] x86/asm: use SYM_INNER_LABEL instead of GLOBAL
Date: Sat, 19 May 2018 09:44:13 +0200
Message-ID: <20180519074413.GB2952@gmail.com>
References: <20180518091721.7604-1-jslaby@suse.cz>
 <20180518091721.7604-18-jslaby@suse.cz>
 <CALCETrXwc05073E7A8KG-2dKqNyz=C2zrAQfBqWhjuChfSd5fQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CALCETrXwc05073E7A8KG-2dKqNyz=C2zrAQfBqWhjuChfSd5fQ@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Andy Lutomirski <luto@amacapital.net>
Cc: Jiri Slaby <jslaby@suse.cz>, Ingo Molnar <mingo@redhat.com>, linux-arch <linux-arch@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, Thomas Gleixner <tglx@linutronix.de>, "H. Peter Anvin" <hpa@zytor.com>, X86 ML <x86@kernel.org>
List-Id: linux-arch.vger.kernel.org


* Andy Lutomirski <luto@amacapital.net> wrote:

> On Fri, May 18, 2018 at 2:17 AM Jiri Slaby <jslaby@suse.cz> wrote:
> 
> > GLOBAL had several meanings and is going away. In this patch, convert
> > all the inner function labels marked with GLOBAL to use SYM_INNER_LABEL
> > instead.
> 
> > Note that retint_user needs not be global, perhaps since commit
> > 2ec67971facc ("x86/entry/64/compat: Remove most of the fast system call
> > machinery"), where entry_64_compat's caller was removed. So mark the
> > label as LOCAL.
> 
> 
> > -GLOBAL(entry_SYSCALL_64_after_hwframe)
> > +SYM_INNER_LABEL(entry_SYSCALL_64_after_hwframe, SYM_L_GLOBAL)
> 
> I've missed all the context here.   I agree that GLOBAL is misleading, and
> "inner label" is nice.  But this is a rather wordy macro.  Would:
> 
> INNER_LABEL_GLOBAL(name)
> 
> be better?  (With just INNER_LABEL(name) for the local version?)

Please keep the SYM_ global namespace for all these symbol macros - but the rest 
of the name can be shortened.

Thanks,

	Ingo
