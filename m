Return-Path: <linux-arch-owner@vger.kernel.org>
Date: Tue, 25 Jan 2005 15:52:39 -0800
From: "David S. Miller" <davem@davemloft.net>
Subject: Re: TASK_SIZE is variable.
Message-Id: <20050125155239.4bc469e6.davem@davemloft.net>
In-Reply-To: <1106692012.6480.158.camel@localhost.localdomain>
References: <1106692012.6480.158.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
To: David Woodhouse <dwmw2@infradead.org>
Cc: linux-arch@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>

On Tue, 25 Jan 2005 22:26:52 +0000
David Woodhouse <dwmw2@infradead.org> wrote:

> Bad things can happen if a 32-bit process is the last user of a 64-bit
> mm.

I guess this is OK.

I think the easiest way to fix this for good is to simply
kill off TASK_SIZE and that way each and every use will be
audited.  We can replace TASK_SIZE with something the describes
what is really wanted:

1) Max address potentially mapped in "mm".  Although I heavily
   dislike the MM_VM_SIZE(mm) scheme because address space size
   is determined by the process emul type, and thus is a thread
   not a mm property

   In fact, look at how nobody seems to even use the "mm" argument
   to this macro.  Further, look at the comment above the ppc64
   definition:

/* We can't actually tell the TASK_SIZE given just the mm, but default
 * to the 64-bit case to make sure that enough gets cleaned up. */

   Yeah, we can't tell the TASK_SIZE from the "mm", no shit.

2) Limits imposed at mmap()/munmap()/mremap() time for virtual
   address arguments.

Thinking about this some more, it may in fact be better to make
these platforms go to using a constant TASK_SIZE, kill this
bogus'ly argumented MM_VM_SIZE(mm) thing, and use something new
for mmap()/mremap()/munmap() et al. argument checking which
is based upon some thread property.
