Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from palinux.external.hp.com ([192.25.206.14]:58520 "EHLO
	mail.parisc-linux.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750781AbXFYKfh (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Mon, 25 Jun 2007 06:35:37 -0400
Date: Mon, 25 Jun 2007 04:35:35 -0600
From: Matthew Wilcox <matthew@wil.cx>
Subject: Re: Introduce fixed sys_sync_file_range2() syscall, implement on PowerPC and ARM
Message-ID: <20070625103535.GF22063@parisc-linux.org>
References: <1182761357.12109.14.camel@pmac.infradead.org> <20070625021145.b84ea186.akpm@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20070625021145.b84ea186.akpm@linux-foundation.org>
Sender: linux-arch-owner@vger.kernel.org
To: Andrew Morton <akpm@linux-foundation.org>
Cc: David Woodhouse <dwmw2@infradead.org>, torvalds@linux-foundation.org, paulus@samba.org, linux-arch@vger.kernel.org, drepper@redhat.com, rmk@arm.linux.org.uk
List-ID: <linux-arch.vger.kernel.org>

On Mon, Jun 25, 2007 at 02:11:45AM -0700, Andrew Morton wrote:
> ABI.  How would you like "it would be nice if maintainers of oddball
> architectures would pay attention"?

If new syscalls got posted to linux-arch for discussion, I assure you,
we'd pay attention.
