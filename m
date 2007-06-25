Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mx1.redhat.com ([66.187.233.31]:53062 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751319AbXFYLeE (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Mon, 25 Jun 2007 07:34:04 -0400
From: David Howells <dhowells@redhat.com>
In-Reply-To: <20070625110907.GA23438@flint.arm.linux.org.uk>
References: <20070625110907.GA23438@flint.arm.linux.org.uk> <1182761357.12109.14.camel@pmac.infradead.org> <20070625021145.b84ea186.akpm@linux-foundation.org> <20070625103535.GF22063@parisc-linux.org>
Subject: Re: Introduce fixed sys_sync_file_range2() syscall, implement on PowerPC and ARM
Date: Mon, 25 Jun 2007 12:33:43 +0100
Message-ID: <29425.1182771223@redhat.com>
Sender: linux-arch-owner@vger.kernel.org
To: Russell King <rmk@arm.linux.org.uk>
Cc: Matthew Wilcox <matthew@wil.cx>, Andrew Morton <akpm@linux-foundation.org>, David Woodhouse <dwmw2@infradead.org>, torvalds@linux-foundation.org, paulus@samba.org, linux-arch@vger.kernel.org, drepper@redhat.com
List-ID: <linux-arch.vger.kernel.org>

Russell King <rmk@arm.linux.org.uk> wrote:

> Thankfully, linux-arch is low noise.  We just need to convince those who
> want to add additional syscalls to copy their stuff here, such as that
> sys_sync_file_range() patch (http://lwn.net/Articles/177830/)

Agreed.  And a prototype manual page should perhaps be included in the patch
description...

David
