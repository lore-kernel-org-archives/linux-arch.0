Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from bombadil.infradead.org ([65.50.211.133]:57119 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751180AbdEELxO (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 5 May 2017 07:53:14 -0400
Date: Fri, 5 May 2017 13:53:03 +0200
From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: =?utf-8?B?562U5aSN?= =?utf-8?Q?=3A?= [PATCH 0/3] arm64: queued
 spinlocks and rw-locks
Message-ID: <20170505115303.s3bsu4adfgkxrhh2@hirez.programming.kicks-ass.net>
References: <20170503145141.4966-1-ynorov@caviumnetworks.com>
 <SIXPR0199MB0604CF9C101455F7D7417FF7C5160@SIXPR0199MB0604.apcprd01.prod.exchangelabs.com>
 <20170504202809.lv222a3oes54ijkj@yury-N73SV>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170504202809.lv222a3oes54ijkj@yury-N73SV>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Yury Norov <ynorov@caviumnetworks.com>
Cc: pan xinhui <mnipxh@hotmail.com>, Will Deacon <will.deacon@arm.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Adam Wallis <awallis@codeaurora.org>, Andrew Pinski <Andrew.Pinski@cavium.com>, Arnd Bergmann <arnd@arndb.de>, Catalin Marinas <catalin.marinas@arm.com>, Ingo Molnar <mingo@redhat.com>, Jan Glauber <jglauber@cavium.com>, Mark Rutland <mark.rutland@arm.com>, Pan Xinhui <xinhui.pan@linux.vnet.ibm.com>
Message-ID: <20170505115303.cU75u8HAe_KIolAFISrPDcdm8JUP1EAdgvZrruENgP8@z>

On Thu, May 04, 2017 at 11:28:09PM +0300, Yury Norov wrote:
> I don't think
> it's a real use case to have ticket spinlocks and queued rwlocks

There's nothing wrong with that combination. In fact, we merged qrwlock
much earlier than qspinlock.
