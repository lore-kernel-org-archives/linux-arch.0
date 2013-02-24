Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-vb0-f47.google.com ([209.85.212.47]:33733 "EHLO
	mail-vb0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759415Ab3BXC4E (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Sat, 23 Feb 2013 21:56:04 -0500
MIME-Version: 1.0
In-Reply-To: <20130220225214.GJ4503@ZenIV.linux.org.uk>
References: <20130220225214.GJ4503@ZenIV.linux.org.uk>
Date: Sat, 23 Feb 2013 18:56:02 -0800
Message-ID: <CA+55aFwx-O4Q=1gKgv=cyG8ObzUyPVh9Ctmuh-DX_DE9rumU5g@mail.gmail.com>
Subject: Re: [git pull] signal.git
From: Linus Torvalds <torvalds@linux-foundation.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Al Viro <viro@zeniv.linux.org.uk>, Helge Deller <deller@gmx.de>, Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>
Message-ID: <20130224025602.aqjUdkUJP4MJdwQzVVjQLEYzkLPUlNUaGYi_lVlKnfI@z>

On Wed, Feb 20, 2013 at 2:52 PM, Al Viro <viro@zeniv.linux.org.uk> wrote:
> * a bunch of signal-related syscalls (both native and compat) unified.

Ok, in the meantime I had merged the parisc and powerpc trees, which
had their own fixes in this area: powerpc added the transactional
memory support for power8 (which impacted signal save/restore), and
parisc had some fixes to the routines you then removed in favor of
generic ones.

I fixed up the conflicts, and they didn't look that bad, but I could
easily have messed something up, so people - please double-check the
end result.

             Linus
