Return-Path: <linux-arch-owner+james.bottomley=40steeleye.com-S268199AbUHYErT@vger.kernel.org>
Received: from mx1.redhat.com ([66.187.233.31]:63132 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S268084AbUHYErT (ORCPT
	<rfc822;linux-arch@vger.kernel.org>);
	Wed, 25 Aug 2004 00:47:19 -0400
Received: from int-mx1.corp.redhat.com (int-mx1.corp.redhat.com [172.16.52.254])
	by mx1.redhat.com (8.12.10/8.12.10) with ESMTP id i7P4lIS0017213
	for <linux-arch@vger.kernel.org>; Wed, 25 Aug 2004 00:47:18 -0400
Received: from devserv.devel.redhat.com (devserv.devel.redhat.com [172.16.58.1])
	by int-mx1.corp.redhat.com (8.11.6/8.11.6) with ESMTP id i7P4lI323932
	for <linux-arch@vger.kernel.org>; Wed, 25 Aug 2004 00:47:18 -0400
Received: from cheetah.davemloft.net (localhost.localdomain [127.0.0.1])
	by devserv.devel.redhat.com (8.12.11/8.12.10) with SMTP id i7P4lFJK020576
	for <linux-arch@vger.kernel.org>; Wed, 25 Aug 2004 00:47:15 -0400
Date: Tue, 24 Aug 2004 21:46:59 -0700
From: "David S. Miller" <davem@redhat.com>
Subject: speaking of copy_*_user()
Message-Id: <20040824214659.164da2a9.davem@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
To: linux-arch@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>


I just noticed that fb_{read,write}() uses copy_*_user() with
the kernel buffer being the frame buffer.  It needs to use
the proper device address accessor functions.
