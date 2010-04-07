Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from gate.crashing.org ([63.228.1.57]:48076 "EHLO gate.crashing.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752327Ab0DGJAV (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Wed, 7 Apr 2010 05:00:21 -0400
Subject: Re: Arch specific mmap attributes
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
In-Reply-To: <20100407161203.FB81.A69D9226@jp.fujitsu.com>
References: <20100407095145.FB70.A69D9226@jp.fujitsu.com>
	 <20100407.000343.181989028.davem@davemloft.net>
	 <20100407161203.FB81.A69D9226@jp.fujitsu.com>
Content-Type: text/plain; charset="UTF-8"
Date: Wed, 07 Apr 2010 19:00:11 +1000
Message-ID: <1270630811.2300.93.camel@pasglop>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: KOSAKI Motohiro <kosaki.motohiro@jp.fujitsu.com>
Cc: David Miller <davem@davemloft.net>, linux-mm@kvack.org, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
Message-ID: <20100407090011.i-gOR0Npaop5rCmnoowu5yB28NGaFLhu4HkXqZPqsSY@z>

On Wed, 2010-04-07 at 16:14 +0900, KOSAKI Motohiro wrote:
> > Desktop already uses similar features via PCI mmap
> > attributes and such, not to mention MSR settings on
> > x86.
> 
> Probably I haven't catch your mention. Why userland process
> need to change PCI mmap attribute by mmap(2)? It seems kernel issue.

There are cases where the userspace based driver needs to control
attributes such as write combining, or even cachability when mapping PCI
devices directly into userspace.

It's not -that- common, though X still does it on a number of platforms,
and there are people still trying to run PCI drivers in userspace ;-) 

But regardless. I don't see why HPC or Embedded would have to be
qualified as "crap" and not warrant our full attention into devising
something sane and clean anyways.

Cheers,
Ben.

