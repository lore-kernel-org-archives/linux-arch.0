From: Lennert Buytenhek <buytenh@wantstofly.org>
Subject: Re: [PATCH 01/24] types: create <asm-generic/int-*.h>
Date: Fri, 25 Apr 2008 02:15:31 +0200
Message-ID: <20080425001531.GC29618@xi.wantstofly.org>
References: <1209078352-7593-1-git-send-email-hpa@zytor.com> <1209078352-7593-2-git-send-email-hpa@zytor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1756699AbYDYAPq@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1209078352-7593-2-git-send-email-hpa@zytor.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Andrew Morton <akpm@linux-foundation.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux Arch Mailing List <linux-arch@vger.kernel.org>, Ben Dooks <ben-linux@fluff.org>, Russell King <rmk@arm.linux.org.uk>
List-Id: linux-arch.vger.kernel.org

On Thu, Apr 24, 2008 at 04:05:08PM -0700, H. Peter Anvin wrote:

> This creates two generic files with common integer definitions; one
> where 64 bits is "long" (most 64-bit architectures) and one where 64
> bits is "long long" (all 32-bit architectures and x86-64.)

Acked-by: Lennert Buytenhek <kernel@wantstofly.org>
