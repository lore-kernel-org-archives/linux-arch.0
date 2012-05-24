From: David Miller <davem@davemloft.net>
Subject: [PATCH 0/3] Make sparc's strncpy_from_user() generic.
Date: Wed, 23 May 2012 23:34:18 -0400 (EDT)
Message-ID: <20120523.233418.889080329511954770.davem@davemloft.net>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from shards.monkeyblade.net ([198.137.202.13]:35985 "EHLO
	shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932116Ab2EXDeZ (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Wed, 23 May 2012 23:34:25 -0400
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-arch@vger.kernel.org
Cc: torvalds@linux-foundation.org


Ok, this is against my current sparc GIT tree at:

	git://git.kernel.org/pub/scm/linux/kernel/git/davem/sparc.git

After these changes it should definitely be usable by any
architecture.

If there are no major objections I can push this out to my sparc tree
and ask Linus to pull all of this work in.

Afterwards we can tweak it to use the x86 word-at-a-time tricks if we
want.

Thanks.
