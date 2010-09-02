From: Andreas Schwab <schwab@redhat.com>
Subject: Re: [PATCH 2/3] M68K: Use CONFIG_MMU not __uClinux__ to select m68knommu contributions
Date: Thu, 02 Sep 2010 16:21:08 +0200
Message-ID: <m38w3kns4r.fsf@hase.home>
References: <19747.1283422807@redhat.com>
	<20100902102158.19806.14133.stgit@warthog.procyon.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:44538 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752969Ab0IBOVY (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Thu, 2 Sep 2010 10:21:24 -0400
In-Reply-To: <20100902102158.19806.14133.stgit@warthog.procyon.org.uk> (David
	Howells's message of "Thu, 02 Sep 2010 11:21:58 +0100")
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: David Howells <dhowells@redhat.com>
Cc: gerg@snapgear.com, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org

David Howells <dhowells@redhat.com> writes:

> Use CONFIG_MMU not __uClinux__ to select m68knommu contributions as nothing in
> the arch defines __uClinux__ for the build.

You are using the wrong compiler.

Andreas.

-- 
Andreas Schwab, schwab@redhat.com
GPG Key fingerprint = D4E8 DBE3 3813 BB5D FA84  5EC7 45C6 250E 6F00 984E
"And now for something completely different."
