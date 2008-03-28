Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from n2.bullet.mail.re3.yahoo.com ([68.142.237.109]:43476 "HELO
	n2.bullet.mail.re3.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1751897AbYC1I0m (ORCPT
	<rfc822;linux-arch@vger.kernel.org>);
	Fri, 28 Mar 2008 04:26:42 -0400
From: Nick Piggin <nickpiggin@yahoo.com.au>
Subject: Re: down_spin() implementation
Date: Fri, 28 Mar 2008 16:03:33 +1100
References: <1FE6DD409037234FAB833C420AA843ECE9DF60@orsmsx424.amr.corp.intel.com> <20080327141508.GL16721@parisc-linux.org> <20080328155107.e9d8866c.sfr@canb.auug.org.au>
In-Reply-To: <20080328155107.e9d8866c.sfr@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-ID: <200803281603.34134.nickpiggin@yahoo.com.au>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Stephen Rothwell <sfr@canb.auug.org.au>
Cc: Matthew Wilcox <matthew@wil.cx>, "Luck, Tony" <tony.luck@intel.com>, linux-arch@vger.kernel.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org
Message-ID: <20080328050333.vt3zWo5QF2oKuE9Ikt4jkozJ2ruChBXPsN8eNfAOHwo@z>

On Friday 28 March 2008 15:51, Stephen Rothwell wrote:
> Hi Willy,
>
> On Thu, 27 Mar 2008 08:15:08 -0600 Matthew Wilcox <matthew@wil.cx> wrote:
> > Stephen, I've updated the 'semaphore' tag to point ot the same place as
> > semaphore-20080327, so please change your linux-next tree from pulling
> > semaphore-20080314 to just pulling plain 'semaphore'.  I'll use this
> > method of tagging from now on.
>
> Thanks. I read this to late for today's tree, but I will fix it up for
> the next one.

Please don't add this nasty code to semaphore.

Did my previous message to the thread get eaten by spam filters?

