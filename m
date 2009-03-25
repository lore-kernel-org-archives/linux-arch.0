From: Heiko Carstens <heiko.carstens@de.ibm.com>
Subject: Re: [PATCH 1/2] fs: Fix sign extension problem in sys_llseek
Date: Wed, 25 Mar 2009 12:33:44 +0100
Message-ID: <20090325123344.409090a3@osiris.boeblingen.de.ibm.com>
References: <20090325001303.GB24026@linux-mips.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mtagate1.de.ibm.com ([195.212.17.161]:39539 "EHLO
	mtagate1.de.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752681AbZCYLds (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Wed, 25 Mar 2009 07:33:48 -0400
In-Reply-To: <20090325001303.GB24026@linux-mips.org>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Ralf Baechle <ralf@linux-mips.org>
Cc: linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, dann frazier <dannf@dannf.org>, linux-mips@linux-mips.org

On Wed, 25 Mar 2009 01:13:03 +0100
Ralf Baechle <ralf@linux-mips.org> wrote:

> In fs/read_write.c:
> 
> SYSCALL_DEFINE5(llseek, unsigned int, fd, unsigned long, offset_high,
>                 unsigned long, offset_low, loff_t __user *, result,
>                 unsigned int, origin)
> ...
>    	offset = vfs_llseek(file, ((loff_t) offset_high << 32) | offset_low,
>                         origin);
> 
> On a 64-bit system that define CONFIG_HAVE_SYSCALL_WRAPPERS SYSCALL_DEFINEx
> will truncate long arguments to 32-bit and on some architectures such as
> MIPS sign-extended to 64-bit again.  On such architectures passing a
> value with bit 31 in offset_low set will result in a huge 64-bit offset
> being passed to vfs_llseek() and it failiing with EINVAL.

How is that possible? If you have CONFIG_HAVE_SYSCALL_WRAPPERS defined
then the wrapper will (in this case) cast offset_low from long to
unsigned long. It won't truncate or sign extend anything here.
The whole operation should be a NOP.

This is what you get after macro expansion (BUILD_BUG_ON removed):

long sys_llseek(unsigned int fd, unsigned long offset_high, unsigned long offset_low, loff_t * result, unsigned int origin);

static inline __attribute__((always_inline))
long SYSC_llseek(unsigned int fd, unsigned long offset_high, unsigned long offset_low, loff_t * result, unsigned int origin);

long SyS_llseek(long fd, long offset_high, long offset_low, long result, long origin)
{
	return (long) SYSC_llseek((unsigned int) fd, (unsigned long) offset_high, (unsigned long) offset_low, (loff_t *) result, (unsigned int) origin);
}

asm ("\t.globl " "sys_llseek" "\n\t.set " "sys_llseek" ", " "SyS_llseek");

static inline __attribute__((always_inline))
long SYSC_llseek(unsigned int fd, unsigned long offset_high, unsigned long offset_low, loff_t * result, unsigned int origin)
{
	[...]
}
