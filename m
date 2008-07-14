From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: Microblaze architecture - ACK
Date: Mon, 14 Jul 2008 13:24:56 +0200
Message-ID: <200807141324.56731.arnd@arndb.de>
References: <487B19E0.3030301@seznam.cz>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.126.174]:65230 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752652AbYGNLZR (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Mon, 14 Jul 2008 07:25:17 -0400
In-Reply-To: <487B19E0.3030301@seznam.cz>
Content-Disposition: inline
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-arch@vger.kernel.org
Cc: Linux Kernel list <linux-kernel@vger.kernel.org>, torvalds@linux-foundation.org, John Williams <john.williams@petalogix.com>, Stephen Neuendorffer <stephen.neuendorffer@xilinx.com>, John Linn <John.Linn@xilinx.com>, Jon Loeliger <jdl@jdl.com>, David Gibson <david@gibson.dropbear.id.au>, Sam Ravnborg <sam@ravnborg.org>

On Monday 14 July 2008, Michal Simek wrote:
> Arnd: I hope you know much about microblaze. Could you help me with the last
> stage of merging?
> 
> Could you recommend me people who can give me valuable ACK? (I'll send patches
> to them and then full pack to LKML too).
> 

I think most of it is fine by now, but I haven't received any reply from you
on my lenghy mail "Re: Microblaze init port v4" sent at 26.06.2008 19:51 MEST
or the other one "Re: [PATCH 59/60] microblaze_v4: syscall_table.S and
unistd.h" at 26.06.2008 18:31 CEST.

I think I raised some important issues regarding your syscall interface in
these, and the same problems persisted in version 5. If you address my
comments there (either by changing the code or convincing me that no change
is needed), you have my full Ack on the port.

	Arnd <><
