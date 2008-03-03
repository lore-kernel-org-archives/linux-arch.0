Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from smtp118.sbc.mail.sp1.yahoo.com ([69.147.64.91]:33004 "HELO
	smtp118.sbc.mail.sp1.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1755317AbYCCEUy (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Sun, 2 Mar 2008 23:20:54 -0500
From: David Brownell <david-b@pacbell.net>
Subject: Re: [PATCH 1/2] Add C99-style constructor macros for specific-sized integers
Date: Sun, 2 Mar 2008 20:14:11 -0800
References: <4a8566f54ff84f498c5c0c0340076c296b1840e6@tazenda.hos.anvin.org> <7e0381d9932a37ad78f0c38b2a3c6a03@kernel.crashing.org>
In-Reply-To: <7e0381d9932a37ad78f0c38b2a3c6a03@kernel.crashing.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-ID: <200803022014.11535.david-b@pacbell.net>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Segher Boessenkool <segher@kernel.crashing.org>
Cc: "H. Peter Anvin" <hpa@zytor.com>, Andrew Morton <akpm@linux-foundation.org>, Linus Torvalds <torvalds@linux-foundation.org>, Linux Arch Mailing List <linux-arch@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Message-ID: <20080303041411.Y2HGNzgglIVfXB8xItu11841esCkXq3dUC2X40NxfZg@z>

On Sunday 02 March 2008, Segher Boessenkool wrote:

> Do these new macros really buy anything over just writing LL in the
> few places that 64-bit constants are used?

The original workaround was to make the offending *SEC_TO_HZ_ADJ32
constants use "ULL" suffixes.  Certainly making the Perl script emit
those would be less intrusive.

- Dave

