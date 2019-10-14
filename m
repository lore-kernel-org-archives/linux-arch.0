From: Borislav Petkov <bp@alien8.de>
Subject: Re: [PATCH v9 07/28] x86/boot: Annotate local functions
Date: Mon, 14 Oct 2019 16:27:42 +0200
Message-ID: <20191014142742.GD4715@zn.tnic>
References: <20191011115108.12392-1-jslaby@suse.cz>
 <20191011115108.12392-8-jslaby@suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20191011115108.12392-8-jslaby@suse.cz>
Sender: linux-kernel-owner@vger.kernel.org
To: Jiri Slaby <jslaby@suse.cz>
Cc: tglx@linutronix.de, mingo@redhat.com, hpa@zytor.com, x86@kernel.org, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-arch.vger.kernel.org

On Fri, Oct 11, 2019 at 01:50:47PM +0200, Jiri Slaby wrote:
> .Lrelocated, .Lpaging_enabled, .Lno_longmode, and .Lin_pm32 are
> self-standing local functions, annotate them as such and preserve "no
> alignment".
> 
> The annotations do not generate anything yet.

So the annotation is only documentational, right?

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
