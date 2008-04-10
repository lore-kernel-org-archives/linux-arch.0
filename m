Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from gate.crashing.org ([63.228.1.57]:42677 "EHLO gate.crashing.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757627AbYDJVrH (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Thu, 10 Apr 2008 17:47:07 -0400
Subject: Re: [PATCH 1/2] Add thread_info_cache_init() to all archs
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Reply-To: benh@kernel.crashing.org
In-Reply-To: <20080410032354.90CB1DDF0F@ozlabs.org>
References: <20080410032354.90CB1DDF0F@ozlabs.org>
Content-Type: text/plain
Date: Fri, 11 Apr 2008 07:46:18 +1000
Message-ID: <1207863978.6958.15.camel@pasglop>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-kernel@vger.kernel.org
Cc: Linux-Arch <linux-arch@vger.kernel.org>, linuxppc-dev@ozlabs.org, takata@linux-m32r.org, linux-m32r@ml.linux-m32r.org, Paul Mackerras <paulus@samba.org>
Message-ID: <20080410214618.mH1hnxcHXAJOVRO_HCtenrZtIjUxyMVW_2A3fPjRJd8@z>


> +#ifndef thread_info_cache_init
> +#define thread_info_cache_init	do { } while(0)
> +#endif
> +

Blah ! Missing a pair of () here. Ooops. I'll send a fixed patch.

Ben.


