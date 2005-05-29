Return-Path: <linux-arch-owner@vger.kernel.org>
Date: Sun, 29 May 2005 03:14:22 -0700
From: William Lee Irwin III <wli@holomorphy.com>
Subject: Re: Lots of possible arch breakage in cpu_idle!!
Message-ID: <20050529101422.GO2057@holomorphy.com>
References: <4299523F.90502@yahoo.com.au> <20050529094246.GM2057@holomorphy.com> <429994BA.3040806@yahoo.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <429994BA.3040806@yahoo.com.au>
To: Nick Piggin <nickpiggin@yahoo.com.au>
Cc: linux-arch@vger.kernel.org, Andrew Morton <akpm@osdl.org>
List-ID: <linux-arch.vger.kernel.org>

> William Lee Irwin III wrote:
On Sun, May 29, 2005 at 03:25:19PM +1000, Nick Piggin wrote:
>> Your cpu_idle routines need to obey the following rules:
>> The cpu_idle() routines you suggest return, which is "unexpected"
>> (AFAICT even on i386). Mind explaining how is this supposed to work?

On Sun, May 29, 2005 at 08:08:58PM +1000, Nick Piggin wrote:
> Eek! They shouldn't.
> That would be a bug... but I don't see it (in i386)
> i386's mwait_idle, default_idle, poll_idle, etc. of course will
> return (when need_resched() goes high). Then cpu_idle() will then
> call schedule()
> Or did the list of rules erroneously imply that it should return?
> Anyway, thanks for casting your eye over this, much appreciated.

I think I misread the diff, sorry.


-- wli
