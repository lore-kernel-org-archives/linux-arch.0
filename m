Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:7517 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1031717Ab2CPO2z (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Fri, 16 Mar 2012 10:28:55 -0400
From: David Howells <dhowells@redhat.com>
In-Reply-To: <1331868043.1971.10.camel@epip-laptop>
References: <1331868043.1971.10.camel@epip-laptop> <20120315205514.28759.58969.stgit@warthog.procyon.org.uk> <20120315205931.28759.81875.stgit@warthog.procyon.org.uk>
Subject: Re: [PATCH 27/38] Disintegrate asm/system.h for Unicore32 [ver #3]
Date: Fri, 16 Mar 2012 14:28:43 +0000
Message-ID: <19084.1331908123@redhat.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: gxt@mprc.pku.edu.cn
Cc: dhowells@redhat.com, paul.gortmaker@windriver.com, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, arnd@arndb.de
Message-ID: <20120316142843.5ZyMsQxbmIM50bZJEtXLvBAS6dogjHzhtz9a9-9uXXA@z>

Guan Xuetao <gxt@mprc.pku.edu.cn> wrote:

> Disintegrate asm/system.h for Unicore32. (Compilation successful)
> The implementation details are not changed, but only splitted.
> BTW, some codestyles are adjusted.

Btw, your patch got word-wrapped by your email client.

Is this to be applied to my patch or is it a replacement for my patch?

David
