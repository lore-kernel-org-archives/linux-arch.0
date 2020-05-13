From: Will Deacon <will-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH 14/14] prctl.2: Add PR_PAC_RESET_KEYS (arm64)
Date: Wed, 13 May 2020 22:00:22 +0100
Message-ID: <20200513210022.GA28594@willie-the-truck>
References: <1589301419-24459-1-git-send-email-Dave.Martin@arm.com>
 <1589301419-24459-15-git-send-email-Dave.Martin@arm.com>
 <20200513072530.GA18196@willie-the-truck>
 <20200513143653.GQ21779@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-man-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20200513143653.GQ21779-5wv7dgnIgG8@public.gmane.org>
Sender: linux-man-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Dave Martin <Dave.Martin-5wv7dgnIgG8@public.gmane.org>
Cc: mtk.manpages-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, linux-man-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arch-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Catalin Marinas <catalin.marinas-5wv7dgnIgG8@public.gmane.org>, Amit Daniel Kachhap <amit.kachhap-5wv7dgnIgG8@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>
List-Id: linux-arch.vger.kernel.org

On Wed, May 13, 2020 at 03:36:54PM +0100, Dave Martin wrote:
> On Wed, May 13, 2020 at 08:25:31AM +0100, Will Deacon wrote:
> > On Tue, May 12, 2020 at 05:36:59PM +0100, Dave Martin wrote:
> > > +As a special case, if
> > > +.I arg2
> > > +is zero then all the keys are reset.
> > > +Since new keys could be added in future,
> > > +this is the recommended way to completely wipe the existing keys
> > > +when creating a new execution context.
> > 
> > I see what you're saying, but the keys are also reset on exec() iirc, so we
> > don't want to encourage people to issue the prctl() unnecessarily
> > immediately following an exec().
> 
> I thought of saying that, then pulled it out again.
> 
> How about:
> 
> "[...] a new execution context within an existing process.  Note that
> execve() always resets all the keys as part of its operation, without
> the need for this prctl() call.  PR_PAC_RESET_KEYS is intended for
> custom situations that do not involve execve(), such as creating a new
> managed run-time sandbox."
> 
> I deliberately don't say "thread" because that's probably libc's job.
> I'll need to check glibc does, though.  There may be issues with
> pthreads semantics that mean we can't reset the keys there.

That's better, but you may even be able to drop the "such as..." part, I
reckon.

> > > @@ -1920,6 +1960,27 @@ are not 0.
> > >  .B EINVAL
> > >  .I option
> > >  was
> > > +.B PR_PAC_RESET_KEYS
> > > +and
> > > +.I arg2
> > > +contains non-zero bits other than
> > > +.BR
> > > +.BR PR_PAC_APIAKEY ,
> > > +.BR PR_PAC_APIBKEY ,
> > > +.BR PR_PAC_APDAKEY ,
> > > +.B PR_PAC_APDBKEY
> > > +and
> > > +.BR PR_PAC_APGAKEY ;
> > > +or
> > > +.IR arg3 ,
> > > +.I arg4
> > > +and
> > > +.I arg5
> > > +were not all zero.
> > 
> > Do we care about other reasons for -EINVAL, such as the system not
> > supporting pointer authentication?
> 
> Again, I tried to catch that under the new "not supported by this
> platform" wording in the earlier patch.  Do you think that's sufficient,
> or do we need something else here?

As long as it's clear that the prctl() *can* fail and userspace can't just
ignore the return value, then I'm happy. If it's not obvious, then spelling
it out seems harmless to me.

Will
