Return-Path: <akpm@osdl.org>
Received: from fw.osdl.org ([65.172.181.6]:43966 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S264894AbUF1JxR (ORCPT
	<rfc822;linux-arch@vger.kernel.org>);
	Mon, 28 Jun 2004 05:53:17 -0400
Received: from bix (build.pdx.osdl.net [172.20.1.2])
	by mail.osdl.org (8.11.6/8.11.6) with SMTP id i5S9rGZ21139
	for <linux-arch@vger.kernel.org>; Mon, 28 Jun 2004 02:53:16 -0700
Date: Mon, 28 Jun 2004 02:52:22 -0700
From: Andrew Morton <akpm@osdl.org>
Subject: Fw: [SPARC64]: No longer set WANT_PAGE_VIRTUAL.
Message-Id: <20040628025222.1d11f71b.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
To: linux-arch@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>


ChangeSet 1.1768.1.1, 2004/06/27 14:20:23-07:00, davem@nuts.davemloft.net

	[SPARC64]: No longer set WANT_PAGE_VIRTUAL.
	

That leasve m68k and mips as the only architectures requesting page->virtual.

Do they really need it?
