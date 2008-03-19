Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mx1.redhat.com ([66.187.233.31]:52490 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S937797AbYCSVgO (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Wed, 19 Mar 2008 17:36:14 -0400
Received: from int-mx1.corp.redhat.com (int-mx1.corp.redhat.com [172.16.52.254])
	by mx1.redhat.com (8.13.8/8.13.8) with ESMTP id m2JLaDh1028971
	for <linux-arch@vger.kernel.org>; Wed, 19 Mar 2008 17:36:13 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
From: Roland McGrath <roland@redhat.com>
Subject: Re: [PATCH 5/8] sparc64 ptrace: forced_successful_syscall_return()
In-Reply-To: David Miller's message of  Wednesday, 19 March 2008 14:30:37 -0700 <20080319.143037.180042261.davem@davemloft.net>
References: <20080319211714.8B14226F995@magilla.localdomain>
	<20080319212001.2DB8526F995@magilla.localdomain>
	<20080319.143037.180042261.davem@davemloft.net>
Message-ID: <20080319213610.244FC26F995@magilla.localdomain>
Date: Wed, 19 Mar 2008 14:36:10 -0700 (PDT)
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: David Miller <davem@davemloft.net>
Cc: linux-arch@vger.kernel.org
Message-ID: <20080319213610.XylIVnGuU6ZWax9HatU0zXd6jJaVuo13_p32Oh-dfbQ@z>

> Acked-by: David S. Miller <davem@davemloft.net>

Thanks!  Please follow up by taking the 7/8 and 8/8 patches as a model and
doing that one-line change to your arch_ptrace/compat_arch_ptrace functions
once the 6/8 generic patch has gone in.  I didn't send those patches for other
arch's than the ones I test myself, but it's just that one line in each
function (replace {compat_,}ptrace_request call with -ENOSYS), plus the
sanity-check testing that ptrace still works.

I sent the forced_successful_syscall_return() change for the affected
arch's I don't build because the 6/8 generic patch would break your arch
without it.


Thanks,
Roland
