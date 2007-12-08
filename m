Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from 74-93-104-97-Washington.hfc.comcastbusiness.net ([74.93.104.97]:49103
	"EHLO sunset.davemloft.net" rhost-flags-OK-FAIL-OK-OK)
	by vger.kernel.org with ESMTP id S1753575AbXLHIkn (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Sat, 8 Dec 2007 03:40:43 -0500
Date: Sat, 08 Dec 2007 00:40:43 -0800 (PST)
Message-Id: <20071208.004043.41207478.davem@davemloft.net>
Subject: Re: mprotect(2) and I-cache/I-TLB
From: David Miller <davem@davemloft.net>
In-Reply-To: <E1J0tqr-00067s-Lx@hikaru.fsij.org>
References: <E1J0tqr-00067s-Lx@hikaru.fsij.org>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: gniibe@fsij.org
Cc: linux-arch@vger.kernel.org

From: NIIBE Yutaka <gniibe@fsij.org>
Date: Sat, 08 Dec 2007 16:11:53 +0900

> I would like to ask architecture maintainers to try this small
> program if CPU has virtual cache and I/D separate.

Doesn't work on sparc :-)

davem@sunset:~/src/GIT/net-2.6.25$ ./test
mremap_page: Invalid argument
davem@sunset:~/src/GIT/net-2.6.25$ 

I think the fixed case enforces D-cache alias alignment
for cases like this and that's why it's failing.
