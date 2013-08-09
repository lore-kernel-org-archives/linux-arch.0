Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:39773 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S934068Ab3HIQDb (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Fri, 9 Aug 2013 12:03:31 -0400
From: Andi Kleen <andi@firstfloor.org>
Subject: RFC: Use single pass kallsyms
Date: Fri,  9 Aug 2013 09:03:16 -0700
Message-ID: <1376064199-8296-1-git-send-email-andi@firstfloor.org>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-kernel@vger.kernel.org
Cc: linux-arch@vger.kernel.org, linux-kbuild@vger.kernel.org, david.daney@cavium.com
Message-ID: <20130809160316.Jkio4s0eU1DMHhuSVk3lhoEXj7Niq2iqK_3QhkH5dy4@z>

This is my attempt to avoid extra link steps for kallsyms.

Originally for LTO (where it gives dramatic build time improvements),
but it also gives a nice build speedup on a standard build (-10s on my laptop)

Even with this we still link two times (one more for modpost), but this
may be eventually fixable too.

Right now this is an RFC, I'm particularly interested in testing
on more architectures.

