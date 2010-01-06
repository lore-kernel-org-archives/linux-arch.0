From: Heiko Carstens <heiko.carstens@de.ibm.com>
Subject: Re: [PATCH 2/3] generic sys_old_mmap
Date: Wed, 6 Jan 2010 23:27:16 +0100
Message-ID: <20100106222716.GA11394@osiris.boeblingen.de.ibm.com>
References: <20100106172135.GB17163@lst.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mtagate3.uk.ibm.com ([194.196.100.163]:53830 "EHLO
	mtagate3.uk.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754858Ab0AFW1U (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Wed, 6 Jan 2010 17:27:20 -0500
Content-Disposition: inline
In-Reply-To: <20100106172135.GB17163@lst.de>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: akpm@linux-foundation.org, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, linux@arm.linux.org.uk, starvik@axis.com, jesper.nilsson@axis.com, ysato@users.sourceforge.jp, tony.luck@intel.com, geert@linux-m68k.org, zippel@linux-m68k.org, gerg@uclinux.org, schwidefsky@de.ibm.com, jdike@addtoit.com, tglx@linutronix.de, mingo@redhat.com, hpa@zytor.com, viro@zeniv.linux.org.uk

On Wed, Jan 06, 2010 at 06:21:35PM +0100, Christoph Hellwig wrote:
> Add a generic implementation of the old mmap syscall, which expects it's
> argument in a memory block and switch all architectures over to use it.

No compat version here?
