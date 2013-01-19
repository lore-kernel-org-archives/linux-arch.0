From: Al Viro <viro@ZenIV.linux.org.uk>
Subject: Re: [PATCH v2 10/76] ARC: Fundamental ARCH data-types/defines
Date: Sat, 19 Jan 2013 03:25:32 +0000
Message-ID: <20130119032532.GC23552@ZenIV.linux.org.uk>
References: <1358511930-7424-1-git-send-email-vgupta@synopsys.com>
 <1358511930-7424-11-git-send-email-vgupta@synopsys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from zeniv.linux.org.uk ([195.92.253.2]:47109 "EHLO
	ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753992Ab3ASDZd (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Fri, 18 Jan 2013 22:25:33 -0500
Content-Disposition: inline
In-Reply-To: <1358511930-7424-11-git-send-email-vgupta@synopsys.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Vineet Gupta <Vineet.Gupta1@synopsys.com>
Cc: linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, arnd@arndb.de, Jonas Bonn <jonas.bonn@gmail.com>

On Fri, Jan 18, 2013 at 05:54:24PM +0530, Vineet Gupta wrote:

> +/* work to do on interrupt/exception return */
> +#define _TIF_WORK_MASK		(0x0000FFFF & ~_TIF_SYSCALL_TRACE)

Yuck...  Use the real set, please - there's future-proofing and then there's
leaving nasty minefields; this is the latter...
