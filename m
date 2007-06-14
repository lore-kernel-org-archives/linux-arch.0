Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from smtp-out.google.com ([216.239.33.17]:54306 "EHLO
	smtp-out.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751446AbXFNGYK (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Thu, 14 Jun 2007 02:24:10 -0400
Received: from spaceape12.eur.corp.google.com (spaceape12.eur.corp.google.com [172.28.16.146])
	by smtp-out.google.com with ESMTP id l5E6O2JZ023216
	for <linux-arch@vger.kernel.org>; Thu, 14 Jun 2007 07:24:02 +0100
Received: from py-out-1112.google.com (pyhf31.prod.google.com [10.34.233.31])
	by spaceape12.eur.corp.google.com with ESMTP id l5E6O0mj030099
	for <linux-arch@vger.kernel.org>; Thu, 14 Jun 2007 07:24:00 +0100
Received: by py-out-1112.google.com with SMTP id f31so836321pyh
        for <linux-arch@vger.kernel.org>; Wed, 13 Jun 2007 23:23:59 -0700 (PDT)
Message-ID: <65dd6fd50706132323i9c760f4m6e23687914d0c46e@mail.gmail.com>
Date: Wed, 13 Jun 2007 23:23:59 -0700
From: "Ollie Wild" <aaw@google.com>
Subject: Re: [patch 0/3] no MAX_ARG_PAGES -v2
In-Reply-To: <617E1C2C70743745A92448908E030B2A01AF860A@scsmsx411.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <20070613100334.635756997@chello.nl>
	 <617E1C2C70743745A92448908E030B2A01AF860A@scsmsx411.amr.corp.intel.com>
Sender: linux-arch-owner@vger.kernel.org
To: "Luck, Tony" <tony.luck@intel.com>
Cc: Peter Zijlstra <a.p.zijlstra@chello.nl>, linux-kernel@vger.kernel.org, parisc-linux@lists.parisc-linux.org, linux-mm@kvack.org, linux-arch@vger.kernel.org, Andrew Morton <akpm@osdl.org>, Ingo Molnar <mingo@elte.hu>, Andi Kleen <ak@suse.de>
List-ID: <linux-arch.vger.kernel.org>

On 6/13/07, Luck, Tony <tony.luck@intel.com> wrote:
> Above 5Mbytes, I started seeing problems.  The line/word/char
> counts from "wc" started being "0 0 0".  Not sure if this is
> a problem in "wc" dealing with a single line >5MBytes, or some
> other problem (possibly I was exceeding the per-process stack
> limit which is only 8MB on that machine).

Interesting.  If you're exceeding your stack ulimit, you should be
seeing either an "argument list too long" message or getting a
SIGSEGV.  Have you tried bypassing wc and piping the output straight
to a file?

Ollie
