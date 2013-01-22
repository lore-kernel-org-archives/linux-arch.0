From: =?ISO-8859-15?Q?Andr=E9_Hentschel?= <nerv@dawncrow.de>
Subject: arm: Request to preserve TPIDRURW per thread
Date: Tue, 22 Jan 2013 01:04:56 +0100
Message-ID: <50FDD7A8.1080402@dawncrow.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.17.9]:54298 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751855Ab3AVAFB (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Mon, 21 Jan 2013 19:05:01 -0500
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-arch@vger.kernel.org
Cc: will.deacon@arm.com, gregkh@linuxfoundation.org, rmk+kernel@arm.linux.org.uk

Hi,
that comes a bit late, but [1] asked for objections.
As you can see in [2] there are more and more applications coming to Wi=
nRT, Wine could support them,
but mostly they expect to have the thread environment block (TEB) in TP=
IDRURW.
This register must be preserved per thread and we have patches for that=
=2E

Currently there exist two kernel behaviours:

1. the kernel does not touch TPIDRURW at all ("covert channel")
2. the kernel clears TPIDRURW on thread switch

Attached to [3] you'll find kernel patches you can freely use.
Permission and more info you'll find in [4].
Any hints or suggestions?

[1] http://www.kernelhub.org/?p=3D2&msg=3D57979
[2] http://forum.xda-developers.com/showthread.php?t=3D2092348
[3] http://bugs.winehq.org/show_bug.cgi?id=3D31322
[4] http://bugs.winehq.org/show_bug.cgi?id=3D31308
--=20

Best Regards, Andr=E9 Hentschel
