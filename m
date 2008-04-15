Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from rv-out-0708.google.com ([209.85.198.242]:34589 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1756943AbYDOPHv (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Tue, 15 Apr 2008 11:07:51 -0400
Received: by rv-out-0506.google.com with SMTP id k29so897196rvb.1
        for <linux-arch@vger.kernel.org>; Tue, 15 Apr 2008 08:07:50 -0700 (PDT)
Subject: Re: + kernel-add-common-infrastructure-for-unaligned-access.patch
	added to -mm tree
From: Harvey Harrison <harvey.harrison@gmail.com>
In-Reply-To: <1208261668.9212.18.camel@pmac.infradead.org>
References: <200804142214.m3EMET5L029431@imap1.linux-foundation.org>
	 <1208261668.9212.18.camel@pmac.infradead.org>
Content-Type: text/plain
Date: Tue, 15 Apr 2008 08:07:53 -0700
Message-ID: <1208272073.11920.74.camel@brick>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: David Woodhouse <dwmw2@infradead.org>
Cc: akpm@linux-foundation.org, mm-commits@vger.kernel.org, linux-arch@vger.kernel.org
Message-ID: <20080415150753.Rmlsnkb7Kh86L3yvAvpEwCAENQNgweiJLo0-Dq6bZ3Y@z>

On Tue, 2008-04-15 at 13:14 +0100, David Woodhouse wrote:
> On Mon, 2008-04-14 at 15:14 -0700, akpm@linux-foundation.org wrote:
> > 
> > Currently there are five implementations:
> > 1) packed_struct.h: C-struct based, from asm-generic/unaligned.h
> > 2) le_byteshift.h: Open coded byte-swapping, heavily based on asm-arm
> > 3) be_byteshift.h: Open coded byte-swapping, heavily based on asm-arm
> > 4) memmove.h: taken from multiple implementations in tree
> > 5) access_ok.h: taken from x86 and others, unaligned access is ok.
> > 
> > All of the new implementations checks for sizes not equal to 1,2,4,8
> > and will fail to link.
> 
> This seems like overkill to me. Can't we just use the packed struct
> version? GCC should then to the right thing for all architectures.
> 

> And couldn't these be macros rather than relying on a boatload of
> infrastructure?


The reason I kept the byte-shifting versions around was that for
arches that need special handling of unaligned access, they could
do the byteshifting manually and get the unaligned access 'for free'
as it were.  The packed struct implementation works fine for the
same endianness, but I tried to make this as little of a change for
each arch as a consolidation step...which is why I kept the
memmove variant.  We can discuss moving arches over to other
implementations after the fact.

Cheers,

Harvey



