Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from smtp2.linux-foundation.org ([207.189.120.14]:55144 "EHLO
	smtp2.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S933251AbXGZIFe (ORCPT
	<rfc822;linux-arch@vger.kernel.org>);
	Thu, 26 Jul 2007 04:05:34 -0400
Date: Thu, 26 Jul 2007 01:05:22 -0700
From: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [patch 1/7] bitops: introduce lock bitops
Message-Id: <20070726010522.0faeab97.akpm@linux-foundation.org>
In-Reply-To: <20070725113407.GG29011@wotan.suse.de>
References: <20070725113407.GG29011@wotan.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
To: Nick Piggin <npiggin@suse.de>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-arch@vger.kernel.org, Benjamin Herrenschmidt <benh@kernel.crashing.org>
List-ID: <linux-arch.vger.kernel.org>

On Wed, 25 Jul 2007 13:34:07 +0200 Nick Piggin <npiggin@suse.de> wrote:

> I'd like to get the new lock bitop primitives in if possible. Maybe it
> is too late for 2.6.23, but at least if I can queue them up in -mm?
> 
> They are pretty simple, but at least the page lock and buffer lock
> conversions touch quite a lot of code.

The changes look innocuous enough.  I'd prefer not to carry this for two
months though.

afacit all the operations which got changed were actually renamed, so any
unconverted code will reliably fail to compile, yes?  (If not, can we find
a way to do this?).  This means that a) if I _were_ to carry if for two
months, any new code which gets added using the old operations will get
reliably detected and b) there's not really much benefit in me carrying it
all for two months.

> Not sure how to really do this
> better to reduce merge difficulties.

Resend around the -rc5/6 timeframe?
