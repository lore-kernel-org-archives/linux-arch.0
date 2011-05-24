Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.17.9]:63466 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754053Ab1EXW6h (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Tue, 24 May 2011 18:58:37 -0400
From: "Hans-Peter Jansen" <hpj@urpla.net>
Subject: Re: (Short?) merge window reminder
Date: Wed, 25 May 2011 01:00:07 +0200
References: <BANLkTi=PLuZhx1=rCfOtg=aOTuC1UbuPYg@mail.gmail.com> <20110523192056.GC23629@elte.hu> <BANLkTikdgM+kSvaEYuQkgCYJZELnvwfetg@mail.gmail.com>
In-Reply-To: <BANLkTikdgM+kSvaEYuQkgCYJZELnvwfetg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-ID: <201105250100.08708.hpj@urpla.net>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Ingo Molnar <mingo@elte.hu>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-arch@vger.kernel.org, DRI <dri-devel@lists.freedesktop.org>, linux-fsdevel <linux-fsdevel@vger.kernel.org>, linux-mm <linux-mm@kvack.org>, Andrew Morton <akpm@linux-foundation.org>, Greg KH <gregkh@suse.de>, aufs-users@lists.sourceforge.net
Message-ID: <20110524230007.Y_Cnbv0RBtbyt0NUNiSmQBRDlO_ADL51Bckn2_kPXI4@z>

On Monday 23 May 2011, 22:33:48 Linus Torvalds wrote:
> On Mon, May 23, 2011 at 12:20 PM, Ingo Molnar <mingo@elte.hu> wrote:
> > I really hope there's also a voice that tells you to wait until .42
> > before cutting 3.0.0! :-)
>
> So I'm toying with 3.0 (and in that case, it really would be "3.0",
> not "3.0.0" - the stable team would get the third digit rather than
> the fourth one.
>
> But no, it wouldn't be for 42. Despite THHGTTG, I think "40" is a
> fairly nice round number.
>
> There's also the timing issue - since we no longer do version numbers
> based on features, but based on time, just saying "we're about to
> start the third decade" works as well as any other excuse.

But hey, do you really want to release a Linux 3.0 kernel without 
serious layered filesystem functionality? 

Shame on you,
Pete

PS.: Sorry for being such a pest in this regard, but filesystem layering 
is one of the most important missing bits to excel out of the box in
 * live distros 
 * diskless computing
 * flash based systems
Even the linux based commercial PBX solution (mobydick), I bought, ships 
with it.
PPS.: Bad timing, I know, but I'm glad, that Al is back to life again..
