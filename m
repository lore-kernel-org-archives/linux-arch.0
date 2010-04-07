From: David Miller <davem@davemloft.net>
Subject: Re: Arch specific mmap attributes
Date: Wed, 07 Apr 2010 00:03:43 -0700 (PDT)
Message-ID: <20100407.000343.181989028.davem@davemloft.net>
References: <20100406185246.7E63.A69D9226@jp.fujitsu.com>
	<1270592111.13812.88.camel@pasglop>
	<20100407095145.FB70.A69D9226@jp.fujitsu.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from 74-93-104-97-Washington.hfc.comcastbusiness.net ([74.93.104.97]:52568
	"EHLO sunset.davemloft.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752836Ab0DGHDn (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Wed, 7 Apr 2010 03:03:43 -0400
In-Reply-To: <20100407095145.FB70.A69D9226@jp.fujitsu.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: kosaki.motohiro@jp.fujitsu.com
Cc: benh@kernel.crashing.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org

From: KOSAKI Motohiro <kosaki.motohiro@jp.fujitsu.com>
Date: Wed,  7 Apr 2010 15:03:45 +0900 (JST)

> I'm not against changing kernel internal. I only disagree mmu
> attribute fashion will be become used widely.

Desktop already uses similar features via PCI mmap
attributes and such, not to mention MSR settings on
x86.

So I disagree with your assesment that this is some
HPC/embedded issue.
