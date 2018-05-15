From: Ingo Molnar <mingo@kernel.org>
Subject: Re: [PATCH -resend 02/27] x86: assembly, use SYM_DATA for data
Date: Tue, 15 May 2018 08:39:35 +0200
Message-ID: <20180515063935.GA25721@gmail.com>
References: <20180510080644.19752-1-jslaby@suse.cz>
 <20180510080644.19752-3-jslaby@suse.cz>
 <20180514080549.GB6607@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180514080549.GB6607@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Jiri Slaby <jslaby@suse.cz>
Cc: mingo@redhat.com, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>, Thomas Gleixner <tglx@linutronix.de>, "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org, linux-pm@vger.kernel.org
List-Id: linux-arch.vger.kernel.org


* Ingo Molnar <mingo@kernel.org> wrote:

> 
> * Jiri Slaby <jslaby@suse.cz> wrote:
> 
> > We make proper use of SYM_DATA on global data instead of marking them as
> > ENTRY. ENTRY is intended for functions and shall be paired with ENDPROC.
> > ENTRY also aligns symbols which creates unnecessary holes here between
> > data.
> > 
> > ENTRY from saved_eip in wakeup_32 and many saved_* in wakeup_64 is
> > simply dropped, as these symbols are local only.
> 
> Yeah, so this commit talks about ENTRY() and ENDPROC(), while the new methods are 
> SYM_FUNC_START()/END().

BTW., I like the series otherwise: for example in my comment above I wrote up the 
SYM_FUNC_START()/END() names from memory, without having to look up the 
primitives.

[ Then I double checked it from the series to make sure I got it right. ;-) ]

Before this I could never remember all these random, idiosyncratic, path dependent 
macro names - now there's at least some good high level structure to them. So it's 
a good step forward.

Thanks,

	Ingo
