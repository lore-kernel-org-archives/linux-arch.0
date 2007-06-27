Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from ftp.linux-mips.org ([194.74.144.162]:53426 "EHLO
	ftp.linux-mips.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757549AbXF0NYU (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Wed, 27 Jun 2007 09:24:20 -0400
Received: from localhost.localdomain ([127.0.0.1]:9926 "EHLO
	dl5rb.ham-radio-op.net") by ftp.linux-mips.org with ESMTP
	id S20022378AbXF0NYS (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Wed, 27 Jun 2007 14:24:18 +0100
Date: Wed, 27 Jun 2007 15:22:59 +0200
From: Ralf Baechle <ralf@linux-mips.org>
Subject: Re: Introduce fixed sys_sync_file_range2() syscall, implement on
	PowerPC and ARM
Message-ID: <20070627132259.GA5020@linux-mips.org>
References: <1182761357.12109.14.camel@pmac.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1182761357.12109.14.camel@pmac.infradead.org>
Sender: linux-arch-owner@vger.kernel.org
To: David Woodhouse <dwmw2@infradead.org>
Cc: torvalds@osdl.org, akpm@osdl.org, paulus@samba.org, linux-arch@vger.kernel.org, drepper@redhat.com, rmk@arm.linux.org.uk
List-ID: <linux-arch.vger.kernel.org>

On Mon, Jun 25, 2007 at 09:49:17AM +0100, David Woodhouse wrote:

> Not all the world is an i386. Many architectures need 64-bit arguments
> to be aligned in suitable pairs of registers, and the original
> sys_sync_file_range(int, loff_t, loff_t, int) was therefore wasting an
> argument register for padding after the first integer. Since we don't
> normally have more than 6 arguments for system calls, that left no room
> for the final argument on some architectures.

The worse side of this class of problem is that at times new syscalls are
being invoked through pseudo-portable assembler code which on architectures
where where 64-bit values are being passed in an aligned pair frequently
end passing some of the arguments the wrong way.  For pread/pwrite this
did result in actual data corruption.

  Ralf
