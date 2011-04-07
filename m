From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCHES] Generalize PCI <-> OF node matching
Date: Fri, 08 Apr 2011 07:50:59 +1000
Message-ID: <1302213059.2458.42.camel@pasglop>
References: <1302146796-26825-1-git-send-email-benh@kernel.crashing.org>
	 <4D9DA5DF.8020303@monstr.eu>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from gate.crashing.org ([63.228.1.57]:54976 "EHLO gate.crashing.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751631Ab1DGVvb (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Thu, 7 Apr 2011 17:51:31 -0400
In-Reply-To: <4D9DA5DF.8020303@monstr.eu>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: monstr@monstr.eu
Cc: linux-pci@vger.kernel.org, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, davem@davemloft.net, bheglaas@google.com, tglx@linuxtronix.de, bigeasy@linuxtronix.de

On Thu, 2011-04-07 at 13:54 +0200, Michal Simek wrote:
> There are several coding style issues.
> Please look at it through checkpatch.pl.

I tend to generally ignore checkpatch :-) I have my reasons... I'll have
a quick look see if there's anything really worthwhile in there but in
general I dislike "absolute" rules such as what checkpatch imposes.

> Compilation is fine for Microblaze as you surely saw.
> I am not able to test it on real hw right now but I will ask for
> remote connection to the board.

Thanks.

Cheers,
Ben.
