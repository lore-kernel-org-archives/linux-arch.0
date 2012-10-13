From: Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH 00/25] asm-generic: Convert all to use Kbuild file
Date: Sat, 13 Oct 2012 10:20:47 -0400
Message-ID: <1350138047.24256.111.camel@gandalf.local.home>
References: <20121013022632.024527228@goodmis.org>
	 <CAHkRjk4D87V9F2-Y5d1A-s+mnt_TpkOSg+dLz6cRtR25aqqoUg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-15"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from hrndva-omtalb.mail.rr.com ([71.74.56.122]:8956 "EHLO
	hrndva-omtalb.mail.rr.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753118Ab2JMOUs (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Sat, 13 Oct 2012 10:20:48 -0400
In-Reply-To: <CAHkRjk4D87V9F2-Y5d1A-s+mnt_TpkOSg+dLz6cRtR25aqqoUg@mail.gmail.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Catalin Marinas <catalin.marinas@arm.com>
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>

On Sat, 2012-10-13 at 11:17 +0100, Catalin Marinas wrote:
> Hi Steven,
> 
> On 13 October 2012 03:26, Steven Rostedt <rostedt@goodmis.org> wrote:
> > Recently I suggested to someone that was adding a new asm file that
> > currently only contained an x86 change to add a header in all archs
> > that was just a wrapper to point to the asm-generic version. I suggested
> > this because that's the way we use to do it and just to refresh my
> > memory, I looked at div64.h in a few archs and saw that was the case.
> >
> > After having the change done and just after finishing testing it, I was
> > notified that the "proper" way of doing this is to add it to the
> >
> >   arch/*/include/asm/Kbuild
> >
> > file, as 'generic-y += foo.h' and it will reference the asm-generic
> > file automatically. Well it would have been nice if I knew this before
> > and wasn't confused by seeing the incorrect method.
> 
> Since you are  cleaning this up already, could you please merge these
> patches into your series:
> 
> https://lkml.org/lkml/2012/10/11/291
> 
> The first patch adds support for generic-y in the new
> arch/*/include/uapi/asm/Kbuild file, followed by few patches to
> convert three architectures. There will probably be more to convert
> after -rc1.

If the maintainers don't, I'll be happy to take them in too. I can set
up a separate branch for this. I'll see what I can do next week,
although I'll be traveling for the RTLWS.

-- Steve
