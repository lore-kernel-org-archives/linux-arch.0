Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from smtp2.linux-foundation.org ([207.189.120.14]:38580 "EHLO
	smtp2.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750911AbYAPRXM (ORCPT
	<rfc822;linux-arch@vger.kernel.org>);
	Wed, 16 Jan 2008 12:23:12 -0500
Date: Wed, 16 Jan 2008 09:21:57 -0800 (PST)
From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [rfc][patch 2/2] mm: introduce optional pte_special pte bit
In-Reply-To: <20080116051759.GA14049@wotan.suse.de>
Message-ID: <alpine.LFD.1.00.0801160918510.2806@woody.linux-foundation.org>
References: <20080113031013.GD22285@wotan.suse.de> <alpine.LFD.1.00.0801121925330.2806@woody.linux-foundation.org> <20080113043922.GA22345@wotan.suse.de> <alpine.LFD.1.00.0801122042220.2806@woody.linux-foundation.org> <20080113050605.GA1340@wotan.suse.de>
 <alpine.LFD.1.00.0801130846000.2806@woody.linux-foundation.org> <20080116033800.GA8890@wotan.suse.de> <alpine.LFD.1.00.0801151944120.2806@woody.linux-foundation.org> <20080116043728.GA7684@wotan.suse.de> <alpine.LFD.1.00.0801152040310.2806@woody.linux-foundation.org>
 <20080116051759.GA14049@wotan.suse.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Nick Piggin <npiggin@suse.de>
Cc: Hugh Dickins <hugh@veritas.com>, Jared Hulbert <jaredeh@gmail.com>, Carsten Otte <cotte@de.ibm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, linux-arch@vger.kernel.org, rmk@arm.linux.org.uk, catalin.marinas@arm.com


On Wed, 16 Jan 2008, Nick Piggin wrote:
> 
> http://marc.info/?t=119968107900003&r=2&w=2

Gaah. That first original patch I would have been perfectly happy with.

I guess having the fallback is inevitable. I don't like it, but oh well.

		Linus
