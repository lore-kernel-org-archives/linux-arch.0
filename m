Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from dallas.jonmasters.org ([72.29.103.172]:34755 "EHLO
	dallas.jonmasters.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754562AbZGNKax (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Tue, 14 Jul 2009 06:30:53 -0400
Subject: Re: [PATCH] reduce export symbol CRC table size on 64-bit	 archs
From: Jon Masters <jonathan@jonmasters.org>
In-Reply-To: <4A5B101E020000780000A284@vpn.id2.novell.com>
References: <4A4A18780200007800008345@vpn.id2.novell.com>
	 <4A4E671C.2090201@suse.cz> <4A51C71B0200007800008EE2@vpn.id2.novell.com>
	 <200907092044.22108.rusty@rustcorp.com.au>
	 <4A57089B0200007800009C0E@vpn.id2.novell.com> <4A5AEC3C.2060608@suse.cz>
	 <4A5B101E020000780000A284@vpn.id2.novell.com>
Content-Type: text/plain
Date: Tue, 14 Jul 2009 06:29:32 -0400
Message-ID: <1247567372.31188.229.camel@perihelion.bos.jonmasters.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Jan Beulich <JBeulich@novell.com>
Cc: Michal Marek <mmarek@suse.cz>, Ingo Molnar <mingo@elte.hu>, tony.luck@intel.com, Thomas Gleixner <tglx@linutronix.de>, Rusty Russell <rusty@rustcorp.com.au>, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, linux-modules@vger.kernel.org, hpa@zytor.com
Message-ID: <20090714102932.v0LWhnQTSWpx3p5DDhzshuNBj5JrvpYaFGG8OunRwac@z>

On Mon, 2009-07-13 at 09:44 +0100, Jan Beulich wrote:
> >>> Michal Marek <mmarek@suse.cz> 13.07.09 10:11 >>>
> >Jan Beulich napsal(a):
> >> Actually I meanwhile think that module-init-tools can easily detect the changed
> >> layout without any further kernel side adjustments: Since it is known that a
> >> CRC always is a 32-bit value, simply checking whether the so-far-used 64-bit
> >> value has more than 32 significant bits should suffice: If so, the new layout
> >> is being used (with the symbol name starting at offset 4), else the old one is
> >> in effect (name at offset 8). This ought to be a pretty trivial change to that
> >> code.
> >
> >But old module-init-tools will continue reading garbage in this case.

Most of the distros can fix that with a dependency on the kernel package
in the absolute worst case, not that I love that idea, but it happens. I
assume for now we are going with detecting the two possibilities because
it doesn't really hurt in any case to have this support.

Jon.


