From: Johannes Weiner <hannes@saeurebad.de>
Subject: Re: [PATCH 16/20] m68knommu: use generic show_mem()
Date: Sat, 05 Jul 2008 12:10:39 +0000
Message-ID: <874p744jls.fsf@saeurebad.de>
References: <20080704160737.750988999@saeurebad.de>
	<20080704161457.056057813@saeurebad.de>
	<Pine.LNX.4.64.0807051010550.5733@anakin>
	<87d4ls4lgv.fsf@saeurebad.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from saeurebad.de ([85.214.36.134]:47549 "EHLO saeurebad.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751523AbYGEMMO (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Sat, 5 Jul 2008 08:12:14 -0400
In-Reply-To: <87d4ls4lgv.fsf@saeurebad.de> (Johannes Weiner's message of "Sat,
	05 Jul 2008 11:30:24 +0000")
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Greg Ungerer <gerg@uclinux.org>, Andrew Morton <akpm@linux-foundation.org>, Linux Kernel Development <linux-kernel@vger.kernel.org>, linux-arch@vger.kernel.org, uClinux list <uclinux-dev@uclinux.org>

Johannes Weiner <hannes@saeurebad.de> writes:

> Hi,
>
> Geert Uytterhoeven <geert@linux-m68k.org> writes:
>
>> On Fri, 4 Jul 2008, Johannes Weiner wrote:
>>> Remove arch-specific show_mem() in favor of the generic version.
>>> 
>>> This also removes the following redundant information display:
>>> 
>>> 	- free pages, printed by show_free_areas()
>>> 	- pages in swapcache, printed by show_swap_cache_info()
>>> 
>>> where show_mem() calls show_free_areas(), which calls
>>> show_swap_cache_info().
>>> 
>>> Signed-off-by: Johannes Weiner <hannes@saeurebad.de>
>>> CC: Geert Uytterhoeven <geert@linux-m68k.org>
>>> ---
>>>  arch/m68knommu/mm/init.c |   27 ---------------------------
>>
>> m68knommu is uClinux.
>
> Uhm, I can not quite follow you here.  Is the CC wrong?

Nevermind, just noticed that you added the ucl list to cc.

	Hannes
