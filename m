Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-qt0-f175.google.com ([209.85.216.175]:35219 "EHLO
        mail-qt0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753131AbcK0Cdu (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sat, 26 Nov 2016 21:33:50 -0500
Received: by mail-qt0-f175.google.com with SMTP id c47so95118843qtc.2
        for <linux-arch@vger.kernel.org>; Sat, 26 Nov 2016 18:33:49 -0800 (PST)
Date: Sat, 26 Nov 2016 21:33:47 -0500 (EST)
From: Nicolas Pitre <nicolas.pitre@linaro.org>
Subject: Re: [PATCH 1/2] kbuild: provide include/asm/asm-prototypes.h for
 ARM
In-Reply-To: <20161123103640.GC14217@n2100.armlinux.org.uk>
Message-ID: <alpine.LFD.2.20.1611262124040.1715@knanqh.ubzr>
References: <20161122110557.1533467-1-arnd@arndb.de> <alpine.LFD.2.20.1611221106410.1814@knanqh.ubzr> <20161123120436.18dc21e7@roar.ozlabs.ibm.com> <alpine.LFD.2.20.1611222030050.1814@knanqh.ubzr> <20161123093332.GB14217@n2100.armlinux.org.uk>
 <20161123103640.GC14217@n2100.armlinux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Russell King - ARM Linux <linux@armlinux.org.uk>
Cc: linux-arch@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>, =?ISO-8859-15?Q?Uwe_Kleine-K=F6nig?= <uwe@kleine-koenig.org>, linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org, Nicholas Piggin <npiggin@gmail.com>, regressions@leemhuis.info, viro@zeniv.linux.org.uk, linux-arm-kernel@lists.infradead.org
Message-ID: <20161127023347.NCP1ayP9u7Jh2dH8PJrUMGtc3-VLTMKTflYW_sP-GYw@z>

On Wed, 23 Nov 2016, Russell King - ARM Linux wrote:

> On Wed, Nov 23, 2016 at 09:33:32AM +0000, Russell King - ARM Linux wrote:
> > So, I still think the whole approach is wrong - it's added extra
> > fragility that wasn't there with the armksyms.c approach.
> 
> Here's what the diffstat and patch looks like when you combine the
> original commit and the three fixes.  The LoC delta of 25 lines can
> be accounted for as deleted commentry.  So, I think (as I've detailed
> above) that the _technical_ benefit of the approach is very low.
> 
> If we want to move the exports into assembly files, I've no problem
> with that, provided we can do it better than this - and by better I
> mean not creating the fragile asm-prototypes.h which divorses the
> prototypes from everything else.

I think we agree on that.

I see that the revert made it to Linus' tree.  That's probably the best 
outcome for now.

I was working on that better solution I alluded to previously. And it 
isn't really complicated either, with much fewer lines of code.  But 
this can wait for the next merge window.


Nicolas
