From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH 3/3] truncate()/ftruncate() fix length argument on ia32 emulation.
Date: Sun, 18 Sep 2011 17:26:19 +0200
Message-ID: <2572424.HyPu2df1S7@wuerfel>
References: <1316282477.5814.19.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.17.8]:63834 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754190Ab1IRP1M (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Sun, 18 Sep 2011 11:27:12 -0400
In-Reply-To: <1316282477.5814.19.camel@localhost.localdomain>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Thomas Meyer <thomas@m3y3r.de>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-arch@vger.kernel.org

On Saturday 17 September 2011 20:01:17 Thomas Meyer wrote:
> move signed-extended int to long, because of signed test.
> 
> Signed-off-by: Thomas Meyer <thomas@m3y3r.de>

I would expect that the same is needed on ia64 and parisc and mips.
powerpc, s390 and sparc probably don't need it because they
have architecture specific code that already does this, but you
can probably remove the powerpc version if you add a generic
one.

New architectures (including tile) won't need the wrapper because
the 32-bit ABI there only has truncate64.

	Arnd
