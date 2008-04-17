Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from smtp1.linux-foundation.org ([140.211.169.13]:54150 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1761985AbYDQS3f (ORCPT
	<rfc822;linux-arch@vger.kernel.org>);
	Thu, 17 Apr 2008 14:29:35 -0400
Date: Thu, 17 Apr 2008 11:28:45 -0700 (PDT)
From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [patch 2/2]: introduce fast_gup
In-Reply-To: <1208453014.7115.39.camel@twins>
Message-ID: <alpine.LFD.1.00.0804171127310.2879@woody.linux-foundation.org>
References: <20080328025455.GA8083@wotan.suse.de>  <20080328030023.GC8083@wotan.suse.de> <1208444605.7115.2.camel@twins>  <alpine.LFD.1.00.0804170814090.2879@woody.linux-foundation.org>  <1208448768.7115.30.camel@twins>  <alpine.LFD.1.00.0804170916470.2879@woody.linux-foundation.org>
  <1208450119.7115.36.camel@twins>  <alpine.LFD.1.00.0804170940270.2879@woody.linux-foundation.org> <1208453014.7115.39.camel@twins>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Peter Zijlstra <peterz@infradead.org>
Cc: Nick Piggin <npiggin@suse.de>, Andrew Morton <akpm@linux-foundation.org>, shaggy@austin.ibm.com, axboe@kernel.dk, linux-mm@kvack.org, linux-arch@vger.kernel.org, Clark Williams <williams@redhat.com>, Ingo Molnar <mingo@elte.hu>, Jeremy Fitzhardinge <jeremy@goop.org>
Message-ID: <20080417182845.RozWh8zfwCTkRgUoI5oz1wJINp0BvGEOl52NvD2Mb5w@z>



On Thu, 17 Apr 2008, Peter Zijlstra wrote:
> 
> D'0h - clearly not my day today...

Ok, I'm acking this one ;)

And yes, it would be nice if the gup patches would go in early, since I 
wouldn't be entirely surprised if other architectures didn't have some 
other subtle issues here. We've never accessed the page tables without 
locking before, so we've only had races with hardware, never software.

			Linus
