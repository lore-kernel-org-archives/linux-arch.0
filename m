Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from 74-93-104-97-Washington.hfc.comcastbusiness.net ([74.93.104.97]:41495
	"EHLO sunset.davemloft.net" rhost-flags-OK-FAIL-OK-OK)
	by vger.kernel.org with ESMTP id S1751088AbXFOJzF (ORCPT
	<rfc822;linux-arch@vger.kernel.org>);
	Fri, 15 Jun 2007 05:55:05 -0400
Date: Fri, 15 Jun 2007 02:55:22 -0700 (PDT)
Message-Id: <20070615.025522.36921451.davem@davemloft.net>
Subject: Re: [PATCH] Introduce compat_u64 and compat_s64 types
From: David Miller <davem@davemloft.net>
In-Reply-To: <200706151131.38429.arnd@arndb.de>
References: <1181897905.26853.66.camel@localhost.localdomain>
	<200706151128.39566.arnd@arndb.de>
	<200706151131.38429.arnd@arndb.de>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
To: arnd@arndb.de
Cc: benh@kernel.crashing.org, dwmw2@infradead.org, linux-kernel@vger.kernel.org, airlied@linux.ie, linux-arch@vger.kernel.org, akpm@linux-foundation.org
List-ID: <linux-arch.vger.kernel.org>

From: Arnd Bergmann <arnd@arndb.de>
Date: Fri, 15 Jun 2007 11:31:37 +0200

> One common problem with 32 bit system call and ioctl emulation
> is the different alignment rules between i386 and 64 bit machines.
> A number of drivers work around this by marking the compat
> structures as 'attribute((packed))', which is not the right
> solution because it breaks all the non-x86 architectures that
> want to use the same compat code.
> 
> Hopefully, this patch improves the situation, it introduces two
> new types, compat_u64 and compat_s64. These are defined on all
> architectures to have the same size and alignment as the 32 bit
> version of u64 and s64.
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Acked-by: David S. Miller <davem@davemloft.net>
