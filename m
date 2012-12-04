Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from smtp-out-241.synserver.de ([212.40.185.241]:1161 "EHLO
	smtp-out-239.synserver.de" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1752054Ab2LDH6l (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Tue, 4 Dec 2012 02:58:41 -0500
Message-ID: <50BDAD3D.9020209@metafoo.de>
Date: Tue, 04 Dec 2012 08:58:53 +0100
From: Lars-Peter Clausen <lars@metafoo.de>
MIME-Version: 1.0
Subject: Re: [PATCH 1/5] asm-generic/mmu.h: Remove unused vmlist field from
 mm_context_t
References: <1351765467-29244-1-git-send-email-lars@metafoo.de> <201212032354.10573.arnd@arndb.de>
In-Reply-To: <201212032354.10573.arnd@arndb.de>
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Arnd Bergmann <arnd@arndb.de>
Cc: Mark Salter <msalter@redhat.com>, Aurelien Jacquiot <a-jacquiot@ti.com>, Yoshinori Sato <ysato@users.sourceforge.jp>, Chris Zankel <chris@zankel.net>, Max Filippov <jcmvbkbc@gmail.com>, linux-c6x-dev@linux-c6x.org, linux-kernel@vger.kernel.org, linux-xtensa@linux-xtensa.org, linux-arch@vger.kernel.org
Message-ID: <20121204075853.mDsPynJSRgAbXM6pXTU-DZMX9fdZTmb2z8bGaStapmI@z>

On 12/04/2012 12:54 AM, Arnd Bergmann wrote:
> On Thursday 01 November 2012, Lars-Peter Clausen wrote:
>> Nothing is using the vmlist field in mm_context_t anymore. It has been removed
>> from the non-generic versions over 3 years ago 8feae1311 ("NOMMU: Make VMAs per
>> MM as for MMU-mode linux").
>>
>> Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
> 
> Whole series:
> 
> Acked-by: Arnd Bergmann <arnd@arndb.de>
> 
> Do you want to include the patches in a patch set of your own, or should I put them
> into the asm-generic tree?
> 
> 	Arnd

Hi Arnd,

The plan was to let it go through the asm-generic tree.

Thanks,
- Lars
