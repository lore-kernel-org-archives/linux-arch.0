From: Dave Martin <Dave.Martin@arm.com>
Subject: Re: [PATCH v3 0/2] prctl.2 man page updates for Linux 5.6
Date: Mon, 20 Jul 2020 17:52:07 +0100
Message-ID: <20200720165205.GI30452@arm.com>
References: <1593020162-9365-1-git-send-email-Dave.Martin@arm.com>
 <c17e330c-69f7-da7a-feae-cb8b8f5d7ea0@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.110.172]:34718 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726506AbgGTQwL (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Mon, 20 Jul 2020 12:52:11 -0400
Content-Disposition: inline
In-Reply-To: <c17e330c-69f7-da7a-feae-cb8b8f5d7ea0@gmail.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: "Michael Kerrisk (man-pages)" <mtk.manpages@gmail.com>
Cc: linux-arch@vger.kernel.org, linux-man@vger.kernel.org, Catalin Marinas <catalin.marinas@arm.com>, Mark Rutland <mark.rutland@arm.com>, Vincenzo Frascino <vincenzo.frascino@arm.com>, Will Deacon <will@kernel.org>, linux-arm-kernel@lists.infradead.org

On Mon, Jun 29, 2020 at 01:52:24PM +0200, Michael Kerrisk (man-pages) wrote:
> Hi Dave,
> 
> On 6/24/20 7:36 PM, Dave Martin wrote:
> > A bunch of updates to the prctl(2) man page to fill in missing
> > prctls (mostly) up to Linux 5.6 (along with a few other tweaks and
> > fixes).
> > 
> > Patches from the v2 series [1] that have been applied or rejected
> > already have been dropped.
> > 
> > All that remain here now are the SVE and tagged address ABI controls
> > for arm64.
> > 
> > 
> > 
> > [1] https://lore.kernel.org/linux-man/1590614258-24728-1-git-send-email-Dave.Martin@arm.com/
> > 
> > 
> > Dave Martin (2):
> >   prctl.2: Add SVE prctls (arm64)
> >   prctl.2: Add tagged address ABI control prctls (arm64)
> > 
> >  man2/prctl.2 | 331 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
> >  1 file changed, 331 insertions(+)
> Thanks. I've pushed these changes to master now.

Thanks -- btw I finally got around to reviewing master, and noted a few
editorial changes that man-pages(7) does not make any statement about:

"arg1, arg2, and arg3"

	Do you strictly prefer the command before "and" here?

	Conventionally, the final comma would typically be omitted in
	prose, except where the list members are complex enough that the
	command is required to assist parsing.  However, lists of formal
	arguments are not quite vanilla prose.

"Providing that" -> "Provided that"

	Any particular rationale here?

"error EFOO" -> "the error EFOO"

	Is this a rule, in general?

.IP \(bu 2

	I assumed that specifying an explicit indentation amount would
	be fragile.  Going with the default behaviour also tends to
	result in a more consistent appearance.  Do you have any
	recommandations in this area?

	Do you have rules about the order to use bullet symbols?  I tend
	to avoid \(bu if possible, since while it's "correct", nroff can
	render it nastily as an unadorned letter "o" (e.g., with -Tascii
	or LC_CTYPE=C).  This is particlarly annoying if the indent is
	<= 2, since then the "o" tends to be visually swallowed by the
	following text (i.e., to a casual glance it looks like a word,
	particlarly if the following text is not capitalised).  Perhaps
	this is a bad glyph substitution decision in nroff rather than
	something that should be fixed in the man-pages source, but the
	man-pages source may be easier to fix...
	
	There is already inconsistency here: there are may top-level
	lists using ".IP *" in prctl.2, and plenty of places where the
	default indentation is used.


Should any of these be written up in man-pages(7), or is there a checker
than can detect them?

I wan't to minimise the amount of tweaking you have to do when merging
patches.

Cheers
---Dave
