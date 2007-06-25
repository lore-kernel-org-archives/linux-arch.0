Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from smtp2.linux-foundation.org ([207.189.120.14]:36990 "EHLO
	smtp2.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750853AbXFYJMU (ORCPT
	<rfc822;linux-arch@vger.kernel.org>);
	Mon, 25 Jun 2007 05:12:20 -0400
Date: Mon, 25 Jun 2007 02:11:45 -0700
From: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: Introduce fixed sys_sync_file_range2() syscall, implement on
 PowerPC and ARM
Message-Id: <20070625021145.b84ea186.akpm@linux-foundation.org>
In-Reply-To: <1182761357.12109.14.camel@pmac.infradead.org>
References: <1182761357.12109.14.camel@pmac.infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
To: David Woodhouse <dwmw2@infradead.org>
Cc: torvalds@linux-foundation.org, paulus@samba.org, linux-arch@vger.kernel.org, drepper@redhat.com, rmk@arm.linux.org.uk
List-ID: <linux-arch.vger.kernel.org>

On Mon, 25 Jun 2007 09:49:17 +0100 David Woodhouse <dwmw2@infradead.org> wrote:

> +/* It would be nice if people remember that not all the world's an i386
> +   when they introduce new system calls */

I think we could do without the smartarse comments, frankly.  It took about
two weeks and 1000000000 emails for you guys to sort out the fallocate()
ABI.  How would you like "it would be nice if maintainers of oddball
architectures would pay attention"?


> +asmlinkage long compat_sys_sync_file_range2(int fd, unsigned int flags,
> +				   unsigned offset_hi, unsigned offset_lo,
> +				   unsigned nbytes_hi, unsigned nbytes_lo)
> +{
> +	loff_t offset = ((loff_t)offset_hi << 32) | offset_lo;
> +	loff_t nbytes = ((loff_t)nbytes_hi << 32) | nbytes_lo;
> +
> +	return sys_sync_file_range(fd, offset, nbytes, flags);
> +}
> 	

versus

+asmlinkage long compat_sys_fallocate(int fd, int mode, u32 offhi, u32 offlo,
+				     u32 lenhi, u32 lenlo)
+{
+	return sys_fallocate(fd, mode, ((loff_t)offhi << 32) | offlo,
+			     ((loff_t)lenhi << 32) | lenlo);
+}

the naming, the implementation and the types are all inconsistent.  Can we
pick one style and stick to it?

