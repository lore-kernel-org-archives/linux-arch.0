From: Dave Martin <Dave.Martin@arm.com>
Subject: Re: [PATCH 07/11] signal/arm64: Document conflicts with SI_USER and
 SIGFPE, SIGTRAP, SIGBUS
Date: Wed, 17 Jan 2018 15:37:31 +0000
Message-ID: <20180117153731.GG22781@e103592.cambridge.arm.com>
References: <87373b6ghs.fsf@xmission.com>
 <20180112005940.23279-7-ebiederm@xmission.com>
 <20180115163028.GU22781@e103592.cambridge.arm.com>
 <87h8rnox3c.fsf@xmission.com>
 <20180116172407.GA22781@e103592.cambridge.arm.com>
 <871sipl9p9.fsf@xmission.com>
 <20180117115708.GM17719@n2100.armlinux.org.uk>
 <20180117121505.GD22781@e103592.cambridge.arm.com>
 <20180117123752.GN17719@n2100.armlinux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <20180117123752.GN17719@n2100.armlinux.org.uk>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Russell King - ARM Linux <linux@armlinux.org.uk>
Cc: linux-arch@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>, Nicolas Pitre <nico@linaro.org>, Tony Lindgren <tony@atomide.com>, Catalin Marinas <catalin.marinas@arm.com>, Tyler Baicar <tbaicar@codeaurora.org>, Will Deacon <will.deacon@arm.com>, linux-kernel@vger.kernel.org, Oleg Nesterov <oleg@redhat.com>, James Morse <james.morse@arm.com>, "Eric W. Biederman" <ebiederm@xmission.com>, Olof Johansson <olof@lixom.net>, Santosh Shilimkar <santosh.shilimkar@ti.com>, linux-arm-kernel@lists.infradead.org, Al Viro <viro@zeniv.linux.org.uk>
List-Id: linux-arch.vger.kernel.org

On Wed, Jan 17, 2018 at 12:37:52PM +0000, Russell King - ARM Linux wrote:
> On Wed, Jan 17, 2018 at 12:15:05PM +0000, Dave Martin wrote:
> > On Wed, Jan 17, 2018 at 11:57:09AM +0000, Russell King - ARM Linux wrote:

[...]

> > > VFP used to use force_sig_info(), but it seems to be really the wrong
> > > call to use.  force_sig_info() checks whether the program decided to
> > > ignore or block the signal, and if it did, replaces the signal handler
> > > with the default handler and unblocks the signal.
> > > 
> > > Are you really suggesting that FP all FP signals should get this
> > > treatment?
> > 
> > feenableexcept(FE_OVERFLOW) kind of means "I can't run safely past
> > an fp overflow exception, please signal me instead".
> > 
> > If the process also blocked SIGFPE, that could be taken to mean
> > "I can't run safely past an fp overflow exception _and_ I can't
> > take SIGFPE either" ... i.e., if an fp overflow happens there is
> > no way to proceed and it's really fatal.
> > 
> > What SIG_IGN ought to mean is rather more debatable, but again,
> > the process could be asking for two opposite things: guarantee a
> > SIGFPE is delivered instead of running past an fp exception, and
> > also guarantee that SIGFPE is _not_ delivered.
> > 
> > It looks like arm and arm64 are different from most other arches
> > (including x86) here, but I'm not sure what is considered correct, and
> > it looks like the answer is not standardised.  There's a possibility
> > that some software goes subtly wrong on arm/arm64 where on other arches
> > it would get terminated with SIGKILL.
> > 
> > Whether this matters depends on how harmless the fp exception is to
> > the work of the program.  I think if an exception is set to trap
> > via feenableexcept() then that's a strong hint the programmer thinks
> > that exception is not harmless.  OTOH, trapping is not always
> > available anyway...
> 
> Like many of these things, there is no clear answer.  It's a set of
> conflicting requirements, and as you point out, even if you've called
> feenableexcept(), you are not guaranteed to get a trap.
> 
> However, do remember that FP exceptions on ARM hardware are already
> asynchronous - they get reported by the _next_ FP operation to the one
> that caused them, which means they could be raised by a library function
> sometime after it occured (when the library function decides to save the
> FP registers to the stack before it makes use of them.)  It's entirely
> possible that the library function has blocked FP signals temporarily
> (not explicitly, just decided to block all signals while it does
> something sensitive) and will unblock them again afterwards - at which
> point we get the SIGFPE, and it would be quite right to deliver that
> signal to the user SIGFPE handler, rather than forcing it onto the
> program mid-library function.
> 
> It's also possible that SIGFPE could be blocked by another signal handler
> having been invoked, and it triggers the latent generation of the SIGFPE.
> 
> I'd be more inclined to agree with you if VFP exceptions were synchronous
> but they aren't.

Hmmm, it looks like imprecise fp exception traps are disallowed from
ARMv8 onwards.  I guess they made more sense when the FPU really was a
coprocessor, or at least semidetached from the integer core.

I think force_sig_info() makes sense here if and only if the traps
are guaranteed to be precise, so we probably should use this on arm64.
Not arm though (alpha doesn't either, if I understand the code
correctly.)

Does that make sense?

Apparently, few recent cores (at least ARM's own ones) support fp
exception trapping anyway...  1176 may be the most recent.

Cheers
---Dave
