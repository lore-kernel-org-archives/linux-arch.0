Return-Path: <linux-arch-owner+james.bottomley=40steeleye.com-S270586AbUJUGLD@vger.kernel.org>
Received: from gate.crashing.org ([63.228.1.57]:46504 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S270266AbUJUGIK (ORCPT
	<rfc822;linux-arch@vger.kernel.org>);
	Thu, 21 Oct 2004 02:08:10 -0400
Received: from localhost (localhost [127.0.0.1])
	by gate.crashing.org (8.12.8/8.12.8) with ESMTP id i9L67MBG023891
	for <linux-arch@vger.kernel.org>; Thu, 21 Oct 2004 01:07:23 -0500
Subject: Re: Interrupts & total mess
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
In-Reply-To: <1098338732.3939.20.camel@gaston>
References: <1098338732.3939.20.camel@gaston>
Content-Type: text/plain
Message-Id: <1098338864.3973.22.camel@gaston>
Mime-Version: 1.0
Date: Thu, 21 Oct 2004 16:07:44 +1000
Content-Transfer-Encoding: 7bit
To: Linux Arch list <linux-arch@vger.kernel.org>
List-ID: <linux-arch.vger.kernel.org>

On Thu, 2004-10-21 at 16:05, Benjamin Herrenschmidt wrote:
> Ok so my simple project of adding NO_IRQ definitions all over the place
> is turning into a nightmare for various reasons (the probe_irq_* stuff
> beeing one of them, as it currently prevents using -1, so I'm leaning
> toward defining NO_IRQ as beeing INT_MIN, nothing against that ?)
>
> .../...

Don't reply here, I'm re-posting that to LKML instead ...

Ben.
