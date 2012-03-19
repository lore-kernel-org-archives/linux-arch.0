From: David Howells <dhowells@redhat.com>
Subject: Re: [PATCH 05/38] Disintegrate asm/system.h for ARM [ver #3]
Date: Mon, 19 Mar 2012 10:45:11 +0000
Message-ID: <2349.1332153911@redhat.com>
References: <1331908808.12353.2.camel@deneb.redhat.com> <20120315205514.28759.58969.stgit@warthog.procyon.org.uk> <20120315205603.28759.91855.stgit@warthog.procyon.org.uk>
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:36717 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753791Ab2CSKp1 (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Mon, 19 Mar 2012 06:45:27 -0400
In-Reply-To: <1331908808.12353.2.camel@deneb.redhat.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Mark Salter <msalter@redhat.com>
Cc: dhowells@redhat.com, paul.gortmaker@windriver.com, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, arnd@arndb.de, linux-arm-kernel@lists.infradead.org

Mark Salter <msalter@redhat.com> wrote:

> Looks like this hunk was unintended. It is causing a build failure for
> me.

Yep.  Removed that already and reissued the ARM chunk, though only on the ARM
list.

David
