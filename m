Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from smtp-out.google.com ([216.239.45.13]:34308 "EHLO
	smtp-out.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756771AbXFOSHh (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Fri, 15 Jun 2007 14:07:37 -0400
Received: from zps37.corp.google.com (zps37.corp.google.com [172.25.146.37])
	by smtp-out.google.com with ESMTP id l5FI7X6d030752
	for <linux-arch@vger.kernel.org>; Fri, 15 Jun 2007 11:07:33 -0700
Received: from py-out-1112.google.com (pybu52.prod.google.com [10.34.97.52])
	by zps37.corp.google.com with ESMTP id l5FI6rer019165
	for <linux-arch@vger.kernel.org>; Fri, 15 Jun 2007 11:07:15 -0700
Received: by py-out-1112.google.com with SMTP id u52so1691601pyb
        for <linux-arch@vger.kernel.org>; Fri, 15 Jun 2007 11:07:15 -0700 (PDT)
Message-ID: <65dd6fd50706151107v784a252aw89a128f255304ef6@mail.gmail.com>
Date: Fri, 15 Jun 2007 11:07:15 -0700
From: "Ollie Wild" <aaw@google.com>
Subject: Re: [patch 0/3] no MAX_ARG_PAGES -v2
In-Reply-To: <1181899478.7348.349.camel@twins>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <20070613100334.635756997@chello.nl>
	 <617E1C2C70743745A92448908E030B2A01AF860A@scsmsx411.amr.corp.intel.com>
	 <65dd6fd50706132323i9c760f4m6e23687914d0c46e@mail.gmail.com>
	 <1181810319.7348.345.camel@twins>
	 <65dd6fd50706141358i39bba32aq139766c8a1a3de2b@mail.gmail.com>
	 <1181899478.7348.349.camel@twins>
Sender: linux-arch-owner@vger.kernel.org
To: Peter Zijlstra <a.p.zijlstra@chello.nl>
Cc: "Luck, Tony" <tony.luck@intel.com>, linux-kernel@vger.kernel.org, parisc-linux@lists.parisc-linux.org, linux-mm@kvack.org, linux-arch@vger.kernel.org, Andrew Morton <akpm@osdl.org>, Ingo Molnar <mingo@elte.hu>, Andi Kleen <ak@suse.de>
List-ID: <linux-arch.vger.kernel.org>

On 6/15/07, Peter Zijlstra <a.p.zijlstra@chello.nl> wrote:
> On Thu, 2007-06-14 at 13:58 -0700, Ollie Wild wrote:
>
> >   A good heuristic, though, might be to limit
> > argument size to a percentage (say 25%) of maximum stack size and
> > validate this inside copy_strings().
>
> This seems to do:

Looks good.

Ollie
