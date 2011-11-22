From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH 0/2] Stop some of the abuse of BUG() where compile time
 checks should be used.
Date: Tue, 22 Nov 2011 09:13:13 -0800
Message-ID: <CA+55aFw-yu0-RXB9wK=qxCnToNBKAZc4jThDLumc+bEOdxBVow@mail.gmail.com>
References: <1321925466-11280-1-git-send-email-ddaney.cavm@gmail.com> <4ECB6080.7050407@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-ww0-f44.google.com ([74.125.82.44]:57984 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753965Ab1KVRNe (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Tue, 22 Nov 2011 12:13:34 -0500
In-Reply-To: <4ECB6080.7050407@gmail.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: DM <dm.n9107@gmail.com>
Cc: David Daney <ddaney.cavm@gmail.com>, ralf@linux-mips.org, Andrew Morton <akpm@linux-foundation.org>, David Rientjes <rientjes@google.com>, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, David Daney <david.daney@cavium.com>

On Tue, Nov 22, 2011 at 12:42 AM, DM <dm.n9107@gmail.com> wrote:
>
> Perhaps BUILD_BUG() is a more consistent name for this?
>
> We would then have BUG() and BUG_ON(x) for run-time vs BUILD_BUG() and BUILD_BUG_ON(x) for compile-time.

Yeah, that probably would be nicer naming. The "BUILD_BUG_ON_USED()"
is kind of about the implementation, not the intention of the thing.

                  Linus
