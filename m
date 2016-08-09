From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH 2/5] kbuild: allow archs to select build for link dead code/data elimination
Date: Wed, 10 Aug 2016 00:10:51 +0200
Message-ID: <4272416.nR10D7I1gD@wuerfel>
References: <1470399123-8455-1-git-send-email-npiggin@gmail.com> <1882847.dG563Vieov@wuerfel> <20160808235016.GD20904@bubble.grove.modra.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([212.227.126.133]:60318 "EHLO
	mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932360AbcHIWLB (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Tue, 9 Aug 2016 18:11:01 -0400
In-Reply-To: <20160808235016.GD20904@bubble.grove.modra.org>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Alan Modra <amodra@gmail.com>
Cc: linuxppc-dev@lists.ozlabs.org, Nicholas Piggin <npiggin@gmail.com>, linux-arch@vger.kernel.org, Stephen Rothwell <sfr@canb.auug.org.au>, Nicolas Pitre <nico@linaro.org>, linux-kbuild@vger.kernel.org, Andi Kleen <ak@linux.intel.com>

On Tuesday, August 9, 2016 9:20:16 AM CEST Alan Modra wrote:
> On Mon, Aug 08, 2016 at 05:14:27PM +0200, Arnd Bergmann wrote:
> > I have reverted that patch now, so ARM uses ".fixup" again like every
> > other architecture does, and now "*(.fixup) *(.text .text.*)" works
> > correctly, while ""*(.fixup) *(.text .fixup .text.*)" also fails
> > the same way that I saw before:
> 
> That is really odd.  The linker isn't supposed to treat those script
> snippets differently.  First match for .fixup wins.

Sorry for my mistake. I checked again and cannot reproduce what I
thought I saw earlier. "*(.fixup) *(.text .text.*)" fails
as would be expected.

	Arnd
