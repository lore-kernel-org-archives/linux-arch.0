Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.126.187]:58129 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754248Ab3COTnz (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Fri, 15 Mar 2013 15:43:55 -0400
From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: Fwd: [PATCH] Turn off -Wmaybe-uninitialized when building with -Os
Date: Fri, 15 Mar 2013 19:43:45 +0000
References: <201303151455.38917.arnd@arndb.de> <20130315181246.GW4977@n2100.arm.linux.org.uk>
In-Reply-To: <20130315181246.GW4977@n2100.arm.linux.org.uk>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-ID: <201303151943.45980.arnd@arndb.de>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: linux-kbuild@vger.kernel.org, Michal Marek <mmarek@suse.cz>, linux-arch@vger.kernel.org, inux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Message-ID: <20130315194345.ge0jJMsE2a6VR8jqprefUGyWqMjA_E3lqwMrmNPzNgQ@z>

On Friday 15 March 2013, Russell King - ARM Linux wrote:
> On Fri, Mar 15, 2013 at 02:55:38PM +0000, Arnd Bergmann wrote:

> > I'd like to merge this for 3.9 and also for the stable kernels,
> > if people agree this is a good idea.
> 
> I think I replied to your previous version recently asking whether
> this affects real uninitialized variables too.

If gcc can prove that there is a code path in which the variable is
used uninitialized, it will still warn with this patch, since we are
leaving -Wuninitialized enabled but only disable -Wmaybe-uninitilized.
There are obviously some cases where gcc correctly warns today but
cannot prove whether or not this is actually possible. I don't have
any data about how often we'd see one or the other, but I would expect
the first one to be more common.

We'd also still see all valid warnings with the Kconfig default of
building with -O2 rather than -Os, and as gcc gets smarter over time,
it should show more of the real bugs with -Wuninitialized.

I think the real trade-off is that not applying this patch will cause
more patches to get merged that add bogus initializations, which
definitely prevent gcc from warning about a real uninitialized
variable bug in that function again. I have done some of those
patches myself in the past, but it always feels really wrong to
do those.

	Arnd
