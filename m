From: Dan Carpenter <dan.carpenter@oracle.com>
Subject: Re: [PATCH 2/3] string: provide strscpy() and strscpy_truncate()
Date: Wed, 6 May 2015 18:59:51 +0300
Message-ID: <20150506155951.GS16501@mwanda>
References: <1430409677-13284-1-git-send-email-cmetcalf@ezchip.com>
 <1430409677-13284-3-git-send-email-cmetcalf@ezchip.com>
 <20150506150140.GB12986@mwanda>
 <554A3161.3030609@ezchip.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from userp1040.oracle.com ([156.151.31.81]:41314 "EHLO
	userp1040.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750989AbbEFQAz (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Wed, 6 May 2015 12:00:55 -0400
Content-Disposition: inline
In-Reply-To: <554A3161.3030609@ezchip.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Chris Metcalf <cmetcalf@ezchip.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Al Viro <viro@zeniv.linux.org.uk>, Fabian Frederick <fabf@skynet.be>, Randy Dunlap <rdunlap@infradead.org>, Rickard Strandqvist <rickard_strandqvist@spectrumdigital.se>, gregkh@linuxfoundation.org, Peter Zijlstra <peterz@infradead.org>, "David S. Miller" <davem@davemloft.net>, Frederic Weisbecker <fweisbec@gmail.com>, Andrew Morton <akpm@linux-foundation.org>, Sam Ravnborg <sam@ravnborg.org>, Stephen Rothwell <sfr@canb.auug.org.au>, Theodore Ts'o <tytso@mit.edu>, Grant Likely <grant.likely@linaro.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-arch@vger.kernel.org

We actually do have a __must_check tag so it's easy enough to force
people to check.  A different option is we could make it trigger a
WARN_ONCE().

#define strXcpy(dest, src, len) (({				\
	ssize_t __ret = strscpy_truncate(dest, src, len);	\
	WARN_ONCE(__ret < 0, "strXcpy trancates\n");		\
	__ret; }))

I have never really cared about truncation, though.  I think not caring
is the common case.

regards,
dan carpenter
