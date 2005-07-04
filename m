Return-Path: <linux-arch-owner@vger.kernel.org>
Date: Mon, 04 Jul 2005 16:02:38 -0700 (PDT)
Message-Id: <20050704.160238.85409250.davem@davemloft.net>
Subject: Re: RFC: is_compat_task
From: "David S. Miller" <davem@davemloft.net>
In-Reply-To: <17096.44712.93088.756834@cargo.ozlabs.ibm.com>
References: <17092.32853.100878.228467@cargo.ozlabs.ibm.com>
	<20050701134838.GA10260@wotan.suse.de>
	<17096.44712.93088.756834@cargo.ozlabs.ibm.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: paulus@samba.org
Cc: ak@suse.de, sfr@canb.auug.org.au, matthew@wil.cx, hch@lst.de, akpm@osdl.org, linux-arch@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>

From: Paul Mackerras <paulus@samba.org>
Date: Mon, 4 Jul 2005 13:36:08 +1000

> Unfortunately it's not just compat versions of read and write, there
> are pread/pwrite, and the various socket send and receive functions.
> The number of extra bits of infrastructure we need to add seems to
> just keep growing.  On the other hand, with an is_compat_syscall() we
> could handle all of those with one piece of infrastructure.

True, it does seem to be a more fruitless path than
finally capitulating to is_compat_syscall() or something
similar.
