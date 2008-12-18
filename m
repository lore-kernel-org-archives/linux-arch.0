Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mx2.redhat.com ([66.187.237.31]:40974 "EHLO mx2.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751473AbYLRLm2 (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Thu, 18 Dec 2008 06:42:28 -0500
From: Gerd Hoffmann <kraxel@redhat.com>
Subject: [PATCH v4 0/3] System call design: preadv & pwritev.
Date: Thu, 18 Dec 2008 12:42:19 +0100
Message-ID: <1229600542-11585-1-git-send-email-kraxel@redhat.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, linux-api@vger.kernel.org
Cc: aarcange@redhat.com, Gerd Hoffmann <kraxel@redhat.com>
Message-ID: <20081218114219.ZUdR-8e8Xu-lHnUn1_2GSYqi0Jt42gBgTr_h-a6Zj1U@z>

  Hi folks,

Guess I have your attention now thanks to LWN ;)

Next round of the preadv & pwritev patch series, hopefully finally
solving the architecture issues.  I've decided to go with the suggestion
from the s390 guys:  split the 64bit offset into two explicitly coded
32bit halves.  The syscall prototype should work now for all archs
without (in-kernel) wrappers.  glibc must wrap the syscalls though to
hide that split from the applications.  But there is no way around glibc
wrappers anyway, so I think that is sensible decision.

cheers,
  Gerd

