Return-Path: <davidm@napali.hpl.hp.com>
Received: from palrel12.hp.com ([156.153.255.237]:49316 "EHLO palrel12.hp.com")
	by vger.kernel.org with ESMTP id S261422AbUCAURc (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Mon, 1 Mar 2004 15:17:32 -0500
From: David Mosberger <davidm@napali.hpl.hp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16451.39513.465799.556109@napali.hpl.hp.com>
Date: Mon, 1 Mar 2004 12:17:29 -0800
Subject: Re: SHMLBA and compat tasks
In-Reply-To: <20040301121122.20e19d9f.davem@redhat.com>
References: <20040228014128.GA6897@intel.com>
	<20040228155529.64bc0741.davem@redhat.com>
	<20040229021105.GA6964@intel.com>
	<20040229215752.3a6f0ce7.davem@redhat.com>
	<20040301193308.GA13305@intel.com>
	<16451.37325.109790.457348@napali.hpl.hp.com>
	<20040301121122.20e19d9f.davem@redhat.com>
Reply-To: davidm@hpl.hp.com
To: "David S. Miller" <davem@redhat.com>
Cc: davidm@hpl.hp.com, davidm@napali.hpl.hp.com, arun.sharma@intel.com, linux-arch@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>

>>>>> On Mon, 1 Mar 2004 12:11:22 -0800, "David S. Miller" <davem@redhat.com> said:

  DaveM> On Mon, 1 Mar 2004 11:41:01 -0800
  DaveM> David Mosberger <davidm@napali.hpl.hp.com> wrote:

  >> I assume you're asking me here (too many David's!).  The answer is
  >> that it's NOT OK to force 1MB alignment for IA-32 tasks.

  DaveM> Why exactly is SHMLBA 1MB, something to do with the ia64 address
  DaveM> space segments or something?

The architecture reserves the right to impose a performance penalty
for aliases which are not congruent modulo 1MB.  None of the current
CPUs do that but future CPUs _could_ do that (well, I hope they never
will, but we do want to be compliant with the architecture, just in
case).

	--david
