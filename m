Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail.ocs.com.au ([202.147.117.210]:42798 "EHLO mail.ocs.com.au")
	by vger.kernel.org with ESMTP id S1030229AbWHME7O (ORCPT
	<rfc822;linux-arch@vger.kernel.org>);
	Sun, 13 Aug 2006 00:59:14 -0400
From: Keith Owens <kaos@ocs.com.au>
Subject: Re: module compiler version check still needed? 
In-reply-to: Your message of "Sun, 13 Aug 2006 06:48:36 +0200."
             <200608130648.36178.ak@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Sun, 13 Aug 2006 14:59:19 +1000
Message-ID: <31645.1155445159@ocs10w.ocs.com.au>
Sender: linux-arch-owner@vger.kernel.org
To: Andi Kleen <ak@suse.de>
Cc: linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>

Andi Kleen (on Sun, 13 Aug 2006 06:48:36 +0200) wrote:
>
>Does anybody know of any reason why we would still need the compiler version
>check during module loading? AFAIK on i386 it was only needed to handle
>2.95 (which got dropped) and on x86-64 it was never needed. Is there
>a need on any other architecture for it?

IA64 still needs the check.  include/asm-ia64/spinlock.h generates
different calls to the out of line spinlock handler, depending on the
version of gcc.

