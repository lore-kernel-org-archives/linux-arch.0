Return-Path: <linux-arch-owner@vger.kernel.org>
Date: Sun, 3 Apr 2005 21:02:01 -0700
From: "David S. Miller" <davem@davemloft.net>
Subject: Re: Consolidation of asm/unaligned.h
Message-Id: <20050403210201.6ecd41aa.davem@davemloft.net>
In-Reply-To: <1112586161.7087.3.camel@mulgrave>
References: <20050317104744.4be7e550.davem@davemloft.net>
	<1112586161.7087.3.camel@mulgrave>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
To: James Bottomley <James.Bottomley@steeleye.com>
Cc: linux-arch@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>

On Sun, 03 Apr 2005 22:42:41 -0500
James Bottomley <James.Bottomley@SteelEye.com> wrote:

> I just got around to checking this on parisc, and I'm afraid we have a
> toolchain cockup:  Our gcc can't optimise the sizeof() if the user is an
> inline function.  It can, however if the functions are made #defines
> instead.
> 
> Would the attached be OK with everyone?  It works fine for us.

Please explain what you mean by "optimize"?

If you are saying what I think you're saying (that gcc always
emits the entire switch statement, not just the constant case
we need) I bet it has to do with inlining or switch statement
heuristics.

In any event, I'd like to be better informed, because this means
you're getting terrible code in a lot of places as this is
a common technique in the kernel header files.

I also don't want to make these macros, since if we do so we lose
the type checking and we also get into the world of CPP macro arg
multiple-evaluation crazyness.
