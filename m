From: Vineet Gupta <Vineet.Gupta1@synopsys.com>
Subject: Re: [PATCH v2 16/76] ARC: Syscall support (no-legacy-syscall ABI)
Date: Sat, 19 Jan 2013 18:26:26 +0530
Message-ID: <50FA97FA.9050603@synopsys.com>
References: <1358511930-7424-1-git-send-email-vgupta@synopsys.com> <1358511930-7424-17-git-send-email-vgupta@synopsys.com> <20130119030918.GA23552@ZenIV.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from vaxjo.synopsys.com ([198.182.60.75]:34202 "EHLO
	vaxjo.synopsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750862Ab3ASM4k (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Sat, 19 Jan 2013 07:56:40 -0500
In-Reply-To: <20130119030918.GA23552@ZenIV.linux.org.uk>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Al Viro <viro@ZenIV.linux.org.uk>
Cc: linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, arnd@arndb.de

On Saturday 19 January 2013 08:39 AM, Al Viro wrote:
> Please, collapse your #36--#40 into that one (and I'd probably fold #17
> here as well, to simplify that reordering).  Sure, it's not a bisection
> hazard, but...

Thanks again for the review Al.

Sure, I can do that - however because those patches have bits in arch/arc/Kconfig,
I'll have to move the Build system patch towards start of series, or simply chop
off Kconfig bits out of those and add them later - what do you prefer ?

My only reason for chunking those up was to capture the intermediate development
of how execve and friends were generalized (and have limited revision history even
in initial upstream version). While I was used to the old code, specially
copy_thread() between 1st and last change seemed to be almost rewritten.  Having
said that, I don't have strong opinion either ways.

Thx,
-Vineet
