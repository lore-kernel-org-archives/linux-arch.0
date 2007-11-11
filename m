Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from saraswathi.solana.com ([198.99.130.12]:50301 "EHLO
	saraswathi.solana.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751064AbXKKBX7 (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Sat, 10 Nov 2007 20:23:59 -0500
Date: Sat, 10 Nov 2007 20:18:43 -0500
From: Jeff Dike <jdike@addtoit.com>
Subject: Re: The FIXADDR stuff in memory.c and task_mmu.c
Message-ID: <20071111011843.GA7708@c2.user-mode-linux.org>
References: <20040112011230.3acb1632.akpm@osdl.org> <200401122222.i0CMMVRm031865@magilla.sf.frob.com> <20040112150402.04221f98.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040112150402.04221f98.akpm@osdl.org>
Sender: linux-arch-owner@vger.kernel.org
To: Andrew Morton <akpm@osdl.org>
Cc: Roland McGrath <roland@redhat.com>, davidm@napali.hpl.hp.com, linux-arch@vger.kernel.org, Nikita@Namesys.COM
List-ID: <linux-arch.vger.kernel.org>

On Mon, Jan 12, 2004 at 03:04:02PM -0800, Andrew Morton wrote:
> The um architecture went and used expressions which cannot be used in
> compile-time initialisers.

The location of the gate vma depends on the host vmsplit.  Right now,
that's compiled in with config variables, but I'd like to auto-detect
it at run-time at some point.

				Jeff

-- 
Work email - jdike at linux dot intel dot com
