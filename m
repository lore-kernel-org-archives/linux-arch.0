From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH v2] all arches, signal: Move restart_block to struct
 task_struct
Date: Wed, 29 Oct 2014 19:12:57 +0100 (CET)
Message-ID: <alpine.DEB.2.11.1410291908290.5308@nanos>
References: <43c88012a4959cd427ab634906e697fbc524e847.1414604015.git.luto@amacapital.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <43c88012a4959cd427ab634906e697fbc524e847.1414604015.git.luto@amacapital.net>
Sender: linux-kernel-owner@vger.kernel.org
To: Andy Lutomirski <luto@amacapital.net>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@linux-foundation.org>, linux-arch <linux-arch@vger.kernel.org>, Al Viro <viro@zeniv.linux.org.uk>, Richard Weinberger <richard.weinberger@gmail.com>, "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@kernel.org>, Kees Cook <keescook@chromium.org>
List-Id: linux-arch.vger.kernel.org

On Wed, 29 Oct 2014, Andy Lutomirski wrote:

> If an attacker can cause a controlled kernel stack overflow,
> overwriting the restart block is a very juicy exploit target.
> Moving the restart block to struct task_struct prevents this
> exploit.
> 
> Note that there are other fields in thread_info that are also easy
> targets, at least on some architectures.
> 
> It's also a decent simplification, since the restart code is more or
> less identical on all architectures.

I think that's the most important change. Moving common stuff into
common code. The side effect of slightly reducing the attack surface
is nice, but as Al pointed out not really the big win here.
 
Thanks,

	tglx
