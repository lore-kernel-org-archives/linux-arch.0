Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:52778 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752147AbbB0Mnq (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Fri, 27 Feb 2015 07:43:46 -0500
Message-ID: <54F06636.6080905@redhat.com>
Date: Fri, 27 Feb 2015 07:42:30 -0500
From: Jon Masters <jcm@redhat.com>
MIME-Version: 1.0
Subject: Re: [PATCH V4 0/6] RCU get_user_pages_fast and __get_user_pages_fast
References: <1411740233-28038-1-git-send-email-steve.capper@linaro.org>
In-Reply-To: <1411740233-28038-1-git-send-email-steve.capper@linaro.org>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Steve Capper <steve.capper@linaro.org>, linux-arm-kernel@lists.infradead.org, catalin.marinas@arm.com, linux@arm.linux.org.uk, linux-arch@vger.kernel.org, linux-mm@kvack.org
Cc: will.deacon@arm.com, gary.robertson@linaro.org, christoffer.dall@linaro.org, peterz@infradead.org, anders.roxell@linaro.org, akpm@linux-foundation.org, dann.frazier@canonical.com, mark.rutland@arm.com, mgorman@suse.de, hughd@google.com
Message-ID: <20150227124230.ywI4VUczQ2inMY6Kp0AfrBdcLqE71PlSCQ-hRxmSwBo@z>

On 09/26/2014 10:03 AM, Steve Capper wrote:

> This series implements general forms of get_user_pages_fast and
> __get_user_pages_fast in core code and activates them for arm and arm64.
> 
> These are required for Transparent HugePages to function correctly, as
> a futex on a THP tail will otherwise result in an infinite loop (due to
> the core implementation of __get_user_pages_fast always returning 0).
> 
> Unfortunately, a futex on THP tail can be quite common for certain
> workloads; thus THP is unreliable without a __get_user_pages_fast
> implementation.
> 
> This series may also be beneficial for direct-IO heavy workloads and
> certain KVM workloads.
> 
> I appreciate that the merge window is coming very soon, and am posting
> this revision on the off-chance that it gets the nod for 3.18. (The changes
> thus far have been minimal and the feedback I've got has been mainly
> positive).

Head's up: these patches are currently implicated in a rare-to-trigger
hang that we are seeing on an internal kernel. An extensive effort is
underway to confirm whether these are the cause. Will followup.

Jon.


