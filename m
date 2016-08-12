From: Russell King - ARM Linux <linux@armlinux.org.uk>
Subject: Re: [PATCH] arm: add an option for erratum 657417
Date: Fri, 12 Aug 2016 15:23:25 +0100
Message-ID: <20160812142325.GC1041@n2100.armlinux.org.uk>
References: <1470989957-23671-1-git-send-email-npiggin@gmail.com>
 <20160812123314.GX1041@n2100.armlinux.org.uk>
 <6bc288d9-6bea-1ee2-572f-d397221adaff@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from pandora.armlinux.org.uk ([78.32.30.218]:34138 "EHLO
	pandora.armlinux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752218AbcHLOXi (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Fri, 12 Aug 2016 10:23:38 -0400
Content-Disposition: inline
In-Reply-To: <6bc288d9-6bea-1ee2-572f-d397221adaff@arm.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Robin Murphy <robin.murphy@arm.com>
Cc: Nicholas Piggin <npiggin@gmail.com>, Nicolas Pitre <nicolas.pitre@linaro.org>, linux-arch@vger.kernel.org, Segher Boessenkool <segher@kernel.crashing.org>, Arnd Bergmann <arnd@arndb.de>, Alan Modra <amodra@gmail.com>, linux-kbuild@vger.kernel.org, Julian Brown <julian@codesourcery.com>, Michal Marek <mmarek@suse.com>, Stephen Rothwell <sfr@canb.auug.org.au>, Sam Ravnborg <sam@ravnborg.org>, linux-arm-kernel@lists.infradead.org

On Fri, Aug 12, 2016 at 03:17:06PM +0100, Robin Murphy wrote:
> On 12/08/16 13:33, Russell King - ARM Linux wrote:
> > On Fri, Aug 12, 2016 at 06:19:17PM +1000, Nicholas Piggin wrote:
> >> This patch adds an option which defaults to "y" in cases where we
> >> could possibly be running Cortex A8 and using Thumb2 instructions.
> >> In reality the workaround might not be required at all for the kernel
> >> if virtual instruction memory is linear in physical memory.
> > 
> > Hmm.
> > 
> > The main kernel image is guaranteed to be contiguous in physical memory
> > for all sorts of reasons, so this really isn't a concern for the kernel
> > itself.
> 
> I'm not sure being contiguous matters much - looking at the errata doc,
> the implication is that the branch is supposed to use bits 31:12 of the
> address of the first page, but under the erratum conditions ends up
> taking bits 31:12 of the address of the _second_ page instead. There
> doesn't seem to be any importance of where those pages actually are
> relative to each other.

I've not actually looked at the errata document - I need to jump through
all sorts of stupid hoops to get it through the ARM website.  Ever since
I requested a change of my email address, it now wants all sorts of
personal information that I'm refusing to type in again.  I've no idea
why ARM Ltd wiped out all that information just because I asked for my
email address to be changed.

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
