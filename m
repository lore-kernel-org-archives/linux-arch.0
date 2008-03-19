Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from 74-93-104-97-Washington.hfc.comcastbusiness.net ([74.93.104.97]:38465
	"EHLO sunset.davemloft.net" rhost-flags-OK-FAIL-OK-OK)
	by vger.kernel.org with ESMTP id S965601AbYCSWmm (ORCPT
	<rfc822;linux-arch@vger.kernel.org>);
	Wed, 19 Mar 2008 18:42:42 -0400
Date: Wed, 19 Mar 2008 15:42:56 -0700 (PDT)
Message-ID: <20080319.154256.64241005.davem@davemloft.net>
Subject: Re: [PATCH 5/8] sparc64 ptrace: forced_successful_syscall_return()
From: David Miller <davem@davemloft.net>
In-Reply-To: <20080319213610.244FC26F995@magilla.localdomain>
References: <20080319212001.2DB8526F995@magilla.localdomain>
	<20080319.143037.180042261.davem@davemloft.net>
	<20080319213610.244FC26F995@magilla.localdomain>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: roland@redhat.com
Cc: linux-arch@vger.kernel.org
Message-ID: <20080319224256.ddUCuSZW1qxDFMyl_c7UtQU3wqHy_4qL2SrCGX8YtKY@z>

From: Roland McGrath <roland@redhat.com>
Date: Wed, 19 Mar 2008 14:36:10 -0700 (PDT)

> > Acked-by: David S. Miller <davem@davemloft.net>
> 
> Thanks!  Please follow up by taking the 7/8 and 8/8 patches as a model and
> doing that one-line change to your arch_ptrace/compat_arch_ptrace functions
> once the 6/8 generic patch has gone in.  I didn't send those patches for other
> arch's than the ones I test myself, but it's just that one line in each
> function (replace {compat_,}ptrace_request call with -ENOSYS), plus the
> sanity-check testing that ptrace still works.

Ok.
