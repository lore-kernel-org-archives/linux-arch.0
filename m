Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from wa-out-1112.google.com ([209.85.146.180]:28589 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751904AbYANVEI (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Mon, 14 Jan 2008 16:04:08 -0500
Received: by wa-out-1112.google.com with SMTP id v27so3876942wah.23
        for <linux-arch@vger.kernel.org>; Mon, 14 Jan 2008 13:04:07 -0800 (PST)
Message-ID: <6934efce0801141304q2987801dr7534fbc657d91061@mail.gmail.com>
Date: Mon, 14 Jan 2008 13:04:07 -0800
From: "Jared Hulbert" <jaredeh@gmail.com>
Subject: Re: [rfc][patch 2/2] mm: introduce optional pte_special pte bit
In-Reply-To: <alpine.LFD.1.00.0801130846000.2806@woody.linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <20080113030810.GB22285@wotan.suse.de>
	 <20080113031013.GD22285@wotan.suse.de>
	 <alpine.LFD.1.00.0801121925330.2806@woody.linux-foundation.org>
	 <20080113043922.GA22345@wotan.suse.de>
	 <alpine.LFD.1.00.0801122042220.2806@woody.linux-foundation.org>
	 <20080113050605.GA1340@wotan.suse.de>
	 <alpine.LFD.1.00.0801130846000.2806@woody.linux-foundation.org>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Nick Piggin <npiggin@suse.de>, Hugh Dickins <hugh@veritas.com>, Carsten Otte <cotte@de.ibm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, linux-arch@vger.kernel.org

> That one doesn't actually say what the point is either. It just claims
> that there *is* a point that isn't actually explained or mentioned
> further.

I can't comment on Nick' lockless get_user_pages, but I can talk about
the XIP part.

As far as I understand it XIP is used with Linux in two kinds of
systems.  The very small (embedded ARM/MIPS) and the very big (s390).
XIP support for the s390 use case was merged long ago but did not
address the needs of the embedded use case.  Not surprising given how
different the systems are.  5 year old funky patches for the embedded
use case have been the norm for hundreds of embedded designs,
including millions of Japanese phones.

When I asked Andrew for advice on how to proceed to get the funky
patches merged he said, "We have an XIP subsystem, why don't you make
that work?"  When I looked in to the issue I found that the vm needed
a little tweaking before we could leverage the filemap_xip.c work.
Fortunately Nick was eager to help.  The result of that effort was the
VM_MIXEDMAP patch and then Nick's get_xip_page->get_xip_address patch.

In a uniquely Linux situation we now have advocates of the smallest
embedded systems and the big mainframe excited about the same
patchset.  The only problem is we are having problems sorting out how
to deal with vm_normal_page() for the VM_MIXEDMAP case such that it
works well for both ARM and s390.  Hence the pte_special bit.  Seems
like the result is a reasonable compromise to me, I'm surprised Nicks
patch is as clean as it is.  Many of the other proposed solutions are
very awkward for one or the other.
