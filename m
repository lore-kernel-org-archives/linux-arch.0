Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from nat-132.atmel.no ([80.232.32.132]:58990 "EHLO relay.atmel.no"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1754419AbYBEKEg (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Tue, 5 Feb 2008 05:04:36 -0500
Date: Tue, 5 Feb 2008 11:03:47 +0100
From: Haavard Skinnemoen <hskinnemoen@atmel.com>
Subject: Re: [PATCH] Fix timerfd breakage on avr32
Message-ID: <20080205110347.62cf2925@dhcp-252-066.norway.atmel.com>
In-Reply-To: <20080205105454.2c0f8133@dhcp-252-066.norway.atmel.com>
References: <200802050627.m156R9G9006417@imap1.linux-foundation.org>
	<20080205105454.2c0f8133@dhcp-252-066.norway.atmel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: torvalds@linux-foundation.org, davidel@xmailserver.org
Cc: David Howells <dhowells@redhat.com>, akpm@linux-foundation.org, linux-arch@vger.kernel.org, mtk-manpages@gmx.net, tglx@linutronix.de, Hirokazu Takata <takata@linux-m32r.org>, Paul Mundt <lethal@linux-sh.org>

On Tue, 5 Feb 2008 10:54:54 +0100
Haavard Skinnemoen <hskinnemoen@atmel.com> wrote:

> The next time you go and remove a system call, could you _please_ post
> a HUGE warning to linux-arch? Or just do a quick grep and fix it up.

Btw, a quick grep through 2.6.24-mm1 shows

arch/frv/kernel/entry.S:	.long sys_timerfd
arch/m32r/kernel/syscall_table.S:	.long sys_timerfd
arch/sh/kernel/syscalls_32.S:	.long sys_timerfd
arch/sh/kernel/syscalls_64.S:	.long sys_timerfd		/* 350 */

so frv, m32r and sh are probably broken too.

Haavard
