Return-Path: <davem@redhat.com>
Received: from mx1.redhat.com ([66.187.233.31]:9434 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S261414AbUCAUOh (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Mon, 1 Mar 2004 15:14:37 -0500
Date: Mon, 1 Mar 2004 12:11:22 -0800
From: "David S. Miller" <davem@redhat.com>
Subject: Re: SHMLBA and compat tasks
Message-Id: <20040301121122.20e19d9f.davem@redhat.com>
In-Reply-To: <16451.37325.109790.457348@napali.hpl.hp.com>
References: <20040228014128.GA6897@intel.com>
	<20040228155529.64bc0741.davem@redhat.com>
	<20040229021105.GA6964@intel.com>
	<20040229215752.3a6f0ce7.davem@redhat.com>
	<20040301193308.GA13305@intel.com>
	<16451.37325.109790.457348@napali.hpl.hp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
To: davidm@hpl.hp.com
Cc: davidm@napali.hpl.hp.com, arun.sharma@intel.com, linux-arch@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>

On Mon, 1 Mar 2004 11:41:01 -0800
David Mosberger <davidm@napali.hpl.hp.com> wrote:

> I assume you're asking me here (too many David's!).  The answer is
> that it's NOT OK to force 1MB alignment for IA-32 tasks.

Why exactly is SHMLBA 1MB, something to do with the ia64 address
space segments or something?
