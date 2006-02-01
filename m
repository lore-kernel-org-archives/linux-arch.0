Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail.suse.de ([195.135.220.2]:56979 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1750807AbWBAIt2 (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Wed, 1 Feb 2006 03:49:28 -0500
From: Andi Kleen <ak@suse.de>
Subject: Re: Fw: [PATCH] abstract type/size specification for assembly
Date: Wed, 1 Feb 2006 09:49:18 +0100
References: <20060131143149.35db2e02.akpm@osdl.org> <200602010836.09932.ak@suse.de> <20060201083243.GB24893@flint.arm.linux.org.uk>
In-Reply-To: <20060201083243.GB24893@flint.arm.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200602010949.19428.ak@suse.de>
Sender: linux-arch-owner@vger.kernel.org
To: Russell King <rmk@arm.linux.org.uk>
Cc: Andrew Morton <akpm@osdl.org>, linux-arch@vger.kernel.org, Jan Beulich <JBeulich@novell.com>
List-ID: <linux-arch.vger.kernel.org>

On Wednesday 01 February 2006 09:32, Russell King wrote:

> @ is the comment character on ARM, so this can't go here - we use
> 
> 	.type name, %function
> 
> instead.  Interestingly, the info pages for as seem to indicate that
> there's a number of alternatives - maybe the most benign one should
> be used, iow:
> 
> 	.type name, "function"
> 
> or alternatively make ENDPROC arch-overridable.

Actually it could be just per architecture. Or do you see ARM specific
assembly code using ENDPROC() any time soon? And there are no portable
assembly files.

I assume Jan only wants/needs it for x86(-32/64) and perhaps ia64/ppc.

-Andi
