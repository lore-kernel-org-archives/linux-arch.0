Return-Path: <linux-arch-owner+james.bottomley=40steeleye.com-S268698AbUHTUB2@vger.kernel.org>
Received: from mx1.redhat.com ([66.187.233.31]:41368 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S268696AbUHTUBM (ORCPT
	<rfc822;linux-arch@vger.kernel.org>);
	Fri, 20 Aug 2004 16:01:12 -0400
Received: from int-mx1.corp.redhat.com (int-mx1.corp.redhat.com [172.16.52.254])
	by mx1.redhat.com (8.12.10/8.12.10) with ESMTP id i7KK1Ce1018527
	for <linux-arch@vger.kernel.org>; Fri, 20 Aug 2004 16:01:12 -0400
Received: from devserv.devel.redhat.com (devserv.devel.redhat.com [172.16.58.1])
	by int-mx1.corp.redhat.com (8.11.6/8.11.6) with ESMTP id i7KK1Ca09999
	for <linux-arch@vger.kernel.org>; Fri, 20 Aug 2004 16:01:12 -0400
Received: from cheetah.davemloft.net (localhost.localdomain [127.0.0.1])
	by devserv.devel.redhat.com (8.12.11/8.12.10) with SMTP id i7KK1BVb004032
	for <linux-arch@vger.kernel.org>; Fri, 20 Aug 2004 16:01:11 -0400
Date: Fri, 20 Aug 2004 13:01:10 -0700
From: "David S. Miller" <davem@redhat.com>
Subject: copy_mount_options()
Message-Id: <20040820130110.07f7c23c.davem@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
To: linux-arch@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>


So the sparc64 user copy bug I fixed recently is pretty
much present on every platform.

Basically, copy_mount_options() requires exact byte granularity
to exception reporting from copy_from_user().  If you don't
do this it can break things like busybox's mount().

Even reporting on a word boundary is illegal.  On sparc64
it was quite poignant because we can report on a 64-byte
boundary for large copies because that is the granularity
of the load/store we use.

Other platforms will need to fix this.  I recommend a two
stage exception handling scheme.  Basically, on the first
exception, you merely note that an exception occurred
and you retry the user copy a byte at a time until you
hit the exact address that fails.  You cannot optimize
this to just check a page at a time, because copy_mount_options
wants all the data to be there.
