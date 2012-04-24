From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [RFC][PATCH 0/3] gcc work-around and math128
Date: Tue, 24 Apr 2012 14:18:09 -0700
Message-ID: <CA+55aFxJHHnEf4nuB5VEKa5OLJ38nY1-tN8oA2JkoYoO6nRUAQ@mail.gmail.com>
References: <20120424161039.293018424@chello.nl> <4F9717E6.8030506@amacapital.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-we0-f174.google.com ([74.125.82.174]:49623 "EHLO
	mail-we0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756379Ab2DXVSc (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Tue, 24 Apr 2012 17:18:32 -0400
In-Reply-To: <4F9717E6.8030506@amacapital.net>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Andy Lutomirski <luto@amacapital.net>
Cc: Peter Zijlstra <a.p.zijlstra@chello.nl>, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>, Juri Lelli <juri.lelli@gmail.com>

On Tue, Apr 24, 2012 at 2:15 PM, Andy Lutomirski <luto@amacapital.net> wrote:
>
> I played with some of this stuff awhile ago, and for timekeeping, it
> seemed like a 64x32->96 bit multiply followed by a right shift was
> enough, and that operation is a lot faster on 32-bit architectures than
> a full 64x64->128 multiply.

Ack. That may sound like odd numbers, but 64x32->96 sounds sane. And I
think it avoids a multiply even on 64-bit, no?

              Linus
