From: Andi Kleen <ak@linux.intel.com>
Subject: Re: + kthread-numa-aware-kthread_create_on_cpu.patch added to -mm
 tree
Date: Wed, 19 Jan 2011 12:17:16 -0800
Message-ID: <20110119201716.GH22288@tassilo.jf.intel.com>
References: <201012100044.oBA0ivp3016990@imap1.linux-foundation.org>
 <1293131522.2170.798.camel@laptop>
 <20110119120756.cd554fb1.akpm@linux-foundation.org>
 <1295468119.2653.2.camel@edumazet-laptop>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:60284 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752024Ab1ASURN (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Wed, 19 Jan 2011 15:17:13 -0500
Content-Disposition: inline
In-Reply-To: <1295468119.2653.2.camel@edumazet-laptop>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Eric Dumazet <eric.dumazet@gmail.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, Peter Zijlstra <peterz@infradead.org>, davem@davemloft.net, dhowells@redhat.com, fenghua.yu@intel.com, linux-arch@vger.kernel.org, rusty@rustcorp.com.au, tj@kernel.org, tony.luck@intel.com

> 
> I wont discuss about a function _name_ Andrew.
> 
> If nobody can chose one better than the one I chosed, what can I do ?

kthread_create_node() would seem logical (with a node parameter)

-Andi
