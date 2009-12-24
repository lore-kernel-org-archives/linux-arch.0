From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH 05/37] kdb: core for kgdb back end
Date: Thu, 24 Dec 2009 13:01:07 +0100
Message-ID: <1261656067.4937.193.camel@laptop>
References: <1261603190-5036-1-git-send-email-jason.wessel@windriver.com>
	 <1261603190-5036-2-git-send-email-jason.wessel@windriver.com>
	 <1261603190-5036-3-git-send-email-jason.wessel@windriver.com>
	 <1261603190-5036-4-git-send-email-jason.wessel@windriver.com>
	 <1261603190-5036-5-git-send-email-jason.wessel@windriver.com>
	 <1261603190-5036-6-git-send-email-jason.wessel@windriver.com>
	 <1261652509.4937.185.camel@laptop>  <4B3356A8.4020901@windriver.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from casper.infradead.org ([85.118.1.10]:50179 "EHLO
	casper.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750872AbZLXMBg (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Thu, 24 Dec 2009 07:01:36 -0500
In-Reply-To: <4B3356A8.4020901@windriver.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Jason Wessel <jason.wessel@windriver.com>
Cc: linux-kernel@vger.kernel.org, kgdb-bugreport@lists.sourceforge.net, kdb@oss.sgi.com, mingo@elte.hu, mort@sgi.com, linux-arch@vger.kernel.org

On Thu, 2009-12-24 at 05:55 -0600, Jason Wessel wrote:
> The remainder was a port from the original kdb, and should not been
> needed.  The preempt_disable and preempt_enable should be able to be
> safely called while the system in the kgdb exception context, so this
> chunk of code is going to get axed and re-tested.

Ok, thanks!
