Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from 74-93-104-97-Washington.hfc.comcastbusiness.net ([74.93.104.97]:60289
	"EHLO sunset.davemloft.net") by vger.kernel.org with ESMTP
	id S935140AbWKYECb (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Fri, 24 Nov 2006 23:02:31 -0500
Date: Fri, 24 Nov 2006 20:02:42 -0800 (PST)
Message-Id: <20061124.200242.91313872.davem@davemloft.net>
Subject: Re: [PATCH] Generic compat_sys_sysinfo
From: David Miller <davem@davemloft.net>
In-Reply-To: <20061125014313.GD11643@athena.road.mcmartin.ca>
References: <20061125014313.GD11643@athena.road.mcmartin.ca>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
To: kyle@parisc-linux.org
Cc: akpm@osdl.org, linux-arch@vger.kernel.org, parisc-linux@lists.parisc-linux.org
List-ID: <linux-arch.vger.kernel.org>

From: Kyle McMartin <kyle@parisc-linux.org>
Date: Fri, 24 Nov 2006 20:43:13 -0500

> While tracking a bug for Thibaut Varene, I noticed that almost all
> architectures implemented exactly the same sys32_sysinfo... except
> parisc, where a bug was to be found in handling of the uptime. So
> let's remove a whole whack of code for fun and profit. Cribbed
> compat_sys_sysinfo from x86_64's implementation, since I figured
> it would be the best tested.
> 
> Tested compat_sys_sysinfo() on parisc and the results look sane.
> 
> Signed-off-by: Kyle McMartin <kyle@parisc-linux.org>

This looks good to me, at least on the sparc side of things. :)
