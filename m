Return-Path: <schwidefsky@de.ibm.com>
Received: from mtagate5.de.ibm.com ([195.212.29.154]:12421 "EHLO
	mtagate5.de.ibm.com") by vger.kernel.org with ESMTP id S264748AbUDWHrS convert rfc822-to-8bit
	(ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Fri, 23 Apr 2004 03:47:18 -0400
Subject: Re: [Patch] SMP call function cleanup
Message-ID: <OF6CF6EC39.22DE1153-ONC1256E7F.002A74D4-C1256E7F.002AB531@de.ibm.com>
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Date: Fri, 23 Apr 2004 09:46:28 +0200
MIME-Version: 1.0
Content-type: text/plain; charset=ISO-8859-1
Content-transfer-encoding: 8BIT
To: Anton Blanchard <anton@samba.org>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>, Jan Glauber <glauber@gmx.de>, Linux Arch list <linux-arch@vger.kernel.org>, William Lee Irwin III <wli@holomorphy.com>
List-ID: <linux-arch.vger.kernel.org>





> The worry is we then start changing algorithms to suit, I could see
> someone replacing a timer based algorithm with an IPI send to cpumask
> one. Im theorising here and the IPI method may end up being more
> efficient on all architectures but we suffer from not having a decent
> example case yet.

We'd need a way to hide the on_cpu function then. What you want is the
old style interface that only allows a call to either all cpus or to
a single one.

> Since we tend to avoid creating infrastructure just in case someone
> finds a use for it Id prefer to avoid adding it at this stage.

I still like the cleanup part of the patch.

blue skies,
   Martin

Linux/390 Design & Development, IBM Deutschland Entwicklung GmbH
Schönaicherstr. 220, D-71032 Böblingen, Telefon: 49 - (0)7031 - 16-2247
E-Mail: schwidefsky@de.ibm.com
