Return-Path: <davem@redhat.com>
Received: from mx1.redhat.com ([66.187.233.31]:7129 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S266011AbUFDVVF (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Fri, 4 Jun 2004 17:21:05 -0400
Date: Fri, 4 Jun 2004 14:19:00 -0700
From: "David S. Miller" <davem@redhat.com>
Subject: Re: [patch 2.6] __ARCH_WANT_SYS_RT_SIGACTION
Message-Id: <20040604141900.7f35900a.davem@redhat.com>
In-Reply-To: <20040604131926.A791@jurassic.park.msu.ru>
References: <20040604131926.A791@jurassic.park.msu.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
To: Ivan Kokshaysky <ink@jurassic.park.msu.ru>
Cc: akpm@osdl.org, linux-arch@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>

On Fri, 4 Jun 2004 13:19:26 +0400
Ivan Kokshaysky <ink@jurassic.park.msu.ru> wrote:

> Recent syscall stubs cleanup broke alpha, as it has its own
> version of sys_rt_sigaction().
> This defines __ARCH_WANT_SYS_RT_SIGACTION for all architectures
> except alpha, sparc and sparc64.
> 
> Signed-off-by: Ivan Kokshaysky <ink@jurassic.park.msu.ru>

I'm totally fine with this patch.
