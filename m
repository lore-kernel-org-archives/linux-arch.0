From: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCHv2 0/3] KASAN: clean stale poison upon cold re-entry to
 kernel
Date: Fri, 4 Mar 2016 14:34:29 -0800
Message-ID: <20160304143429.22d7a6fa522956535ba6000e@linux-foundation.org>
References: <1457024068-2236-1-git-send-email-mark.rutland@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail.linuxfoundation.org ([140.211.169.12]:44075 "EHLO
	mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758796AbcCDWeb (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Fri, 4 Mar 2016 17:34:31 -0500
In-Reply-To: <1457024068-2236-1-git-send-email-mark.rutland@arm.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Mark Rutland <mark.rutland@arm.com>
Cc: linux-mm@kvack.org, mingo@redhat.com, aryabinin@virtuozzo.com, catalin.marinas@arm.com, glider@google.com, lorenzo.pieralisi@arm.com, peterz@infradead.org, will.deacon@arm.com, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org

On Thu,  3 Mar 2016 16:54:25 +0000 Mark Rutland <mark.rutland@arm.com> wrote:

> Andrew, the conclusion [5] from v1 was that this should go via the mm tree.
> Are you happy to pick this up? 

yep.  I'll aim to get this into 4.5.
