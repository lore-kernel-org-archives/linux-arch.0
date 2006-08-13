Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:30690 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1751408AbWHMU1f (ORCPT
	<rfc822;linux-arch@vger.kernel.org>);
	Sun, 13 Aug 2006 16:27:35 -0400
From: Andi Kleen <ak@suse.de>
Subject: Re: module compiler version check still needed?
Date: Sun, 13 Aug 2006 22:27:24 +0200
References: <31645.1155445159@ocs10w.ocs.com.au>
In-Reply-To: <31645.1155445159@ocs10w.ocs.com.au>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200608132227.24719.ak@suse.de>
Sender: linux-arch-owner@vger.kernel.org
To: Keith Owens <kaos@ocs.com.au>
Cc: linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>

On Sunday 13 August 2006 06:59, Keith Owens wrote:
> Andi Kleen (on Sun, 13 Aug 2006 06:48:36 +0200) wrote:
> >
> >Does anybody know of any reason why we would still need the compiler version
> >check during module loading? AFAIK on i386 it was only needed to handle
> >2.95 (which got dropped) and on x86-64 it was never needed. Is there
> >a need on any other architecture for it?
> 
> IA64 still needs the check.  include/asm-ia64/spinlock.h generates
> different calls to the out of line spinlock handler, depending on the
> version of gcc.

Thanks. But I guess it could be used to MODULE_ARCH_VERMAGIC for ia64 only then.
If nobody else complains I will do that.

-Andi
