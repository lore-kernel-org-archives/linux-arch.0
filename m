From: Dave Martin <Dave.Martin-5wv7dgnIgG8@public.gmane.org>
Subject: Re: [PATCH 05/14] prctl.2: tfix listing order of prctls
Date: Wed, 13 May 2020 12:21:33 +0100
Message-ID: <20200513112133.GH21779@arm.com>
References: <1589301419-24459-1-git-send-email-Dave.Martin@arm.com>
 <1589301419-24459-6-git-send-email-Dave.Martin@arm.com>
 <1bb991f4-176a-a74e-01fc-c73b49ed77f5@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-man-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1bb991f4-176a-a74e-01fc-c73b49ed77f5-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: linux-man-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: "Michael Kerrisk (man-pages)" <mtk.manpages-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: linux-man-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arch-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: linux-arch.vger.kernel.org

On Wed, May 13, 2020 at 12:10:53PM +0200, Michael Kerrisk (man-pages) wrote:
> Hi Dave,
> 
> On 5/12/20 6:36 PM, Dave Martin wrote:
> > The prctl list has historically been sorted by prctl name (ignoring
> > any SET_ or GET_ prefix) to make individual prctls easier to find.
> > Some noise seems to have crept in since.
> > 
> > Sort the list back into order.  Similarly, reorder the list of
> > prctls specified to return non-zero values on success.
> 
> This is a good patch. But see my comments on patch 04.
> I'd prefer a patch like this at the end of a series, 
> rather than in the middle of it.

Ack.

Ideally we could check the order with a script, but that seemed a step
too far.

What's the view on having parts of the man pages generated, rather then
being distributed ready-built?

If we split prctl.2 up with a fragment per prctl, we could paste the
fragments together in the right order with a script.

> 
> > Content movement only.  No semantic change.
> 
> And explicitly noting that detail is very helpful to me.

Unless of course I'm lying ;)  (I'm not, but I won't be offended if you
check.)

Cheers
---Dave
