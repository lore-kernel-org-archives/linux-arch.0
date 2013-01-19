From: Al Viro <viro@ZenIV.linux.org.uk>
Subject: Re: [PATCH v2 16/76] ARC: Syscall support (no-legacy-syscall ABI)
Date: Sat, 19 Jan 2013 03:09:18 +0000
Message-ID: <20130119030918.GA23552@ZenIV.linux.org.uk>
References: <1358511930-7424-1-git-send-email-vgupta@synopsys.com>
 <1358511930-7424-17-git-send-email-vgupta@synopsys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from zeniv.linux.org.uk ([195.92.253.2]:47069 "EHLO
	ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754859Ab3ASDJU (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Fri, 18 Jan 2013 22:09:20 -0500
Content-Disposition: inline
In-Reply-To: <1358511930-7424-17-git-send-email-vgupta@synopsys.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Vineet Gupta <Vineet.Gupta1@synopsys.com>
Cc: linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, arnd@arndb.de

Please, collapse your #36--#40 into that one (and I'd probably fold #17
here as well, to simplify that reordering).  Sure, it's not a bisection
hazard, but...
