Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from rv-out-0708.google.com ([209.85.198.246]:39237 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1756769AbYDOPRC (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Tue, 15 Apr 2008 11:17:02 -0400
Received: by rv-out-0506.google.com with SMTP id k29so898937rvb.1
        for <linux-arch@vger.kernel.org>; Tue, 15 Apr 2008 08:17:02 -0700 (PDT)
Subject: Re: [PATCHv4 2/2] kernel: Move arches to use common unaligned
	access
From: Harvey Harrison <harvey.harrison@gmail.com>
In-Reply-To: <17632.1208253714@redhat.com>
References: <1208195405.5721.45.camel@brick>  <17632.1208253714@redhat.com>
Content-Type: text/plain
Date: Tue, 15 Apr 2008 08:17:05 -0700
Message-ID: <1208272625.11920.78.camel@brick>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: David Howells <dhowells@redhat.com>
Cc: Russell King <rmk@arm.linux.org.uk>, linux-arch <linux-arch@vger.kernel.org>, Andrew Morton <akpm@linux-foundation.org>, Linus Torvalds <torvalds@linux-foundation.org>
Message-ID: <20080415151705.3xoz_6ZJNGxlizJLImWJTbWwt3nk2odOBfq552j4OAM@z>

On Tue, 2008-04-15 at 11:01 +0100, David Howells wrote:
> Harvey Harrison <harvey.harrison@gmail.com> wrote:
> 
> >  arch/frv/kernel/traps.c           |    7 +-
> >  arch/frv/mm/unaligned.c           |  217 -------------------------------------
> 
> And arch/frv/mm/Makefile?  It still refers to unaligned.c.
> 

Missed that, thanks a lot.

> > -#ifndef _ASM_UNALIGNED_H
> > -#define _ASM_UNALIGNED_H
> > +#ifndef _ASM_FRV_UNALIGNED_H
> > +#define _ASM_FRV_UNALIGNED_H
> 
> Please don't!

Andrew, do you need an incremental patch for this, or can you take care
of it on your end?

Cheers,

Harvey


