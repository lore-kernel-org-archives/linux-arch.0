Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from terminus.zytor.com ([198.137.202.10]:54997 "EHLO mail.zytor.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753324Ab0BAW1z (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Mon, 1 Feb 2010 17:27:55 -0500
Message-ID: <4B675379.80807@zytor.com>
Date: Mon, 01 Feb 2010 14:19:37 -0800
From: "H. Peter Anvin" <hpa@zytor.com>
MIME-Version: 1.0
Subject: Re: [PATCH 2/6] generic sys_old_mmap
References: <20100201185524.GB11045@lst.de>
In-Reply-To: <20100201185524.GB11045@lst.de>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: akpm@linux-foundation.org, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, linux@arm.linux.org.uk, starvik@axis.com, jesper.nilsson@axis.com, ysato@users.sourceforge.jp, tony.luck@intel.com, geert@linux-m68k.org, zippel@linux-m68k.org, gerg@uclinux.org, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com, jdike@addtoit.com, tglx@linutronix.de, mingo@redhat.com, viro@zeniv.linux.org.uk
Message-ID: <20100201221937.ycv4iaT3n2pXMPtC8uLEwJQTo9W3wOVuUKqeWGyEras@z>

> Add a generic implementation of the old mmap syscall, which expects it's
> argument in a memory block and switch all architectures over to use it.

Looks good to me from an x86 perspective.

Reviewed-by: H. Peter Anvin <hpa@zytor.com>
