From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH] modules: add default loader hook implementations
Date: Sat, 25 Jun 2011 15:08:49 +0200
Message-ID: <201106251508.50129.arnd@arndb.de>
References: <1308987512-6583-1-git-send-email-jonas@southpole.se> <20110625100449.GA19097@elte.hu> <1308998367.6699.30.camel@localhost>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.17.10]:55448 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751414Ab1FYNJk (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Sat, 25 Jun 2011 09:09:40 -0400
In-Reply-To: <1308998367.6699.30.camel@localhost>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Jonas Bonn <jonas@southpole.se>
Cc: Ingo Molnar <mingo@elte.hu>, rusty@rustcorp.com.au, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, monstr@monstr.eu, cmetcalf@tilera.com, Linus Torvalds <torvalds@linux-foundation.org>, Andrew Morton <akpm@linux-foundation.org>

On Saturday 25 June 2011, Jonas Bonn wrote:
> On Sat, 2011-06-25 at 12:04 +0200, Ingo Molnar wrote:
> > Also, and more importantly, don't we generally do such things via 
> > __weak aliases, because the result looks cleaner and needs no changes 
> > for architectures beyond the removal of the generic functions? We 
> > have excluded broken toolchains that miscompile/mislink __weak IIRC 
> > so __weak ought to work.
> 
> When we discussed this briefly yesterday, both Rusty and Arnd showed a
> preference for not using __weak aliases... I'll leave it to them to
> comment further.
> 
> The alternative patch that just provides __weak implementations for
> these hooks is much less invasive than the patch I sent, effectively
> touching only kernel/module.c
> 
> Let me know which is preferable.

I don't care much either way, you would get my Ack for both solutions.
The __weak approach would definitely make a simpler patch, and the
patch you sent adds extra complexity because of the
asm_generic_moduleloader_hooks macro you used to avoid having to
change all other architectures.

	Arnd
