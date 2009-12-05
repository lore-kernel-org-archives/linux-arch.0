From: Ralf Baechle <ralf@linux-mips.org>
Subject: Re: [PATCH] fix broken aliasing checks for MAP_FIXED on sparc32,
 mips, arm and sh
Date: Sat, 5 Dec 2009 20:22:51 +0000
Message-ID: <20091205202251.GA475@linux-mips.org>
References: <E1NH12k-0001gw-NA@ZenIV.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from h5.dl5rb.org.uk ([81.2.74.5]:42404 "EHLO h5.dl5rb.org.uk"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752679AbZLEUYM (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Sat, 5 Dec 2009 15:24:12 -0500
Content-Disposition: inline
In-Reply-To: <E1NH12k-0001gw-NA@ZenIV.linux.org.uk>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Al Viro <viro@ftp.linux.org.uk>
Cc: linux-arch@vger.kernel.org, lethal@linux-sh.org, rmk@arm.linux.org.uk, davem@davemloft.net, torvalds@linux-foundation.org, linux-kernel@vger.kernel.org

On Sat, Dec 05, 2009 at 08:15:50PM +0000, Al Viro wrote:

After our IRC chat I've already applied an commit that is identical to the
MIPS segment of your patch.

Thanks!

  Ralf
