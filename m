From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH 17/27] add generic lib/checksum.c
Date: Fri, 1 May 2009 11:14:18 +0200
Message-ID: <200905011114.18880.arnd@arndb.de>
References: <cover.1241105648.git.arnd@arndb.de> <cda5746ab12cf9d6bcb7803a3667c92250a29784.1241105648.git.arnd@arndb.de> <20090430223547.GO12974@lug-owl.de>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.126.187]:63885 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750727AbZEAJOb (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Fri, 1 May 2009 05:14:31 -0400
In-Reply-To: <20090430223547.GO12974@lug-owl.de>
Content-Disposition: inline
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Jan-Benedict Glaw <jbglaw@lug-owl.de>
Cc: linux-arch@vger.kernel.org, Michal Simek <monstr@monstr.eu>, Remis Lima Baima <remis.developer@googlemail.com>, linux-kernel@vger.kernel.org

On Friday 01 May 2009, Jan-Benedict Glaw wrote:
> I haven't looked at the code in detail, but it would be nice to see it
> show up soon. Just faced the IP checksumming code while resurrecting
> the VAX port.

I hope my other header changes are helping you as well, that
was the main point. The checksum code was one of the hardest
to consolidate because every architecture tries to optimize
this in a different way. After merging all the different
approaches and throwing away all the assembly code from
each of them, I made the code practically identical to
Michals version.

Please tell me if you need more hooks in the checksum
code for VAX optimizations. You might want to try overriding
the csum_fold function.

	Arnd <><
