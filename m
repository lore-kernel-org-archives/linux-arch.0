From: Andreas Schwab <schwab@linux-m68k.org>
Subject: Re: "N" symbols and System.map
Date: Sat, 02 May 2009 01:10:18 +0200
Message-ID: <m2preso1wl.fsf@igel.home>
References: <49FB7692.2000508@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-out.m-online.net ([212.18.0.9]:35446 "EHLO
	mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754269AbZEAXKW (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Fri, 1 May 2009 19:10:22 -0400
In-Reply-To: <49FB7692.2000508@linux.intel.com> (H. Peter Anvin's message of
	"Fri, 01 May 2009 15:24:18 -0700")
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: "H. Peter Anvin" <hpa@linux.intel.com>
Cc: LKML <linux-kernel@vger.kernel.org>, linux-arch@vger.kernel.org, Sam Ravnborg <sam@ravnborg.org>

"H. Peter Anvin" <hpa@linux.intel.com> writes:

> right now, we filter out symbols that nm tag N, meaning "debugging
> symbols", from System.map.  However, at least on x86, the linker-generated
> symbol _end is tagged N, and in fact is the only N in the entire image.
>
> Are there other architectures which would suffer if N were included in
> System.map, or would that be a reasonable thing to do?

There should not be any N symbols unless you are using stabs debugging.

Andreas.

-- 
Andreas Schwab, schwab@linux-m68k.org
GPG Key fingerprint = 58CA 54C7 6D53 942B 1756  01D3 44D5 214B 8276 4ED5
"And now for something completely different."
