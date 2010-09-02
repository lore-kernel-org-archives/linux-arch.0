From: Sam Ravnborg <sam@ravnborg.org>
Subject: Re: [PATCH 2/3] M68K: Use CONFIG_MMU not __uClinux__ to select
	m68knommu contributions
Date: Thu, 2 Sep 2010 18:50:35 +0200
Message-ID: <20100902165035.GB24011@merkur.ravnborg.org>
References: <20100902135438.GA23729@merkur.ravnborg.org> <19747.1283422807@redhat.com> <20100902102158.19806.14133.stgit@warthog.procyon.org.uk> <24082.1283440358@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from pqueuea.post.tele.dk ([193.162.153.9]:44810 "EHLO
	pqueuea.post.tele.dk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754682Ab0IBQuz (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Thu, 2 Sep 2010 12:50:55 -0400
Received: from pfepb.post.tele.dk (pfepb.post.tele.dk [195.41.46.236])
	by pqueuea.post.tele.dk (Postfix) with ESMTP id 2A8B8DBAA0
	for <linux-arch@vger.kernel.org>; Thu,  2 Sep 2010 18:50:54 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <24082.1283440358@redhat.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: David Howells <dhowells@redhat.com>
Cc: gerg@snapgear.com, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org

On Thu, Sep 02, 2010 at 04:12:38PM +0100, David Howells wrote:
> Sam Ravnborg <sam@ravnborg.org> wrote:
> 
> > This was exactly the reason why __uClinux__ was used in the first place.
> 
> That shouldn't be used in kernel headers.  It should be !CONFIG_MMU.

Thats preferable - yes.
But in headers that are exported we cannot rely on CONFIG_MMU,
and Andreas could point out two headers that are exported
where your patch replaced __uClinux__ with CONFIG_MMU.

Thats wrong.
I assume you aggree on this?

	Sam
