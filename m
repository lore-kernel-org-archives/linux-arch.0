Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail.orcon.net.nz ([219.88.242.62]:54502 "EHLO
        mail.orcon.net.nz" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1758624AbcJYJ04 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 25 Oct 2016 05:26:56 -0400
Date: Tue, 25 Oct 2016 22:12:10 +1300
From: Michael Cree <mcree@orcon.net.nz>
Subject: Re: [PATCH 2/3] ARM: convert to generated system call tables
Message-ID: <20161025091210.rjfhvq4mqtuquei5@tower>
References: <E1bwa6s-0004ZY-4k@rmk-PC.armlinux.org.uk>
 <13702107.LdHY4HTXyY@wuerfel>
 <20161019155325.GR1041@n2100.armlinux.org.uk>
 <3851270.xZRcP9hae0@wuerfel>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3851270.xZRcP9hae0@wuerfel>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Arnd Bergmann <arnd@arndb.de>
Cc: Russell King - ARM Linux <linux@armlinux.org.uk>, linux-arm-kernel@lists.infradead.org, linux-arch <linux-arch@vger.kernel.org>, linux-api <linux-api@vger.kernel.org>, linux-alpha@vger.kernel.org
Message-ID: <20161025091210.T0Fk3Vtts1NZRa3hmL5GFxlzMZbmPgR5TJhWUUW5siE@z>

On Fri, Oct 21, 2016 at 03:06:45PM +0200, Arnd Bergmann wrote:
> I see your point, but I think there are serious issues with the current
> approach as well:
> 
> - a lot of the less common architectures just don't get updated
>   in time, out of 22 architectures that don't use asm-generic/unistd.h,
>   only 12 have pwritev2 in linux-next, and only three have pkey_mprotect
> 
> - some architectures that add all syscalls sometimes make a mistake
>   and forget one, e.g. alpha apparently never added __NR_bpf, but it
>   did add the later __NR_execveat.

__NR_bpf was not forgotten on Alpha.  It was not wired up because
extra architecture support is needed which has not been implemented.

But maybe we should just wire it up to sys_ni_syscall in the meantime
so a syscall number is reserved for it, and user space can call it to
get -ENOSYS returned.

Cheers
Michael.
