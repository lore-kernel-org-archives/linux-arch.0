From: KOSAKI Motohiro <kosaki.motohiro@jp.fujitsu.com>
Subject: Re: [PATCH] Fix unconditional GFP_KERNEL allocations in __vmalloc().
Date: Fri, 17 Dec 2010 16:27:53 +0900 (JST)
Message-ID: <20101217162626.DA0A.A69D9226@jp.fujitsu.com>
References: <1292381126-5710-1-git-send-email-ricardo.correia@oracle.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from fgwmail6.fujitsu.co.jp ([192.51.44.36]:57807 "EHLO
	fgwmail6.fujitsu.co.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751226Ab0LQH14 (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Fri, 17 Dec 2010 02:27:56 -0500
Received: from m2.gw.fujitsu.co.jp ([10.0.50.72])
	by fgwmail6.fujitsu.co.jp (Fujitsu Gateway) with ESMTP id oBH7Rsa0017092
	for <linux-arch@vger.kernel.org> (envelope-from kosaki.motohiro@jp.fujitsu.com);
	Fri, 17 Dec 2010 16:27:54 +0900
Received: from smail (m2 [127.0.0.1])
	by outgoing.m2.gw.fujitsu.co.jp (Postfix) with ESMTP id 5961345DE68
	for <linux-arch@vger.kernel.org>; Fri, 17 Dec 2010 16:27:54 +0900 (JST)
Received: from s2.gw.fujitsu.co.jp (s2.gw.fujitsu.co.jp [10.0.50.92])
	by m2.gw.fujitsu.co.jp (Postfix) with ESMTP id 3F69745DE4D
	for <linux-arch@vger.kernel.org>; Fri, 17 Dec 2010 16:27:54 +0900 (JST)
Received: from s2.gw.fujitsu.co.jp (localhost.localdomain [127.0.0.1])
	by s2.gw.fujitsu.co.jp (Postfix) with ESMTP id 32E551DB803E
	for <linux-arch@vger.kernel.org>; Fri, 17 Dec 2010 16:27:54 +0900 (JST)
Received: from m106.s.css.fujitsu.com (m106.s.css.fujitsu.com [10.249.87.106])
	by s2.gw.fujitsu.co.jp (Postfix) with ESMTP id F0B5B1DB803B
	for <linux-arch@vger.kernel.org>; Fri, 17 Dec 2010 16:27:53 +0900 (JST)
In-Reply-To: <1292381126-5710-1-git-send-email-ricardo.correia@oracle.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: "Ricardo M. Correia" <ricardo.correia@oracle.com>
Cc: kosaki.motohiro@jp.fujitsu.com, linux-mm@kvack.org, linux-arch@vger.kernel.org, andreas.dilger@oracle.com, behlendorf1@llnl.gov

> (Patch based on 2.6.36 tag).
> 
> These GFP_KERNEL allocations could happen even though the caller of __vmalloc()
> requested a stricter gfp mask (such as GFP_NOFS or GFP_ATOMIC).
> 
> This was first noticed in Lustre, where it led to deadlocks due to a filesystem
> thread which requested a GFP_NOFS __vmalloc() allocation ended up calling down
> to Lustre itself to free memory, despite this not being allowed by GFP_NOFS.
> 
> Further analysis showed that some in-tree filesystems (namely GFS, Ceph and XFS)
> were vulnerable to the same bug due to calling __vmalloc() or vm_map_ram() in
> contexts where __GFP_FS allocations are not allowed.
> 
> Fixing this bug required changing a few mm interfaces to accept gfp flags.
> This needed to be done in all architectures, thus the large number of changes.

I like this patch. but please separate it two patches.

 1) add gfp_mask argument to some function
 2) vmalloc use flexible mask instead GFP_KERNEL always.

I mean please consider to make reviewers friendly patch.
IOW, please see your diffstat. ;)
