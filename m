From: Dave Martin <Dave.Martin@arm.com>
Subject: Re: [RFC PATCH] arm64: signal: Make parse_user_sigframe()
 independent of rt_sigframe layout
Date: Mon, 26 Jun 2017 17:38:15 +0100
Message-ID: <20170626163814.GJ8543@e103592.cambridge.arm.com>
References: <1498208859-6099-1-git-send-email-Dave.Martin@arm.com>
 <20170625150544.2qsh4hpnmxygmcft@yury-thinkpad>
 <20170626093518.GG8543@e103592.cambridge.arm.com>
 <20170626153827.kzraqd3s7gavx3uw@yury-thinkpad>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:46790 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751435AbdFZQiS (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Mon, 26 Jun 2017 12:38:18 -0400
Content-Disposition: inline
In-Reply-To: <20170626153827.kzraqd3s7gavx3uw@yury-thinkpad>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Yury Norov <ynorov@caviumnetworks.com>
Cc: linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org

On Mon, Jun 26, 2017 at 06:38:27PM +0300, Yury Norov wrote:
> On Mon, Jun 26, 2017 at 10:35:21AM +0100, Dave Martin wrote:
> > On Sun, Jun 25, 2017 at 06:05:44PM +0300, Yury Norov wrote:
> > > On Fri, Jun 23, 2017 at 10:07:39AM +0100, Dave Martin wrote:
> > > > ILP32 support uses the same struct sigcontext as the native ABI
> > > > (i.e., LP64), but a different layout for the rest of the signal
> > > > frame (since siginfo_t and ucontext_t are both ABI-dependent).
> > > > 
> > > > Since the purpose of parse_user_sigframe() is really to parse
> > > > sigcontext and not the whole signal frame, the function does not
> > > > need to depend on the layout of rt_sigframe -- the only purpose of
> > > > the rt_sigframe pointer is for use as a base to measure the signal
> > > > frame size.
> > > > 
> > > > So, this patch renames the function to parse_user_sigcontext() and
> > > > makes the sigframe base pointer generic.  ABI-specific parsers that
> > > > share the same sigcontext definition can then call it.
> > > > 
> > > > To minimise churn in this patch, the native LP64 parser is retained
> > > > under the old name, but becomes a call to parse_user_sigconext().
> > > > It may make sense instead to fold this into its restore_sigframe(),
> > > > depending on how ILP32 support is integrated.
> > > > 
> > > > Suggested-by: Yury Norov <ynorov@caviumnetworks.com>
> > > > Signed-off-by: Dave Martin <Dave.Martin@arm.com>
> > > > ---
> > > > 
> > > > This patch depends on [1], which does not appear to be applied yet.
> > > > 
> > > > [1] [PATCH] arm64: signal: Allow expansion of the signal frame                  http://lists.infradead.org/pipermail/linux-arm-kernel/2017-June/514699.html
> > 
> > [...]
> > 
> > FYI, [1] above is now merged in arm64 for-next/core, so we shouldn't
> > have dependency issues with this patch.
> > 
> > > > +static int parse_user_sigframe(struct user_ctxs *user,
> > > > +			       struct rt_sigframe __user const *sf)
> > > > +{
> > > > +	return parse_user_sigcontext(user, &sf->uc.uc_mcontext, sf);
> > > > +}
> > > > +
> > > 
> > > Hi Dave, 
> > > 
> > > Thank you. Seems this is what I need. Only one thing. We can #define
> > > parse_user_sigframe() as macro, and so bypass type control.
> > > The macro then will be used both by lp64 and ilp32 without any
> > > modification.
> > 
> > For the reasons you already gave, parse_user_sigframe is probably not
> > the right name for such a macro.  But it otherwise makes sense as an
> > interface.  Does [2] look OK for you?
>  
> Yes, looks good, thank you.
> 
> > Unless you suggest otherwise, I don't plan to maintain or push this
> > patch -- I think it makes more sense for you to carry it in the ILP32
> > series, since that's the only thing that needs it.
> 
> I'll just add it to ilp32 series.

OK, thanks

Let me know if you have any other questions.

Cheers
---Dave
