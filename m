Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-qg0-f51.google.com ([209.85.192.51]:45245 "EHLO
	mail-qg0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754561AbaGULRo (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Mon, 21 Jul 2014 07:17:44 -0400
MIME-Version: 1.0
In-Reply-To: <53C9198B.1020808@imgtec.com>
References: <1405413956-2772-1-git-send-email-lftan@altera.com>
	<1405413956-2772-16-git-send-email-lftan@altera.com>
	<53C9198B.1020808@imgtec.com>
Date: Mon, 21 Jul 2014 19:17:42 +0800
Message-ID: <CAFiDJ59Aj9Hdp3C9d-2XhUdCGVwn9aYm2yY=sUHDCZFCv8XhOw@mail.gmail.com>
Subject: Re: [PATCH v2 15/29] nios2: System calls handling
From: Ley Foon Tan <lftan@altera.com>
Content-Type: text/plain; charset=UTF-8
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: James Hogan <james.hogan@imgtec.com>
Cc: Linux-Arch <linux-arch@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>, Chung-Lin Tang <cltang@codesourcery.com>, Arnd <arnd@arndb.de>
Message-ID: <20140721111742.V55vtoJf0kB0OIn-k0PDQheHUJQxeS7O0vx_26h3CPU@z>

On Fri, Jul 18, 2014 at 8:56 PM, James Hogan <james.hogan@imgtec.com> wrote:
> Hi,
>
> On 15/07/14 09:45, Ley Foon Tan wrote:
>> This patch adds support for system calls from userspaces. It uses the
>> asm-generic/unistd.h definitions with architecture spcific syscall. The sys_call_table
>> is just an array defined in a C file and it contains pointers to the syscall functions.
>
> I don't think you need the renameat syscall now that renameat2 exists.
>
> Can I suggest preceding your patchset with this patch:
> https://lkml.org/lkml/2014/4/23/197
> ([RFC 3/3] asm-generic: Drop renameat syscall from default list)
>
> which drops renameat from the generic list unless __ARCH_WANT_RENAMEAT
> is defined in the arch's uapi/asm/unistd.h.
Yes, we don't need renameat syscall. Will add this patch.

Thanks.

Regards
Ley Foon
