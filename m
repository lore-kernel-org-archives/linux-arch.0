From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH] asm-generic: Use __BITS_PER_LONG in statfs.h
Date: Mon, 30 Apr 2012 13:57:11 +0000
Message-ID: <201204301357.11706.arnd@arndb.de>
References: <1335465916-16965-1-git-send-email-hpa@linux.intel.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.126.187]:65222 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753843Ab2D3N5R (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Mon, 30 Apr 2012 09:57:17 -0400
In-Reply-To: <1335465916-16965-1-git-send-email-hpa@linux.intel.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: "H. Peter Anvin" <hpa@linux.intel.com>
Cc: linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, hpa@zytor.com

On Thursday 26 April 2012, H. Peter Anvin wrote:
> From: "H. Peter Anvin" <hpa@linux.intel.com>
> 
> <asm-generic/statfs.h> is exported to userspace, so using
> BITS_PER_LONG is invalid.  We need to use __BITS_PER_LONG instead.
> 
> This is kernel bugzilla 43165.

Acked-by: Arnd Bergmann <arnd@arndb.de>
