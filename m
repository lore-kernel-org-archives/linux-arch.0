From: David Howells <dhowells@redhat.com>
Subject: Re: [PATCH 1/3] generic sys_old_select
Date: Wed, 06 Jan 2010 17:44:29 +0000
Message-ID: <31914.1262799869@redhat.com>
References: <20100106172112.GA17163@lst.de>
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:21061 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932295Ab0AFRpt (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Wed, 6 Jan 2010 12:45:49 -0500
In-Reply-To: <20100106172112.GA17163@lst.de>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: dhowells@redhat.com, akpm@linux-foundation.org, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, linux@arm.linux.org.uk, ysato@users.sourceforge.jp, tony.luck@intel.com, geert@linux-m68k.org, zippel@linux-m68k.org, gerg@uclinux.org, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com, jdike@addtoit.com, tglx@linutronix.de, mingo@redhat.com, hpa@zytor.com, viro@zeniv.linux.org.uk

Christoph Hellwig <hch@lst.de> wrote:

> Add a generic implementation of the old select syscall, which expects it's
> argument in a memory block and switch all architectures over to use it.
> 
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Acked-by: David Howells <dhowells@redhat.com> [for MN10300]
