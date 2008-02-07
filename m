Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from pentafluge.infradead.org ([213.146.154.40]:34742 "EHLO
	pentafluge.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753926AbYBGIx3 (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Thu, 7 Feb 2008 03:53:29 -0500
Subject: Re: -
	cleanup-asm-elfpageuserh-ifdef-__kernel__-is-no-longer-needed-fix.pa tch
	removed from -mm tree
From: David Woodhouse <dwmw2@infradead.org>
In-Reply-To: <20080207085133.GA4206@localhost.localdomain>
References: <200802070338.m173c8MA014249@imap1.linux-foundation.org>
	 <20080207085133.GA4206@localhost.localdomain>
Content-Type: text/plain
Date: Thu, 07 Feb 2008 08:53:25 +0000
Message-Id: <1202374405.5469.170.camel@pmac.infradead.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: "Kirill A. Shutemov" <k.shutemov@gmail.com>
Cc: akpm@linux-foundation.org, linux-arch@vger.kernel.org, mm-commits@vger.kernel.org


On Thu, 2008-02-07 at 10:51 +0200, Kirill A. Shutemov wrote:
> On [Wed, 06.02.2008 19:38], akpm@linux-foundation.org wrote:
> > 
> > The patch titled
> >      Cleanup asm/{elf,page,user}.h: #ifdef __KERNEL__ is no longer needed (fix)
> > has been removed from the -mm tree.  Its filename was
> >      cleanup-asm-elfpageuserh-ifdef-__kernel__-is-no-longer-needed-fix.patch
> 
> Why? asm/elf.h on PowerPC has still exported, so this patch is needed.

This patch was dropped because it was folded into
cleanup-asm-elfpageuserh-ifdef-__kernel__-is-no-longer-needed.patch

-- 
dwmw2

