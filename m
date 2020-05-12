From: Dave Hansen <dave.hansen@intel.com>
Subject: Re: [PATCH 07/14] prctl.2: Document removal of Intel MPX prctls
Date: Tue, 12 May 2020 09:41:04 -0700
Message-ID: <a1d1460f-cc18-342e-1c60-af593ed7a5c1@intel.com>
References: <1589301419-24459-1-git-send-email-Dave.Martin@arm.com>
 <1589301419-24459-8-git-send-email-Dave.Martin@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mga05.intel.com ([192.55.52.43]:39793 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725987AbgELQlF (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Tue, 12 May 2020 12:41:05 -0400
In-Reply-To: <1589301419-24459-8-git-send-email-Dave.Martin@arm.com>
Content-Language: en-US
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Dave Martin <Dave.Martin@arm.com>, mtk.manpages@gmail.com
Cc: linux-man@vger.kernel.org, linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Dave Hansen <dave.hansen@linux.intel.com>, Thomas Gleixner <tglx@linutronix.de>

On 5/12/20 9:36 AM, Dave Martin wrote:
> The Intel MPX API was removed from Linux 5.4.  See Linux
> commit f240652b6032 ("x86/mpx: Remove MPX APIs")
> 
> Document this change.

Thanks for doing this!

Acked-by: Dave Hansen <dave.hansen@linux.intel.com>
