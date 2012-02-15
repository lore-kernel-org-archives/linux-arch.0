Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from shards.monkeyblade.net ([198.137.202.13]:51990 "EHLO
	shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751178Ab2BOD5Z (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Tue, 14 Feb 2012 22:57:25 -0500
Date: Tue, 14 Feb 2012 22:57:13 -0500 (EST)
Message-ID: <20120214.225713.1807433250606231046.davem@davemloft.net>
Subject: Re: [PATCH 32/40] sparc: Use block_sigmask()
From: David Miller <davem@davemloft.net>
In-Reply-To: <1329219673-28711-33-git-send-email-matt@console-pimps.org>
References: <1329219673-28711-1-git-send-email-matt@console-pimps.org>
	<1329219673-28711-33-git-send-email-matt@console-pimps.org>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: matt@console-pimps.org
Cc: linux-arch@vger.kernel.org, oleg@redhat.com, akpm@linux-foundation.org, linux-kernel@vger.kernel.org, matt.fleming@intel.com, sparclinux@vger.kernel.org
Message-ID: <20120215035713.YhGSo3dG9C64tRQs0s9NBQvMTnlzzrqkadIHH-Ai5a0@z>

From: Matt Fleming <matt@console-pimps.org>
Date: Tue, 14 Feb 2012 11:41:05 +0000

> From: Matt Fleming <matt.fleming@intel.com>
> 
> Use the new helper function introduced in commit 5e6292c0f28f
> ("signal: add block_sigmask() for adding sigmask to current->blocked")
> which centralises the code for updating current->blocked after
> successfully delivering a signal and reduces the amount of duplicate
> code across architectures. In the past some architectures got this
> code wrong, so using this helper function should stop that from
> happening again.
> 
> Cc: Oleg Nesterov <oleg@redhat.com>
> Cc: "David S. Miller" <davem@davemloft.net>
> Cc: sparclinux@vger.kernel.org
> Signed-off-by: Matt Fleming <matt.fleming@intel.com>

Acked-by: David S. Miller <davem@davemloft.net>
