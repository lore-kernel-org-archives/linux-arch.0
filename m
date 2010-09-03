From: Greg Ungerer <gerg@snapgear.com>
Subject: Re: [PATCH 2/3] M68K: Use CONFIG_MMU not __uClinux__ to select m68knommu
 contributions
Date: Fri, 3 Sep 2010 19:31:20 +1000
Message-ID: <4C80C068.1010302@snapgear.com>
References: <m3vd6nmd68.fsf@hase.home> <19747.1283422807@redhat.com> <20100902102158.19806.14133.stgit@warthog.procyon.org.uk> <m38w3kns4r.fsf@hase.home> <AANLkTikwax-Jb60jT5_TOL=Zkwbgh8FwMk78ncm1dN-P@mail.gmail.com> <3048.1283505520@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from dalsmrelay2.nai.com ([205.227.136.216]:47754 "HELO
	dalsmrelay2.nai.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1755929Ab0ICJb5 (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Fri, 3 Sep 2010 05:31:57 -0400
In-Reply-To: <3048.1283505520@redhat.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: David Howells <dhowells@redhat.com>
Cc: Andreas Schwab <schwab@redhat.com>, Geert Uytterhoeven <geert@linux-m68k.org>, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org

On 03/09/10 19:18, David Howells wrote:
> Andreas Schwab<schwab@redhat.com>  wrote:
>
>> You are almost able to use the uclinux compiler for both, except that
>> currently __uClinux__ is hardcoded.
>
> The m68knommu arch Makefile in the kernel could specify it on the compiler
> command line, then m68k compilers should be possible.
>
> The kernel should probably also set appropriate -mcpu= and -mtune= flags,
> depending on the type of kernel selected.

Not sure about m68k but m68knommu targets already setup
appropriate -mcpu flags for its various supported CPU types.

Regards
Greg
