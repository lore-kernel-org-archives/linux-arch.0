Return-Path: <akpm@osdl.org>
Received: from fw.osdl.org ([65.172.181.6]:19334 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S264709AbUEMUct (ORCPT
	<rfc822;linux-arch@vger.kernel.org>);
	Thu, 13 May 2004 16:32:49 -0400
Received: from akpm.pao.digeo.com (build.pdx.osdl.net [172.20.1.2])
	by mail.osdl.org (8.11.6/8.11.6) with SMTP id i4DKWmJ10765
	for <linux-arch@vger.kernel.org>; Thu, 13 May 2004 13:32:48 -0700
Date: Thu, 13 May 2004 13:35:26 -0700
From: Andrew Morton <akpm@osdl.org>
Subject: atomic ops for a VM fix
Message-Id: <20040513133526.0e5efed3.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
To: linux-arch@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>

Guys, I have four patches here which I'd like to merge into Linus's tree
within a week.

They require that the architecture implement atomic_add_negative() and
atomic_inc_and_test().  I managed to cobble these together for many
architectures, but there are a few gaps.  Please review the third and
fourth patches.

Dave, sparc64 is missing atomic_add_negative(), sorry.
