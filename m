Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from smtp1.linux-foundation.org ([140.211.169.13]:34403 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752015AbYC0XOf (ORCPT
	<rfc822;linux-arch@vger.kernel.org>);
	Thu, 27 Mar 2008 19:14:35 -0400
Date: Thu, 27 Mar 2008 16:14:14 -0700 (PDT)
From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH] ptrace: arch_ptrace cleanup
In-Reply-To: <20080327230623.969FF26FA1C@magilla.localdomain>
Message-ID: <alpine.LFD.1.00.0803271612360.14670@woody.linux-foundation.org>
References: <20080327230623.969FF26FA1C@magilla.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Roland McGrath <roland@redhat.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
Message-ID: <20080327231414.FpCMUJEdvQkqwtlCRSCDyL94QceSelf-y5L61eb90xU@z>



On Thu, 27 Mar 2008, Roland McGrath wrote:
>
> This intends to remove the last bit of entanglement with core ptrace
> implementation details in arch code's arch_ptrace and arch_compat_ptrace.

So I think this has a nicer calling convention, but you never answered the 
question about what the *point* of this all is.

This is _still_ uglier than what we already have, which is to just have 
the code call "[compat_]ptrace_request()" for any cases they don't 
recognize.

I wanted to know if there was some actual technical point to it, and never 
got a reply to that. 

			Linus
