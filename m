From: Yury Norov <ynorov@caviumnetworks.com>
Subject: Re: =?utf-8?B?562U5aSN?= =?utf-8?Q?=3A?= [PATCH 0/3] arm64: queued
 spinlocks and rw-locks
Date: Fri, 5 May 2017 18:28:45 +0300
Message-ID: <20170505152845.e32h3jxhjdjw6yht@yury-N73SV>
References: <20170503145141.4966-1-ynorov@caviumnetworks.com>
 <SIXPR0199MB0604CF9C101455F7D7417FF7C5160@SIXPR0199MB0604.apcprd01.prod.exchangelabs.com>
 <20170504202809.lv222a3oes54ijkj@yury-N73SV>
 <20170505115303.s3bsu4adfgkxrhh2@hirez.programming.kicks-ass.net>
 <20170505122639.GB14111@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-dm3nam03on0048.outbound.protection.outlook.com ([104.47.41.48]:39968
        "EHLO NAM03-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1754370AbdEEP3F (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Fri, 5 May 2017 11:29:05 -0400
Content-Disposition: inline
In-Reply-To: <20170505122639.GB14111@arm.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Will Deacon <will.deacon@arm.com>
Cc: Peter Zijlstra <peterz@infradead.org>, pan xinhui <mnipxh@hotmail.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Adam Wallis <awallis@codeaurora.org>, Andrew Pinski <Andrew.Pinski@cavium.com>, Arnd Bergmann <arnd@arndb.de>, Catalin Marinas <catalin.marinas@arm.com>, Ingo Molnar <mingo@redhat.com>, Jan Glauber <jglauber@cavium.com>, Mark Rutland <mark.rutland@arm.com>, Pan Xinhui <xinhui.pan@linux.vnet.ibm.com>

On Fri, May 05, 2017 at 01:26:40PM +0100, Will Deacon wrote:
> On Fri, May 05, 2017 at 01:53:03PM +0200, Peter Zijlstra wrote:
> > On Thu, May 04, 2017 at 11:28:09PM +0300, Yury Norov wrote:
> > > I don't think
> > > it's a real use case to have ticket spinlocks and queued rwlocks
> > 
> > There's nothing wrong with that combination. In fact, we merged qrwlock
> > much earlier than qspinlock.
> 
> ... and that's almost certainly the direction we'll go on arm64 too, not
> least because the former are a lot easier to grok.
> 
> Will

Hmm. Then I think I have to split patch 3 to rwlock and spinlock
parts, and allow user to enable them independently in config. 

Yury
