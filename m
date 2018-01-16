From: Dave Martin <Dave.Martin@arm.com>
Subject: Re: [PATCH 08/11] signal/arm: Document conflicts with SI_USER and
 SIGFPE
Date: Tue, 16 Jan 2018 17:41:21 +0000
Message-ID: <20180116174120.GB22781@e103592.cambridge.arm.com>
References: <87373b6ghs.fsf@xmission.com>
 <20180112005940.23279-8-ebiederm@xmission.com>
 <20180115174947.GH17719@n2100.armlinux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180115174947.GH17719@n2100.armlinux.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
To: Russell King - ARM Linux <linux@armlinux.org.uk>
Cc: "Eric W. Biederman" <ebiederm@xmission.com>, linux-arch@vger.kernel.org, Al Viro <viro@zeniv.linux.org.uk>, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Oleg Nesterov <oleg@redhat.com>
List-Id: linux-arch.vger.kernel.org

On Mon, Jan 15, 2018 at 05:49:47PM +0000, Russell King - ARM Linux wrote:
> On Thu, Jan 11, 2018 at 06:59:37PM -0600, Eric W. Biederman wrote:
> > Setting si_code to 0 results in a userspace seeing an si_code of 0.
> > This is the same si_code as SI_USER.  Posix and common sense requires
> > that SI_USER not be a signal specific si_code.  As such this use of 0
> > for the si_code is a pretty horribly broken ABI.
> > 
> > Further use of si_code == 0 guaranteed that copy_siginfo_to_user saw a
> > value of __SI_KILL and now sees a value of SIL_KILL with the result
> > that uid and pid fields are copied and which might copying the si_addr
> > field by accident but certainly not by design.  Making this a very
> > flakey implementation.
> > 
> > Utilizing FPE_FIXME, siginfo_layout will now return SIL_FAULT and the
> > appropriate fields will be reliably copied.
> 
> So what do you suggest when none of the SIGFPE FPE_xxx codes match the
> condition that "we don't know what happened" ?  Raise a SIGKILL instead
> maybe?  We will have dumped the VFP state into the kernel log at this
> point, things are pretty much fscked.
> 
> It's probably an impossible condition unless the hardware has failed,
> no one has knowingly reported getting such a dump in their kernel log,
> so it's something that could very likely be changed in some way
> without anyone noticing.

arm64 can optionally not tell you exactly what exception(s) happened for 
vector operations.  This may also be true for 32-bit.

Unfortunately, there's nothing sensible to report in this case, and
there is no such constant as FPE_UNKNOWN.

Currently arm64 sets si_code to 0, which doesn't match any FPE_*
constant (but unfortunately matches SI_USER) -- defining a new, distinct
FPE_UNKNOWN is probably no worse than that. 

I'm not sure yet whether a similar argument applies for 32-bit.

Cheers
---Dave
