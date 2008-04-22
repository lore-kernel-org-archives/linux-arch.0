Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from nf-out-0910.google.com ([64.233.182.186]:51683 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756832AbYDVJIy (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Tue, 22 Apr 2008 05:08:54 -0400
Received: by nf-out-0910.google.com with SMTP id g13so711111nfb.21
        for <linux-arch@vger.kernel.org>; Tue, 22 Apr 2008 02:08:52 -0700 (PDT)
Message-ID: <480DAA34.7010709@gmail.com>
Date: Tue, 22 Apr 2008 11:04:52 +0200
From: Jacek Luczak <difrost.kernel@gmail.com>
MIME-Version: 1.0
Subject: Re: [PATCH 2/11] x86: convert to generic helpers for IPI function
  calls
References: <1208851058-8500-1-git-send-email-jens.axboe@oracle.com> <1208851058-8500-3-git-send-email-jens.axboe@oracle.com> <20080422084738.GB2388@elte.hu> <480DA670.4060707@gmail.com> <20080422085629.GV12774@kernel.dk>
In-Reply-To: <20080422085629.GV12774@kernel.dk>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Jens Axboe <jens.axboe@oracle.com>
Cc: Ingo Molnar <mingo@elte.hu>, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, npiggin@suse.de, torvalds@linux-foundation.org, Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <a.p.zijlstra@chello.nl>
Message-ID: <20080422090452.Ok4XPoAC1D7B206Ieou1mNXFhfwwLQMHux5VhIu3Ygw@z>

Jens Axboe pisze:
> On Tue, Apr 22 2008, Jacek Luczak wrote:
>> Ingo Molnar pisze:
>>> * Jens Axboe <jens.axboe@oracle.com> wrote:
>>>
>>>> This converts x86 and x86-64 to use the new helpers for 
>>>> smp_call_function() and friends, and adds support for 
>>>> smp_call_function_single().
>>> nice stuff. The x86 and generic bits:
>>>
>>>  Acked-by: Ingo Molnar <mingo@elte.hu>
>>>
>>> this has been brewing for months, what is the testing/confidence status 
>> A'propos testing: Jens did you placed all patches (latest versions)
>> somewhere on net, so I can grab it and test?
> 
> It's in git as well, generic-ipi branch. So you can pull it into current
> linus by doing:
> 
> $ git pull git://git.kernel.dk/linux-2.6-block.git generic-ipi

OK, thanks. I've got number of unused x86 boxes, so I will give it a spin.

Jacek
