Return-Path: <davem@redhat.com>
Received: from mx1.redhat.com ([66.187.233.31]:40343 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S261763AbUDWXjJ (ORCPT
	<rfc822;linux-arch@vger.kernel.org>);
	Fri, 23 Apr 2004 19:39:09 -0400
Date: Fri, 23 Apr 2004 16:38:20 -0700
From: "David S. Miller" <davem@redhat.com>
Subject: Re: [Patch] SMP call function cleanup
Message-Id: <20040423163820.71b527d1.davem@redhat.com>
In-Reply-To: <1082636511.1332.34.camel@halo>
References: <1082636511.1332.34.camel@halo>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
To: glauber@gmx.de
Cc: linux-arch@vger.kernel.org, schwidefsky@de.ibm.com
List-ID: <linux-arch.vger.kernel.org>


FWIW, sparc64 has a smp_cross_call_masked() internal routine that sends the IPI
to a cpumask_t specified set of cpus.

So whatever is decided, it can easily be implemented on that platform.
