Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from smtp2.linux-foundation.org ([207.189.120.14]:49790 "EHLO
	smtp2.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S935544AbXGSQoV (ORCPT
	<rfc822;linux-arch@vger.kernel.org>);
	Thu, 19 Jul 2007 12:44:21 -0400
Date: Thu, 19 Jul 2007 09:43:57 -0700 (PDT)
From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [patch 059/209] mm: variable length argument support
In-Reply-To: <200707190848.l6J8mGmT023102@imap1.linux-foundation.org>
Message-ID: <alpine.LFD.0.999.0707190937290.8502@woody.linux-foundation.org>
References: <200707190848.l6J8mGmT023102@imap1.linux-foundation.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=us-ascii
Sender: linux-arch-owner@vger.kernel.org
To: akpm@linux-foundation.org
Cc: aaw@google.com, a.p.zijlstra@chello.nl, bunk@stusta.de, hugh@veritas.com, linux-arch@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>



On Thu, 19 Jul 2007, akpm@linux-foundation.org wrote:
>
> From: Ollie Wild <aaw@google.com>
> 
> Remove the arg+env limit of MAX_ARG_PAGES by copying the strings directly from
> the old mm into the new mm.

Btw, this is just a note to say "thanks". 

This is my old commit from 2002 from the BK tree:

	commit 1d0c3d1807bf80943ad06868ef41665766c3ff0f
	Author: Linus Torvalds <torvalds@home.transmeta.com>
	Date:   Tue May 28 08:01:57 2002 -0700
	
	    Remove re-use of "struct mm_struct" at execve() time.
	
	    This will eventually allow us to copy argc/argv without
	    any intermediate storage (removing current argument size
	    limitations).

..and the "eventually" ended up being more than five years later, but hey, 
better late than never.

			Linus
