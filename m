Return-Path: <linux-arch-owner@vger.kernel.org>
Date: Tue, 8 Feb 2005 11:09:06 -0800
From: "David S. Miller" <davem@davemloft.net>
Subject: Re: [patch 19/24] TASK_SIZE is variable.
Message-Id: <20050208110906.5b339201.davem@davemloft.net>
In-Reply-To: <OF3254ED41.AFB5BCC2-ON41256FA2.00303C7D-41256FA2.0031E7E0@de.ibm.com>
References: <20050207113000.79c60358.davem@davemloft.net>
	<OF3254ED41.AFB5BCC2-ON41256FA2.00303C7D-41256FA2.0031E7E0@de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
To: Martin Schwidefsky <schwidefsky@de.ibm.com>
Cc: akpm@osdl.org, dhowells@redhat.com, dwmw2@infradead.org, linux-arch@vger.kernel.org, torvalds@osdl.org
List-ID: <linux-arch.vger.kernel.org>

On Tue, 8 Feb 2005 10:05:06 +0100
Martin Schwidefsky <schwidefsky@de.ibm.com> wrote:

> It can be a constant on architectures that use a separate address space for
> the kernel, e.g. s390. In fact I don't set addr_limit at all, access_ok and
> friends always return 1.

I wouldn't say it's constant in this case, but rather that it's not
needed at all. :-)

Sparc64 also returns "1" all the time, and will continue to do so no matter
what the non-split kernel/user platforms end up doing, just like s390.
