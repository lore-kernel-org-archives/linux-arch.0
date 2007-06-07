Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from wf1.mips-uk.com ([194.74.144.154]:44777 "EHLO
	dl5rb.ham-radio-op.net" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S937466AbXFHLLs (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Fri, 8 Jun 2007 07:11:48 -0400
Date: Thu, 7 Jun 2007 22:05:12 +0100
From: Ralf Baechle <ralf@linux-mips.org>
Subject: Re: [RFC PATCH 0/9] Thumb-2 ISA kernel port
Message-ID: <20070607210512.GA13729@linux-mips.org>
References: <20070606172409.6689.26641.stgit@localhost.localdomain> <20070606182914.GB6303@uranus.ravnborg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20070606182914.GB6303@uranus.ravnborg.org>
Sender: linux-arch-owner@vger.kernel.org
To: Sam Ravnborg <sam@ravnborg.org>
Cc: Catalin Marinas <catalin.marinas@arm.com>, linux-arch@vger.kernel.org, linux-arm-kernel@lists.arm.linux.org.uk
List-ID: <linux-arch.vger.kernel.org>

On Wed, Jun 06, 2007 at 08:29:14PM +0200, Sam Ravnborg wrote:

> > Because of the issues listed below, merging the Thumb-2 support into
> > the existing arch/arm files would clutter the existing code with
> > macros like ARM, THUMB or W (for conditional compilation and the wide
> > instruction format). The IT instruction is also not recognised by
> > older toolchains and additional (assembler) macros would be needed,
> > including support for the inline assembly. I therefore decided to
> > create a separate arch/arm_t2 directory that shares a lot of code with
> > the existing arch/arm.
> 
> Hi Catalin.
> Can you please share with us the strong arguments why another (third)
> arm architecture are needed?

It's been my experience with 64-bit MIPS that starting off with a 2nd
arch then eventually factoring out the differences and unifying things
back into a single mips architecture was actually the easier road to go.

Downside: this approach takes long term careful coding.  It is hell with
the kind of "code once and resuse never" style that's only too common in
the embedded industry.

  Ralf
