Return-Path: <davidm@napali.hpl.hp.com>
Received: from palrel10.hp.com ([156.153.255.245]:52426 "EHLO palrel10.hp.com")
	by vger.kernel.org with ESMTP id S263544AbUDPVii (ORCPT
	<rfc822;linux-arch@vger.kernel.org>);
	Fri, 16 Apr 2004 17:38:38 -0400
From: David Mosberger <davidm@napali.hpl.hp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16512.21080.49982.22120@napali.hpl.hp.com>
Date: Fri, 16 Apr 2004 14:38:32 -0700
Subject: Re: Unexpected syscalls on 64-bit arches
In-Reply-To: <20040416210802.GU31589@devserv.devel.redhat.com>
References: <20040416210802.GU31589@devserv.devel.redhat.com>
Reply-To: davidm@hpl.hp.com
To: Jakub Jelinek <jakub@redhat.com>
Cc: linux-arch@vger.kernel.org, drepper@redhat.com
List-ID: <linux-arch.vger.kernel.org>

>>>>> On Fri, 16 Apr 2004 17:08:03 -0400, Jakub Jelinek <jakub@redhat.com> said:

  Jakub> On all these arches, struct statfs and struct statfs64 are
  Jakub> identical,

Yes.

  Jakub> thus __NR_statfs64 is a dup of __NR_statfs and
  Jakub> __NR_fstatfs64 is a dup of __NR_fstatfs.

But sys_{f,}statfs64() does take an additional "size" argument.
Perhaps the intention was to enable extensibility?

	--david
