Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org ([63.228.1.57]:45782 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S261848AbUCKXwm (ORCPT
	<rfc822;linux-arch@vger.kernel.org>);
	Thu, 11 Mar 2004 18:52:42 -0500
Received: from localhost (localhost.localdomain [127.0.0.1])
	by gate.crashing.org (8.12.8/8.12.8) with ESMTP id i2BNiEUn011337
	for <linux-arch@vger.kernel.org>; Thu, 11 Mar 2004 17:44:16 -0600
Subject: removing lib/errno.c
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Content-Type: text/plain
Message-Id: <1079048907.9746.312.camel@gaston>
Mime-Version: 1.0
Date: Fri, 12 Mar 2004 10:48:27 +1100
Content-Transfer-Encoding: 7bit
To: Linux Arch list <linux-arch@vger.kernel.org>
List-ID: <linux-arch.vger.kernel.org>

Hi !

Any objection killing that ? Archs that use that in their _syscall macro
can either fix the macro or have their own "int errno" defined in
arch/something.

We just found a nasty bug in the ppc64 code that was filling that value
on in-kernel syscalls (asm shit was writing a 64 bits value to the
32 bits errno).

IMHO, Anything relying on the value of that global errno is broken,
so what about just removing it completely ?

Ben.
