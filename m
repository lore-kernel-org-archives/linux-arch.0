Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from terminus.zytor.com ([198.137.202.10]:45324 "EHLO
	terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751544AbYCCEsr (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Sun, 2 Mar 2008 23:48:47 -0500
Message-ID: <47CB826A.7000202@zytor.com>
Date: Sun, 02 Mar 2008 20:45:30 -0800
From: "H. Peter Anvin" <hpa@zytor.com>
MIME-Version: 1.0
Subject: Re: [PATCH 1/2] Add C99-style constructor macros for specific-sized
 integers
References: <4a8566f54ff84f498c5c0c0340076c296b1840e6@tazenda.hos.anvin.org> <7e0381d9932a37ad78f0c38b2a3c6a03@kernel.crashing.org>
In-Reply-To: <7e0381d9932a37ad78f0c38b2a3c6a03@kernel.crashing.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Segher Boessenkool <segher@kernel.crashing.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, Linus Torvalds <torvalds@linux-foundation.org>, Linux Arch Mailing List <linux-arch@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, David Brownell <dbrownell@users.sourceforge.net>
Message-ID: <20080303044530.GfUGvyj7cJgt2e1qcXiimmbLntvj3NQ1cTzkNo_dfYg@z>

Segher Boessenkool wrote:
> 
> Do these new macros really buy anything over just writing LL in the
> few places that 64-bit constants are used?
> 

It gives you macros that matches the s64/u64 et al definitions are, thus 
avoiding another class of spurious warnings.

	-hpa
