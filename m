From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH 04/29] Disintegrate asm/system.h on all arches
Date: Wed, 7 Mar 2012 21:47:42 +0000
Message-ID: <201203072147.42218.arnd@arndb.de>
References: <20120307194548.15987.36073.stgit@warthog.procyon.org.uk> <20120307194641.15987.33637.stgit@warthog.procyon.org.uk>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.126.171]:56179 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751376Ab2CGVsl (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Wed, 7 Mar 2012 16:48:41 -0500
In-Reply-To: <20120307194641.15987.33637.stgit@warthog.procyon.org.uk>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: David Howells <dhowells@redhat.com>
Cc: paul.gortmaker@windriver.com, hpa@zytor.com, torvalds@linux-foundation.org, sfr@canb.auug.org.au, mingo@redhat.com, tglx@linutronix.de, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org

On Wednesday 07 March 2012, David Howells wrote:
> asm/system.h is a cause of circular dependency problems because it contains
> commonly used primitive stuff like barrier definitions and uncommonly used
> stuff like switch_to() that might require MMU definitions.

In this patch, you seem to have put the wrong description, as this the alpha
specific part of your series but the description is the same as in patch 3.

	Arnd
