Return-Path: <linux-arch-owner+james.bottomley=40steeleye.com-S268582AbUJTQ4v@vger.kernel.org>
Received: from mtagate1.de.ibm.com ([195.212.29.150]:33485 "EHLO
	mtagate1.de.ibm.com") by vger.kernel.org with ESMTP id S268501AbUJTQxv
	(ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Wed, 20 Oct 2004 12:53:51 -0400
In-Reply-To: <1098289545.2009.17.camel@mulgrave>
Subject: Re: 4level page tables architecture porting
Message-ID: <OF14AD849F.49584F04-ON42256F33.005B3FB1-42256F33.005BC93B@de.ibm.com>
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Date: Wed, 20 Oct 2004 18:42:32 +0200
MIME-Version: 1.0
Content-type: text/plain; charset=US-ASCII
To: James Bottomley <James.Bottomley@steeleye.com>
Cc: Andi Kleen <ak@suse.de>, Arnd Bergmann <arnd@arndb.de>, linux-arch@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>





> Actually, the kicker (at least for software TLB architectures) is
> another lookup in the TLB insertion handler.  We actually run a hybrid
> scheme on parisc for this reason---compat 32 processes only get a
> 2-Level page table even on 64 bit kernels.  That was also the reason for
> all the theoretical work on different types of page tables.

Even on architectures with hardware TLB lookup a reduction in the number
of page table levels gives you some performance. The processor needs to
fetch the cachelines that contain the page table for a lookup in hardware
as well.
So you do run a hybrid scheme on parisc, that is interesting. I'm probably
going to copy some of the parisc code to s390 then. We do want to have this
for our 31-bit processes on a 64 bit kernel.

blue skies,
   Martin

Martin Schwidefsky
Linux for zSeries Development & Services
IBM Deutschland Entwicklung GmbH
