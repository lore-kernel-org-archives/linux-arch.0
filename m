Return-Path: <linux-arch-owner+james.bottomley=40steeleye.com-S265275AbUHYWDM@vger.kernel.org>
Received: from fw.osdl.org ([65.172.181.6]:56018 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S269169AbUHYVbd (ORCPT
	<rfc822;linux-arch@vger.kernel.org>);
	Wed, 25 Aug 2004 17:31:33 -0400
Date: Wed, 25 Aug 2004 14:29:40 -0700
From: Andrew Morton <akpm@osdl.org>
Subject: incoming: signal delivery race fixes
Message-Id: <20040825142940.0e3318b8.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
To: Linus Torvalds <torvalds@osdl.org>
Cc: linux-arch@vger.kernel.org, Corey Minyard <minyard@acm.org>
List-ID: <linux-arch.vger.kernel.org>


A bunch of patches here to fix a race in signal delivery.  I don't think
anyone's totally ecstatic about the solution, but it works.

Many architectures have been converted, but some still will break.
