From: David Miller <davem@davemloft.net>
Subject: Re: [RFC][PATCH 8/18] file ->get_unmapped_area() shouldn't
 duplicate work of get_unmapped_area()
Date: Sat, 05 Dec 2009 15:10:01 -0800 (PST)
Message-ID: <20091205.151001.225544378.davem@davemloft.net>
References: <E1NGzzu-0008RX-VJ@ZenIV.linux.org.uk>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from 74-93-104-97-Washington.hfc.comcastbusiness.net ([74.93.104.97]:49498
	"EHLO sunset.davemloft.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1757475AbZLEXJy (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Sat, 5 Dec 2009 18:09:54 -0500
In-Reply-To: <E1NGzzu-0008RX-VJ@ZenIV.linux.org.uk>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: viro@ftp.linux.org.uk
Cc: linux-arch@vger.kernel.org, torvalds@linux-foundation.org, linux-kernel@vger.kernel.org

From: Al Viro <viro@ftp.linux.org.uk>
Date: Sat, 05 Dec 2009 19:08:50 +0000

> 
> ... we should call mm ->get_unmapped_area() instead and let our caller
> do the final checks.
> 
> Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>

Acked-by: David S. Miller <davem@davemloft.net>
