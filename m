From: David Howells <dhowells@redhat.com>
Subject: Re: [PATCH 2/6] generic sys_old_mmap
Date: Mon, 08 Feb 2010 14:31:55 +0000
Message-ID: <26143.1265639515@redhat.com>
References: <20100201185524.GB11045@lst.de>
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:59369 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752643Ab0BHOh4 (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Mon, 8 Feb 2010 09:37:56 -0500
In-Reply-To: <20100201185524.GB11045@lst.de>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: dhowells@redhat.com, akpm@linux-foundation.org, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, linux@arm.linux.org.uk, starvik@axis.com, jesper.nilsson@axis.com, ysato@users.sourceforge.jp, tony.luck@intel.com, geert@linux-m68k.org, zippel@linux-m68k.org, gerg@uclinux.org, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com, jdike@addtoit.com, tglx@linutronix.de, mingo@redhat.com, hpa@zytor.com, viro@zeniv.linux.org.uk

Christoph Hellwig <hch@lst.de> wrote:

> Add a generic implementation of the old mmap syscall, which expects it's
> argument in a memory block and switch all architectures over to use it.
> 
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Acked-by: David Howells <dhowells@redhat.com>
