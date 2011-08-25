From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH] memcg: remove unneeded preempt_disable
Date: Thu, 25 Aug 2011 16:57:52 +0200
Message-ID: <1314284272.27911.32.camel@twins>
References: <1313650253-21794-1-git-send-email-gthelen@google.com>
	 <20110818144025.8e122a67.akpm@linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from merlin.infradead.org ([205.233.59.134]:46940 "EHLO
	merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751612Ab1HYO6O convert rfc822-to-8bit (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Thu, 25 Aug 2011 10:58:14 -0400
In-Reply-To: <20110818144025.8e122a67.akpm@linux-foundation.org>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Greg Thelen <gthelen@google.com>, linux-kernel@vger.kernel.org, linux-mm@kvack.org, KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>, Balbir Singh <bsingharora@gmail.com>, Daisuke Nishimura <nishimura@mxp.nes.nec.co.jp>, linux-arch@vger.kernel.org

On Thu, 2011-08-18 at 14:40 -0700, Andrew Morton wrote:
> 
> I think I'll apply it, as the call frequency is low (correct?) and the
> problem will correct itself as other architectures implement their
> atomic this_cpu_foo() operations. 

Which leads me to wonder, can anything but x86 implement that this_cpu_*
muck? I doubt any of the risk chips can actually do all this.
Maybe Itanic, but then that seems to be dying fast.
