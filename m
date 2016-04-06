Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-wm0-f50.google.com ([74.125.82.50]:33203 "EHLO
	mail-wm0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754854AbcDFJGq (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Wed, 6 Apr 2016 05:06:46 -0400
Date: Wed, 6 Apr 2016 11:06:38 +0200
From: Michal Hocko <mhocko@kernel.org>
Subject: [PATCH] sparc, rwsem: drop superfluous arch specific implementation
Message-ID: <20160406090638.GB24272@dhcp22.suse.cz>
References: <1459508695-14915-1-git-send-email-mhocko@kernel.org>
 <1459508695-14915-3-git-send-email-mhocko@kernel.org>
 <20160402011753.GB5329@linux-uzut.site>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20160402011753.GB5329@linux-uzut.site>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: "David S. Miller" <davem@davemloft.net>
Cc: Davidlohr Bueso <dave@stgolabs.net>, LKML <linux-kernel@vger.kernel.org>, sparclinux@vger.kernel.org, linux-arch@vger.kernel.org
Message-ID: <20160406090638.0rpyi1EyhlnjDGvEEZ_9yp4VGocHyqxwvGDmpZmJGqI@z>

[Redicing CC list]

On Fri 01-04-16 18:17:53, Davidlohr Bueso wrote:
> On Fri, 01 Apr 2016, Michal Hocko wrote:
[...]
> >arch/sh/include/asm/rwsem.h     | 14 ++------------
> >arch/xtensa/include/asm/rwsem.h | 14 ++------------
> >2 files changed, 4 insertions(+), 24 deletions(-)
> 
> I think we can actually get rid of these files altogether.

And after double checking sparc is using the generic implementation
without any arch specific tweaks as well. So it can be dropped.

David, does the following look good to you or am I missing something?
I will drop "[PATCH 08/11] sparc, rwsem: provide __down_write_killable"
then.
---
