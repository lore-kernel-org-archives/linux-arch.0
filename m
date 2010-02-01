From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [PATCH 1/6] generic sys_old_select
Date: Mon, 01 Feb 2010 13:58:55 -0800
Message-ID: <4B674E9F.8060403@zytor.com>
References: <20100201185506.GA11045@lst.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from terminus.zytor.com ([198.137.202.10]:33890 "EHLO mail.zytor.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752442Ab0BAWIU (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Mon, 1 Feb 2010 17:08:20 -0500
In-Reply-To: <20100201185506.GA11045@lst.de>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: akpm@linux-foundation.org, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, linux@arm.linux.org.uk, dhowells@redhat.com, ysato@users.sourceforge.jp, tony.luck@intel.com, geert@linux-m68k.org, zippel@linux-m68k.org, gerg@uclinux.org, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com, jdike@addtoit.com, tglx@linutronix.de, mingo@redhat.com, viro@zeniv.linux.org.uk

On 02/01/2010 10:55 AM, Christoph Hellwig wrote:
> Add a generic implementation of the old select syscall, which expects it's
> argument in a memory block and switch all architectures over to use it.
> 
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Looks good to me from an x86 perspective.

Reviewed-by: H. Peter Anvin <hpa@zytor.com>
