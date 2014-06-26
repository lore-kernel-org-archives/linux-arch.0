From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH 0/6] RCU get_user_pages_fast and __get_user_pages_fast
Date: Thu, 26 Jun 2014 09:53:34 +0200
Message-ID: <20140626075334.GA12054@laptop.lan>
References: <1403710824-24340-1-git-send-email-steve.capper@linaro.org>
 <20140625134235.4f32768faa1a4380a62458ff@linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from casper.infradead.org ([85.118.1.10]:33824 "EHLO
	casper.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754046AbaFZHxk (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Thu, 26 Jun 2014 03:53:40 -0400
Content-Disposition: inline
In-Reply-To: <20140625134235.4f32768faa1a4380a62458ff@linux-foundation.org>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Steve Capper <steve.capper@linaro.org>, linux-arm-kernel@lists.infradead.org, catalin.marinas@arm.com, linux@arm.linux.org.uk, linux-arch@vger.kernel.org, linux-mm@kvack.org, will.deacon@arm.com, gary.robertson@linaro.org, christoffer.dall@linaro.org, anders.roxell@linaro.org

On Wed, Jun 25, 2014 at 01:42:35PM -0700, Andrew Morton wrote:
> On Wed, 25 Jun 2014 16:40:18 +0100 Steve Capper <steve.capper@linaro.org> wrote:
> 
> > This series implements general forms of get_user_pages_fast and
> > __get_user_pages_fast and activates them for arm and arm64.
> 
> Why not x86?
> 
> I think I might have already asked this.  If so, it's your fault for
> not updating the changelog ;)

Because x86 doesn't do RCU freed page tables :-) Also because i386 PAE
has magic (although one might expect ARM PAE -- or whatever they called
it -- to need similar magic).
