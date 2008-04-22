Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from nf-out-0910.google.com ([64.233.182.186]:29960 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760427AbYDVIw4 (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Tue, 22 Apr 2008 04:52:56 -0400
Received: by nf-out-0910.google.com with SMTP id g13so707304nfb.21
        for <linux-arch@vger.kernel.org>; Tue, 22 Apr 2008 01:52:53 -0700 (PDT)
Message-ID: <480DA670.4060707@gmail.com>
Date: Tue, 22 Apr 2008 10:48:48 +0200
From: Jacek Luczak <difrost.kernel@gmail.com>
MIME-Version: 1.0
Subject: Re: [PATCH 2/11] x86: convert to generic helpers for IPI function
 calls
References: <1208851058-8500-1-git-send-email-jens.axboe@oracle.com> <1208851058-8500-3-git-send-email-jens.axboe@oracle.com> <20080422084738.GB2388@elte.hu>
In-Reply-To: <20080422084738.GB2388@elte.hu>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Jens Axboe <jens.axboe@oracle.com>
Cc: Ingo Molnar <mingo@elte.hu>, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, npiggin@suse.de, torvalds@linux-foundation.org, Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <a.p.zijlstra@chello.nl>
Message-ID: <20080422084848.7x0RCV5amCDEjm7RRZkScce0sXV7mWHHbrikms4tohw@z>

Ingo Molnar pisze:
> * Jens Axboe <jens.axboe@oracle.com> wrote:
> 
>> This converts x86 and x86-64 to use the new helpers for 
>> smp_call_function() and friends, and adds support for 
>> smp_call_function_single().
> 
> nice stuff. The x86 and generic bits:
> 
>  Acked-by: Ingo Molnar <mingo@elte.hu>
> 
> this has been brewing for months, what is the testing/confidence status 

A'propos testing: Jens did you placed all patches (latest versions) somewhere on
net, so I can grab it and test?

> of it? Could we still merge it into v2.6.26? (i think we should)

-Jacek
