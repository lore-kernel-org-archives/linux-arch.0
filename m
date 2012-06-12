From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH] sched/numa: fix compat declarations for sys_numa_{t,m}bind()
Date: Tue, 12 Jun 2012 17:36:36 +0000
Message-ID: <201206121736.36586.arnd@arndb.de>
References: <201206121724.q5CHOaeU002148@farm-0023.internal.tilera.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.17.10]:59204 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751847Ab2FLRgt (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Tue, 12 Jun 2012 13:36:49 -0400
In-Reply-To: <201206121724.q5CHOaeU002148@farm-0023.internal.tilera.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Chris Metcalf <cmetcalf@tilera.com>
Cc: Peter Zijlstra <a.p.zijlstra@chello.nl>, Ingo Molnar <mingo@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org

On Tuesday 12 June 2012, Chris Metcalf wrote:
> The asm-generic code needs actual declarations of the routines,
> and the syscall entries need to reference the correct names.
> 
> Signed-off-by: Chris Metcalf <cmetcalf@tilera.com>
> ---
> The tilegx architecture is currently broken in linux-next because
> of this issue.

Acked-by: Arnd Bergmann <arnd@arndb.de>

Please apply to the branch that contains the syscall implementation.
