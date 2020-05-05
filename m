From: Dave Martin <Dave.Martin-5wv7dgnIgG8@public.gmane.org>
Subject: Re: Adding arch-specific user ABI documentation in linux-man
Date: Tue, 5 May 2020 11:55:24 +0100
Message-ID: <20200505105522.GL30377@arm.com>
References: <20200504153214.GH30377@arm.com>
 <32259f3763344500a058a8ca8a3a33d8@bfs.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-man-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <32259f3763344500a058a8ca8a3a33d8-fPG8STNUNVg@public.gmane.org>
Sender: linux-man-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Walter Harms <wharms-fPG8STNUNVg@public.gmane.org>
Cc: Michael Kerrisk <mtk.manpages-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Catalin Marinas <catalin.marinas-5wv7dgnIgG8@public.gmane.org>, Will Deacon <will-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Vincenzo Frascino <vincenzo.frascino-5wv7dgnIgG8@public.gmane.org>, "linux-man-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-man-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-arch-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-arch-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Id: linux-arch.vger.kernel.org

On Tue, May 05, 2020 at 07:45:32AM +0000, Walter Harms wrote:
> Hi Dave,
> you are pointing to an (IMHO) interesting question.
> How to document different CPUs ?
> Given that an operating system should hide the different CPU's using
> CPU specific features should be used sparsely at best.

Agreed!  But there are real situations where cpu specifics can't be
avoided, and having documentation will help people to use those features
correctly.

> the easy part are adds-on like flags for prctrl etc. simply add it to the page.

For prctl, that makes sense (it's a jumble of arch specifics already).

But would it be considered a problem if the ptrace page, say, becomes
80% arch-specific stuff?  That page is cumbersome enough already...

> Other things should go to a cpu specific pages (can of worms). The problem will
> be to keep that small but informative. I have no idea about the level of detail
> (and i have worked with a range of CPUs) that could be interesting for a programmer.
> An of cause every other CPU now needs also a page.

Fair enough.

Cheers
---Dave
