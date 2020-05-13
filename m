Return-Path: <SRS0=OnnN=63=vger.kernel.org=linux-arch-owner@kernel.org>
Received: from foss.arm.com ([217.140.110.172]:44060 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729376AbgEMLll (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Wed, 13 May 2020 07:41:41 -0400
Date: Wed, 13 May 2020 12:41:38 +0100
From: Dave Martin <Dave.Martin@arm.com>
Subject: Re: [PATCH 02/14] prctl.2: Add health warning
Message-ID: <20200513114137.GJ21779@arm.com>
References: <1589301419-24459-1-git-send-email-Dave.Martin@arm.com>
 <1589301419-24459-3-git-send-email-Dave.Martin@arm.com>
 <93c5bfe6-fbbe-93ca-ef9c-91228c99d31b@gmail.com>
 <20200513111340.GF21779@arm.com>
 <7218089f-20df-52b3-e1d4-ac63e0215efc@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7218089f-20df-52b3-e1d4-ac63e0215efc@gmail.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: "Michael Kerrisk (man-pages)" <mtk.manpages@gmail.com>
Cc: linux-man@vger.kernel.org, linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Message-ID: <20200513114138.Xc5n579p0PlrVUIE0NwdsqkXLPqKHTReh3o03Hhhl50@z>

On Wed, May 13, 2020 at 01:40:26PM +0200, Michael Kerrisk (man-pages) wrote:
> Hi Dave,
> 
> On 5/13/20 1:13 PM, Dave Martin wrote:
> > On Wed, May 13, 2020 at 12:10:25PM +0200, Michael Kerrisk (man-pages) wrote:
> >> Hi Dave,
> >>
> >> On 5/12/20 6:36 PM, Dave Martin wrote:
> >>> In reality, almost every prctl interferes with assumptions that the
> >>> compiler and C library / runtime rely on.  prctl() can therefore
> >>> make userspace explode in a variety ways that are likely to be hard
> >>> to debug.
> >>>
> >>> This is not obvious to the uninitiated, so add a warning.
> >>
> >> Patch applied. But see my comments on patch 04. I may want to 
> >> circle back on this patch later, since the wording feels a 
> >> little strong to me (we simply must use prctl for some things, 
> >> and not all of those things break user-space/runtime as far 
> >> as I know). If you have some thoughts on softening the warning,
> >> let me know.
> > 
> > Certainly the "if at all" can go -- this was just a suggestion
> > really.
> 
> Yes. Gone.
> 
> > Maybe the whole thing is superfluous.  In C anything can screw up the
> > runtime if you try hard enough.
> 
> I think it's at least worth alerting the reader to this issue.
> 
> > The background to this patch is that things like the new
> > PR_PAC_RESET_KEYS and PR_SVE_SET_VL are likely to crash the program, or
> > place a timebomb that will explode later when someone upgrades their
> > toolchain or links with a new version of some library.  Many existing
> > prctls that look equally unfriendly...
> > 
> > I didn't want to say nothing at all, but I didn't want to get into the
> > gory details either.
> 
> (Okay.)
> 
> > Doing the digging to document the safety requirements of each prctl
> > would be a lot of work, and probably an exercise in futility anyway --
> > how to use a lot of prctls safely depends on the run-time environment as
> > much as it does on the kernel.
> > 
> > 
> > If you want to drop this, I'm happy to add explicit notes to just the
> > new arm64 prctls instead for now.
> 
> I just softened the warning a little; see below. Explicit notes for
> the new arm64 prctls would certainly be welcome.

OK, that works for me.  I'll try to keep it brief.

Cheers
---Dave
