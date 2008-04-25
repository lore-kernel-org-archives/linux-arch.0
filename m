Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from alephnull.demon.nl ([83.160.184.112]:55966 "EHLO
	xi.wantstofly.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755593AbYDYAPd (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Thu, 24 Apr 2008 20:15:33 -0400
Date: Fri, 25 Apr 2008 02:15:31 +0200
From: Lennert Buytenhek <buytenh@wantstofly.org>
Subject: Re: [PATCH 01/24] types: create <asm-generic/int-*.h>
Message-ID: <20080425001531.GC29618@xi.wantstofly.org>
References: <1209078352-7593-1-git-send-email-hpa@zytor.com> <1209078352-7593-2-git-send-email-hpa@zytor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1209078352-7593-2-git-send-email-hpa@zytor.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Andrew Morton <akpm@linux-foundation.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux Arch Mailing List <linux-arch@vger.kernel.org>, Ben Dooks <ben-linux@fluff.org>, Russell King <rmk@arm.linux.org.uk>
Message-ID: <20080425001531.EsDchE_j4oNIrw1lJRjzwPC7QW6HpNRKLAwSp3GElaY@z>

On Thu, Apr 24, 2008 at 04:05:08PM -0700, H. Peter Anvin wrote:

> This creates two generic files with common integer definitions; one
> where 64 bits is "long" (most 64-bit architectures) and one where 64
> bits is "long long" (all 32-bit architectures and x86-64.)

Acked-by: Lennert Buytenhek <kernel@wantstofly.org>
