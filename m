Return-Path: <linux-arch-owner+james.bottomley=40steeleye.com-S268070AbUJSHCm@vger.kernel.org>
Received: from gate.crashing.org ([63.228.1.57]:24977 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S268058AbUJSHCm (ORCPT
	<rfc822;linux-arch@vger.kernel.org>);
	Tue, 19 Oct 2004 03:02:42 -0400
Received: from localhost (localhost [127.0.0.1])
	by gate.crashing.org (8.12.8/8.12.8) with ESMTP id i9J723BG002573
	for <linux-arch@vger.kernel.org>; Tue, 19 Oct 2004 02:02:04 -0500
Subject: All archs: NO_IRQ definition
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Content-Type: text/plain
Message-Id: <1098169077.11400.51.camel@gaston>
Mime-Version: 1.0
Date: Tue, 19 Oct 2004 16:57:57 +1000
Content-Transfer-Encoding: 7bit
To: Linux Arch list <linux-arch@vger.kernel.org>
List-ID: <linux-arch.vger.kernel.org>

Hi !

I need to fix a few wrong cases where driver assume that irq = 0 means
no interrupt. This is wrong, some arch have pefectly valid IRQ 0. We
started defining NO_IRQ a while ago for that reason, but it seems lot
of archs didn't catch up. I plan to collect a patch fixing them all but
you guys will have to tell me what value to use for NO_IRQ (0 ? -1 ?).

Currently, only ppc64, arm and mips add it, and I know what to do for
ppc, that leaves me with request for the proper value to use for those
archs:

alpha
arm
arm26
cris
h8300
i386
ia64
m32r
m68k
m68knommu
parisc
sh
sh64
sparc
sparc64
um
v850
x86_64

Thanks ! 

Ben.
