From: David Miller <davem@davemloft.net>
Subject: Re: [PATCH 02/17] UAPI: Don't include linux/compat.h in sparc's
 asm/siginfo.h
Date: Tue, 13 Dec 2011 13:32:08 -0500 (EST)
Message-ID: <20111213.133208.1867222061450505776.davem@davemloft.net>
References: <1323770653-19177-1-git-send-email-dhowells@redhat.com>
	<1323770653-19177-3-git-send-email-dhowells@redhat.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from shards.monkeyblade.net ([198.137.202.13]:49624 "EHLO
	shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751548Ab1LMSei (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Tue, 13 Dec 2011 13:34:38 -0500
In-Reply-To: <1323770653-19177-3-git-send-email-dhowells@redhat.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: dhowells@redhat.com
Cc: sfr@canb.auug.org.au, torvalds@linux-foundation.org, arnd@arndb.de, alan@lxorguk.ukuu.org.uk, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, sparclinux@vger.kernel.org

From: David Howells <dhowells@redhat.com>
Date: Tue, 13 Dec 2011 10:03:58 +0000

> Don't include linux/compat.h in sparc's asm/siginfo.h as it leads to a circular
> dependency:
> 
> 	asm/siginfo.h -> linux/compat.h -> asm/siginfo.h
> 
> Signed-off-by: David Howells <dhowells@redhat.com>

Acked-by: David S. Miller <davem@davemloft.net>
