Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mtagate6.de.ibm.com ([195.212.29.155]:3994 "EHLO
	mtagate6.de.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751383AbYDWH6e (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Wed, 23 Apr 2008 03:58:34 -0400
Date: Wed, 23 Apr 2008 09:58:31 +0200
From: Heiko Carstens <heiko.carstens@de.ibm.com>
Subject: Re: [PATCH 11/11] s390: convert to generic helpers for IPI
	function calls
Message-ID: <20080423075831.GB15850@osiris.boeblingen.de.ibm.com>
References: <1208890227-24808-1-git-send-email-jens.axboe@oracle.com> <1208890227-24808-12-git-send-email-jens.axboe@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1208890227-24808-12-git-send-email-jens.axboe@oracle.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Jens Axboe <jens.axboe@oracle.com>
Cc: linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, npiggin@suse.de, torvalds@linux-foundation.org, peterz@infradead.org, sam@ravnborg.org, Martin Schwidefsky <schwidefsky@de.ibm.com>
Message-ID: <20080423075831.YGCJF8NgyA4PKk6v1y4lx93XeO40-4Gsr8U7EmF-_Pc@z>

On Tue, Apr 22, 2008 at 08:50:27PM +0200, Jens Axboe wrote:
> This converts s390 to use the new helpers for smp_call_function() and
> friends, and adds support for smp_call_function_single(). Not tested,
> but it compiles.
> 
> Cc: Martin Schwidefsky <schwidefsky@de.ibm.com>
> Cc: Heiko Carstens <heiko.carstens@de.ibm.com>
> Signed-off-by: Jens Axboe <jens.axboe@oracle.com>

Your generic patch changes semantics of smp_call_function(). At least the
s390 version of smp_call_function() mask used to not return unless all IPIs
where received on the target cpus.
Your patch changes that. It will already return as soon as all IPIs have
been sent. Unfortunately Martin's etr code in arch/s390/kernel/time.c
relies on exactly the old semantics.
Since this seems to be an s390 only issue, could you just drop the s390
conversion patch? We'll have to think about how to change the err code
and convert later I guess.
