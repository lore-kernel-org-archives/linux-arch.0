From: hu.taoo@gmail.com
Subject: Re: [PATCH v2] kmap_types: convert most arches to a single header
	file
Date: Fri, 5 Jun 2009 16:04:06 +0800
Message-ID: <20090605080406.GA1285@gentoo-ht>
References: <4A280BB0.4030805@oracle.com> <20090605004329.GA7653@cr0.nay.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-pz0-f171.google.com ([209.85.222.171]:65333 "EHLO
	mail-pz0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755440AbZFEIFr (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Fri, 5 Jun 2009 04:05:47 -0400
Content-Disposition: inline
In-Reply-To: <20090605004329.GA7653@cr0.nay.redhat.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Amerigo Wang <xiyou.wangcong@gmail.com>
Cc: Randy Dunlap <randy.dunlap@oracle.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-arch@vger.kernel.org, Mike Frysinger <vapier@gentoo.org>, Richard Henderson <rth@twiddle.net>, Ivan Kokshaysky <ink@jurassic.park.msu.ru>, Bryan Wu <cooloney@kernel.org>, Mikael Starvik <starvik@axis.com>, Hirokazu Takata <takata@linux-m32r.org>, Luck Tony <tony.luck@intel.com>, Geert Uytterhoeven <geert@linux-m68k.org>, Ralf Baechle <ralf@linux-mips.org>, David Howells <dhowells@redhat.com>, Kyle McMartin <kyle@mcmartin.ca>, Martin Schwidefsky <schwidefsky@de.ibm.com>, Paul Mundt <lethal@linux-sh.org>, "David S. Miller" <davem@davemloft.net>, Ingo Molnar <mingo@elte.hu>, Thomas Gleixner <tglx@linutronix.de>, "H. Peter Anvin" <hpa@zytor.com>, Arnd Bergmann <arnd@arndb.de>

On Fri, Jun 05, 2009 at 08:43:29AM +0800, Amerigo Wang wrote:
> 
> UML only uses KM_TYPE_NR and KM_UML_USERCOPY, so
> this patch should be fine for UML.
> 
> Acked-by: WANG Cong <xiyou.wangcong@gmail.com>

You probably need a Reviewed-by:...

FYC, Acked-by and Reviewed-by are well documented
in Documentation/SubmittingPatches.
