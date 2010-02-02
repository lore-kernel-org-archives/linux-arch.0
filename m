From: Jesper Nilsson <Jesper.Nilsson@axis.com>
Subject: Re: [PATCH 2/6] generic sys_old_mmap
Date: Tue, 2 Feb 2010 10:23:26 +0100
Message-ID: <20100202092326.GT5383@axis.com>
References: <20100201185524.GB11045@lst.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from miranda.se.axis.com ([193.13.178.8]:37208 "EHLO
	miranda.se.axis.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750884Ab0BBJwP (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Tue, 2 Feb 2010 04:52:15 -0500
Content-Disposition: inline
In-Reply-To: <20100201185524.GB11045@lst.de>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: "akpm@linux-foundation.org" <akpm@linux-foundation.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, "linux@arm.linux.org.uk" <linux@arm.linux.org.uk>, Mikael Starvik <mikael.starvik@axis.com>, "ysato@users.sourceforge.jp" <ysato@users.sourceforge.jp>, "tony.luck@intel.com" <tony.luck@intel.com>, "geert@linux-m68k.org" <geert@linux-m68k.org>, "zippel@linux-m68k.org" <zippel@linux-m68k.org>, "gerg@uclinux.org" <gerg@uclinux.org>, "schwidefsky@de.ibm.com" <schwidefsky@de.ibm.com>, "heiko.carstens@de.ibm.com" <heiko.carstens@de.ibm.com>, "jdike@addtoit.com" <jdike@addtoit.com>, "tglx@linutronix.de" <tglx@linutronix.de>, "mingo@redhat.com" <mingo@redhat.com>, "hpa@zytor.com" <hpa@zytor.com>, "viro@zeniv.linux.org.uk" <viro@zeniv.linux.org.uk>

On Mon, Feb 01, 2010 at 07:55:24PM +0100, Christoph Hellwig wrote:
> Add a generic implementation of the old mmap syscall, which expects it's
> argument in a memory block and switch all architectures over to use it.

CRIS parts look ok.

> Signed-off-by: Christoph Hellwig <hch@lst.de>

Acked-by: Jesper Nilsson <jesper.nilsson@axis.com>

/^JN - Jesper Nilsson
-- 
               Jesper Nilsson -- jesper.nilsson@axis.com
