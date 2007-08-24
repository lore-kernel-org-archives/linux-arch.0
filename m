Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mx1.redhat.com ([66.187.233.31]:56262 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932437AbXHXI7a (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Fri, 24 Aug 2007 04:59:30 -0400
From: David Howells <dhowells@redhat.com>
In-Reply-To: <20070824032646.GE6989@wotan.suse.de>
References: <20070824032646.GE6989@wotan.suse.de>
Subject: Re: [rfc] vmalloc: lazy, batched vunmapping
Date: Fri, 24 Aug 2007 09:59:25 +0100
Message-ID: <14030.1187945965@redhat.com>
Sender: linux-arch-owner@vger.kernel.org
To: Nick Piggin <npiggin@suse.de>
Cc: dhowells@redhat.com, linux-arch@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>

Nick Piggin <npiggin@suse.de> wrote:

> I'm working on a bit of code that vmaps/vunmaps a bit more often than
> I'd like. I've implemented a frontend to cache commonly used mappings,
> which solves most of the problem, but in looking various other ways to
> get the last bit of performance, I thought might be generally helpful
> to batch up vunmap driven TLB flushes. So I'll just throw the idea
> out there (is anyone else doing a lot of vmapping? I'd like to hear
> from you!).

Can the OOM handler force a purge?

David
