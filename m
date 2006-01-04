Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from smtp002.mail.ukl.yahoo.com ([217.12.11.33]:14754 "HELO
	smtp002.mail.ukl.yahoo.com") by vger.kernel.org with SMTP
	id S965285AbWADT6O (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Wed, 4 Jan 2006 14:58:14 -0500
From: Blaisorblade <blaisorblade@yahoo.it>
Subject: Re: [RFC] Consolidate asm/futex.h
Date: Wed, 4 Jan 2006 20:58:09 +0100
References: <20060103235910.GA10792@ccure.user-mode-linux.org>
In-Reply-To: <20060103235910.GA10792@ccure.user-mode-linux.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200601042058.10268.blaisorblade@yahoo.it>
Sender: linux-arch-owner@vger.kernel.org
To: Jeff Dike <jdike@addtoit.com>
Cc: linux-arch@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>

On Wednesday 04 January 2006 00:59, Jeff Dike wrote:
> Most of the architectures have the same asm/futex.h.  The patch below
> consolidates them into asm-generic, with the arches including it from
> their own asm/futex.h.

That's ok  - though for most architectures, that code is only a non-working 
stub returning -ENOSYS, so it's different from most stuff in asm-generic in 
being a generic non-implementation. May make however sense, however.

Don't forget mentioning in the changelog that for UML there is an 
implementation but it's wrong at the moment, so we're reverting it to the 
default stub.

> Unless there are objections, I'm going to send this to Andrew in the
> next few days.
>
> 				Jeff

-- 
Inform me of my mistakes, so I can keep imitating Homer Simpson's "Doh!".
Paolo Giarrusso, aka Blaisorblade (Skype ID "PaoloGiarrusso", ICQ 215621894)
http://www.user-mode-linux.org/~blaisorblade

	

	
		
___________________________________ 
Yahoo! Mail: gratis 1GB per i messaggi e allegati da 10MB 
http://mail.yahoo.it
