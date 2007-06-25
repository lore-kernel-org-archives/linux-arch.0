Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from stout.engsoc.carleton.ca ([134.117.69.22]:58506 "EHLO
	stout.engsoc.carleton.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752781AbXFYOqN (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Mon, 25 Jun 2007 10:46:13 -0400
Date: Mon, 25 Jun 2007 10:35:45 -0400
From: Kyle McMartin <kyle@mcmartin.ca>
Subject: Re: Introduce fixed sys_sync_file_range2() syscall, implement on PowerPC and ARM
Message-ID: <20070625143545.GA21777@fattire.cabal.ca>
References: <20070625110907.GA23438@flint.arm.linux.org.uk> <1182761357.12109.14.camel@pmac.infradead.org> <20070625021145.b84ea186.akpm@linux-foundation.org> <20070625103535.GF22063@parisc-linux.org> <29425.1182771223@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <29425.1182771223@redhat.com>
Sender: linux-arch-owner@vger.kernel.org
To: David Howells <dhowells@redhat.com>
Cc: Russell King <rmk@arm.linux.org.uk>, Matthew Wilcox <matthew@wil.cx>, Andrew Morton <akpm@linux-foundation.org>, David Woodhouse <dwmw2@infradead.org>, torvalds@linux-foundation.org, paulus@samba.org, linux-arch@vger.kernel.org, drepper@redhat.com
List-ID: <linux-arch.vger.kernel.org>

On Mon, Jun 25, 2007 at 12:33:43PM +0100, David Howells wrote:
> Russell King <rmk@arm.linux.org.uk> wrote:
> 
> > Thankfully, linux-arch is low noise.  We just need to convince those who
> > want to add additional syscalls to copy their stuff here, such as that
> > sys_sync_file_range() patch (http://lwn.net/Articles/177830/)
> 
> Agreed.  And a prototype manual page should perhaps be included in the patch
> description...
> 

hear, hear.

A testcase too!
