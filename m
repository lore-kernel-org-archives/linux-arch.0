From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [RFC Patch v1 00/31] Synopsys ARC Linux kernel Port
Date: Fri, 18 Jan 2013 22:17:45 +0000
Message-ID: <201301182217.46142.arnd@arndb.de>
References: <1352281674-2186-1-git-send-email-vgupta@synopsys.com> <50AB9116.3090401@synopsys.com> <20130118194631.GA5119@amd.pavel.ucw.cz>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.17.10]:59465 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751815Ab3ARWRv (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Fri, 18 Jan 2013 17:17:51 -0500
In-Reply-To: <20130118194631.GA5119@amd.pavel.ucw.cz>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Pavel Machek <pavel@ucw.cz>
Cc: Vineet Gupta <Vineet.Gupta1@synopsys.com>, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, tglx@linutronix.de

On Friday 18 January 2013, Pavel Machek wrote:
> Yeah, and it is best use of reviewers time to confuse them with
> one-letter difference to very popular architecture... and use three
> letter acronym that was already taken.
> 
> In this state, I hope your port never gets merged. Yes, I got used to
> do cd a<tab>/ar<tab>.

You already lost that capability with the addition of arm64. As you
may remember, that one was proposed to be called arch/aarch64 at first,
which wasn't very popular ;-)

A lot of people are familiar with the ARC name, it's been around
for decades and has sold billions of CPUs under that name, likely
more than x86 or mips (still dwarfed by ARM of course). They've just
kept a low profile so far and never tried to upstream their Linux
port (unlike their gcc port, which was merged in 1997).

I'm sure there are a lot of bad things one can say about Synopsys,
but they are doing the right thing here, and calling their CPU
architecture by a different name is not going to be helpful
to their users.

	Arnd
