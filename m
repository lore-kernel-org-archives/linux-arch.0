From: David Miller <davem@davemloft.net>
Subject: Re: [RFC PATCH 15/16] sparc: locks: remove unused arch_*_relax
 operations
Date: Fri, 21 Jun 2013 12:18:58 -0700 (PDT)
Message-ID: <20130621.121858.1944780066162510278.davem@davemloft.net>
References: <1371835057-19335-1-git-send-email-will.deacon@arm.com>
	<1371835057-19335-16-git-send-email-will.deacon@arm.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from shards.monkeyblade.net ([149.20.54.216]:35252 "EHLO
	shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1423672Ab3FUTPc (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Fri, 21 Jun 2013 15:15:32 -0400
In-Reply-To: <1371835057-19335-16-git-send-email-will.deacon@arm.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: will.deacon@arm.com
Cc: linux-arch@vger.kernel.org

From: Will Deacon <will.deacon@arm.com>
Date: Fri, 21 Jun 2013 18:17:36 +0100

> The arch_{spin,read,write}_relax macros are not used anywhere in the
> kernel and are typically just aliases for cpu_relax().
> 
> This patch removes the unused definitions for Sparc.
> 
> Cc: David Miller <davem@davemloft.net>
> Signed-off-by: Will Deacon <will.deacon@arm.com>

Acked-by: David S. Miller <davem@davemloft.net>
