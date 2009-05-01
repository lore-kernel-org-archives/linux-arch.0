From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH 04/27] asm-generic: add legacy I/O header files
Date: Fri, 1 May 2009 14:40:37 +0100
Message-ID: <20090501144037.5a5dc65f@lxorguk.ukuu.org.uk>
References: <cover.1241105648.git.arnd@arndb.de>
	<200905011453.32006.arnd@arndb.de>
	<20090501141414.4adfe4ab@lxorguk.ukuu.org.uk>
	<200905011520.34097.arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from earthlight.etchedpixels.co.uk ([81.2.110.250]:48350 "EHLO
	www.etchedpixels.co.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751843AbZEANkF (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Fri, 1 May 2009 09:40:05 -0400
In-Reply-To: <200905011520.34097.arnd@arndb.de>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Arnd Bergmann <arnd@arndb.de>
Cc: Russell King <rmk+lkml@arm.linux.org.uk>, Michal Simek <monstr@monstr.eu>, linux-arch@vger.kernel.org, Remis Lima Baima <remis.developer@googlemail.com>, linux-kernel@vger.kernel.org

> In that case, I still think it would be good to have it in asm-generic.
> Half the architectures define it in this way currently, and new architectures
> would still have to think about it before falling back on the default.

Only if they noticed it was even present in the generic includes. Why
would they notice - meaningless code would just compile perfectly.
