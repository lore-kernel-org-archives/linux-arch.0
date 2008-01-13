Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from smtp2.linux-foundation.org ([207.189.120.14]:36656 "EHLO
	smtp2.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752071AbYAMQvM (ORCPT
	<rfc822;linux-arch@vger.kernel.org>);
	Sun, 13 Jan 2008 11:51:12 -0500
Date: Sun, 13 Jan 2008 08:50:23 -0800 (PST)
From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [rfc][patch 2/2] mm: introduce optional pte_special pte bit
In-Reply-To: <20080113050605.GA1340@wotan.suse.de>
Message-ID: <alpine.LFD.1.00.0801130846000.2806@woody.linux-foundation.org>
References: <20080113030810.GB22285@wotan.suse.de> <20080113031013.GD22285@wotan.suse.de> <alpine.LFD.1.00.0801121925330.2806@woody.linux-foundation.org> <20080113043922.GA22345@wotan.suse.de> <alpine.LFD.1.00.0801122042220.2806@woody.linux-foundation.org>
 <20080113050605.GA1340@wotan.suse.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Nick Piggin <npiggin@suse.de>
Cc: Hugh Dickins <hugh@veritas.com>, Jared Hulbert <jaredeh@gmail.com>, Carsten Otte <cotte@de.ibm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, linux-arch@vger.kernel.org



On Sun, 13 Jan 2008, Nick Piggin wrote:
> 
> OK, you have to read to the 3rd paragraph.

That one doesn't actually say what the point is either. It just claims 
that there *is* a point that isn't actually explained or mentioned 
further.

> Well the immediate improvement from this actual patch is just that
> it gives better and smaller code for vm_normal_page (even if you
> discount the debug checks in the existing code).

It does no such thing, except for the slow-path that doesn't matter.

So it may optimize the slow-path (PFNMAP/MIXMAP), but the real path stays 
exactly the same from a code generation standpoint (just checking a 
different bit, afaik). 

If those pte_special bits are required for unexplained lockless 
get_user_pages, is this going to get EVEN WORSE when s390 (again) cannot 
do it?

		Linus
