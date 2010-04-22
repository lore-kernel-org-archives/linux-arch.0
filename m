From: David Rientjes <rientjes@google.com>
Subject: Re: [patch 12/14] score: invoke oom-killer from page fault
Date: Thu, 22 Apr 2010 13:57:20 -0700 (PDT)
Message-ID: <alpine.DEB.2.00.1004221357100.25350@chino.kir.corp.google.com>
References: <20100422160613.723698029@suse.de> <20100422161224.624110747@suse.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from smtp-out.google.com ([74.125.121.35]:31959 "EHLO
	smtp-out.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758750Ab0DVU53 (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Thu, 22 Apr 2010 16:57:29 -0400
Received: from kpbe15.cbf.corp.google.com (kpbe15.cbf.corp.google.com [172.25.105.79])
	by smtp-out.google.com with ESMTP id o3MKvQwc022763
	for <linux-arch@vger.kernel.org>; Thu, 22 Apr 2010 22:57:26 +0200
Received: from pzk42 (pzk42.prod.google.com [10.243.19.170])
	by kpbe15.cbf.corp.google.com with ESMTP id o3MKvN5U005963
	for <linux-arch@vger.kernel.org>; Thu, 22 Apr 2010 13:57:24 -0700
Received: by pzk42 with SMTP id 42so6157455pzk.4
        for <linux-arch@vger.kernel.org>; Thu, 22 Apr 2010 13:57:23 -0700 (PDT)
In-Reply-To: <20100422161224.624110747@suse.de>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: npiggin@suse.de
Cc: linux-arch@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>, Chen Liqin <liqin.chen@sunplusct.com>, Lennox Wu <lennox.wu@gmail.com>

On Fri, 23 Apr 2010, npiggin@suse.de wrote:

> As explained in commit 1c0fe6e3bd, we want to call the architecture independent
> oom killer when getting an unexplained OOM from handle_mm_fault, rather than
> simply killing current.
> 
> Cc: Chen Liqin <liqin.chen@sunplusct.com>
> Cc: Lennox Wu <lennox.wu@gmail.com>
> Cc: linux-arch@vger.kernel.org
> Signed-off-by: Nick Piggin <npiggin@suse.de>

Acked-by: David Rientjes <rientjes@google.com>
