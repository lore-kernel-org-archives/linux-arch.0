Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from d12nrmr1607.megacenter.de.ibm.com (d12nrmr1607.megacenter.de.ibm.com [9.149.167.49])
	by mtagate3.de.ibm.com (8.12.10/8.12.10) with ESMTP id j18955dt042548
	for <linux-arch@vger.kernel.org>; Tue, 8 Feb 2005 09:05:05 GMT
Received: from d12av04.megacenter.de.ibm.com (d12av04.megacenter.de.ibm.com [9.149.165.229])
	by d12nrmr1607.megacenter.de.ibm.com (8.12.10/NCO/VER6.6) with ESMTP id j189558r175184
	for <linux-arch@vger.kernel.org>; Tue, 8 Feb 2005 10:05:05 +0100
Received: from d12av04.megacenter.de.ibm.com (loopback [127.0.0.1])
	by d12av04.megacenter.de.ibm.com (8.12.11/8.12.11) with ESMTP id j18955KC023406
	for <linux-arch@vger.kernel.org>; Tue, 8 Feb 2005 10:05:05 +0100
In-Reply-To: <20050207113000.79c60358.davem@davemloft.net>
Subject: Re: [patch 19/24] TASK_SIZE is variable.
Message-ID: <OF3254ED41.AFB5BCC2-ON41256FA2.00303C7D-41256FA2.0031E7E0@de.ibm.com>
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Date: Tue, 8 Feb 2005 10:05:06 +0100
MIME-Version: 1.0
Content-type: text/plain; charset=US-ASCII
To: "David S. Miller" <davem@davemloft.net>
Cc: akpm@osdl.org, David Howells <dhowells@redhat.com>, dwmw2@infradead.org, linux-arch@vger.kernel.org, torvalds@osdl.org
List-ID: <linux-arch.vger.kernel.org>

> > > Would you be against a "mm->addr_limit"?  That's what an approach
> > > by Paulus implemented, and I was in the camp supporting that kind
> > > of direction.
> >
> > On the other hand, this value is constant on some archs, and in those
cases,
> > wouldn't it be better for it to be a compile-time constant?
>
> How can it be constant?  It would need to change when a set_fs(KERNEL_DS)
> is performed.

It can be a constant on architectures that use a separate address space for
the kernel, e.g. s390. In fact I don't set addr_limit at all, access_ok and
friends always return 1.

blue skies,
   Martin

Martin Schwidefsky
Linux for zSeries Development & Services
IBM Deutschland Entwicklung GmbH
