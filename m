Return-Path: <linux-arch-owner+james.bottomley=40steeleye.com-S268126AbUHQGn5@vger.kernel.org>
Received: from gate.crashing.org ([63.228.1.57]:28832 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S263818AbUHQGn5 (ORCPT
	<rfc822;linux-arch@vger.kernel.org>);
	Tue, 17 Aug 2004 02:43:57 -0400
Received: from localhost (localhost [127.0.0.1])
	by gate.crashing.org (8.12.8/8.12.8) with ESMTP id i7H6ePHR029948
	for <linux-arch@vger.kernel.org>; Tue, 17 Aug 2004 01:40:26 -0500
Subject: ptep_mkdirty obsolete ?
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Content-Type: text/plain
Message-Id: <1092724532.9536.119.camel@gaston>
Mime-Version: 1.0
Date: Tue, 17 Aug 2004 16:35:32 +1000
Content-Transfer-Encoding: 7bit
To: Linux Arch list <linux-arch@vger.kernel.org>
List-ID: <linux-arch.vger.kernel.org>

Hi guys !

This is still used anywhere ? I see that we have
__HAVE_ARCH_PTEP_MKDIRTY on ppc64 but no actual implementation for it
and nobody either uses ptep_mkdirty of #ifdef on the macro...

Ben.
