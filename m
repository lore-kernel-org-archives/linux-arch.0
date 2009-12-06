From: David Miller <davem@davemloft.net>
Subject: Re: [RFC][PATCH 7/18] kill useless checks in sparc mremap variants
Date: Sat, 05 Dec 2009 18:39:04 -0800 (PST)
Message-ID: <20091205.183904.193687185.davem@davemloft.net>
References: <E1NGzzu-0008RV-Tx@ZenIV.linux.org.uk>
	<20091205.150941.142886510.davem@davemloft.net>
	<20091206011332.GA14381@ZenIV.linux.org.uk>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from 74-93-104-97-Washington.hfc.comcastbusiness.net ([74.93.104.97]:41586
	"EHLO sunset.davemloft.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752870AbZLFCi7 (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Sat, 5 Dec 2009 21:38:59 -0500
In-Reply-To: <20091206011332.GA14381@ZenIV.linux.org.uk>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: viro@ZenIV.linux.org.uk
Cc: viro@ftp.linux.org.uk, linux-arch@vger.kernel.org, torvalds@linux-foundation.org, linux-kernel@vger.kernel.org

From: Al Viro <viro@ZenIV.linux.org.uk>
Date: Sun, 6 Dec 2009 01:13:32 +0000

> On Sat, Dec 05, 2009 at 03:09:41PM -0800, David Miller wrote:
>> From: Al Viro <viro@ftp.linux.org.uk>
>> Date: Sat, 05 Dec 2009 19:08:50 +0000
>> 
>> > 
>> > Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
>> 
>> Acked-by: David S. Miller <davem@davemloft.net>
> 
> BTW, do we need sys32_mremap() after that?  The only difference between
> it and sys_mremap() that we have new_addr u32 in the former and u64 in
> the latter and IIRC the upper 32 bits of %i4 are going to be 0 anyway...

That's right, it should be superfluous now.
