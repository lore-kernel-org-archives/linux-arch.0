Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from e06smtp17.uk.ibm.com ([195.75.94.113]:51775 "EHLO
	e06smtp17.uk.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757828AbbGHGqR (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Wed, 8 Jul 2015 02:46:17 -0400
Received: from /spool/local
	by e06smtp17.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-arch@vger.kernel.org> from <heiko.carstens@de.ibm.com>;
	Wed, 8 Jul 2015 07:46:15 +0100
Date: Wed, 8 Jul 2015 08:46:07 +0200
From: Heiko Carstens <heiko.carstens@de.ibm.com>
Subject: Re: [PATCH V3 2/5] mm: mlock: Add new mlock, munlock, and munlockall
 system calls
Message-ID: <20150708064607.GB7079@osiris>
References: <1436288623-13007-1-git-send-email-emunson@akamai.com>
 <1436288623-13007-3-git-send-email-emunson@akamai.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1436288623-13007-3-git-send-email-emunson@akamai.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Eric B Munson <emunson@akamai.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, Michal Hocko <mhocko@suse.cz>, Vlastimil Babka <vbabka@suse.cz>, linux-alpha@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, adi-buildroot-devel@lists.sourceforge.net, linux-cris-kernel@axis.com, linux-ia64@vger.kernel.org, linux-m68k@lists.linux-m68k.org, linux-mips@linux-mips.org, linux-am33-list@redhat.com, linux-parisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org, linux-sh@vger.kernel.org, sparclinux@vger.kernel.org, linux-xtensa@linux-xtensa.org, linux-api@vger.kernel.org, linux-arch@vger.kernel.org, linux-mm@kvack.org
Message-ID: <20150708064607.kUx96w48BFxmifB4O78fHqNElltgzklrZrtxP1QXFHk@z>

On Tue, Jul 07, 2015 at 01:03:40PM -0400, Eric B Munson wrote:
> With the refactored mlock code, introduce new system calls for mlock,
> munlock, and munlockall.  The new calls will allow the user to specify
> what lock states are being added or cleared.  mlock2 and munlock2 are
> trivial at the moment, but a follow on patch will add a new mlock state
> making them useful.
> 
> munlock2 addresses a limitation of the current implementation.  If a
> user calls mlockall(MCL_CURRENT | MCL_FUTURE) and then later decides
> that MCL_FUTURE should be removed, they would have to call munlockall()
> followed by mlockall(MCL_CURRENT) which could potentially be very
> expensive.  The new munlockall2 system call allows a user to simply
> clear the MCL_FUTURE flag.
> 
> Signed-off-by: Eric B Munson <emunson@akamai.com>

...

> diff --git a/arch/s390/kernel/syscalls.S b/arch/s390/kernel/syscalls.S
> index 1acad02..f6d81d6 100644
> --- a/arch/s390/kernel/syscalls.S
> +++ b/arch/s390/kernel/syscalls.S
> @@ -363,3 +363,6 @@ SYSCALL(sys_bpf,compat_sys_bpf)
>  SYSCALL(sys_s390_pci_mmio_write,compat_sys_s390_pci_mmio_write)
>  SYSCALL(sys_s390_pci_mmio_read,compat_sys_s390_pci_mmio_read)
>  SYSCALL(sys_execveat,compat_sys_execveat)
> +SYSCALL(sys_mlock2,compat_sys_mlock2)			/* 355 */
> +SYSCALL(sys_munlock2,compat_sys_munlock2)
> +SYSCALL(sys_munlockall2,compat_sys_munlockall2)

FWIW, you would also need to add matching lines to the two files

arch/s390/include/uapi/asm/unistd.h
arch/s390/kernel/compat_wrapper.c

so that the system call would be wired up on s390.

