Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from ftp.linux-mips.org ([194.74.144.162]:54223 "EHLO
	ftp.linux-mips.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756769AbXJaMs6 (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Wed, 31 Oct 2007 08:48:58 -0400
Received: from localhost.localdomain ([127.0.0.1]:4480 "EHLO
	dl5rb.ham-radio-op.net") by ftp.linux-mips.org with ESMTP
	id S28575923AbXJaMs4 (ORCPT <rfc822;linux-arch@vger.kernel.org>
	+ 1 other); Wed, 31 Oct 2007 12:48:56 +0000
Date: Wed, 31 Oct 2007 12:48:31 +0000
From: Ralf Baechle <ralf@linux-mips.org>
Subject: Re: [patch 04/28] Add cmpxchg64 and cmpxchg64_local to mips
Message-ID: <20071031124831.GA3982@linux-mips.org>
References: <20071030191557.947156623@polymtl.ca> <20071030192102.677087409@polymtl.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20071030192102.677087409@polymtl.ca>
Sender: linux-arch-owner@vger.kernel.org
To: Mathieu Desnoyers <mathieu.desnoyers@polymtl.ca>
Cc: akpm@linux-foundation.org, linux-kernel@vger.kernel.org, matthew@wil.cx, linux-arch@vger.kernel.org, penberg@cs.helsinki.fi, linux-mm@kvack.org, Christoph Lameter <clameter@sgi.com>
List-ID: <linux-arch.vger.kernel.org>

On Tue, Oct 30, 2007 at 03:16:01PM -0400, Mathieu Desnoyers wrote:

> Index: linux-2.6-lttng/include/asm-mips/cmpxchg.h
> ===================================================================
> --- linux-2.6-lttng.orig/include/asm-mips/cmpxchg.h	2007-10-12 12:05:06.000000000 -0400
> +++ linux-2.6-lttng/include/asm-mips/cmpxchg.h	2007-10-12 12:08:56.000000000 -0400
> @@ -104,4 +104,13 @@ extern void __cmpxchg_called_with_bad_po
>  #define cmpxchg(ptr, old, new)		__cmpxchg(ptr, old, new, smp_llsc_mb())
>  #define cmpxchg_local(ptr, old, new)	__cmpxchg(ptr, old, new, )
>  
> +#define cmpxchg64	cmpxchg
> +
> +#ifdef CONFIG_64BIT
> +#define cmpxchg64_local	cmpxchg_local

This implementation means cmpxchg64_local will also silently take 32-bit
arguments without making noises at compile time.  I think it should.

  Ralf
