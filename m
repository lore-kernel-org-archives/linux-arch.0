From: David Miller <davem@davemloft.net>
Subject: Re: [RFC][PATCH 13/18] Unify sys_mmap*
Date: Sat, 05 Dec 2009 15:10:57 -0800 (PST)
Message-ID: <20091205.151057.247213755.davem@davemloft.net>
References: <E1NGzzv-0008Rn-4G@ZenIV.linux.org.uk>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from 74-93-104-97-Washington.hfc.comcastbusiness.net ([74.93.104.97]:49503
	"EHLO sunset.davemloft.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1757912AbZLEXKu (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Sat, 5 Dec 2009 18:10:50 -0500
In-Reply-To: <E1NGzzv-0008Rn-4G@ZenIV.linux.org.uk>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: viro@ftp.linux.org.uk
Cc: linux-arch@vger.kernel.org, torvalds@linux-foundation.org, linux-kernel@vger.kernel.org

From: Al Viro <viro@ftp.linux.org.uk>
Date: Sat, 05 Dec 2009 19:08:51 +0000

> 
> New helper - sys_mmap_pgoff(); switch syscalls to using it.
> 
> Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>

Acked-by: David S. Miller <davem@davemloft.net>
