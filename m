Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from n9.bullet.re3.yahoo.com ([68.142.237.94]:21147 "HELO
	n9.bullet.re3.yahoo.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1751571AbYC2Bd3 (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Fri, 28 Mar 2008 21:33:29 -0400
From: Nick Piggin <nickpiggin@yahoo.com.au>
Subject: Re: down_spin() implementation
Date: Sat, 29 Mar 2008 12:04:36 +1100
References: <1FE6DD409037234FAB833C420AA843ECE9DF60@orsmsx424.amr.corp.intel.com> <200803281101.25037.nickpiggin@yahoo.com.au> <20080328124517.GQ16721@parisc-linux.org>
In-Reply-To: <20080328124517.GQ16721@parisc-linux.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-ID: <200803291204.36855.nickpiggin@yahoo.com.au>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Matthew Wilcox <matthew@wil.cx>
Cc: "Luck, Tony" <tony.luck@intel.com>, Stephen Rothwell <sfr@canb.auug.org.au>, linux-arch@vger.kernel.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org
Message-ID: <20080329010436.ero4TdNCVBky7cFNISJGBBkab-wt0b6WKBIghXI_9Q4@z>

On Friday 28 March 2008 23:45, Matthew Wilcox wrote:

> I think we can do better here with:
>
> 	atomic_set(max);
>
> and
>
> 	while (unlikely(!atomic_add_unless(&ss->cur, -1, 0)))
> 		while (atomic_read(&ss->cur) == 0)
> 			cpu_relax();

Yeah of course! That's much better ;)

I'd say Tony could just open code it for now, which would get him
up and running quickly... although if anybody gets keen to add it
as a generic API then I wouldn't object.

