Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from smtp1.linux-foundation.org ([140.211.169.13]:53873 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753809AbYDQQrS (ORCPT
	<rfc822;linux-arch@vger.kernel.org>);
	Thu, 17 Apr 2008 12:47:18 -0400
Date: Thu, 17 Apr 2008 09:40:54 -0700 (PDT)
From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [patch 2/2]: introduce fast_gup
In-Reply-To: <1208450119.7115.36.camel@twins>
Message-ID: <alpine.LFD.1.00.0804170940270.2879@woody.linux-foundation.org>
References: <20080328025455.GA8083@wotan.suse.de>  <20080328030023.GC8083@wotan.suse.de> <1208444605.7115.2.camel@twins>  <alpine.LFD.1.00.0804170814090.2879@woody.linux-foundation.org>  <1208448768.7115.30.camel@twins>  <alpine.LFD.1.00.0804170916470.2879@woody.linux-foundation.org>
 <1208450119.7115.36.camel@twins>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Peter Zijlstra <peterz@infradead.org>
Cc: Nick Piggin <npiggin@suse.de>, Andrew Morton <akpm@linux-foundation.org>, shaggy@austin.ibm.com, axboe@kernel.dk, linux-mm@kvack.org, linux-arch@vger.kernel.org, Clark Williams <williams@redhat.com>, Ingo Molnar <mingo@elte.hu>, Jeremy Fitzhardinge <jeremy@goop.org>
Message-ID: <20080417164054.yy7dyNS5it6julZUWZnmu3RpSYGk2rbGt_dZ6WwYi2w@z>



On Thu, 17 Apr 2008, Peter Zijlstra wrote:
> 
> Here you go ;-)

I think you should _use_ the new functions too ;)

		Linus
