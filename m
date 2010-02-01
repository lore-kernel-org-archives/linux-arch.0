From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [PATCH 2/6] generic sys_old_mmap
Date: Mon, 01 Feb 2010 14:19:37 -0800
Message-ID: <4B675379.80807@zytor.com>
References: <20100201185524.GB11045@lst.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20100201185524.GB11045@lst.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Christoph Hellwig <hch@lst.de>
Cc: akpm@linux-foundation.org, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, linux@arm.linux.org.uk, starvik@axis.com, jesper.nilsson@axis.com, ysato@users.sourceforge.jp, tony.luck@intel.com, geert@linux-m68k.org, zippel@linux-m68k.org, gerg@uclinux.org, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com, jdike@addtoit.com, tglx@linutronix.de, mingo@redhat.com, viro@zeniv.linux.org.uk
List-Id: linux-arch.vger.kernel.org

> Add a generic implementation of the old mmap syscall, which expects it's
> argument in a memory block and switch all architectures over to use it.

Looks good to me from an x86 perspective.

Reviewed-by: H. Peter Anvin <hpa@zytor.com>
