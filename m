From: Al Viro <viro@ZenIV.linux.org.uk>
Subject: Re: [RFC][PATCHSET] mremap/mmap mess
Date: Sat, 5 Dec 2009 23:01:49 +0000
Message-ID: <20091205230149.GZ14381@ZenIV.linux.org.uk>
References: <E1NGzzu-0008RH-T2@ZenIV.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from zeniv.linux.org.uk ([195.92.253.2]:34099 "EHLO
	ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756698AbZLEXBo (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Sat, 5 Dec 2009 18:01:44 -0500
Content-Disposition: inline
In-Reply-To: <E1NGzzu-0008RH-T2@ZenIV.linux.org.uk>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: mingo@redhat.com
Cc: linux-arch@vger.kernel.org, torvalds@linux-foundation.org, linux-kernel@vger.kernel.org

BTW, another fun question in the same area: what enforces the virtual
aliasing rules for fremap.c stuff?  AFAICS, on VIPT architectures
we are asking for trouble there.  No?

Is there anything that would prevent an arbitrary page from file's
page cache from being mapped at any cache colours?
