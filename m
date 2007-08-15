Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mx1.redhat.com ([66.187.233.31]:45165 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751830AbXHORzo (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Wed, 15 Aug 2007 13:55:44 -0400
Message-ID: <46C33E19.3050805@redhat.com>
Date: Wed, 15 Aug 2007 13:55:37 -0400
From: Chris Snook <csnook@redhat.com>
MIME-Version: 1.0
Subject: [RFP] atomic[64]_[read|set] asm implementations
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
To: Linux Kernel <linux-kernel@vger.kernel.org>, linux-arch@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>

In the fallout from the recent atomic_t volatility discussions, patches 
have been posted to moot the compiler correctness issues by implementing 
atomic[64]_[read|set] in inline assembly on powerpc, i386, and x86_64. 
While I personally don't consider such implementations to be critically 
necessary, they slightly reduce binary size and greatly reduce lkml 
controversy, so I like them.

I'm not an inline assembly expert, but I would welcome it if those who 
are would like to submit implementations of these functions for 
architectures they're intimately familiar with.  I'll pull them into the 
atomic_t patch set I've stumbled into shepherding, and hopefully we can 
commit something all at once that makes all architectures consistent, 
resists compiler bugs, and doesn't piss off too many people.

For architectures whose maintainers aren't worried and whose 
developers/users aren't bothered enough to submit an inline assembly 
patch, I'll just keep the inlines with the *(volatile foo *)& casts, 
unless of course ISO clarifies the C standard to different effect while 
we're arguing over semantics and micro-optimizations.

	-- Chris
