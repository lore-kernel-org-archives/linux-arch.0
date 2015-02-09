From: Rasmus Villemoes <linux@rasmusvillemoes.dk>
Subject: Re: [RFC] change non-atomic bitops method
Date: Mon, 09 Feb 2015 22:42:18 +0100
Message-ID: <87386evk1x.fsf@rasmusvillemoes.dk>
References: <35FD53F367049845BC99AC72306C23D1044A02027E0A@CNBJMBX05.corpusers.net>
	<20150202152909.13bfd11f192fb0268b2ab4bf@linux-foundation.org>
	<20150203011730.GA15653@node.dhcp.inet.fi>
	<35FD53F367049845BC99AC72306C23D1044A02027E0B@CNBJMBX05.corpusers.net>
	<35FD53F367049845BC99AC72306C23D1044A02027E0C@CNBJMBX05.corpusers.net>
	<20150202223851.f30768d0.akpm@linux-foundation.org>
	<35FD53F367049845BC99AC72306C23D1044A02027E0D@CNBJMBX05.corpusers.net>
	<35FD53F367049845BC99AC72306C23D1044A02027E0E@CNBJMBX05.corpusers.net>
	<20150203025925.d1c95fb8.akpm@linux-foundation.org>
	<35FD53F367049845BC99AC72306C23D1044A02027E12@CNBJMBX05.corpusers.net>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-lb0-f171.google.com ([209.85.217.171]:62734 "EHLO
	mail-lb0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759473AbbBIVmW (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Mon, 9 Feb 2015 16:42:22 -0500
Received: by mail-lb0-f171.google.com with SMTP id b6so9968849lbj.2
        for <linux-arch@vger.kernel.org>; Mon, 09 Feb 2015 13:42:20 -0800 (PST)
In-Reply-To: <35FD53F367049845BC99AC72306C23D1044A02027E12@CNBJMBX05.corpusers.net>
	(Yalin Wang's message of "Mon, 9 Feb 2015 16:18:10 +0800")
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: "Wang, Yalin" <Yalin.Wang@sonymobile.com>
Cc: 'Andrew Morton' <akpm@linux-foundation.org>, "'Kirill A. Shutemov'" <kirill@shutemov.name>, "'arnd@arndb.de'" <arnd@arndb.de>, "'linux-arch@vger.kernel.org'" <linux-arch@vger.kernel.org>, "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>, "'linux@arm.linux.org.uk'" <linux@arm.linux.org.uk>, "'linux-arm-kernel@lists.infradead.org'" <linux-arm-kernel@lists.infradead.org>

On Mon, Feb 09 2015, "Wang, Yalin" <Yalin.Wang@sonymobile.com> wrote:

> I te-test the patch on 3.10 kernel.
> The result like this:
>
> VmallocChunk:   251498164 kB
> __set_bit_miss_count:11730 __set_bit_success_count:1036316
> __clear_bit_miss_count:209640 __clear_bit_success_count:4806556
> __test_and_set_bit_miss_count:0 __test_and_set_bit_success_count:121
> __test_and_clear_bit_miss_count:0 __test_and_clear_bit_success_count:445
>
> __clear_bit miss rate is a little high,
> I check the log, and most miss coming from this code:
>
> <6>[  442.701798] [<ffffffc00021d084>] warn_slowpath_fmt+0x4c/0x58
> <6>[  442.701805] [<ffffffc0002461a8>] __clear_bit+0x98/0xa4
> <6>[  442.701813] [<ffffffc0003126ac>] __alloc_fd+0xc8/0x124
> <6>[  442.701821] [<ffffffc000312768>] get_unused_fd_flags+0x28/0x34
> <6>[  442.701828] [<ffffffc0002f9370>] do_sys_open+0x10c/0x1c0
> <6>[  442.701835] [<ffffffc0002f9458>] SyS_openat+0xc/0x18
> In __clear_close_on_exec(fd, fdt);
>
>
>
> <6>[  442.695354] [<ffffffc00021d084>] warn_slowpath_fmt+0x4c/0x58
> <6>[  442.695359] [<ffffffc0002461a8>] __clear_bit+0x98/0xa4
> <6>[  442.695367] [<ffffffc000312340>] dup_fd+0x1d4/0x280
> <6>[  442.695375] [<ffffffc00021b07c>] copy_process.part.56+0x42c/0xe38
> <6>[  442.695382] [<ffffffc00021bb9c>] do_fork+0xe0/0x360
> <6>[  442.695389] [<ffffffc00021beb4>] SyS_clone+0x10/0x1c
> In __clear_open_fd(open_files - i, new_fdt);
>
> Do we need test_bit() before clear_bit()at these 2 place?
>

In the second case, new_fdt->open_fds has just been filled by a
memcpy, and no-one can possibly have written to that cache line in the
meantime. 

In the first case, testing is also likely wasteful if fdt->max_fds is
less than half the number of bits in a cacheline (fdt->close_on_exec and
fdt->open_fds are always contiguous, and the latter is unconditionally
written to).

Rasmus
