From: KOSAKI Motohiro <kosaki.motohiro@jp.fujitsu.com>
Subject: Re: Arch specific mmap attributes
Date: Wed,  7 Apr 2010 16:14:29 +0900 (JST)
Message-ID: <20100407161203.FB81.A69D9226@jp.fujitsu.com>
References: <20100407095145.FB70.A69D9226@jp.fujitsu.com> <20100407.000343.181989028.davem@davemloft.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from fgwmail5.fujitsu.co.jp ([192.51.44.35]:40158 "EHLO
	fgwmail5.fujitsu.co.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932071Ab0DGHOd (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Wed, 7 Apr 2010 03:14:33 -0400
In-Reply-To: <20100407.000343.181989028.davem@davemloft.net>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: David Miller <davem@davemloft.net>
Cc: kosaki.motohiro@jp.fujitsu.com, benh@kernel.crashing.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org

> From: KOSAKI Motohiro <kosaki.motohiro@jp.fujitsu.com>
> Date: Wed,  7 Apr 2010 15:03:45 +0900 (JST)
> 
> > I'm not against changing kernel internal. I only disagree mmu
> > attribute fashion will be become used widely.
> 
> Desktop already uses similar features via PCI mmap
> attributes and such, not to mention MSR settings on
> x86.

Probably I haven't catch your mention. Why userland process
need to change PCI mmap attribute by mmap(2)? It seems kernel issue.



> So I disagree with your assesment that this is some
> HPC/embedded issue.
