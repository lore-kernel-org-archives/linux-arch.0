Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from www.linutronix.de ([62.245.132.108]:55803 "EHLO
	Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753944Ab1DLIxD (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Tue, 12 Apr 2011 04:53:03 -0400
Date: Tue, 12 Apr 2011 10:53:00 +0200
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: [PATCHES v3] pci/of: Generic PCI <-> OF matching
Message-ID: <20110412085300.GA25467@linutronix.de>
References: <1302495170-973-1-git-send-email-benh@kernel.crashing.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <1302495170-973-1-git-send-email-benh@kernel.crashing.org>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: linux-pci@vger.kernel.org, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, davem@davemloft.net, bheglaas@google.com, monstr@monstr.eu, tglx@linutronix.de
Message-ID: <20110412085300.YN03nbb746Vdsp4ncN7W8N0M69USeySVA69YPlwlrDo@z>

* Benjamin Herrenschmidt | 2011-04-11 14:12:44 [+1000]:

>Here's a new batch. This time, I'm reasonably confident I build-tested the
>right commit-id's on sparc :-)
>
>To sort out the sparc problem I took a slightly different approach than
>discussed. I made the new code be of_pci.c (which I enabled on sparc)
>and put the old stuff into of_pci_irq.c (which should still be disabled
>there).
>
>I've also consolidated pci_bus_to_OF_node() while at it.

This series builds and boots fine on x86.

Sebastian
