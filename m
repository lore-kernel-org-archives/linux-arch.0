From: David Miller <davem@davemloft.net>
Subject: Re: [PATCH] mm: kill kmemcheck
Date: Wed, 11 Mar 2015 14:44:43 -0400 (EDT)
Message-ID: <20150311.144443.1290707334236248572.davem@davemloft.net>
References: <55004595.7020304@oracle.com>
	<20150311.132052.205877953171712952.davem@davemloft.net>
	<55007A9B.4010608@oracle.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from shards.monkeyblade.net ([149.20.54.216]:50033 "EHLO
	shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750779AbbCKSou (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Wed, 11 Mar 2015 14:44:50 -0400
In-Reply-To: <55007A9B.4010608@oracle.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: sasha.levin@oracle.com
Cc: rostedt@goodmis.org, linux-kernel@vger.kernel.org, linux-mm@kvack.org, netdev@vger.kernel.org, linux-arch@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-crypto@vger.kernel.org

From: Sasha Levin <sasha.levin@oracle.com>
Date: Wed, 11 Mar 2015 13:25:47 -0400

> You're probably wondering why there are changes to SPARC in that patchset? :)

Libsanitizer doesn't even build have the time on sparc, the release
manager has to hand patch it into building again every major release
because of the way ASAN development is done out of tree and local
commits to the gcc tree are basically written over during the
next merge.

So I'm a little bit bitter about this, as you can see. :)
