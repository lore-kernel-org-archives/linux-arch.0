Return-Path: <schwidefsky@de.ibm.com>
Received: from mtagate7.de.ibm.com ([195.212.29.156]:38337 "EHLO
	mtagate7.de.ibm.com") by vger.kernel.org with ESMTP id S264733AbUDWGxy convert rfc822-to-8bit
	(ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Fri, 23 Apr 2004 02:53:54 -0400
Subject: Re: [Patch] SMP call function cleanup
Message-ID: <OFD7014FC9.01C49161-ONC1256E7F.002590F4-C1256E7F.0025D0FE@de.ibm.com>
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Date: Fri, 23 Apr 2004 08:53:03 +0200
MIME-Version: 1.0
Content-type: text/plain; charset=ISO-8859-1
Content-transfer-encoding: 8BIT
To: Anton Blanchard <anton@samba.org>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>, Jan Glauber <glauber@gmx.de>, Linux Arch list <linux-arch@vger.kernel.org>, William Lee Irwin III <wli@holomorphy.com>
List-ID: <linux-arch.vger.kernel.org>





> Then someone uses it in a performance critical place and my big SMP
> ppc64 performance sucks.

I still have problem to understand this argument. Either there is the
need to execute a function on a selected set of cpus or there isn't.
If there is the need and the architecture is slow doing IPI's to single
cpus then the architecture can choose to do a IPI to all cpus
and do the mask selection in the IPI interrupt.

> We still havent been given a place in generic code where this
> optimisation makes sense.

Ok, thats a valid point.

blue skies,
   Martin

Linux/390 Design & Development, IBM Deutschland Entwicklung GmbH
Schönaicherstr. 220, D-71032 Böblingen, Telefon: 49 - (0)7031 - 16-2247
E-Mail: schwidefsky@de.ibm.com
