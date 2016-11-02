From: Mark Rutland <mark.rutland@arm.com>
Subject: Re: [PATCHv2 0/2] THREAD_INFO_IN_TASK prep work for arm64+s390
Date: Wed, 2 Nov 2016 15:56:27 +0000
Message-ID: <20161102155020.GA17547@remoulade>
References: <1477503787-25537-1-git-send-email-mark.rutland@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:46680 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753150AbcKBP44 (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Wed, 2 Nov 2016 11:56:56 -0400
Content-Disposition: inline
In-Reply-To: <1477503787-25537-1-git-send-email-mark.rutland@arm.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-kernel@vger.kernel.org, heiko.carstens@de.ibm.com
Cc: linux-arch@vger.kernel.org, akpm@linux-foundation.org, keescook@chromium.org, luto@kernel.org

On Wed, Oct 26, 2016 at 06:43:05PM +0100, Mark Rutland wrote:
> Heiko and I have been working on THREAD_INFO_IN_TASK for s390 and arm64
> respectively, and we're both targetting v4.10.
> 
> These are the common core changes which we both require. I've put together a
> branch [1,2] based on v4.9-rc2. I intend to tag this at some point next week so
> that Heiko and I have a stable base.

As a heads-up, I've collated the tags I've received in the last few days, along
with the comment Andy requested in the v1 thread, and tagged this as
core-ti-stack-split [1].

Thanks,
Mark.

[1] git://git.kernel.org/pub/scm/linux/kernel/git/mark/linux.git core-ti-stack-split
