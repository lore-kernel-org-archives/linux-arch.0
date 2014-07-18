From: James Hogan <james.hogan@imgtec.com>
Subject: Re: [PATCH v2 15/29] nios2: System calls handling
Date: Fri, 18 Jul 2014 13:56:43 +0100
Message-ID: <53C9198B.1020808@imgtec.com>
References: <1405413956-2772-1-git-send-email-lftan@altera.com> <1405413956-2772-16-git-send-email-lftan@altera.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mailapp01.imgtec.com ([195.59.15.196]:35047 "EHLO
	mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756489AbaGRM4r (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Fri, 18 Jul 2014 08:56:47 -0400
In-Reply-To: <1405413956-2772-16-git-send-email-lftan@altera.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Ley Foon Tan <lftan@altera.com>, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org
Cc: lftan.linux@gmail.com, cltang@codesourcery.com, Arnd <arnd@arndb.de>

Hi,

On 15/07/14 09:45, Ley Foon Tan wrote:
> This patch adds support for system calls from userspaces. It uses the
> asm-generic/unistd.h definitions with architecture spcific syscall. The sys_call_table
> is just an array defined in a C file and it contains pointers to the syscall functions.

I don't think you need the renameat syscall now that renameat2 exists.

Can I suggest preceding your patchset with this patch:
https://lkml.org/lkml/2014/4/23/197
([RFC 3/3] asm-generic: Drop renameat syscall from default list)

which drops renameat from the generic list unless __ARCH_WANT_RENAMEAT
is defined in the arch's uapi/asm/unistd.h.

Cheers
James
