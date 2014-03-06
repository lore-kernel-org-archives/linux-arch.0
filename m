From: Rik van Riel <riel@redhat.com>
Subject: Re: [PATCH 6/6] arch: Remove stub cputime.h headers
Date: Thu, 06 Mar 2014 14:40:29 -0500
Message-ID: <5318CF2D.70408@redhat.com>
References: <1394128601-26034-1-git-send-email-fweisbec@gmail.com> <1394128601-26034-7-git-send-email-fweisbec@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:56721 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750988AbaCFTmZ (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Thu, 6 Mar 2014 14:42:25 -0500
In-Reply-To: <1394128601-26034-7-git-send-email-fweisbec@gmail.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Frederic Weisbecker <fweisbec@gmail.com>, LKML <linux-kernel@vger.kernel.org>
Cc: Archs <linux-arch@vger.kernel.org>, Ingo Molnar <mingo@kernel.org>, Marcelo Tosatti <mtosatti@redhat.com>, Peter Zijlstra <peterz@infradead.org>, Thomas Gleixner <tglx@linutronix.de>

On 03/06/2014 12:56 PM, Frederic Weisbecker wrote:
> Many architectures have a stub cputime.h that only include the default
> cputime.h
>
> Lets remove the useless headers, we only need to mention that we want
> the default headers on the Kbuild files.
>
> Cc: Archs <linux-arch@vger.kernel.org>
> Cc: Ingo Molnar <mingo@kernel.org>
> Cc: Marcelo Tosatti <mtosatti@redhat.com>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Signed-off-by: Frederic Weisbecker <fweisbec@gmail.com>

Acked-by: Rik van Riel <riel@redhat.com>
