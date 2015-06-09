From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH 19/28] arch: conditionally define smp_{mb,rmb,wmb}
Date: Tue, 9 Jun 2015 14:32:51 +0200
Message-ID: <20150609123251.GY3644@twins.programming.kicks-ass.net>
References: <1433850508-26317-1-git-send-email-vgupta@synopsys.com>
 <1433850508-26317-20-git-send-email-vgupta@synopsys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from casper.infradead.org ([85.118.1.10]:50513 "EHLO
	casper.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753877AbbFIMc5 (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Tue, 9 Jun 2015 08:32:57 -0400
Content-Disposition: inline
In-Reply-To: <1433850508-26317-20-git-send-email-vgupta@synopsys.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Vineet Gupta <Vineet.Gupta1@synopsys.com>
Cc: linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, arnd@arndb.de, arc-linux-dev@synopsys.com

On Tue, Jun 09, 2015 at 05:18:19PM +0530, Vineet Gupta wrote:
> That way arches can define the minimal versions and still #include
> asm-generic for defaults (vs. defining defaults in arch code)
> 
> See new barrier.h in arc for usage !
> 

Fair enough,

Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
