From: Vineet Gupta <Vineet.Gupta1@synopsys.com>
Subject: Re: [PATCH v2 10/76] ARC: Fundamental ARCH data-types/defines
Date: Sat, 19 Jan 2013 18:41:02 +0530
Message-ID: <50FA9B66.2080207@synopsys.com>
References: <1358511930-7424-1-git-send-email-vgupta@synopsys.com> <1358511930-7424-11-git-send-email-vgupta@synopsys.com> <20130119032532.GC23552@ZenIV.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from alvesta.synopsys.com ([198.182.60.77]:52545 "EHLO
	alvesta.synopsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750940Ab3ASNML (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Sat, 19 Jan 2013 08:12:11 -0500
In-Reply-To: <20130119032532.GC23552@ZenIV.linux.org.uk>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Al Viro <viro@ZenIV.linux.org.uk>
Cc: linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, arnd@arndb.de, Jonas Bonn <jonas.bonn@gmail.com>

On Saturday 19 January 2013 08:55 AM, Al Viro wrote:
> On Fri, Jan 18, 2013 at 05:54:24PM +0530, Vineet Gupta wrote:
>
>> +/* work to do on interrupt/exception return */
>> +#define _TIF_WORK_MASK		(0x0000FFFF & ~_TIF_SYSCALL_TRACE)
> Yuck...  Use the real set, please - there's future-proofing and then there's
> leaving nasty minefields; this is the latter...

Rightly so - fixed in next revision. BTW I'm not bothering with SYSCALL_AUDIT yet,
so that's out of those.

-#define _TIF_WORK_MASK         (0x0000FFFF & ~_TIF_SYSCALL_TRACE)
+#define _TIF_WORK_MASK         (_TIF_NEED_RESCHED | _TIF_SIGPENDING \
+                                _TIF_NOTIFY_RESUME)

Thx,
-Vineet
