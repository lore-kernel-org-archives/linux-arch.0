Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:51617 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758597AbYDYHtr (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Fri, 25 Apr 2008 03:49:47 -0400
From: Andreas Schwab <schwab@suse.de>
Subject: Re: [PATCH 00/24] Unify integer type definitions, and add fixed type constructor macros
References: <1209078352-7593-1-git-send-email-hpa@zytor.com>
	<Pine.LNX.4.64.0804250915030.21224@anakin>
Date: Fri, 25 Apr 2008 09:49:45 +0200
In-Reply-To: <Pine.LNX.4.64.0804250915030.21224@anakin> (Geert Uytterhoeven's
	message of "Fri, 25 Apr 2008 09:17:32 +0200 (CEST)")
Message-ID: <jebq3yjrvq.fsf@sykes.suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: "H. Peter Anvin" <hpa@zytor.com>, Linus Torvalds <torvalds@linux-foundation.org>, Andrew Morton <akpm@linux-foundation.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux Arch Mailing List <linux-arch@vger.kernel.org>
Message-ID: <20080425074945.V7NEM2F7FyyCU-ek0Lf9nT2184f9wQBzhpqlMKmShow@z>

Geert Uytterhoeven <geert@linux-m68k.org> writes:

> On Thu, 24 Apr 2008, H. Peter Anvin wrote:
>> This patchset unifies the integer definitions across all the
>> <asm-*/types.h> files, replacing them with two asm-generic files, one
>> for the LL64 model (all 32-bit architectures plus x86-64) and one for
>> the L64 model (all other 64-bit architectures.)
>
> Just a minor nitpick, what about calling them LP32 and LP64, like
> everybody else does?

LP32 wouldn't fit x86-64 (the header has nothing to say about pointer
types, it's all about integer types).

Andreas.

-- 
Andreas Schwab, SuSE Labs, schwab@suse.de
SuSE Linux Products GmbH, Maxfeldstraße 5, 90409 Nürnberg, Germany
PGP key fingerprint = 58CA 54C7 6D53 942B 1756  01D3 44D5 214B 8276 4ED5
"And now for something completely different."
