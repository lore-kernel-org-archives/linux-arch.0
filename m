Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from gate.crashing.org ([63.228.1.57]:49132 "EHLO gate.crashing.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750902AbYBCFnI (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Sun, 3 Feb 2008 00:43:08 -0500
Subject: Re: [patch 2/3] CONFIG_HIGHPTE vs. sub-page page tables.
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Reply-To: benh@kernel.crashing.org
In-Reply-To: <20080201151541.8e3e0359.akpm@linux-foundation.org>
References: <20071112143009.425807965@de.ibm.com>
	 <20071112144009.831296895@de.ibm.com>
	 <20080201151541.8e3e0359.akpm@linux-foundation.org>
Content-Type: text/plain
Date: Sun, 03 Feb 2008 16:37:00 +1100
Message-Id: <1202017020.7208.2.camel@pasglop>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: schwidefsky@de.ibm.com, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, Ingo Molnar <mingo@elte.hu>

Why dropping add-mm-argument-to-pte-pmd-pud-pgd_free.patch though ?

It's a sane patch and a helps going further, and a total pain to re-do
later on. Besides, I may have some use for it on powerpc at some point
too...

Ben.


