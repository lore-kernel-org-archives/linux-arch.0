From: Borislav Petkov <bp@alien8.de>
Subject: Re: [PATCH 0/5] x86: finish the MPX removal process
Date: Thu, 23 Jan 2020 21:26:00 +0100
Message-ID: <20200123202600.GG10328@zn.tnic>
References: <20200123190456.8E05ADE6@viggo.jf.intel.com>
 <CAHk-=wgLR5JnaBgCtg0-AAxtdN3=4=LMp6-0212608=vbmCAxg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAHk-=wgLR5JnaBgCtg0-AAxtdN3=4=LMp6-0212608=vbmCAxg@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>, Dave Hansen <dave.hansen@linux.intel.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Peter Zijlstra <peterz@infradead.org>, Andrew Lutomirski <luto@kernel.org>, the arch/x86 maintainers <x86@kernel.org>, linux-arch <linux-arch@vger.kernel.org>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>, Jeff Dike <jdike@addtoit.com>, Richard Weinberger <richard@nod.at>, Anton Ivanov <anton.ivanov@cambridgegreys.com>, Guan Xuetao <gxt@pku.edu.cn>
List-Id: linux-arch.vger.kernel.org

On Thu, Jan 23, 2020 at 11:26:38AM -0800, Linus Torvalds wrote:
> On Thu, Jan 23, 2020 at 11:23 AM Dave Hansen
> <dave.hansen@linux.intel.com> wrote:
> >
> > I'd _rather_ this go in via the x86 tree, but I'm not picky.

Any particular reason why?

I mean, I don't care a whole lot either - I just don't see the point,
see below.

> I have no strong feelings either way. I'll happily pull this tree for
> the 5.6 merge window directly from you, or get it as part of one of
> the x86 -tip pull requests.
> 
> Up to you and the -tip maintainers, really. Thomas/Ingo/Borislav?

My reasoning to suggest to go directly to you is that there's
practically not a whole lotta sense to add a separate branch to tip,
merge Dave's tree and have a merge commit of the mpx branch only which
you then merge into your master.

Or I can apply each patch separately and then send you that branch so
that there's no pointless merge commit in the history before you merge
it but we get the same if you merge Dave's branch directly...

Oh and btw: I ran a bunch of build smoke tests today of the mpx removal
branch with tip/master merged in and except for a trivial include fix,
there were no issues.

But if someone points out a valid argument why it should go through tip,
I'll gladly do it.

Thx guys.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
