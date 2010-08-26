From: Jean Sacren <sakiwit@gmail.com>
Subject: [PATCH 0/1] x86: Fix warning: ignoring return value of 'fread'
Date: Wed, 25 Aug 2010 18:07:39 -0600
Message-ID: <20100826000739.GA7216@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-pv0-f174.google.com ([74.125.83.174]:35267 "EHLO
	mail-pv0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752792Ab0HZAHh (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Wed, 25 Aug 2010 20:07:37 -0400
Received: by pvg2 with SMTP id 2so431282pvg.19
        for <linux-arch@vger.kernel.org>; Wed, 25 Aug 2010 17:07:37 -0700 (PDT)
Content-Disposition: inline
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: "H. Peter Anvin" <hpa@linux.intel.com>
Cc: Linux Arch Mailing List <linux-arch@vger.kernel.org>

Hi,

Jean Sacren (1):
  x86: Fix warning: ignoring return value of 'fread'

 arch/x86/boot/compressed/mkpiggy.c |    5 ++++-
 1 files changed, 4 insertions(+), 1 deletions(-)


-- 
Jean Sacren
Bring LAMP To People
