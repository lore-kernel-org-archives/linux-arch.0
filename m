From: "Steven J. Magnani" <steve@digidescorp.com>
Subject: Re: Generic DMA - BUG_ON
Date: Thu, 21 Jan 2010 09:51:37 -0600
Message-ID: <1264089097.18869.0.camel@iscandar.digidescorp.com>
References: <1263982111-24123-1-git-send-email-monstr@monstr.eu>
	 <20100120105350.GA23394@flint.arm.linux.org.uk>
	 <20100120110031.GD8665@amd.com>
Reply-To: steve@digidescorp.com
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail.digidescorp.com ([66.244.163.200]:54482 "EHLO
	digidescorp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752077Ab0AUQA7 (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Thu, 21 Jan 2010 11:00:59 -0500
In-Reply-To: <20100120110031.GD8665@amd.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Joerg Roedel <joerg.roedel@amd.com>
Cc: monstr@monstr.eu, linux-kernel@vger.kernel.org, michal.simek@petalogix.com, arnd@arndb.de, linux-arch@vger.kernel.org, fujita.tomonori@lab.ntt.co.jp, akpm@linux-foundation.org, mingo@elte.hu

On Wed, 2010-01-20 at 12:00 +0100, Joerg Roedel wrote:
> On Wed, Jan 20, 2010 at 10:53:50AM +0000, Russell King wrote:
> > and ops is NULL, then this code will oops; you will get a full register
> > dump and backtrace.  You can use this information along with markup_oops.pl
> > to find out where the problem is.
> 
> You can't rely on the oops if the code runs in process context. The
> process may have address 0 mapped which would result in a security hole.
> We had two of these bugs last year.

You also can't rely on an oops in a NOMMU environment.

------------------------------------------------------------------------
 Steven J. Magnani               "I claim this network for MARS!
 www.digidescorp.com              Earthling, return my space modulator!"

 #include <standard.disclaimer>
