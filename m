Return-Path: <akpm@osdl.org>
Received: from fw.osdl.org ([65.172.181.6]:63387 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S265226AbUHAG0D (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Sun, 1 Aug 2004 02:26:03 -0400
Received: from bix (build.pdx.osdl.net [172.20.1.2])
	by mail.osdl.org (8.11.6/8.11.6) with SMTP id i716Q2115408
	for <linux-arch@vger.kernel.org>; Sat, 31 Jul 2004 23:26:02 -0700
Date: Sat, 31 Jul 2004 23:24:34 -0700
From: Andrew Morton <akpm@osdl.org>
Subject: find_next_bit return type
Message-Id: <20040731232434.7263b50c.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
To: linux-arch@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>


Seems that several 64-bit architectures are returning longs from
find_next_bit(), find_next_zero_bit(), etc.  x86 returns an int.  wli sent
me a patch which does

	return min(NR_CPUS, find_first_bit(srcp->bits, nbits));

so these architectures now get a zillion warnings.

We should be consistent here.  Is there any reason why these functions
cannot return integers?
