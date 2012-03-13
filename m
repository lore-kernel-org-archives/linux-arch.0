From: David Howells <dhowells@redhat.com>
Subject: Re: [RFC][PATCH 00/35] Disintegrate and kill asm/system.h [ver #2]
Date: Tue, 13 Mar 2012 14:11:45 +0000
Message-ID: <3744.1331647905@redhat.com>
References: <20120312233602.13888.27659.stgit@warthog.procyon.org.uk>
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:58638 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754784Ab2CMOLz (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Tue, 13 Mar 2012 10:11:55 -0400
In-Reply-To: <20120312233602.13888.27659.stgit@warthog.procyon.org.uk>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
Cc: dhowells@redhat.com, paul.gortmaker@windriver.com, hpa@zytor.com, torvalds@linux-foundation.org, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, arnd@arndb.de

David Howells <dhowells@redhat.com> wrote:

> Here are a bunch of patches to disintegrate asm/system.h into a set of
> separate bits to relieve the problem of circular inclusion dependencies.

They can also be found here:

	http://git.kernel.org/?p=linux/kernel/git/dhowells/linux-asm_system.git;a=shortlog;h=refs/heads/split-asm-system_h

David
