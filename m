Return-Path: <linux-arch-owner@vger.kernel.org>
Date: Thu, 30 Jun 2005 19:34:35 -0700 (PDT)
Message-Id: <20050630.193435.74728490.davem@davemloft.net>
Subject: Re: RFC: is_compat_task
From: "David S. Miller" <davem@davemloft.net>
In-Reply-To: <17092.32853.100878.228467@cargo.ozlabs.ibm.com>
References: <20050701012857.6b6de8f9.sfr@canb.auug.org.au>
	<20050630154904.GQ13890@bragg.suse.de>
	<17092.32853.100878.228467@cargo.ozlabs.ibm.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: paulus@samba.org
Cc: ak@suse.de, sfr@canb.auug.org.au, matthew@wil.cx, hch@lst.de, akpm@osdl.org, linux-arch@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>

From: Paul Mackerras <paulus@samba.org>
Date: Fri, 1 Jul 2005 09:29:25 +1000

> The problem with that is that it seems horrible to me to interpret the
> contents of a buffer being given to write() differently depending on
> whether it's a 32-bit or a 64-bit task that is writing it.  The data
> format *should* be designed so that it is wordsize-independent (and
> preferably endian-independent too), or else it should at least be
> self-describing.

Unfortunately, on ia64 and x86_64 executing x86 binaries,
netlink has the same exact problems, particular for IPSEC.

So it's not just the input layer with this problem.
