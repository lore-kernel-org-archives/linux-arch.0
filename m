Return-Path: <schwidefsky@de.ibm.com>
Received: from mtagate6.de.ibm.com ([195.212.29.155]:51437 "EHLO
	mtagate6.de.ibm.com") by vger.kernel.org with ESMTP id S264731AbUDWGqq convert rfc822-to-8bit
	(ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Fri, 23 Apr 2004 02:46:46 -0400
Subject: Re: [Patch] SMP call function cleanup
Message-ID: <OF82611DF6.73F6250E-ONC1256E7F.0024FB7C-C1256E7F.00253922@de.ibm.com>
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Date: Fri, 23 Apr 2004 08:46:34 +0200
MIME-Version: 1.0
Content-type: text/plain; charset=ISO-8859-1
Content-transfer-encoding: 8BIT
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: glauber@gmx.de, Linux Arch list <linux-arch@vger.kernel.org>
List-ID: <linux-arch.vger.kernel.org>





> Well, I'd go further and allow an arbitraty cpu_mask. There are
> cases where that could be an interesting optimisation to be able
> to send an IPI to a "set" of CPUs. If the HW can't do it easily,
> just send on all and software mask who gets the actual function
> call.

That is exactly what Jan's patch provides. The on_cpu function takes
an arbitrary cpu_mask. on_each_cpu, on_other_cpus and on_single_cpu
just expand to a on_cpu call with the appropriate mask.

blue skies,
   Martin

Linux/390 Design & Development, IBM Deutschland Entwicklung GmbH
Schönaicherstr. 220, D-71032 Böblingen, Telefon: 49 - (0)7031 - 16-2247
E-Mail: schwidefsky@de.ibm.com
