Return-Path: <davidm@napali.hpl.hp.com>
Received: from palrel12.hp.com ([156.153.255.237]:59105 "EHLO palrel12.hp.com")
	by vger.kernel.org with ESMTP id S261410AbUCATlI (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Mon, 1 Mar 2004 14:41:08 -0500
From: David Mosberger <davidm@napali.hpl.hp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16451.37325.109790.457348@napali.hpl.hp.com>
Date: Mon, 1 Mar 2004 11:41:01 -0800
Subject: Re: SHMLBA and compat tasks
In-Reply-To: <20040301193308.GA13305@intel.com>
References: <20040228014128.GA6897@intel.com>
	<20040228155529.64bc0741.davem@redhat.com>
	<20040229021105.GA6964@intel.com>
	<20040229215752.3a6f0ce7.davem@redhat.com>
	<20040301193308.GA13305@intel.com>
Reply-To: davidm@hpl.hp.com
To: Arun Sharma <arun.sharma@intel.com>
Cc: "David S. Miller" <davem@redhat.com>, davidm@hpl.hp.com, linux-arch@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>

>>>>> On Mon, 1 Mar 2004 11:33:08 -0800, Arun Sharma <arun.sharma@intel.com> said:

  Arun> David, are you ok with changing this code to force SHMLBA
  Arun> alignment for both 32 and 64 bit tasks ?

I assume you're asking me here (too many David's!).  The answer is
that it's NOT OK to force 1MB alignment for IA-32 tasks.  It'll eat up
address space like there is no tomorrow.  In fact, the reason the code
is there is because some versions of the open-office installer used to
crash due to address-space exhaustion.  Probably a bug in open-office,
but the point is that for ia32-emulation purposes, we want/need to be
bug-for-bug compatible with x86.

	--david
