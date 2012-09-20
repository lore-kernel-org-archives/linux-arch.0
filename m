From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH] module: add finit_module syscall to asm-generic
Date: Thu, 20 Sep 2012 21:52:38 +0000
Message-ID: <201209202152.38630.arnd@arndb.de>
References: <20120920200702.GA18807@www.outflux.net>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.126.187]:64523 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752366Ab2ITVwo (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Thu, 20 Sep 2012 17:52:44 -0400
In-Reply-To: <20120920200702.GA18807@www.outflux.net>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Kees Cook <keescook@chromium.org>
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, Rusty Russell <rusty@rustcorp.com.au>

On Thursday 20 September 2012, Kees Cook wrote:
> 
> This adds the finit_module syscall to the generic syscall list.
> 
> Signed-off-by: Kees Cook <keescook@chromium.org>
> ---
> This depends on the finit_module patchset in Rusty's tree, based on
> https://lkml.org/lkml/2012/9/7/559

Acked-by: Arnd Bergmann <arnd@arndb.de>

Please queue this along with the other patches.
